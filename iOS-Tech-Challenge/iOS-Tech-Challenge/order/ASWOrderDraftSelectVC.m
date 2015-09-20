//
//  ASWOrderDraftSelectVC.m
//  iOS-Tech-Challenge
//
//  Created by LaiKuan Wen on 2015/9/20.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import "ASWOrderDraftSelectVC.h"

@interface ASWOrderDraftSelectVC ()
@property (weak, nonatomic) IBOutlet UITableView *m_tableView;
@property (strong, nonatomic) NSArray *m_aryTableData;
@end

@interface ASWOrderDraftSelectVC (UITableViewDelegate) <UITableViewDataSource, UITableViewDelegate >

@end


@implementation ASWOrderDraftSelectVC

- (instancetype) init
{
    self = [super init];
    if (nil != self)
    {
        NSUserDefaults *userdefault = [[NSUserDefaults alloc] init];
        NSDictionary *dic = [userdefault objectForKey:ASW_KEY_DicOrderEditing];
        self.m_aryTableData = [dic allKeys];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
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

@end

@implementation ASWOrderDraftSelectVC (UITableViewDelegate)

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
    UITableViewCell *cell;
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
                cell = (UITableViewCell *)view;
                break;
            }
        }
        
        UINib *nibRegister = [UINib nibWithNibName:strCellIdentifier
                                            bundle:[NSBundle mainBundle]];
        [self.m_tableView registerNib:nibRegister forCellReuseIdentifier:strCellIdentifier];
    }
    cell.textLabel.text = self.m_aryTableData[indexPath.row];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strEONumber = self.m_aryTableData[indexPath.row];
    [self.m_delegate aswDidSelectDraft:strEONumber];
}

@end
