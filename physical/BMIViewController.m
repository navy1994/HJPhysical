//
//  BMIViewController.m
//  physical
//
//  Created by mac- t4 on 15/8/10.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import "BMIViewController.h"
#import "BMIResultViewController.h"
#import "PhysicalPrefix.pch"

@interface BMIViewController ()<UITextFieldDelegate>

@end

@implementation BMIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:[UIScreen mainScreen].bounds andColors:@[[UIColor whiteColor],[UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f]]];
    _backView.layer.cornerRadius = 8;
    _backView.layer.masksToBounds = YES;
    _backView.layer.borderWidth = 5;
    _backView.layer.borderColor = [[UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f]CGColor];
    _heightTF.delegate = self;
    _weightTF.delegate = self;
    _heightTF.keyboardType = UIKeyboardTypeNumberPad;
    _weightTF.keyboardType = UIKeyboardTypeNumberPad;
    _heightTF.text = @"165";
    _weightTF.text = @"50";
    
    _resultBtn.backgroundColor = [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
    _resultBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    _resultBtn.layer.cornerRadius = 5;
    _resultBtn.layer.masksToBounds = YES;
    _resultBtn.tintColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWillHide:(NSNotification *) notification {
//    float animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
//    CGFloat height = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
//    
//    CGRect bottomBarFrame = self.mToolBar.frame;
//    [UIView beginAnimations:@"bottomBarDown" context:nil];
//    [UIView setAnimationDuration: animationDuration];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    bottomBarFrame.origin.y += height;
//    [self.mToolBar setFrame:bottomBarFrame];
//    [UIView commitAnimations];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0.0;
        self.view.frame = frame;
    }];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_heightTF resignFirstResponder];
    [_weightTF resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0.0;
        self.view.frame = frame;
    }];
}

#pragma mark ---- UITextFiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (_heightTF==textField || _weightTF==textField ) {
        [_heightTF resignFirstResponder];
        [_weightTF resignFirstResponder];
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = 0.0;
            self.view.frame = frame;
        }];
    }
    return YES;
}

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//    if ([_heightTF resignFirstResponder] && [_weightTF resignFirstResponder]) {
//        [UIView animateWithDuration:0.3 animations:^{
//            CGRect frame = self.view.frame;
//            frame.origin.y = 0.0;
//            self.view.frame = frame;
//        }];
//
//    }
//    return YES;
//}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGFloat offset = self.view.frame.size.height- (_backView.frame.origin.y+_backView.frame.size.height + 216 +50);
    if (offset <= 0) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = offset;
            self.view.frame = frame;
        }];
    }
    return YES;
}

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        CGRect frame = self.view.frame;
//        frame.origin.y = 0.0;
//        self.view.frame = frame;
//    }];
//    return YES;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickBtnToResult:(id)sender {
    BMIResultViewController *resultViewController = [[BMIResultViewController alloc]init];
    resultViewController.result = [_weightTF.text floatValue]/(([_heightTF.text floatValue]*[_heightTF.text floatValue])/10000);
    [self.navigationController pushViewController:resultViewController animated:YES];
}
@end
