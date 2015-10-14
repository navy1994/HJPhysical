//
//  AppDelegate.h
//  physical
//
//  Created by mac- t4 on 15/7/2.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGLNavigationController.h"

@class HomeTestViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) HomeTestViewController *physicalViewController;
@property (strong, nonatomic) MGLNavigationController *physicalNavigationController;

@end

