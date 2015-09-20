//
//  SJDataTableViewCell.m
//  SJDataTableView
//
//  Created by LeeSungJu on 2015. 7. 31..
//  Copyright (c) 2015년 LeeSungJu. All rights reserved.
//

#import "SJDataTableViewCell.h"
#import "UIColor+Inventory.h"

@implementation SJDataTableViewCell
{
    UILabel *headLabel;
    UIView * bgView;
    NSMutableArray * labelArray;
    NSMutableArray * bgArray;
    CGSize itemSize;
    NSArray * keyArray;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier itemSize:(CGSize)size headerArray:(NSArray*)headerArray
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        itemSize = size;
        keyArray = headerArray;
        labelArray = [NSMutableArray new];
        bgArray = [NSMutableArray new];
		self.backgroundColor = [UIColor clearColor];
		self.contentView.backgroundColor = [UIColor clearColor];
        [self setupLabel];
    }
    return self;
}

- (void)setupLabel
{
    for (int i = 0; i < [keyArray count]-1; i++)
    {
        bgView = [[UIView alloc] initWithFrame:CGRectMake(i*itemSize.width, 0, itemSize.width, itemSize.height)];
		bgView.backgroundColor = [UIColor colorDataBg];
        [self addSubview:bgView];
        
        headLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, bgView.frame.size.width - 40, bgView.frame.size.height - 20)];
        [headLabel setAdjustsFontSizeToFitWidth:YES];
		headLabel.textColor = [UIColor colorDataText];
        [bgView addSubview:headLabel];
        [labelArray addObject:headLabel];
        [bgArray addObject:bgView];
    }

	[self.discardBtn setTitle:@"報廢" forState:UIControlStateNormal];
	[self addSubview:self.discardBtn];
}

- (UIButton *)discardBtn
{
	if (!_discardBtn) {
		_discardBtn = [[UIButton alloc] initWithFrame:CGRectMake(([keyArray count]-2)*itemSize.width, 0, itemSize.width-5, itemSize.height-5)];
		_discardBtn.backgroundColor = [UIColor lightGrayColor];
		[_discardBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_discardBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
	}
	return _discardBtn;
}

-(void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict = dataDict;
    
    for (int i = 0; i < [labelArray count]; i++)
    {
        UILabel * tempLabel = [labelArray objectAtIndex:i];
        switch (i) {
            case 0:
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i+1]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
                break;
                
            case 1:
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i+1]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
                break;
                
            case 2:
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i+1]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
                break;
                
            case 3:
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i+1]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
                break;
                
            case 4:
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i+1]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
                break;
                
            default:
                break;
        }
    }

	NSString *amountNow = dataDict[@"現有數量"];
	if (amountNow && [amountNow isEqualToString:@"0"]) {
		self.discardBtn.hidden = YES;
	}
}

@end
