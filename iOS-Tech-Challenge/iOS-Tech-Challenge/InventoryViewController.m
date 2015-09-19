//
//  InventoryViewController.m
//  iOS-Tech-Challenge
//
//  Created by cjlin on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import "InventoryViewController.h"
#import "SJDataTableView.h"
#import "Constants.h"
#import "Masonry.h"
#import <Parse/Parse.h>

@interface InventoryViewController ()

@end

@implementation InventoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	NSArray * headerAarray = @[@"品項", @"現有數量", @"最近到期日", @"單位"];
	NSMutableArray *dataArray = [NSMutableArray new];
	for (int i = 0 ; i< 20; i++) {
		NSMutableDictionary *dataDict = [NSMutableDictionary new];
		[dataDict setObject:[NSString stringWithFormat:@"name_%d",i] forKey:[headerAarray objectAtIndex:0]];
		[dataDict setObject:[NSString stringWithFormat:@"value1_%d",i] forKey:[headerAarray objectAtIndex:1]];
		[dataDict setObject:[NSString stringWithFormat:@"value2_%d",i] forKey:[headerAarray objectAtIndex:2]];
		[dataDict setObject:[NSString stringWithFormat:@"value3_%d",i] forKey:[headerAarray objectAtIndex:3]];
		[dataArray addObject:dataDict];
	}

	CGRect rect = CGRectMake(100, 0, self.view.frame.size.width, self.view.frame.size.height);
	SJDataTableView *table =[[SJDataTableView alloc] initWithFrame:rect
														 headerSize:CGSizeMake(100, 70)];
	[table setHeaderArray:headerAarray dataArray:dataArray];
	[self.view addSubview:table];
	[table mas_makeConstraints:^(MASConstraintMaker *make) {
		make.leading.equalTo(self.view.mas_leading).offset(100);
		make.trailing.equalTo(@0);
		make.top.equalTo(@0);
		make.bottom.equalTo(@0);
	}];

	self.view.backgroundColor = [UIColor whiteColor];
}

#define ParseClassWareHouse @"warehouse"
- (void)queryWareHouse
{
	PFQuery *query = [[PFQuery alloc] initWithClassName:ParseClassWareHouse];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){

	}];
}

@end
