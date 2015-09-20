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

@end
@implementation PurchaseDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (NSString*)numberToCheckedSymbol:(NSNumber*)number
{
    
    NSString* value = @"☐";
    if (number) {
        switch (number.integerValue) {
            case 0:
                return @"☒";
                break;
            case 1:
                return @"☑";
        }
    }
    
    return value;
}

- (void)bindModel:(id)theModel
{
    if (![theModel isKindOfClass:[PFObject class]]) {
        return;
    }
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
