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

#define Tag 1000

@interface IngredientsUploadTableViewController ()
<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *m_products;
@property (weak, nonatomic) IBOutlet UITableView *m_tableview;
- (IBAction)totalUpload:(id)sender;

@end

@implementation IngredientsUploadTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
}

-(void)loadData{
    
    [self showHud];
    
    [ParseAPI aws_productMenu:^(NSArray *array) {
       
        self.m_products = [NSMutableArray array];
        
        for (int i = 0 ; i < [array count]; i++) {
            
            [self.m_products addObject:[array[i] objectForKey:@"Product_name"]];
        }
        [self.m_tableview reloadData];
        [self finishGetData];
    }];
    
}

-(void)finishGetData{
    
    [self performSelector:@selector(hideHud)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark < UITableViewDataSource,UITableViewDelegate >

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.m_products count];
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
  
    cell.i_displayLabel.text = @"0";
    
    [cell.i_AddBtn setTag:Tag+indexPath.row];
    [cell.i_AddBtn addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [cell.i_MinusBtn setTag:Tag+indexPath.row];
    [cell.i_MinusBtn addTarget:self action:@selector(minus:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [cell.i_uploadBtn setTag:Tag+indexPath.row];
    [cell.i_uploadBtn addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
    
    return  cell;
}

-(void)add:(UIButton*)sender{
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:sender.tag-Tag inSection:0];
    
    IngredientsUploadTableViewCell *cell = (IngredientsUploadTableViewCell*)[self.m_tableview cellForRowAtIndexPath:index];
    
    NSString *str =  cell.i_displayLabel.text;
    
    cell.i_displayLabel.text = [NSString stringWithFormat:@"%ld",str.integerValue+1];
    
}

-(void)minus:(UIButton*)sender{
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:sender.tag-Tag inSection:0];
    
    IngredientsUploadTableViewCell *cell = (IngredientsUploadTableViewCell*)[self.m_tableview cellForRowAtIndexPath:index];
    
    NSString *str =  cell.i_displayLabel.text;
    
    if (str.integerValue <= 0 ) {
        return;
    }
    
    cell.i_displayLabel.text = [NSString stringWithFormat:@"%ld",str.integerValue-1];
}

-(void)upload:(UIButton*)sender{
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:sender.tag-Tag inSection:0];
    
    IngredientsUploadTableViewCell *cell = (IngredientsUploadTableViewCell*)[self.m_tableview cellForRowAtIndexPath:index];
    
    NSString *productName =  cell.i_productLable.text;
    NSString *amount =  cell.i_displayLabel.text;
    
    [ParseAPI aws_uploadUsingRecord:productName
                             amount:amount.integerValue
                        andCallback:^(BOOL result){
        
    if (result) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"上傳成功" message:nil
                        delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil];
        [alert show];
    }
                            
    cell.i_displayLabel.text = @"0";
                 
            
    }];
 
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(IBAction)btnMenu:(id)sender{
    [self showMenu];
}

- (IBAction)totalUpload:(id)sender {
    
    
    
    for (int i = 0 ; i < [self.m_products count]; i++) {
        
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
        
        IngredientsUploadTableViewCell *cell = (IngredientsUploadTableViewCell*)[self.m_tableview cellForRowAtIndexPath:index];
        
    
        NSString *productName =  cell.i_productLable.text;
        NSString *amount =  cell.i_displayLabel.text;
        if (amount.integerValue > 0) {
            
            [ParseAPI aws_uploadUsingRecord:productName
                                     amount:amount.integerValue
                                andCallback:^(BOOL result){
                                    
                                    if (result) {
                                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"上傳成功" message:nil
                                                                                      delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil];
                                        [alert show];
                                    }
                                    
                                    cell.i_displayLabel.text = @"0";
                                    
                                    
                                }];

        }
    }
}
@end
