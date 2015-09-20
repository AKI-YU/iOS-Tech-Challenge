//
//  PurchaseViewController.m
//  iOS-Tech-Challenge
//
//  Created by Lono on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//
//  進貨單編號　進貨日期

#import "PurchaseViewController.h"
#import "PurchaseDetailViewController.h"
#import "Parse.h"
#import "HFTableViewBindingHelper.h"
#import <RACEXTScope.h>
#import <Parse.h>
@interface PurchaseViewController ()
@property (nonatomic) HFTableViewBindingHelper* helper;
@property (nonatomic) IBOutlet UITableView* tableView;
@property (nonatomic) KVOMutableArray* data;
@property (nonatomic) IBOutlet UIView* addView;
@end

@implementation PurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"進貨管理";
    
    UITapGestureRecognizer* addTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(add:)];
    self.addView.userInteractionEnabled = YES;
    addTap.numberOfTapsRequired = 1;
    [self.addView addGestureRecognizer:addTap];
    
    PFQuery *query = [PFQuery queryWithClassName:@"purchase"];
    @weakify(self);
//    query whereKey:equalTo:
    [query orderByDescending:@"arrive_date"];
    [query addAscendingOrder:@"item_index"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        @strongify(self);
        KVOMutableArray* data = [self mergeSameOrderId:objects];
        self.data = data;
        UINib* nib = [UINib nibWithNibName:@"PurchaseTableViewCell" bundle:nil];
        self.helper = [HFTableViewBindingHelper
                       bindingForTableView:self.tableView
                       sourceList:data
                         didSelectionBlock:^(KVOMutableArray* model) {
                             if ([model isKindOfClass:[KVOMutableArray class]]) {
                                 // Lono
                                 PurchaseDetailViewController* viewController = [[PurchaseDetailViewController alloc] initWithNibName:@"PurchaseDetailViewController" bundle:nil];
                                 viewController.data = model;
                                 [self.navigationController pushViewController:viewController animated:YES];
                             }
                         }
                              templateCell:nib
                                  isNested:NO];
    }];
}

- (BOOL)isDay:(NSDate*)day1 equalTo:(NSDate*)day2
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:day1];
    NSDate *today = [cal dateFromComponents:components];
    components = [cal components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:day2];
    NSDate *otherDate = [cal dateFromComponents:components];
    
    if([today isEqualToDate:otherDate]) {
        return YES;
    }
    return NO;
}
- (IBAction)add:(id)sender
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
    
    PurchaseDetailViewController* viewController = [[PurchaseDetailViewController alloc] initWithNibName:@"PurchaseDetailViewController" bundle:nil];
    
    // fetch expected arrivals today
    PFQuery *query = [PFQuery queryWithClassName:@"AWS_Order"];
    @weakify(self);
    //    query whereKey:equalTo:
    [query orderByDescending:@"p_arrive"];
    [query addAscendingOrder:@"item_index"];
    
   [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
       @strongify(self);
       
       NSMutableArray* todayOrder = [NSMutableArray new];
       
       for (PFObject* ob in objects) {
           NSDate* date = ob[@"p_arrive"];
           
           if([self isDay:today equalTo:date]) {
               [todayOrder addObject:ob];
           }
       }
       
       PFQuery *pQuery = [PFQuery queryWithClassName:@"purchase"];
       //    query whereKey:equalTo:
       [pQuery orderByDescending:@"arrive_date"];
       [pQuery addAscendingOrder:@"item_index"];
       @weakify(self);
       [pQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
           @strongify(self);
           NSMutableArray* todayPurchase = [NSMutableArray new];
           for (PFObject* ob in objects) {
               NSDate* date = ob[@"arrive_date"];
               
               if([self isDay:today equalTo:date]) {
                   [todayPurchase addObject:ob];
               }
           }
           
           KVOMutableArray* expectedOrder = [KVOMutableArray new];
           for (PFObject* order in todayOrder) {
               for (PFObject* purchase in todayPurchase) {
                   if ([order[@"order_id"] isEqualToNumber:purchase[@"order_id"]]
                       && [order[@"name"] isEqualToString:purchase[@"name"]]) {
                       
                       NSInteger orderAmount = [order[@"amount"] integerValue];
                       NSInteger purchaseAmount = [purchase[@"amount"] integerValue];
                       
                       orderAmount -= purchaseAmount;
                       if (orderAmount > 0) {
                           order[@"amount"] = @(orderAmount);
                           [expectedOrder addObject:order];
                       }
                       
                   }
               }
           }
           
           viewController.data = [self purchaseFromOrder:expectedOrder];
            [self.navigationController pushViewController:viewController animated:YES];
           
       }];
       
   }];
}

- (KVOMutableArray*)purchaseFromOrder:(KVOMutableArray*)order
{
    return [KVOMutableArray new];
}

- (KVOMutableArray*)mergeSameOrderId:(NSArray*)data
{
    KVOMutableArray* res = [KVOMutableArray new];
    NSMutableDictionary* orderIdMap = [NSMutableDictionary new];
    for (PFObject* obj in data) {
        NSNumber* orderId = obj[@"order_id"];
        if (!orderId) {
            continue;
        }
        
        if (!orderIdMap[orderId]) {
            orderIdMap[orderId] = [KVOMutableArray new];
            [res addObject:orderIdMap[orderId]];
        }
        if (orderIdMap[orderId]) {
            KVOMutableArray* array = orderIdMap[orderId];
            [array addObject:obj];
        }
    }
    return res;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
