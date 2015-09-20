//
//  ASWOrderMagCell.m
//  iOS-Tech-Challenge
//
//  Created by LaiKuan Wen on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import "ASWOrderMagCell.h"

@interface ASWOrderMagCell ()
//UI
@property (weak, nonatomic) IBOutlet UILabel *m_lbEONumber;//!<訂單編號
@property (weak, nonatomic) IBOutlet UILabel *m_lbEODate;//!<訂單日期
@property (weak, nonatomic) IBOutlet UILabel *m_lbEOStatus;//!<狀態
@property (weak, nonatomic) IBOutlet UILabel *m_lbEOSummary;//!<摘要

@property (strong, nonatomic) NSArray *m_aryLbsNeedUpdate;
@property (strong, nonatomic) NSArray *m_aryDicKeys;
@end

@implementation ASWOrderMagCell

- (void)awakeFromNib
{
    // Initialization code
    self.m_aryLbsNeedUpdate = @[self.m_lbEONumber, self.m_lbEODate, self.m_lbEOStatus, self.m_lbEOSummary];
    self.m_aryDicKeys = @[@"",@"",@"",@""];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void) aswUpdateWithDictionary:(NSDictionary *)dictionary
{
    for (NSInteger iCount = 0; iCount < self.m_aryLbsNeedUpdate.count; iCount ++)
    {
        UILabel *lb = self.m_aryLbsNeedUpdate[iCount];
        lb.text = [dictionary objectForKey:self.m_aryDicKeys[iCount]];
    }
}

@end
