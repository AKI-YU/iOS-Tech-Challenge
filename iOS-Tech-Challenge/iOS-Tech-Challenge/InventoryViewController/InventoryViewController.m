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
#import "UIImage+ImageEffects.h"
#import "Masonry.h"
#import <Parse/Parse.h>
#import "MLClass.h"
#import "Constants.h"


@interface InventoryViewController () <SJDataTableViewDelegate>
@property (nonatomic, strong) SJDataTableView *table;
@property (nonatomic, strong) NSArray *headerAarray;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSArray *dataResult;
@end

@implementation InventoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.headerAarray = @[@"品項", @"現有數量", @"最近保存期限", @"功能"];
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
														headerSize:CGSizeMake(150, 70)];
	self.table.cjDelegate = self;
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

	[self uiSetting];
}

- (void)uiSetting
{
	self.bgImageView.image = [self blurWithImageEffects:[UIImage imageNamed:@"Order2.jpg"]];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self queryWareHouse];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];

	[self.table reloadDataTable];
}

#pragma mark -
- (void)didTapDiscardButton:(UIButton *)sender
{
	PFObject *obj = self.dataResult[sender.tag];
	obj[ParseClassWareHouseAmount] = @0;
	[obj saveEventually:nil];

	[self setTableWithPFObjectsArr:self.dataResult];

	PFObject *purchaseObj = obj[ParseClassWareHousePurchase];
	if (purchaseObj) {
		NSDate *arrivedDate = purchaseObj[ParseClassPurchaseArriveDate];
		NSLog(@"%@", arrivedDate);
		NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:arrivedDate];
		NSInteger day = (NSInteger)interval / (24.0 * 60 * 60);
		NSLog(@"%s %ld %ld", __PRETTY_FUNCTION__, sender.tag, day);

		[MLClass saveUsage:obj[ParseClassWareHouseProduct] :(int)day];
		[MLClass queryAWS_Ingredients:obj[ParseClassWareHouseProduct] :(int)day];
	}
}

#pragma mark -


- (void)queryWareHouse
{
	PFQuery *query = [[PFQuery alloc] initWithClassName:ParseClassWareHouse];
	[query includeKey:ParseClassWareHousePurchase];
	query.cachePolicy = kPFCachePolicyCacheThenNetwork;
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
		if (!error) {
			self.dataResult = objects;
			[self setTableWithPFObjectsArr:self.dataResult];
		}
	}];
}

- (void)setTableWithPFObjectsArr:(NSArray *)objects
{
	NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:objects.count];
	for (NSInteger i = 0 ; i< objects.count; i++) {
		PFObject *obj = objects[i];
		NSMutableDictionary *dataDict = [NSMutableDictionary new];
		NSString *productName = obj[ParseClassWareHouseProduct];
		NSString *amount = [NSString stringWithFormat:@"%@", obj[ParseClassWareHouseAmount]];

		NSDate *freshDate = obj[ParseClassWareHouseFresh];
		NSString *strDate = @"";
		if (freshDate) {
			strDate = [self.dateFormatter stringFromDate:freshDate];
		}

		[dataDict setObject:productName forKey:[self.headerAarray objectAtIndex:0]];
		[dataDict setObject:amount forKey:[self.headerAarray objectAtIndex:1]];
		[dataDict setObject:strDate forKey:[self.headerAarray objectAtIndex:2]];
		[dataDict setObject:@"" forKey:[self.headerAarray objectAtIndex:3]];
		[dataArray addObject:dataDict];
	}

	[self.table setHeaderArray:self.headerAarray dataArray:dataArray];
	[self.table reloadDataTable];
}

- (NSArray *)dataResult
{
	if (!_dataResult) {
		_dataResult = [[NSArray alloc] init];
	}
	return _dataResult;
}

- (NSDateFormatter *)dateFormatter
{
	if (!_dateFormatter) {
		_dateFormatter = [[NSDateFormatter alloc] init];
		//[_dateFormatter setDateFormat:@"yyyy-MM-dd"];
		[_dateFormatter setDateFormat:@"MM/dd"];
	}
	return _dateFormatter;
}

- (IBAction)showMenuInventory:(id)sender {
	[self showMenu];
}

#pragma mark - blur
- (UIImage *)blurWithImageEffects:(UIImage *)image
{
	return [image applyBlurWithRadius:10 tintColor:[UIColor colorWithWhite:1 alpha:0.1] saturationDeltaFactor:1.5 maskImage:nil];
}

@end
