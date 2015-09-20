//
//  ASWOrderMagCell.m
//  iOS-Tech-Challenge
//
//  Created by LaiKuan Wen on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import "ASWOrderMagCell.h"
#import "ParseAPI.h"

@interface ASWOrderMagCell ()
//UI
@property (weak, nonatomic) IBOutlet UILabel *m_lbEONumber;//!<訂單編號
@property (weak, nonatomic) IBOutlet UILabel *m_lbEODate;//!<訂單日期
@property (weak, nonatomic) IBOutlet UILabel *m_lbEOStatus;//!<狀態
@property (weak, nonatomic) IBOutlet UILabel *m_lbEOSummary;//!<摘要

@end

@implementation ASWOrderMagCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void) aswUpdateWithArray:(NSMutableArray *)array
{
    if (array.count >= 1)
    {
        PFObject *pfDic = array[0];
//
        
        self.m_lbEONumber.text = [NSString stringWithFormat: @"%d",[[pfDic objectForKey:@"order_id"] integerValue]];
        self.m_lbEOStatus.text = [pfDic objectForKey:@"Status"];
        
        NSDate *date = [pfDic objectForKey:@"EODate"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy/MM/dd";
        self.m_lbEODate.text = [formatter stringFromDate:date];
        
        NSMutableString *strSummary = [NSMutableString new];
        for (NSInteger i = 0 ; i < array.count; i ++)
        {
            PFObject *pfDetailDic = array[i];
            [strSummary appendString:[pfDetailDic objectForKey:@"name"]];
            [strSummary appendString:@"、"];
        }
        self.m_lbEOSummary.text = [strSummary substringToIndex:strSummary.length-1];

    }
}


- (void) aswUpdateWithDictionary:(NSDictionary *)dictionary
{

}

@end
