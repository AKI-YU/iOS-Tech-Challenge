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

// ☒☑☐
@interface PurchaseDetailViewController ()
@property (nonatomic) HFTableViewBindingHelper* helper;

@end

@implementation PurchaseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    
    if (self.isNewPurchase) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"新增" style:UIBarButtonItemStylePlain target:self action:nil];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
