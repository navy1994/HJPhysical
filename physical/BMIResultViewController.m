//
//  BMIResultViewController.m
//  physical
//
//  Created by mac- t4 on 15/8/10.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import "BMIResultViewController.h"
#import "PhysicalPrefix.pch"
#import "PhysicalTestViewController.h"

@interface BMIResultViewController ()
@property (nonatomic, strong) NSString *weightString;
@property (nonatomic, strong) NSString *illnessString;

/**
 *  判断结果
 */
- (void)calculateResult;
@end

@implementation BMIResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:[UIScreen mainScreen].bounds andColors:@[[UIColor whiteColor],[UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f]]];
    self.scrollView.frame = CGRectMake(0, 0, fDeviceWidth, fDeviceHeight);
    self.scrollView.contentSize = CGSizeMake(fDeviceWidth,fDeviceHeight+200);
    
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_chbackbtn"] style:UIBarButtonItemStylePlain target:self action:@selector(previousToViewController)];
    
    UILabel *ceshi = [[UILabel alloc]initWithFrame:CGRectMake(30, 84, 80, 25)];
    ceshi.text = @"测试结果";
    [self.scrollView addSubview:ceshi];
    [self.scrollView addSubview:ceshi];
    
    NSArray *views = [[NSBundle mainBundle]loadNibNamed:@"TestResult" owner:self options:nil];
    UIView *view = [views firstObject];
    view.frame = CGRectMake(30, ceshi.frame.origin.y+ceshi.frame.size.height, fDeviceWidth-60, 180);
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 3;
    view.layer.borderColor = [[UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f]CGColor];
    [self.scrollView addSubview:view];
    
    [self calculateResult];
    self.BMIValue.text = [NSString stringWithFormat:@"您的BMI指数为：%.2f",self.result];
    self.weight.text = [NSString stringWithFormat:@"您的体重状况为：%@",_weightString];
    self.illness.text = [NSString stringWithFormat:@"相关疾病发病的危险性：%@",_illnessString];
    self.illness.numberOfLines = 0;
    [self.illness sizeToFit];
    
    
    view.frame = CGRectMake(30, ceshi.frame.origin.y+ceshi.frame.size.height, fDeviceWidth-60, 100+self.BMIValue.frame.size.height+_weight.frame.size.height+_illness.frame.size.height);
}

- (void)previousToViewController{
    PhysicalTestViewController *homeViewController = [[PhysicalTestViewController alloc]init];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[homeViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}

- (void)calculateResult{
    if (_result < 18.5) {
        _weightString = @"偏瘦";
        _illnessString = @"增加（相关疾病：贫血、血尿等）";
    }else if (_result >= 18.5 && _result <=23.9){
        _weightString = @"正常";
        _illnessString = @"平均水平";
    }else if (_result > 23.9 && _result <= 26.9){
        _weightString = @"偏胖";
        _illnessString = @"增加（相关疾病：高血压、心脏病等）";
    }else if (_result > 26.9 && _result <= 29.9){
        _weightString = @"肥胖";
        _illnessString = @"中度增加（相关疾病：高血压、心脏病等）";
    }else{
        _weightString = @"重度肥胖";
        _illnessString = @"严重增加（相关疾病：高血压、心脏病等）";
    }
}

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

@end
