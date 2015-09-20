//
//  ViewController.m
//  iOS-Tech-Challenge
//
//  Created by AKI on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import "ViewController.h"
#import "ParseAPI.h"
#import "QntView.h"
#import "PurchaseViewController.h"
#import "InventoryViewController.h"
#import "ASWOrderMagVC.h"
#import "SellProductViewController.h"


@interface ViewController ()

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

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
    
    //[self.navigationController.navigationBar setHidden:YES];
    
    
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];


  
}


- (IBAction)onBurger:(id)sender {
    NSArray *images = @[
                        [UIImage imageNamed:@"gear"],
                        [UIImage imageNamed:@"globe"],
                        [UIImage imageNamed:@"profile"],
                        [UIImage imageNamed:@"star"],
                        ];
    NSArray *titles = @[
                        @"進貨",
                        @"訂單",
                        @"銷售",
                        @"庫存",
                        ];
    NSArray *colors = @[
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        ];
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images titles:titles selectedIndices:self.optionIndices borderColors:colors];
    //    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images];
    callout.delegate = self;
    //    callout.showFromRight = YES;
    [callout show];
}

#pragma mark - RNFrostedSidebarDelegate

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    NSLog(@"Tapped item at index %ld",index);
    if (index == 0) {
        PurchaseViewController *purchase = [[PurchaseViewController alloc] initWithNibName:@"PurchaseViewController" bundle:nil];
        [self.navigationController pushViewController:purchase animated:YES];
        
    }else if (index == 1) {
        ASWOrderMagVC *order = [[ASWOrderMagVC alloc] init];
        [self.navigationController pushViewController:order animated:YES];
        
    }else if (index == 2) {
        SellProductViewController *sell = [[SellProductViewController alloc] initWithNibName:@"SellProductViewController" bundle:nil];
        [self.navigationController pushViewController:sell animated:YES];
        
    }else if (index == 3) {
        InventoryViewController *order = [[InventoryViewController alloc] init];
        [self.navigationController pushViewController:order animated:YES];
        
    }
    
    [sidebar dismiss];
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index {
    if (itemEnabled) {
        [self.optionIndices addIndex:index];
    }
    else {
        [self.optionIndices removeIndex:index];
    }
}

@end
