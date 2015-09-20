//
//  MLClass.m
//  iOS-Tech-Challenge
//
//  Created by AKI on 2015/9/20.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import "MLClass.h"
#import "KRKNN.h"
#import <Parse/Parse.h>

@implementation MLClass



+(void)saveUsage:(NSString *)productName :(int)freshDayCount{
    
    NSMutableArray *saveArray;
    
    if([productName rangeOfString:@"牛奶"].location != NSNotFound){
        
        saveArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"milkUsage"]];
        
        [saveArray addObject:[NSNumber numberWithInt:freshDayCount]];
        [[NSUserDefaults standardUserDefaults] setObject:saveArray forKey:@"milkUsage"];
        
        
    }else{
        saveArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"non_milkUsage"]];
        [saveArray addObject:[NSNumber numberWithInt:freshDayCount]];
        [[NSUserDefaults standardUserDefaults] setObject:saveArray forKey:@"non_milkUsage"];
    }
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}




+(void)setFreshDate:(NSArray *)KRANNArray :(NSString *)productName :(int)freshDayCount{
    
    
    KRKNN *_knn = [KRKNN sharedInstance];
    
    for (NSInteger i=0;i<KRANNArray.count; i++) {
        if([productName rangeOfString:@"牛奶"].location != NSNotFound){
            [_knn addFeatures:@[[NSNumber numberWithInteger:[[[KRANNArray objectAtIndex:i] objectForKey:@"fresh_date"] integerValue]], @5, @20]
                        group:@"未過期"
                   identifier:@"牛奶"];
            
        }else{
            [_knn addFeatures:@[[NSNumber numberWithInteger:[[[KRANNArray objectAtIndex:i] objectForKey:@"fresh_date"] integerValue]], @30, @10]
                        group:@"未過期"
                   identifier:@"一般"];
        }
    }
    
    if([productName rangeOfString:@"牛奶"].location != NSNotFound){
        
        NSArray *saveArray = [[NSArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"milkUsage"]];
        
        for (NSInteger i=0;i<saveArray.count; i++) {
            [_knn addFeatures:@[[saveArray objectAtIndex:i], @5, @20]
                        group:@"過期"
                   identifier:@"牛奶"];
        }
    }else{
        
        
        NSArray *saveArray = [[NSArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"non_milkUsage"]];
        for (NSInteger i=0;i<saveArray.count; i++) {
            
            [_knn addFeatures:@[[saveArray objectAtIndex:i], @5, @20]
                        group:@"過期"
                   identifier:@"一般"];
            
        }
    }
    
    [_knn classifyFeatures:@[[NSNumber numberWithInt:freshDayCount], @1, @10]
                identifier:productName
                 kNeighbor:3
                completion:^(BOOL success, NSString *ownGroup, NSInteger groupCounts, NSDictionary *allData) {
                    if( success )
                    {
                        if ([ownGroup isEqualToString:@"過期"]) {
                            //updateFreshDate
                            
                            
                            
                        }
                        NSLog(@"ownGroup : %@", ownGroup);
                        
                        
                    }
                }];
    
}

#define ParseClassAWS_Ingredients @"AWS_Ingredients"
+(void)queryAWS_Ingredients:(NSString *)productName :(int)freshDayCount
{
    PFQuery *query = [[PFQuery alloc] initWithClassName:ParseClassAWS_Ingredients];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){

        [self setFreshDate:[[NSArray alloc] initWithArray:objects] :productName :freshDayCount];
        
    }];
}


@end
