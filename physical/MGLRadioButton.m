//
//  MGLRadioButton.m
//  LifeCalculator
//
//  Created by mac- t4 on 15/8/6.
//  Copyright (c) 2015年 上海科文麦格里实业有限公司. All rights reserved.
//

#import "MGLRadioButton.h"

@implementation MGLRadioButton

- (id)initWithDelegate:(id)delegate groupId:(NSString *)groupId andTitle:(NSString*)title{
    self = [super initWithDelegate:delegate groupId:groupId];
    if (self) {
        [self setTitle:title forState:UIControlStateNormal];
        self.titleLabel.numberOfLines = 0;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];

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
