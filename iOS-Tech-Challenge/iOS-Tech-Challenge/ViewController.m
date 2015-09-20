//
//  ViewController.m
//  iOS-Tech-Challenge
//
//  Created by AKI on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:YES];
    

  
}


- (IBAction)onBurger:(id)sender {
    [self showMenu];
}


@end
