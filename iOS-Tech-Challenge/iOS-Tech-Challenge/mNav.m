//
//  mNav.m
//  iOS-Tech-Challenge
//
//  Created by AKI on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import "mNav.h"

@interface mNav ()

@end

@implementation mNav

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationBar.backgroundColor = [UIColor blackColor];//[UIColor colorWithRed:3.0f/255.0f green:48.0f/255.0f blue:30.0f/255.0f alpha:0.8];
    
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
