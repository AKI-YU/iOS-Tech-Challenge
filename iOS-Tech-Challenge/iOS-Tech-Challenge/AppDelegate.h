//
//  AppDelegate.h
//  iOS-Tech-Challenge
//
//  Created by AKI on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mNav.h"
#import "DFBlunoManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property(strong, nonatomic) DFBlunoDevice* blunoDev;
@property(strong, nonatomic) DFBlunoManager* blunoManager;
@property NSString* itemName;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) mNav *nav;

@end

