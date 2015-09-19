//
//  PurchaseTableViewCell.m
//  iOS-Tech-Challenge
//
//  Created by Lono on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import "PurchaseTableViewCell.h"
#import <Parse.h>

@implementation PurchaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)bindModel:(NSArray*)array
{
    PFObject* model = array.firstObject;
    NSDate* date = model[@"arrive_date"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd"];
    NSString *correctDate = [formatter stringFromDate:date];
    
    self.purchaseOrderIdLabel.text = model[@"purchase_id"];
    self.purchaseDateLabel.text = correctDate;
    self.checker.text = model[@"checker"];
    
    NSMutableArray* itemList = [NSMutableArray new];
    for (NSInteger i = 0; i < 5 && i < array.count; ++i) {
        PFObject* obj = array[i];
        NSString* name = obj[@"name"];
        if (name.length > 0) {
            [itemList addObject:name];
        }
    }
    NSString* str = [itemList componentsJoinedByString:@"、"];
    str = @"       hihihihiohifhoihfaiohfiohaiohfoiahfoisahiofhoasihfioashfaiaf";
    self.itemNames.text = str;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
