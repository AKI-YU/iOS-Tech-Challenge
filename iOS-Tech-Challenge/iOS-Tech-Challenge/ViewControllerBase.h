//
//  ViewControllerBase.h
//  iOS-Tech-Challenge
//
//  Created by AKI on 2015/9/20.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"

@interface ViewControllerBase : UIViewController<RNFrostedSidebarDelegate>

-(void)showMenu;

-(void)showHud;
-(void)hideHud;

@end
