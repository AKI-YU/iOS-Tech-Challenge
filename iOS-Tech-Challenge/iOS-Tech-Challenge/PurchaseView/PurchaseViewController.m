//
//  PurchaseViewController.m
//  iOS-Tech-Challenge
//
//  Created by Lono on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//
//  進貨單編號　進貨日期

#import "PurchaseViewController.h"
#import "Parse.h"
#import "HFTableViewBindingHelper.h"
@interface PurchaseViewController ()
@property (nonatomic) HFTableViewBindingHelper* helper;
@property (nonatomic) IBOutlet UITableView* tableView;
@end

@implementation PurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"進貨管理";
//    self.helper = [HFTableViewBindingHelper
//                   bindingForTableView:self.tableView
//                            sourceList:nil
//                     didSelectionBlock:^(id model) {
//    
//    } cellReuseIdentifier:@"CELL" isNested:NO];
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
