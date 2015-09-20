//
//  QntView.h
//  iOS-Tech-Challenge
//
//  Created by AKI on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QntView : UIView

-(void)Add;
-(void)Minus;


-(void)setQntValue:(NSInteger)qnt;
-(void)setColor:(UIColor *)color;

@end
