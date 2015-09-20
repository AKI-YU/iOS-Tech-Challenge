//
//  ASWOrderDraftSelectVC.h
//  iOS-Tech-Challenge
//
//  Created by LaiKuan Wen on 2015/9/20.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASWOrderVC.h"

@protocol ASWOrderDraftSelectVCDelegate <NSObject>
- (void) aswDidSelectDraft:(NSString *)strEONumber;
@end

@interface ASWOrderDraftSelectVC : UIViewController
@property (weak, nonatomic) id<ASWOrderDraftSelectVCDelegate> m_delegate;
@end
