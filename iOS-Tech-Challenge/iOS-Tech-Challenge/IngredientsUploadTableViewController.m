//
//  IngredientsUploadTableViewController.m
//  iOS-Tech-Challenge
//
//  Created by Lee-Sheng Chen on 9/20/15.
//  Copyright © 2015 AKI. All rights reserved.
//
#import "ParseAPI.h"
#import "IngredientsUploadTableViewController.h"
#import "IngredientsUploadTableViewCell.h"

@interface IngredientsUploadTableViewController ()
<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *m_products;

@end

@implementation IngredientsUploadTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)loadData{
    
    [self showHud];
    
    [ParseAPI aws_productMenu:^(NSArray *array) {
       
        self.m_products = [NSMutableArray array];
        
        for (int i = 0 ; i < [array count]; i++) {
            
            [self.m_products addObject:[array[i] objectForKey:@"Product_name"]];
        }
    }];
    
    
    [self performSelector:@selector(hideHud)
               withObject:nil
               afterDelay:3.];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark < UITableViewDataSource,UITableViewDelegate >

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Identifier";
    
    
    IngredientsUploadTableViewCell *cell = (IngredientsUploadTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell){
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"IngredientsUploadTableViewCell" owner:self options:nil];
        for (id tempView in views) {
            if ([tempView isKindOfClass:[UITableViewCell class]]){
                cell = ( IngredientsUploadTableViewCell *) tempView;
                break;
            }
        }
    }
    
    cell.i_productLable.text = (NSString*)self.m_products[indexPath.row];
    
    
    cell.i_displayLabel.text = @"1";
    
    [cell.i_displayLabel setTag:1000+indexPath.row];
    
    
    [cell.i_AddBtn setTag:1000+indexPath.row];
    [cell.i_AddBtn addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [cell.i_MinusBtn setTag:1000+indexPath.row];
    [cell.i_MinusBtn addTarget:self action:@selector(minus:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return  cell;
}

-(void)add:(UIButton*)sender{
    
    
    
    
}

-(void)minus:(UIButton*)sender{
    
    
    
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
