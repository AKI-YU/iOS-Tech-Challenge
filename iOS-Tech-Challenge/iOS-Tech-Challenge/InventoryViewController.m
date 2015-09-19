//
//  InventoryViewController.m
//  iOS-Tech-Challenge
//
//  Created by cjlin on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import "InventoryViewController.h"
#import "SJDataTableView.h"

@interface InventoryViewController ()

@end

@implementation InventoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	NSArray * headerAarray = [[NSArray alloc] initWithObjects:@"Name", @"value1", @"value2", @"value3", @"value4", nil];
	NSMutableArray *dataArray = [NSMutableArray new];
	for (int i = 0 ; i< 20; i++) {
		NSMutableDictionary *dataDict = [NSMutableDictionary new];
		[dataDict setObject:[NSString stringWithFormat:@"name_%d",i] forKey:[headerAarray objectAtIndex:0]];
		[dataDict setObject:[NSString stringWithFormat:@"value1_%d",i] forKey:[headerAarray objectAtIndex:1]];
		[dataDict setObject:[NSString stringWithFormat:@"value2_%d",i] forKey:[headerAarray objectAtIndex:2]];
		[dataDict setObject:[NSString stringWithFormat:@"value3_%d",i] forKey:[headerAarray objectAtIndex:3]];
		[dataDict setObject:[NSString stringWithFormat:@"value4_%d",i] forKey:[headerAarray objectAtIndex:4]];
		[dataArray addObject:dataDict];
	}

	SJDataTableView * table =[[SJDataTableView alloc] initWithFrame:self.view.bounds headerSize:CGSizeMake(100, 70)];
	[table setHeaderArray:headerAarray dataArray:dataArray];
	[self.view addSubview:table];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
