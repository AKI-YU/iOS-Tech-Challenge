//
//  IngredientsUploadTableViewCell.h
//  iOS-Tech-Challenge
//
//  Created by Lee-Sheng Chen on 9/20/15.
//  Copyright © 2015 AKI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IngredientsUploadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *i_productLable;
@property (weak, nonatomic) IBOutlet UIButton *i_MinusBtn;
@property (weak, nonatomic) IBOutlet UIButton *i_AddBtn;
@property (weak, nonatomic) IBOutlet UILabel *i_displayLabel;
@property (weak, nonatomic) IBOutlet UIButton *i_uploadBtn;

@end
