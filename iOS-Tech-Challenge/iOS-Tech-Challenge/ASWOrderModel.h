//
//  ASWOrderModel.h
//  iOS-Tech-Challenge
//
//  Created by LaiKuan Wen on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ASWOrderModelDelegate <NSObject>

- (void) aswTotalDidChange:(NSInteger)total;

@end

@interface ASWOrderModel : NSObject

- (NSUInteger) aswGetTodaySerialNo;

- (NSArray *) aswGetDetailDataArray;

@end
