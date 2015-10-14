//
//  QuizTableViewCell.m
//  physical
//
//  Created by mac- t4 on 15/7/2.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import "QuizTableViewCell.h"
#import "PhysicalPrefix.pch"

#define CONTROL_HEIGHT 30

@implementation QuizTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, fDeviceWidth-30, 40)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        
        self.resultSegment = [[UISegmentedControl alloc]initWithItems:@[@"根本不",@"很少",@"有时",@"经常",@"总是"]];
        _resultSegment.tintColor = [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
        
        self.view = [[UIView alloc]init];
        
        self.backView = [[UIView alloc]init];
        
    }
    return self;
}

//赋值 and 自动换行,计算出cell的高度
-(void)setTitleText:(NSString*)text{
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.titleLabel.text = text;
    //设置label的最大行数
    self.titleLabel.numberOfLines = 0;

    [_titleLabel sizeToFit];
    //计算出自适应的高度
    frame.size.height = _titleLabel.frame.size.height + 45;
    
    self.view.frame = CGRectMake(0, 0, fDeviceWidth-20, _titleLabel.frame.size.height+5);
    _view.backgroundColor = [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:0.3f];

    [self.view addSubview:_titleLabel];
    
    self.resultSegment.frame = CGRectMake(20, self.view.frame.origin.y+self.view.frame.size.height+5, fDeviceWidth-60, 30);
    
    self.frame = frame;

    
    _backView.frame = CGRectMake(0, 0, fDeviceWidth-20, _titleLabel.frame.size.height + 45);
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.cornerRadius = 8;
    _backView.layer.masksToBounds = YES;
    _backView.layer.borderWidth = 1;
    _backView.layer.borderColor = [[UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f]CGColor];
    [self.contentView addSubview:_backView];
    [_backView addSubview:_view];
    [_backView addSubview:_resultSegment];

    self.backgroundColor = [UIColor clearColor];

  
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
