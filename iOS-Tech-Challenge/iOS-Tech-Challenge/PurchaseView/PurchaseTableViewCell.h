//
//  PurchaseTableViewCell.h
//  iOS-Tech-Challenge
//
//  Created by Lono on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFBindingViewDelegate.h"
@interface PurchaseTableViewCell : UITableViewCell<HFBindingViewDelegate>
@property (nonatomic) IBOutlet UILabel* purchaseOrderIdLabel;
@property (nonatomic) IBOutlet UILabel* purchaseDateLabel;
@property (nonatomic) IBOutlet UILabel* checker;
@property (nonatomic) IBOutlet UILabel* itemNames;
@end
