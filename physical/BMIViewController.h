//
//  BMIViewController.h
//  physical
//
//  Created by mac- t4 on 15/8/10.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMIViewController : UIViewController

//@property (nonatomic, strong) NSString *title;
@property (weak, nonatomic) IBOutlet UITextField *heightTF;
@property (weak, nonatomic) IBOutlet UITextField *weightTF;

@property (weak, nonatomic) IBOutlet UIButton *resultBtn;

@property (weak, nonatomic) IBOutlet UIView *backView;

- (IBAction)clickBtnToResult:(id)sender;
@end
