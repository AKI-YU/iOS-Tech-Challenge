//
//  ASWOrderModel.m
//  iOS-Tech-Challenge
//
//  Created by LaiKuan Wen on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import "ASWOrderModel.h"
#define ASW_Order_SerialNo @"ASW_Order_SerialNo"

@interface ASWOrderModel ()
@property (nonatomic) NSUInteger m_i;
@property (strong, nonatomic) NSArray *m_aryDetail;
@end

@implementation ASWOrderModel

- (instancetype) init
{
    self  = [super init];
    if (nil != self)
    {
        self.m_i = 001;
    }
    return self;
}

- (NSUInteger) aswGetTodaySerialNo
{
    NSUInteger i = self.m_i++;
    return i;
}

/**取回明細串
 此為供Table快速取用model內資料
 內擋掉陣列為nil之情況*/
- (NSArray *) aswGetDetailDataArray
{
    if(nil == _m_aryDetail)
    {
        self.m_aryDetail = [NSArray array];
    }
    return self.m_aryDetail;
}

@end
