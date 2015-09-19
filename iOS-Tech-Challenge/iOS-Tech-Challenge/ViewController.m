//
//  ViewController.m
//  iOS-Tech-Challenge
//
//  Created by AKI on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import "ViewController.h"

#import "QntView.h"

#import "InventoryViewController.h"


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *leftTableView;
    NSArray *tableArr;
}
@end

@implementation ViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.backgroundImage = [UIImage imageNamed:@"1.jpg"];
        self.leftWidth = 250;
        tableArr = [[NSArray alloc] initWithObjects:@"管理",@"進貨訂貨",@"庫存盤點",@"其他", nil];
        
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    //add left sidebar
    leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.leftContentView.frame.size.width, self.leftContentView.frame.size.height-20)];
    leftTableView.backgroundColor = [UIColor clearColor];
    leftTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    leftTableView.dataSource = self;
    leftTableView.delegate = self;
    [self.leftContentView addSubview:leftTableView];
    
    QntView *view = [[QntView alloc] initWithFrame:CGRectMake(150, 150, 150, 60)];
    UIButton *btnAdd = (UIButton *)[[view viewWithTag:99] viewWithTag:3];
    [btnAdd addTarget:self action:@selector(btnAdd:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btnMinus = (UIButton *)[[view viewWithTag:99] viewWithTag:1];
    [btnMinus addTarget:self action:@selector(btnMinus:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:view];
    
    
    [view setColor:[UIColor redColor]];
}

-(void)btnAdd:(id)sender{
    [((QntView *)[[sender superview] superview])Add];
}

-(void)btnMinus:(id)sender{
    [((QntView *)[[sender superview] superview])Minus];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    cell.textLabel.text = [tableArr objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

	if (indexPath.row == 2) {
		InventoryViewController *vc = [[InventoryViewController alloc] init];
		[self.navigationController pushViewController:vc animated:YES];
	}

    [self closeSideView:YES];
}



@end
