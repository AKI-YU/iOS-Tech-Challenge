//
//  ParseAPI.m
//  iOS-Tech-Challenge
//
//  Created by Lee-Sheng Chen on 9/19/15.
//  Copyright © 2015 AKI. All rights reserved.
//



//Parse Class Name
#define AWS_PRODUCT @"AWS_Product"
#define COMPANY_DETAIL @"companyDetail"
#define AWS_ORDER @"AWS_Order"


//Parse AWS_Order Name
#define ORDER_ID @"order_id"
#define NAME @"name"
#define AMOUNT @"amount"
#define ORDER_PPL @"order_ppl"
#define PRICE @"price"



#define NO_DATA_LOG NSLog(@"Did Not Get Data");



#import "ParseAPI.h"

@implementation ParseAPI

+(void)aws_orderWithOrderID:(NSInteger)order_id     //訂單編號
                productName:(NSString*)productName  //訂單產品名稱
                orderAmount:(NSInteger)amount       //訂單數量
                   orderPPL:(NSString*)order_ppl    //訂單人
                      price:(NSInteger)pirce        //訂單價錢
                andCallback:(void (^)(BOOL))callback{
    
    
    PFObject *newGroup = [PFObject objectWithClassName:AWS_ORDER];
    newGroup[ORDER_ID] = [NSNumber numberWithInteger:order_id];
    newGroup[NAME] = productName;
    newGroup[AMOUNT] = [NSNumber numberWithInteger:amount];
    newGroup[ORDER_PPL] = order_ppl;
    newGroup[PRICE] = [NSNumber numberWithInteger:pirce];
    [newGroup saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         return callback(succeeded);
     }];
    
    
}
+(void)aws_productMenu:(void (^)(NSArray *))callback{
    
    PFQuery *query = [PFQuery queryWithClassName:AWS_PRODUCT];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        
        if (results)
            callback(results);
        else
            NO_DATA_LOG
            }];
}

+(void)aws_companyDetail:(void (^)(NSArray *))callback{
    
    
    PFQuery *query = [PFQuery queryWithClassName:COMPANY_DETAIL];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        
        if (results) {
            if (results)
                callback(results);
            else
                NO_DATA_LOG
                }
    }];
    
    //            NSLog(@"results");
    //            NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:results.count];
    //            for (PFObject *obj in results) {
    //                [arr addObject:obj[@"company"]];
    //            }
}


@end
