//
//  ViewController.m
//  iOS-Tech-Challenge
//
//  Created by AKI on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import "ViewController.h"
#import "KRKNN.h"


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
    
   
    

  
}


- (IBAction)onBurger:(id)sender {
    [self showMenu];
}


-(void)setFreshDate{
    
    KRKNN *_knn = [KRKNN sharedInstance];
    
    // Features are wording appeared times on a paper as below like :
    // Apple, OS, Mobile, Taiwan, Japan, Developer
    [_knn addFeatures:@[@20, @9, @1, @3, @6, @2]
                group:@"Apple Fans"
           identifier:@"Smith"];
    
    [_knn addFeatures:@[@52, @32, @18, @7, @0, @1]
                group:@"Apple Fans"
           identifier:@"John"];
    
    [_knn addFeatures:@[@2, @20, @15, @5, @9, @16]
                group:@"Linux Fans"
           identifier:@"James"];
    
    [_knn addFeatures:@[@7, @11, @2, @12, @1, @0]
                group:@"Linux Fans"
           identifier:@"Terry"];
    
    [_knn addFeatures:@[@20, @8, @3, @21, @8, @25]
                group:@"Android Fans"
           identifier:@"Sam"];
    
    [_knn addFeatures:@[@2, @30, @8, @6, @33, @29]
                group:@"Android Fans"
           identifier:@"Amy"];
    
    [_knn classifyFeatures:@[@20, @1, @10, @2, @12, @3]
                identifier:@"Bob"
                 kNeighbor:3
                completion:^(BOOL success, NSString *ownGroup, NSInteger groupCounts, NSDictionary *allData) {
                    if( success )
                    {
                        NSLog(@"ownGroup : %@", ownGroup);
                       
                        
                    }
                }];
    
}


@end
