//
//  FuzhiResultViewController.m
//  physical
//
//  Created by mac- t4 on 15/8/10.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import "FuzhiResultViewController.h"
#import "PhysicalPrefix.pch"
#import "PhysicalTestViewController.h"

@interface FuzhiResultViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSString *fuzhiString;
@property (nonatomic, strong) NSString *tipsString;

@property (nonatomic, strong) UILabel *fuzhi;
@property (nonatomic, strong) UILabel *tips;

@end

@implementation FuzhiResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:[UIScreen mainScreen].bounds andColors:@[[UIColor whiteColor],[UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f]]];
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+200)];
    [self.view addSubview:_scrollView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_chbackbtn"] style:UIBarButtonItemStylePlain target:self action:@selector(previousToViewController)];

    
    UILabel *ceshi = [[UILabel alloc]initWithFrame:CGRectMake(30, 84, 80, 25)];
    ceshi.text = @"测试结果";
    [self.scrollView addSubview:ceshi];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(30, ceshi.frame.origin.y+ceshi.frame.size.height, fDeviceWidth-60, 180)];
    view.backgroundColor = [UIColor clearColor];
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 3;
    view.layer.borderColor = [[UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f]CGColor];
    [self.scrollView addSubview:view];
    
    [self calculateResult];
    
    self.fuzhi = [[UILabel alloc]initWithFrame:CGRectMake(30, 20, view.frame.size.width-60, 30)];
    _fuzhi.font = [UIFont boldSystemFontOfSize:18];
    _fuzhi.text = _fuzhiString;
    [view addSubview:_fuzhi];
    
    self.tips = [[UILabel alloc]initWithFrame:CGRectMake(30, self.fuzhi.frame.origin.y+self.fuzhi.frame.size.height+10, view.frame.size.width-60, view.frame.size.height - 90)];
    _tips.font = [UIFont boldSystemFontOfSize:15];
    _tips.numberOfLines = 0;
    _tips.text = _tipsString;
    [_tips sizeToFit];
    [view addSubview:_tips];
    
    view.frame = CGRectMake(30, ceshi.frame.origin.y+ceshi.frame.size.height, fDeviceWidth-60, 60+_fuzhi.frame.size.height+_tips.frame.size.height);
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
    if (self.sumScore<10) {
        _fuzhiString = @"干性肌肤";
        _tipsString = @"看来您的皮肤像沙漠一样干燥，赶紧给肌肤喂饱水吧，这样能缓解肌肤的脱皮现象，缓和皮肤紧绷感，祝您早日成为水美人！";
    }else if (self.sumScore>=11 && self.sumScore <= 14){
        _fuzhiString = @"中性肤质";
        _tipsString = @"您的肤质不错哦，继续保持吧。";
    }else if (self.sumScore >= 15 && self.sumScore <= 20){
        _fuzhiString = @"混合性肤质";
        _tipsString = @"亲，您的肌肤在需要补水的同时，一定要记得用收缩毛孔的护肤品呢。";
    }else{
        _fuzhiString = @"油性皮肤";
        _tipsString = @"身为油性肌肤的您，不但要做好控油的工作，还需要给肌肤喂饱水呢，只要您做好控油的工作同时补水，就能脱离大油田呢，哦，记得要经常清洁你的皮肤呐。";
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
