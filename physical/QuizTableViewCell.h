//
//  QuizTableViewCell.h
//  physical
//
//  Created by mac- t4 on 15/7/2.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UISegmentedControl *resultSegment;
@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UIView *backView;
//给用户介绍赋值并且实现自动换行
-(void)setTitleText:(NSString*)text;
@end
