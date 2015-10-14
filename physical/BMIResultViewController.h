//
//  BMIResultViewController.h
//  physical
//
//  Created by mac- t4 on 15/8/10.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMIResultViewController : UIViewController
@property (nonatomic) float result;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UILabel *BMIValue;
@property (weak, nonatomic) IBOutlet UILabel *weight;

@property (weak, nonatomic) IBOutlet UILabel *illness;

@end
