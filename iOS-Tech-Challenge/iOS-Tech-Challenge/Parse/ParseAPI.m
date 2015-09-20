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



//Parse Use Record  (使用記錄)

#define FLOUR @"flour"
#define MILK_A @"milk_a"
#define MILK_B @"milk_b"
#define OIL @"oil"
#define SUGAR_A @"sugar_a"
#define SUGAR_B @"sugar_b"
#define TEA_A @"tea_a"
#define TEA_B @"tea_b"
#define BEE @"bee"
#define CHEESE @"cheese"
#define PRODUCT_ID @"product_id"
#define DATE1 @"date"





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


+(void)aws_uploadUsingRecord:(NSString*)product //產品名稱
                      amount:(NSInteger)amount //當前產品數量
                 andCallback:(void (^)(BOOL))callback{
    
    PFObject *newGroup = [PFObject objectWithClassName:USE];
    newGroup[PRODUCT_ID] = product;
    newGroup[DATE1] = [NSDate date];
    

    newGroup[AMOUNT] = [NSNumber numberWithInteger:amount];
    
    NSArray *ingredientsArray = [NSArray arrayWithObjects:FLOUR,MILK_A,MILK_B,OIL,SUGAR_A,SUGAR_B,TEA_A,TEA_B,BEE,CHEESE, nil];
    
    NSInteger randomIngredient_1 = arc4random() % ingredientsArray.count;
    NSInteger randomIngredient_2 = arc4random() % ingredientsArray.count;
    NSInteger randomComponent = arc4random() % 3;
    
    NSString *Ingredient_1 = ingredientsArray[randomIngredient_1];
    NSString *Ingredient_2 = ingredientsArray[randomIngredient_2];
    
    for (int i = 0 ; i < [ingredientsArray count]; i++) {
        
        if ([ingredientsArray[i] isEqual:Ingredient_1]) {
            newGroup[Ingredient_1] = [NSNumber numberWithInteger:randomIngredient_1*randomComponent];
        }else if ([ingredientsArray[i] isEqual:Ingredient_2]){
            newGroup[Ingredient_2] = [NSNumber numberWithInteger:randomIngredient_2*randomComponent];
        }else{
            newGroup[ingredientsArray[i]] = [NSNumber numberWithInteger:0];
        }
    }
    
    [newGroup saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         return callback(succeeded);
     }];
    
}



@end
