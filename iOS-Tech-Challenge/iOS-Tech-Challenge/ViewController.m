//
//  ViewController.m
//  iOS-Tech-Challenge
//
//  Created by AKI on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *leftTableView;
    NSArray *tableArr;
}
@end

@implementation ViewController

- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        self.backgroundImage = [UIImage imageNamed:@"logo.png"];
        self.leftWidth = 250;
        tableArr = [[NSArray alloc] initWithObjects:@"管理",@"進貨訂貨",@"庫存盤點",@"其他", nil];
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //add left sidebar
    leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.leftContentView.frame.size.width, self.leftContentView.frame.size.height-20)];
    leftTableView.backgroundColor = [UIColor clearColor];
    leftTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    leftTableView.dataSource = self;
    leftTableView.delegate = self;
    [self.leftContentView addSubview:leftTableView];
    
    
    
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
    [self closeSideView:YES];
}


@end
