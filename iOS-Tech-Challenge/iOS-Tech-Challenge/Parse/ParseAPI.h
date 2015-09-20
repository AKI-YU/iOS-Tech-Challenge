//
//  ParseAPI.h
//  iOS-Tech-Challenge
//
//  Created by Lee-Sheng Chen on 9/19/15.
//  Copyright © 2015 AKI. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Parse/PFQuery.h>


@interface ParseAPI : NSObject

//上傳   "訂"單單
+(void)aws_orderWithOrderID:(NSInteger)order_id         //訂單編號
                productName:(NSString*)productName      //訂單產品名稱
                orderAmount:(NSInteger)amount           //訂單數量
                   orderPPL:(NSString*)order_ppl        //訂單人
                      price:(NSInteger)pirce            //訂單價錢
                andCallback:(void (^)(BOOL))callback;   //成功與否callback
//上傳   "進"貨單
+(void)aws_purchaseWithPurchaseId:(NSString*)purchase_Id //進貨編號
                       OrderID:(NSInteger)order_id       //進貨編號
                   productName:(NSString*)name           //進貨產品名稱
                   orderAmount:(NSInteger)amount         //進貨數量
                      orderPPL:(NSString*)checker        //進貨檢查員
                         price:(NSInteger)pirce          //訂單價錢
                   andCallback:(void (^)(BOOL))callback; //成功與否callback

//取得 "訂"貨單
+(void)aws_OrderDetail:(void (^)(NSArray *))callback;

//取得 "進"貨單
+(void)aws_PurchaseDetail:(void (^)(NSArray *))callback;

//取得原料資料
+(void)aws_IngredientDetail:(void (^)(NSArray *))callback;

//取得庫存資料
+(void)aws_WarehouseDetail:(void (^)(NSArray *))callback;

//取得公司細節資料
+(void)aws_companyDetail:(void (^)(NSArray *))callback;

//取得menu
+(void)aws_productMenu:(void (^)(NSArray *))callback;



@end
