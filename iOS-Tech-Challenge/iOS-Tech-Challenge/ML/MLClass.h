//
//  MLClass.h
//  iOS-Tech-Challenge
//
//  Created by AKI on 2015/9/20.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLClass : NSObject
{

}

+(void)saveUsage:(NSString *)productName :(int)freshDayCount;
+(void)setFreshDate:(NSString *)productName :(int)freshDayCount;
+(void)queryAWS_Ingredients:(NSString *)productName :(int)freshDayCount;

@end
