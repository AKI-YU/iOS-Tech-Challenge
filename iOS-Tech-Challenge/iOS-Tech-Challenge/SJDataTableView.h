//
//  SJDataTableView.h
//  SJDataTableView
//
//  Created by LeeSungJu on 2015. 7. 31..
//  Copyright (c) 2015년 LeeSungJu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJDataFixItemTableView.h"
#import "SJDataTableViewCell.h"

@protocol SJDataTableViewDelegate <NSObject>

- (void)didTapDiscardButton:(UIButton *)sender;

@end

@interface SJDataTableView : UIView <UITableViewDataSource, UITableViewDelegate, SJDataFixItemTableViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame headerSize:(CGSize)size;
- (void)setHeaderArray:(NSArray*)headerArray dataArray:(NSArray*)dataArray;
- (void)reloadDataTable;

@property (nonatomic, weak) id <SJDataTableViewDelegate> cjDelegate;

@end
