//
//  SellProductViewController.m
//  iOS-Tech-Challenge
//
//  Created by AKI on 2015/9/20.
//  Copyright © 2015年 AKI. All rights reserved.
//


#import "SellProductViewController.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@interface SellProductViewController ()

@end

@implementation SellProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.navigationController.navigationBar setHidden:NO];
    mArray = [[NSMutableArray alloc] init];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self performSelector:@selector(queryWareHouse) withObject:nil afterDelay:0.1f];
    
}

-(IBAction)btnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}





#define ParseClassWareHouse @"warehouse"
- (void)queryWareHouse
{
    PFQuery *query = [[PFQuery alloc] initWithClassName:ParseClassWareHouse];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        NSLog(@"%@",objects);
        mArray = [[NSMutableArray alloc] initWithArray:objects];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [mTable reloadData];
        });
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --------------------------------------------------------
#pragma mark UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return mArray.count ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *cellIDT = [NSString stringWithFormat:@"TableViewCell-%ld",(long)indexPath.row];
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIDT];
    
    if (cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIDT];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        
        
    }
    
    cell.textLabel.text = [[mArray objectAtIndex:indexPath.row] objectForKey:@"product_name"];
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

#pragma mark --------------------------------------------------------

@end
