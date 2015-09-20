//
//  QntView.m
//  iOS-Tech-Challenge
//
//  Created by AKI on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import "QntView.h"

@implementation QntView


- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        UIView *thisView = [[[NSBundle mainBundle] loadNibNamed:@"QntView" owner:self options:nil] objectAtIndex:0];
        [self addSubview:thisView];
        
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    
    //width = 150   height 60
    
    if(self = [super initWithFrame:frame])
    {
        UIView *thisView = [[[NSBundle mainBundle] loadNibNamed:@"QntView" owner:self options:nil] objectAtIndex:0];
        
        [self addSubview:thisView];
        
    }
    return self;
    
}

-(void)Add{
    
    ((UILabel *)[self viewWithTag:2]).text = [NSString stringWithFormat:@"%ld",[((UILabel *)[self viewWithTag:2]).text integerValue] + 1];
    
}

-(void)Minus{
    if ([((UILabel *)[self viewWithTag:2]).text integerValue]<=0) {
        return;
    }
   
    ((UILabel *)[self viewWithTag:2]).text = [NSString stringWithFormat:@"%ld",[((UILabel *)[self viewWithTag:2]).text integerValue] - 1];
    
}

-(void)setQntValue:(NSInteger)qnt{
    ((UILabel *)[self viewWithTag:2]).text = [NSString stringWithFormat:@"%ld",qnt];
}

-(void)setColor:(UIColor *)color{
    [((UILabel *)[self viewWithTag:2]) setTextColor:color];
}


@end
