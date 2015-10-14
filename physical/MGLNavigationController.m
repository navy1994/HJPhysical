//
//  MGLNavigationController.m
//  physical
//
//  Created by mac- t4 on 15/7/29.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import "MGLNavigationController.h"

@implementation MGLNavigationController

- (id)init{
    self = [super init];
    if (self) {
        [self.navigationBar setBarTintColor:[UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f]];
        //NSMutableArray *colorArray = [[NSMutableArray alloc]initWithArray:ColorScheme(ColorSchemeAnalogous, [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f], NO)];
        //UIColor *firstColor = [colorArray firstObject];
        
        //self.navigationBar.barTintColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:self.view.frame andColors:@[[UIColor whiteColor],[UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f],[UIColor yellowColor]]];
        [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                     
                                                     NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [self.navigationBar setTintColor:[UIColor whiteColor]];
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    //Return the style that best contrasts the navigationBar's barTintColor
    return [ChameleonStatusBar statusBarStyleForColor:self.navigationBar.barTintColor];
    
    //Shorthand
    //return StatusBarContrastColorOf(self.navigationBar.barTintColor);
}

@end
