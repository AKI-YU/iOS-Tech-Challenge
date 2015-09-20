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

@property (strong, nonatomic) NSArray *m_aryLbsNeedUpdate;
@property (strong, nonatomic) NSArray *m_aryDicKeys;
@end

@implementation ASWOrderCell

- (void)awakeFromNib
{
    // Initialization code
    self.m_aryLbsNeedUpdate = @[self.m_lbItemNo, self.m_lbName, self.m_lbpAriveDate, self.m_lbVolum, self.m_lbPrice, self.m_lbSubTotal];
    self.m_aryDicKeys = @[@"",@"",@"",@"",@"",@"",@""];
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
