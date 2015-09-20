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

//訂單
+(void)aws_orderWithOrderID:(NSInteger)order_id     //訂單編號
                productName:(NSString*)productName  //訂單產品名稱
                orderAmount:(NSInteger)amount       //訂單數量
                   orderPPL:(NSString*)order_ppl    //訂單人
                      price:(NSInteger)pirce        //訂單價錢
                andCallback:(void (^)(BOOL))callback;     //callback
//進貨單

//庫存

//公司細節
+(void)aws_companyDetail:(void (^)(NSArray *))callback;

//menu
+(void)aws_productMenu:(void (^)(NSArray *))callback;



@end
