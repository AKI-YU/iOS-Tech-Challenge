//
//  PurchaseDetailTableViewCell.h
//  iOS-Tech-Challenge
//
//  Created by Lono on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurchaseDetailTableViewCell : UITableViewCell
@property (nonatomic) IBOutlet UILabel* checkBoxLabel;
@property (nonatomic) IBOutlet UILabel* itemIndexLabel;
@property (nonatomic) IBOutlet UILabel* itemNameLabel;
@property (nonatomic) IBOutlet UITextField* itemCountLabel;
@property (nonatomic) IBOutlet UITextField* itemExpirationDateLabel;
@property (nonatomic) IBOutlet UILabel* orderIdLabel;
@end
