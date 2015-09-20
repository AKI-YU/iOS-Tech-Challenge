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
#define AWS_PURCHASE @"purchase"
#define WAREHOUSE @"warehouse"
#define USE @"use"
#define AWS_INGREDIENTS @"AWS_Ingredients"


//Parse AWS_Order Name  (訂單)
#define ORDER_ID @"order_id"
#define NAME @"name"
#define AMOUNT @"amount"
#define ORDER_PPL @"order_ppl"
#define PRICE @"price"


//Parse Purchase Name  (進貨單)

#define PURCHASE_ID @"purchase_id"
#define CHECKED @"checked"
#define CHECKER @"checker"
#define P_FRESH_TIME @"p_fresh_time"


#define NO_DATA_LOG NSLog(@"Did Not Get Data");



#import "ParseAPI.h"

@implementation ParseAPI

+(void)aws_orderWithOrderID:(NSInteger)order_id     //訂單編號
                productName:(NSString*)productName  //訂單產品名稱
                orderAmount:(NSInteger)amount       //訂單數量
                   orderPPL:(NSString*)order_ppl    //訂單人
                      price:(NSInteger)pirce        //訂單價錢
                andCallback:(void (^)(BOOL))callback{
    
    //    訂單編號規則  年+月+日期+001
    //    ex 2015+09+20+001
    //    ex 001 會一直往上疊加  ~需要先從資料庫取下""訂單""編號 然後在+1
    
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


//進貨單
+(void)aws_purchaseWithPurchaseId:(NSString*)purchase_Id    //進貨編號
                       OrderID:(NSInteger)order_id       //進貨的訂單編號
                   productName:(NSString*)name    //進貨產品名稱
                   orderAmount:(NSInteger)amount         //進貨數量
                      orderPPL:(NSString*)checker        //進貨檢查員
                         price:(NSInteger)pirce          //訂單價錢
                   andCallback:(void (^)(BOOL))callback  //成功與否callback
{
    
    //    訂單編號是從order_id那邊取下來的
    

    //    進貨編號規則  po+年+月+日期+001
    //    ex po+2015+09+20+001
    //    ex 001 會一直往上疊加  ~需要先從資料庫取下""進貨""編號 然後在+1
    
    PFObject *newGroup = [PFObject objectWithClassName:AWS_PURCHASE];
    newGroup[PURCHASE_ID] = purchase_Id;
    newGroup[CHECKER] = checker;
    newGroup[NAME] = name;
    newGroup[AMOUNT] =  [NSNumber numberWithInteger:amount];
    newGroup[CHECKED] = [NSNumber numberWithInteger:1];
    newGroup[PRICE] =   [NSNumber numberWithInteger:pirce];
    
    [newGroup saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         return callback(succeeded);
     }];
}

//取得 "訂"貨單
+(void)aws_OrderDetail:(void (^)(NSArray *))callback{
    
    PFQuery *query = [PFQuery queryWithClassName:AWS_ORDER];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        
        if (results)
            callback(results);
        else
            NO_DATA_LOG
            }];
    
    
}

//取得 "進"貨單
+(void)aws_PurchaseDetail:(void (^)(NSArray *))callback{
    
    PFQuery *query = [PFQuery queryWithClassName:AWS_PURCHASE];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        
        if (results)
            callback(results);
        else
            NO_DATA_LOG
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
        
        
        if (results)
            callback(results);
        else
            NO_DATA_LOG
                
    }];
    
    //            NSLog(@"results");
    //            NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:results.count];
    //            for (PFObject *obj in results) {
    //                [arr addObject:obj[@"company"]];
    //            }
}

+(void)aws_IngredientDetail:(void (^)(NSArray *))callback{
    
    PFQuery *query = [PFQuery queryWithClassName:AWS_INGREDIENTS];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        
        
        if (results)
            callback(results);
        else
            NO_DATA_LOG
                
    }];
}


+(void)aws_WarehouseDetail:(void (^)(NSArray *))callback{
    
    PFQuery *query = [PFQuery queryWithClassName:WAREHOUSE];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        
        if (results)
            callback(results);
        else
            NO_DATA_LOG
            
    }];
}



@end
