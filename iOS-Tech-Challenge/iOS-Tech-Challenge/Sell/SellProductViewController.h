//
//  SellProductViewController.h
//  iOS-Tech-Challenge
//
//  Created by AKI on 2015/9/20.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellProductViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *mArray;
    IBOutlet UITableView *mTable;
}
@end
