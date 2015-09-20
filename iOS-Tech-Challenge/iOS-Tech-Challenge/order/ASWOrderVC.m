//
//  ASWOrderVC.m
//  iOS-Tech-Challenge
//
//  Created by LaiKuan Wen on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import "ASWOrderVC.h"
#import "ASWOrderCell.h"
#import "ASWOrderModel.h"
#import "ASWOrderDraftSelectVC.h"

@interface ASWOrderVC ()
@property (weak, nonatomic) IBOutlet UIView *m_viewLine;
@property (weak, nonatomic) IBOutlet UITableView *m_tableView;
@property (weak, nonatomic) IBOutlet UILabel *m_lbEONumber;
@property (weak, nonatomic) IBOutlet UILabel *m_lbEODate;
@property (weak, nonatomic) IBOutlet UILabel *m_lbSum;
@property (weak, nonatomic) IBOutlet UIButton *m_btnAddNew;
@property (strong, nonatomic) ASWOrderModel *m_model;
@property (strong, nonatomic) NSArray *m_aryTableData;
@end

@interface ASWOrderVC (UITableView_Delegate)<UITableViewDelegate>
@end

@interface ASWOrderVC (UITableView_Datasource)<UITableViewDataSource>
@end

@interface ASWOrderVC (ASWOrderModel_Delegate)<ASWOrderModelDelegate>
@end

@interface ASWOrderVC (ASWOrderDraftSelectVC_Delegate)<ASWOrderDraftSelectVCDelegate>

@end

@implementation ASWOrderVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationBar];
    
    self.m_aryTableData = [NSArray array];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy/MM/dd";
    NSString *strDate = [formater stringFromDate:date];
    self.m_lbEODate.text = strDate;
    
    formater.dateFormat = @"yyyyMMdd";
    NSString *strEONumber = [NSString stringWithFormat:@"EO%@%.3d",[formater stringFromDate:date],[self.m_model aswGetTodaySerialNo]];
    self.m_lbEONumber.text = strEONumber;
    
    self.m_btnAddNew.layer.cornerRadius = self.m_btnAddNew.frame.size.width/2;
    self.m_viewLine.layer.cornerRadius = 16;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Public Method

- (void) aswUpdateDataWithEONumber:(NSString *)strEONumber
{
    
}

#pragma mark - Private Method

- (void) setNavigationBar
{
    self.navigationItem.title = @"訂貨單";
    
    UIBarButtonItem *buttonItem;
    NSMutableArray  *aryUIBarButtonItem = [NSMutableArray array];
    
    buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"下訂" style:UIBarButtonItemStylePlain target:self action:@selector(onBtnAdviceClick:)];
    [aryUIBarButtonItem addObject:buttonItem];
    
    buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"草稿" style:UIBarButtonItemStylePlain target:self action:@selector(onBtnCancelClick:)];
    [aryUIBarButtonItem addObject:buttonItem];
    
    buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"儲存" style:UIBarButtonItemStylePlain target:self action:@selector(onBtnSaveClick:)];
    [aryUIBarButtonItem addObject:buttonItem];
    
    buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"建議" style:UIBarButtonItemStylePlain target:self action:@selector(onBtnAdviceClick:)];
    [aryUIBarButtonItem addObject:buttonItem];
    
    self.navigationItem.rightBarButtonItems = aryUIBarButtonItem;

}

/** 按取消鍵 */
- (void) onBtnCancelClick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

/** 按儲存鍵 */
- (void) onBtnSaveClick:(UIButton *)btn
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic = [userDefaults objectForKey:ASW_KEY_DicOrderEditing];
    if (nil == dic)
    {
        dic = [NSMutableDictionary dictionary];
    }
    [dic setObject:self.m_aryTableData forKey:[NSString stringWithFormat: @"%@",self.m_lbEONumber.text]];
    
    [userDefaults setObject:dic forKey:ASW_KEY_DicOrderEditing];
    [userDefaults synchronize];
}

/** 按草稿鍵 */
- (void)onBtnDraftClick:(UIButton *)btn
{
    ASWOrderDraftSelectVC *vc = [[ASWOrderDraftSelectVC alloc] init];
    UIView *view = vc.view;
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.origin.y = frame.size.height;
    frame.size.height = frame.size.height/3;
    view.frame = frame;
    [UIView animateWithDuration:0.5f
                     animations:^(void){
                         CGRect frame = vc.view.frame;
                         frame.origin.y = frame.origin.y - frame.size.height;
                     }
                     completion:^(BOOL finished){
        
    }];
}

/** 按建議鍵 */
- (void) onBtnAdviceClick:(UIButton *)btn
{
    
}

- (void) onBtnAddNewClick:(UIButton *)btn
{
    
}

@end

@implementation ASWOrderVC (UITableView_Datasource)

/** Section Number */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/** Cell Number */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.m_aryTableData count];
}

/** Cell View */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //建立Cell
    ASWOrderCell *cell;
    Class cellClass = [cell class];
    NSString *strCellIdentifier = NSStringFromClass(cellClass);
    cell = [self.m_tableView dequeueReusableCellWithIdentifier:strCellIdentifier];
    if (nil == cell)
    {
        NSArray *aryNib = [[NSBundle mainBundle] loadNibNamed:strCellIdentifier
                                         owner:self
                                       options:nil];
        for (UIView *view in aryNib)
        {
            if ([view isKindOfClass:cellClass])
            {
                cell = (ASWOrderCell *)view;
                break;
            }
        }
        
        UINib *nibRegister = [UINib nibWithNibName:strCellIdentifier
                                            bundle:[NSBundle mainBundle]];
        [self.m_tableView registerNib:nibRegister forCellReuseIdentifier:strCellIdentifier];
    }

    [cell aswUpdateWithDictionary:self.m_aryTableData[indexPath.row]];
    return cell;
}

@end

@implementation ASWOrderVC (UITableView_Delegate)


@end

@implementation ASWOrderVC (ASWOrderModel_Delegate)

- (void) aswTotalDidChange:(NSInteger)total;
{
    self.m_lbSum.text = [NSString stringWithFormat:@"%d",total];
}

@end

@implementation ASWOrderVC (ASWOrderDraftSelectVC_Delegate)

- (void) aswDidSelectDraft:(NSString *)strEONumber
{
    [self aswUpdateDataWithEONumber:strEONumber];
}

@end