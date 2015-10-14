//
//  PhysicalTestHomeView.m
//  physical
//
//  Created by mac- t4 on 15/7/2.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import "PhysicalTestHomeView.h"
#import "PhysicalPrefix.pch"
#import "Chameleon.h"

#define CONTROL_HEIGHT 30

@implementation PhysicalTestHomeView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        float x,y;
        if (fDeviceWidth==375) {
            x = 375/320;
            y = 667/568;
        }else if(fDeviceWidth==414){
            x = 414/320;
            y = 736/568;
        }else{
            x = 1;
            y = 1;
        }
        self.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:[UIScreen mainScreen].bounds andColors:@[[UIColor whiteColor],[UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f]]];
        self.logoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.origin.y+30, fDeviceWidth, 40*y)];
        _logoLabel.text = @"食方生活";
        _logoLabel.font = [UIFont boldSystemFontOfSize:30];
        _logoLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_logoLabel];
        
        self.tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, _logoLabel.frame.origin.y+_logoLabel.frame.size.height+20, fDeviceWidth-80, 80*y)];
       // _tipsLabel.text = @"本测试过程分为9步，可能占用你3-5分钟时间；为了保证测试结果的准确性，请根据您当前的特征认真选择。";
        _tipsLabel.font = [UIFont boldSystemFontOfSize:14*y];
        _tipsLabel.numberOfLines = 0;
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipsLabel];
        
        self.sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-80, _tipsLabel.frame.origin.y+_tipsLabel.frame.size.height+20, 50, CONTROL_HEIGHT*y)];
        _sexLabel.text = @"性别:";
        _sexLabel.font = [UIFont boldSystemFontOfSize:15*y];
        [self addSubview:_sexLabel];
        
        self.sexSegment = [[UISegmentedControl alloc]initWithItems:@[@"男",@"女"]];
        _sexSegment.frame = CGRectMake(_sexLabel.frame.origin.x+_sexLabel.frame.size.width+5, _sexLabel.frame.origin.y, 100, CONTROL_HEIGHT*y);
        _sexSegment.tintColor = [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
        [self addSubview:_sexSegment];
        
        self.ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-80, _sexLabel.frame.origin.y+_sexLabel.frame.size.height+15, 50, CONTROL_HEIGHT*y)];
        _ageLabel.text = @"年龄:";
        _ageLabel.font = [UIFont boldSystemFontOfSize:15*y];
        [self addSubview:_ageLabel];
        
        self.ageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _ageBtn.frame = CGRectMake(_ageLabel.frame.origin.x+_ageLabel.frame.size.width+5, _ageLabel.frame.origin.y, 100, CONTROL_HEIGHT*y);
        _ageBtn.backgroundColor = [UIColor clearColor];
        [self addSubview:_ageBtn];
        
        self.ageResultLabel = [[UILabel alloc]initWithFrame:_ageBtn.frame];
        _ageResultLabel.text = @"20岁以下";
        _ageResultLabel.font = [UIFont boldSystemFontOfSize:15*y];
        [self addSubview:_ageResultLabel];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(_ageResultLabel.frame.size.width-10, 10, 15, 10)];
        imageView.image = [UIImage imageNamed:@"f_up"];
        [self.ageResultLabel addSubview:imageView];
        
        self.startTestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _startTestBtn.frame = CGRectMake(fDeviceWidth/2-80, _ageLabel.frame.origin.y+_ageLabel.frame.size.height+20, 160, 40*y);
        [_startTestBtn setTitle:@"开始测试" forState:UIControlStateNormal];
        _startTestBtn.backgroundColor = [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
        _startTestBtn.layer.cornerRadius = 5;
        _startTestBtn.layer.masksToBounds = YES;
        [self addSubview:_startTestBtn];
        
        
        self.aboutTestLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, _startTestBtn.frame.origin.y+_startTestBtn.frame.size.height-40, fDeviceWidth-80, self.frame.size.height-_startTestBtn.frame.origin.y+_startTestBtn.frame.size.height-30)];
        _aboutTestLabel.textColor = [UIColor colorWithRed:242.0f/255.0f green:129.0f/255.0f blue:37.0f/255.0f alpha:1.0f];
        _aboutTestLabel.font = [UIFont boldSystemFontOfSize:15*y];
        _aboutTestLabel.textAlignment = NSTextAlignmentCenter;
        _aboutTestLabel.numberOfLines = 0;
        [self addSubview:_aboutTestLabel];

    }
    
    return self;
    
}

@end
