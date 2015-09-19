//
//  QntView.m
//  iOS-Tech-Challenge
//
//  Created by AKI on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import "QntView.h"

@implementation QntView
@synthesize Qnt;


- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame])
    {
        
    }
    return self;
    
}

-(void)Add{
    Qnt+=1;
}

-(void)Minus{
    if (Qnt<=0) {
        Qnt = 0;
    }else{
        Qnt -=1;
    }
}

@end
