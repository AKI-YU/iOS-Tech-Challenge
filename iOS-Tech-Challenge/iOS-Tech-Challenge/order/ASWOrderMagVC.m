//
//  ASWOrderMagVC.m
//  iOS-Tech-Challenge
//
//  Created by LaiKuan Wen on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import "ASWOrderMagVC.h"
#import "ASWOrderModel.h"
#import "ASWOrderMagCell.h"
#import "ASWOrderVC.h"
#import "ParseAPI.h"

@interface ASWOrderMagVC ()

@property (weak, nonatomic) IBOutlet UIView *m_view;
@property (weak, nonatomic) IBOutlet UIView *m_viewTitle;
@property (weak, nonatomic) IBOutlet UITableView *m_tableView;
@property (weak, nonatomic) IBOutlet UIButton *m_btnAddNew;
@property (strong, nonatomic) NSArray *m_aryTableData;

@end

@interface ASWOrderMagVC (UITableView_Datasource)<UITableViewDataSource>
@end

@interface ASWOrderMagVC (UITableView_Delegate) <UITableViewDelegate>

@end

@implementation ASWOrderMagVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frame = self.navigationController.navigationBar.frame;
    NSLog(@"Navlocation: %f %f, %f %f",frame.origin.x,frame.origin.y,frame.size.height, frame.size.width);
    
    // Do any additional setup after loading the view from its nib.
    self.title = @"訂單管理";
    self.m_btnAddNew.layer.cornerRadius = (self.m_btnAddNew.frame.size.width)/2;
    [self.m_btnAddNew addTarget:self action:@selector(onBtnAddNewClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.m_view.layer.cornerRadius = 64;
    self.m_viewTitle.layer.cornerRadius = 4;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGRect frame = self.navigationController.navigationBar.frame;
    NSLog(@"Navlocation: %f %f, %f %f",frame.origin.x,frame.origin.y,frame.size.height, frame.size.width);
    [self aswReloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) onBtnAddNewClick:(UIButton *)btn
{
    ASWOrderVC *pushVC = [[ASWOrderVC alloc] init];
    [self.navigationController pushViewController:pushVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/** 重新填label 和 table */
- (void) aswReloadData
{
    [ParseAPI aws_OrderDetail:^(NSArray *array)
    {
        self.m_aryTableData = [self mergeSameOrderId:array];
        [self.m_tableView reloadData];
    }];
}
- (NSMutableArray *)mergeSameOrderId:(NSArray*)data
{
    NSMutableArray* res = [NSMutableArray new];
    NSMutableDictionary* orderIdMap = [NSMutableDictionary new];
    for (PFObject* obj in data) {
        NSNumber* orderId = obj[@"order_id"];
        if (!orderId) {
            continue;
        }
        
        if (!orderIdMap[orderId]) {
            orderIdMap[orderId] = [NSMutableArray new];
            [res addObject:orderIdMap[orderId]];
        }
        if (orderIdMap[orderId]) {
            NSMutableArray* array = orderIdMap[orderId];
            [array addObject:obj];
        }
    }
    return res;
}


@end

@implementation ASWOrderMagVC (UITableView_Datasource)

/** Section Number */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/** Cell Number */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d",[self.m_aryTableData count]);
    return [self.m_aryTableData count];
}

/** Cell View */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //建立Cell
    NSString *strCellIdentifier = @"aa";
    ASWOrderMagCell *cell = [self.m_tableView dequeueReusableCellWithIdentifier:strCellIdentifier];
    if (nil == cell)
    {
        NSArray *aryNib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ASWOrderMagCell class])
                                                        owner:self
                                                      options:nil];
        for (UIView *view in aryNib)
        {
            if ([view isKindOfClass:[ASWOrderMagCell class]])
            {
                cell = (ASWOrderMagCell *)view;
                break;
            }
        }
        
        UINib *nibRegister = [UINib nibWithNibName:NSStringFromClass([ASWOrderMagCell class])
                                            bundle:[NSBundle mainBundle]];
        [self.m_tableView registerNib:nibRegister forCellReuseIdentifier:strCellIdentifier];
    }
    
    [cell aswUpdateWithArray:self.m_aryTableData[indexPath.row]];

    return cell;
}

@end

@implementation ASWOrderMagVC (UITableView_Delegate)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFObject *obj = [self.m_aryTableData[indexPath.row] objectAtIndex:0];
    NSInteger a = [obj[@"order_id"] integerValue];
    NSString *str = [NSString stringWithFormat:@"%d",a] ;
    ASWOrderVC *pushVC = [[ASWOrderVC alloc] initWithEONumber:str];
    [self.navigationController pushViewController:pushVC animated:YES];
}

@end

