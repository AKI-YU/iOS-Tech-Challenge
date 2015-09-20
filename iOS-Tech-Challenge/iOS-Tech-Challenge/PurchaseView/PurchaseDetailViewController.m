//
//  PurchaseDetailViewController.m
//  iOS-Tech-Challenge
//
//  Created by Lono on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import "PurchaseDetailViewController.h"
#import "HFTableViewBindingHelper.h"
#import <Parse.h>
#import "AppDelegate.h"
#import "Constants.h"

@interface PurchaseDetailViewController ()
@property (nonatomic) HFTableViewBindingHelper* helper;

@end

@implementation PurchaseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.naviItem.topItem.title = @"進貨單";
    
    PFObject* ob = self.data.firstObject;
    
    NSDate* date = ob[@"arrive_date"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd"];
    NSString *purchaseDate = [formatter stringFromDate:date];
    
    self.purchaseDateLabel.text = purchaseDate;
    self.purchaseIdLabel.text = self.purchaseId ?: ob[@"purchase_id"];
    
    UINib* nib = [UINib nibWithNibName:@"PurchaseDetailTableViewCell" bundle:nil];
    self.helper = [HFTableViewBindingHelper
                   bindingForTableView:self.tableView
                            sourceList:self.data
                     didSelectionBlock:^(id model) {
        
                    }
                          templateCell:nib
                              isNested:NO];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:nil];
    self.naviItem.topItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    
    if (self.isNewPurchase) {
        self.naviItem.topItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"新增" style:UIBarButtonItemStylePlain target:self action:@selector(add:)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)add:(id)sender
{
    [self showHud];
    BOOL isSuccess = NO;
    
    NSMutableArray* toBeAdded = [NSMutableArray new];
    for (PFObject* ob in self.data) {
        
        NSNumber* checked = ob[@"checked"];
        ob[@"purchase_id"] = self.purchaseId;
        ob[@"checker"] = @"店長";
        if (checked.integerValue == 0 || checked.integerValue == 1) {
            [toBeAdded addObject:ob];
            isSuccess = YES;
        }
    }
    
    if (toBeAdded.count <= 0) {
        [self alert:@"提示" msg:@"請檢核項目"];
    }
	else {
		for (PFObject *obj in toBeAdded) {
			PFObject *wareHouseObj = [PFObject objectWithClassName:ParseClassWareHouse];
			wareHouseObj[ParseClassWareHouseProduct] = obj[ParseClassPurchaseName];
			wareHouseObj[ParseClassWareHouseAmount] = obj[ParseClassPurchaseAmount];
			wareHouseObj[ParseClassWareHousePurchase] = obj;
			wareHouseObj[ParseClassWareHousePurchaseID] = obj[ParseClassPurchasePurchaseID];
			wareHouseObj[@"p_fresh_time"] = obj[@"p_fresh_time"];

			[obj save];
			[wareHouseObj save];
		}
	}

    if (isSuccess) {
        KVOMutableArray* newRow = [self mergeSameOrderId:toBeAdded];
        if (newRow.firstObject) {
            [self.parentData insertObject:newRow.firstObject atIndex:0];
            [self sendDataToNotAbomb:newRow.firstObject[0]];
        }

        [self.navigationController popViewControllerAnimated:YES];
    }
    [self hideHud];
}

- (void)sendDataToNotAbomb:(PFObject*)ob
{
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    delegate.itemName = [NSString stringWithFormat:@"%@到期!", ob[@"name"]];
    
    if (delegate.blunoDev.bReadyToWrite)
    {
        //        NSString* strTemp = self.txtSendMsg.text;
        NSString* strTemp = @"S 10\n";
        NSLog(@"%@",strTemp);
        NSData* data = [strTemp dataUsingEncoding:NSUTF8StringEncoding];
        [delegate.blunoManager writeDataToDevice:data Device:delegate.blunoDev];
    }
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
