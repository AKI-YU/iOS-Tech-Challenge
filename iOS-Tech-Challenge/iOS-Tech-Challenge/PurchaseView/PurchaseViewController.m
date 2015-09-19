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
@end

@implementation PurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"進貨管理";
    
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
