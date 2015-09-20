//
//  ASWOrderCell.m
//  iOS-Tech-Challenge
//
//  Created by LaiKuan Wen on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import "ASWOrderCell.h"

@interface ASWOrderCell ()
//UI
@property (weak, nonatomic) IBOutlet UILabel *m_lbItemNo;//!<項次
@property (weak, nonatomic) IBOutlet UILabel *m_lbName;//!<品名
@property (weak, nonatomic) IBOutlet UILabel *m_lbpAriveDate;//預計到達時間
@property (weak, nonatomic) IBOutlet UILabel *m_lbVolum;//!<訂購量
@property (weak, nonatomic) IBOutlet UILabel *m_lbPrice;//!<單價
@property (weak, nonatomic) IBOutlet UILabel *m_lbSubTotal;//!<小計

@end

@implementation ASWOrderCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) aswUpdateWithDictionary:(PFObject *)dictionary
{
    NSString *strItem = [NSString stringWithFormat:@"%d",[[dictionary objectForKey:@"item_index"] integerValue]];
    self.m_lbItemNo.text = strItem;
    
    NSInteger v, p ;
    v = [[dictionary objectForKey:@"amount"] integerValue];
    p = [[dictionary objectForKey:@"price"] integerValue];
    self.m_lbVolum.text = [NSString stringWithFormat:@"%d",v];
    self.m_lbPrice.text = [NSString stringWithFormat:@"%d",p];
    self.m_lbSubTotal.text = [NSString stringWithFormat:@"%d",p*v];
    
    self.m_lbName.text = dictionary[@"name"];
    
    NSDate *date = dictionary[@"p_arrive"];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"yyyy/MM/dd";
    self.m_lbpAriveDate.text = [f stringFromDate:date];
    
}

@end
