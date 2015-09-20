//
//  UIColor+Inventory.h
//  iOS-Tech-Challenge
//
//  Created by cjlin on 2015/9/20.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Inventory)
+ (UIColor *)colorTopLeftText; //品項
+ (UIColor *)colorTopLeftBg;

+ (UIColor *)colorFirstRowBg;
+ (UIColor *)colorFirstRowText;

+ (UIColor *)colorDataBg;
+ (UIColor *)colorDataText;

+ (UIColor *)colorFirstColumnBg;

//
+ (UIColor *)colorWithHex:(int)hex;
+ (UIColor *)colorWithHex:(int)he3x alpha:(CGFloat)alpha;
@end
