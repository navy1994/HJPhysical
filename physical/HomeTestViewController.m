//
//  HomeTestViewController.m
//  physical
//
//  Created by mac- t4 on 15/8/10.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import "HomeTestViewController.h"
#import "PhysicalTestViewController.h"
#import "PhysicalPrefix.pch"


@interface HomeTestViewController ()

@end

@implementation HomeTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:[UIScreen mainScreen].bounds andColors:@[[UIColor whiteColor],[UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f]]];
    self.title = @"健康测试";
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)clickTizhi:(id)sender {
   PhysicalTestViewController *TestHome = [[PhysicalTestViewController alloc]init];
    TestHome.title = @"体质测试";
    TestHome.tips = @"本测试过程分为9步，可能占用你3-5分钟时间；为了保证测试结果的准确性，请根据您当前的特征认真选择。";
    TestHome.aboutString = @"本测试软件完全依据中华中医医药会颁布的《中国体质分类与判定》标准(标准号ZYYXH/T157-2009)设计,具有权威性,并已申请软件著作权登记(登记号2013SR137631).";
    TestHome.controller = 1;
    [self.navigationController pushViewController:TestHome animated:YES];
}

- (IBAction)clickXianti:(id)sender {
    PhysicalTestViewController *TestHomeViewController = [[PhysicalTestViewController alloc]init];
    TestHomeViewController.title = @"纤体测试";
    TestHomeViewController.controller = 2;
    [self.navigationController pushViewController:TestHomeViewController animated:YES];
}

- (IBAction)clickBMI:(id)sender {
    PhysicalTestViewController *testHome = [[PhysicalTestViewController alloc]init];
    testHome.title = @"BMI测试";
    testHome.tips = @"";
    testHome.aboutString = @"";
    testHome.controller = 3;
    [self.navigationController pushViewController:testHome animated:YES];
}

- (IBAction)clickFuzhi:(id)sender {
    PhysicalTestViewController *testHome = [[PhysicalTestViewController alloc]init];
    testHome.title = @"肤质测试";
    testHome.controller = 4;
    [self.navigationController pushViewController:testHome animated:YES];
}
@end
