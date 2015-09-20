//
//  PurchaseDetailViewController.h
//  iOS-Tech-Challenge
//
//  Created by Lono on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KVOMutableArray.h"
@interface PurchaseDetailViewController : UIViewController
@property (nonatomic) KVOMutableArray* data;
@property (nonatomic) IBOutlet UITableView* tableView;
@property IBOutlet UILabel* purchaseIdLabel;
@property IBOutlet UILabel* purchaseDateLabel;
@property BOOL isNewPurchase;
@property NSString* purchaseId;
@end
