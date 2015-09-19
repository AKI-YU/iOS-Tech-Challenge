//
//  ParseAPI.m
//  iOS-Tech-Challenge
//
//  Created by Lee-Sheng Chen on 9/19/15.
//  Copyright © 2015 AKI. All rights reserved.
//

#define Product @""

#import "ParseAPI.h"

@implementation ParseAPI


+(PFQuery*)productMenu{
    
    PFQuery *query = [PFQuery queryWithClassName:@"AWS_Product"];
    
    return query;
    
}

@end
