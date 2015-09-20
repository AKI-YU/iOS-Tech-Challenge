//
//  UIColor+Inventory.m
//  iOS-Tech-Challenge
//
//  Created by cjlin on 2015/9/20.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import "UIColor+Inventory.h"

@implementation UIColor (Inventory)
+ (UIColor *)colorTopLeftText { return [UIColor whiteColor]; }
+ (UIColor *)colorTopLeftBg { return [UIColor colorWithHex:0xFFE5B9 alpha:0.3]; }

+ (UIColor *)colorFirstRowText { return [UIColor whiteColor]; }
+ (UIColor *)colorFirstRowBg { return [UIColor colorWithHex:0xFFE5B9 alpha:0.3]; }

+ (UIColor *)colorDataText { return [UIColor whiteColor]; }
+ (UIColor *)colorDataBg { return [UIColor colorWithHex:0x111111 alpha:0.3]; }

+ (UIColor *)colorWithHex:(int)hex
{
	return [UIColor colorWithHex:hex alpha:1.0f];
}

+ (UIColor *)colorWithHex:(int)hex alpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0
						   green:((float)((hex & 0x00FF00) >>  8))/255.0
							blue:((float)((hex & 0x0000FF) >>  0))/255.0
						   alpha:alpha];
}
@end
