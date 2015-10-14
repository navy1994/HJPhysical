//
//  ResultView.m
//  physical
//
//  Created by mac- t4 on 15/7/7.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import "ResultView.h"
#import "PhysicalPrefix.pch"
#import "Chameleon.h"

@implementation ResultView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        //self.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:[UIScreen mainScreen].bounds andColors:@[[UIColor whiteColor],[UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f]]];
        self.backgroundColor = [UIColor clearColor];
        
        self.tezhengName = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, fDeviceWidth-10, 20)];
        _tezhengName.font = [UIFont boldSystemFontOfSize:18];
        _tezhengName.textColor = [UIColor colorWithRed:242.0f/255.0f green:129.0f/255.0f blue:37.0f/255.0f alpha:1.0f];
        [self addSubview:_tezhengName];
        
        self.tezheng = [[UILabel alloc]initWithFrame:CGRectMake(5, self.tezhengName.frame.origin.y+self.tezhengName.frame.size.height, fDeviceWidth-10, 80)];
        _tezheng.font = [UIFont boldSystemFontOfSize:14];
        _tezheng.textColor = [UIColor colorWithRed:242.0f/255.0f green:129.0f/255.0f blue:37.0f/255.0f alpha:1.0f];
        _tezheng.numberOfLines = 0;
        [self addSubview:_tezheng];
        
        self.yangsheng = [[UILabel alloc]initWithFrame:CGRectMake(5, self.tezheng.frame.origin.y+self.tezheng.frame.size.height, fDeviceWidth-10, 20)];
        _yangsheng.font = [UIFont boldSystemFontOfSize:14];
        _yangsheng.textColor = [UIColor colorWithRed:242.0f/255.0f green:129.0f/255.0f blue:37.0f/255.0f alpha:1.0f];
        _yangsheng.numberOfLines = 0;
        [self addSubview:_yangsheng];
        
        self.medName = [[UILabel alloc]initWithFrame:CGRectMake(5, self.yangsheng.frame.origin.y+self.yangsheng.frame.size.height+10, fDeviceWidth-10, 20)];
        _medName.font = [UIFont boldSystemFontOfSize:18];
        _medName.textColor = [UIColor colorWithRed:242.0f/255.0f green:129.0f/255.0f blue:37.0f/255.0f alpha:1.0f];
        _medName.numberOfLines = 0;
        [self addSubview:_medName];
        
        self.med = [[UILabel alloc]initWithFrame:CGRectMake(5, self.medName.frame.origin.y+self.medName.frame.size.height, fDeviceWidth-10, 20)];
        _med.font = [UIFont boldSystemFontOfSize:14];
        _med.textColor = [UIColor colorWithRed:242.0f/255.0f green:129.0f/255.0f blue:37.0f/255.0f alpha:1.0f];
        _med.numberOfLines = 0;
        [self addSubview:_med];
        
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(fDeviceWidth/12, self.med.frame.origin.y+self.med.frame.size.height+5, fDeviceWidth*5/6, fDeviceWidth*5/6)];
        [self addSubview:_imageView];
        
        self.medtips = [[UILabel alloc]initWithFrame:CGRectMake(5, self.imageView.frame.origin.y+self.imageView.frame.size.height+5, fDeviceWidth-10, 60)];
        _medtips.font = [UIFont boldSystemFontOfSize:14];
        _medtips.textColor = [UIColor colorWithRed:242.0f/255.0f green:129.0f/255.0f blue:37.0f/255.0f alpha:1.0f];
        _medtips.numberOfLines = 0;
        [self addSubview:_medtips];
        
}
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
