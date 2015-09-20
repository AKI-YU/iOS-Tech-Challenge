//
//  PurchaseDetailTableViewCell.m
//  iOS-Tech-Challenge
//
//  Created by Lono on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import "PurchaseDetailTableViewCell.h"
#import "HFBindingViewDelegate.h"
#import <Parse.h>

@interface PurchaseDetailTableViewCell()<HFBindingViewDelegate>
@property PFObject* model;
@end
@implementation PurchaseDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.checkBoxLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checked:)];
    tap.numberOfTapsRequired = 1;
    
    [self.checkBoxLabel addGestureRecognizer:tap];
    self.contentView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    self.backgroundColor = [UIColor clearColor];

    
}

- (void)checked:(id)sender
{
    NSNumber* checked = self.model[@"checked"];
    NSNumber* nextCheck = [self checkNumber:checked];
    
    self.checkBoxLabel.text = [self numberToCheckedSymbol:nextCheck];
    self.model[@"checked"] = nextCheck;
}

- (NSNumber*)checkNumber:(NSNumber*)number
{
    if (number) {
        switch (number.integerValue) {
            case 0:
                return @(2);
                break;
            case 1:
                return @(0);
            case 2:
                return @(1);
        }
    }
    
    return number;
}

- (NSString*)numberToCheckedSymbol:(NSNumber*)number
{
    NSString* value = @"　";
    if (number) {
        switch (number.integerValue) {
            case 0:
                return @"☒";
                break;
            case 1:
                return @"☑";
            case 2:
                return @"☐";
        }
    }
    
    return value;
}

- (void)bindModel:(id)theModel
{
    if (![theModel isKindOfClass:[PFObject class]]) {
        return;
    }
    self.model = theModel;
   
    PFObject* model = theModel;
    
    self.itemNameLabel.text = model[@"name"];
    NSDate* date = model[@"p_fresh_time"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd"];
    NSString *correctDate = [formatter stringFromDate:date];
    self.itemExpirationDateLabel.text = correctDate;
    
    NSNumber* index = model[@"item_index"];
    self.itemIndexLabel.text = [index stringValue];

    self.checkBoxLabel.text = [self numberToCheckedSymbol:model[@"checked"]];
    
    NSNumber* order_id = model[@"order_id"];
    self.orderIdLabel.text = [order_id stringValue];
    
    NSNumber* amount = model[@"amount"];
    self.itemCountLabel.text = [amount stringValue];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
