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
@property (nonatomic, strong) SJDataTableView *table;
@property (nonatomic, strong) NSArray *headerAarray;
@end

@implementation InventoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.headerAarray = @[@"品項", @"現有數量", @"最近到期日", @"單位"];
	NSMutableArray *dataArray = [NSMutableArray new];
	for (int i = 0 ; i< 20; i++) {
		NSMutableDictionary *dataDict = [NSMutableDictionary new];
		[dataDict setObject:[NSString stringWithFormat:@"name_%d",i] forKey:[self.headerAarray objectAtIndex:0]];
		[dataDict setObject:[NSString stringWithFormat:@"value1_%d",i] forKey:[self.headerAarray objectAtIndex:1]];
		[dataDict setObject:[NSString stringWithFormat:@"value2_%d",i] forKey:[self.headerAarray objectAtIndex:2]];
		[dataDict setObject:[NSString stringWithFormat:@"value3_%d",i] forKey:[self.headerAarray objectAtIndex:3]];
		[dataArray addObject:dataDict];
	}

	//CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
	self.table =[[SJDataTableView alloc] initWithFrame:self.view.bounds
														headerSize:CGSizeMake(100, 70)];
	[self.table setHeaderArray:self.headerAarray dataArray:dataArray];
	[self.view addSubview:self.table];
	[self.table mas_makeConstraints:^(MASConstraintMaker *make) {
		make.leading.equalTo(self.view.mas_leading).offset(100);
		make.trailing.equalTo(self.view.mas_trailing).offset(-30);
		make.top.equalTo(self.view.mas_top).offset(30);
		make.bottom.equalTo(self.view.mas_bottom).offset(-30);
	}];

	//self.view.backgroundColor = [UIColor whiteColor];
	self.table.backgroundColor = [UIColor clearColor];
	[self queryWareHouse];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];

	[self.table reloadDataTable];
}

#define ParseClassWareHouse @"warehouse"
#define ParseClassWareHouseProduct @"product_name"
#define ParseClassWareHouseAmount @"amount"
- (void)queryWareHouse
{
	PFQuery *query = [[PFQuery alloc] initWithClassName:ParseClassWareHouse];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
		if (!error) {
			NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:objects.count];
			for (NSInteger i = 0 ; i< objects.count; i++) {
				PFObject *obj = objects[i];
				NSMutableDictionary *dataDict = [NSMutableDictionary new];
				NSString *productName = obj[ParseClassWareHouseProduct];
				NSString *amount = [NSString stringWithFormat:@"%@", obj[ParseClassWareHouseAmount]];
				[dataDict setObject:productName forKey:[self.headerAarray objectAtIndex:0]];
				[dataDict setObject:amount forKey:[self.headerAarray objectAtIndex:1]];
				[dataDict setObject:[NSString stringWithFormat:@"value2_%ld",i] forKey:[self.headerAarray objectAtIndex:2]];
				[dataDict setObject:[NSString stringWithFormat:@"value3_%ld",i] forKey:[self.headerAarray objectAtIndex:3]];
				[dataArray addObject:dataDict];
			}
			[self.table setHeaderArray:self.headerAarray dataArray:dataArray];
			[self.table reloadDataTable];
//			for (PFObject *obj in objects) {
//				NSLog(@"%s %@", __PRETTY_FUNCTION__, obj[ParseClassWareHouseProduct]);
//			}
		}
	}];
}
- (IBAction)showMenuInventory:(id)sender {
	[self showMenu];
}

@end
