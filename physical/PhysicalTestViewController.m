//
//  PhysicalTestViewController.m
//  physical
//
//  Created by mac- t4 on 15/7/2.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import "PhysicalTestViewController.h"
#import "BMIViewController.h"
#import "XiantiViewController.h"
#import "FuzhiViewController.h"
#import "HomeTestViewController.h"
#import "PhysicalTestHomeView.h"
#import "PhysicalPrefix.pch"
#import "PhysicalQuizViewController.h"
#import "HomeTestViewController.h"

@interface PhysicalTestViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_ageTableView;
    int selectSex;
}

@property (strong, nonatomic) PhysicalTestHomeView *homeView;
@property (strong, nonatomic) NSArray *ageArray;

@end

@implementation PhysicalTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.navigationController setNavigationBarHidden:NO];
      NSLog(@"==========%f======%f",fDeviceWidth,fDeviceHeight);
    self.view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:[UIScreen mainScreen].bounds andColors:@[[UIColor whiteColor],[UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f]]];
    
    self.title = self.title;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_chbackbtn"] style:UIBarButtonItemStylePlain target:self action:@selector(previousToViewController)];
    
    self.homeView = [[PhysicalTestHomeView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, fDeviceWidth, fDeviceHeight)];
    _homeView.tipsLabel.text = self.tips;
    _homeView.aboutTestLabel.text = _aboutString;
    [_homeView.ageBtn addTarget:self action:@selector(clickAgeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_homeView];
    [_homeView.startTestBtn addTarget:self action:@selector(clickStartTestBtn) forControlEvents:UIControlEventTouchUpInside];
    [_homeView.sexSegment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    _ageTableView = [[UITableView alloc]initWithFrame:CGRectMake(_homeView.ageBtn.frame.origin.x, _homeView.ageBtn.frame.origin.y, _homeView.ageBtn.frame.size.width+10, 100)];
    _ageTableView.layer.cornerRadius = 5;
    _ageTableView.layer.masksToBounds = YES;
    _ageTableView.dataSource = self;
    _ageTableView.delegate = self;
    _ageTableView.rowHeight = 30;
    [_ageTableView setHidden:YES];
    [self.homeView addSubview:_ageTableView];
    
    self.ageArray = @[@"20岁以下",@"20-35岁",@"35-45岁",@"45-55岁",@"55-65岁",@"65岁以上"];
}

-(void)segmentAction:(UISegmentedControl *)Seg{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    
    switch (Index) {
            
        case 0:
            selectSex = 6;//男性
            break;
            
        case 1:
            selectSex = 5;//女性
            break;
        default:
            
            break;
            
    }
    
}

#pragma mark --- PhysicalNavigationDelegate
- (void)previousToViewController{
    HomeTestViewController *homeViewController = [[HomeTestViewController alloc]init];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[homeViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}

- (void)clickAgeBtn{
    [_ageTableView setHidden:NO];
}

- (void)clickStartTestBtn{
    PhysicalQuizViewController *quizViewController = [[PhysicalQuizViewController alloc]init];
    quizViewController.selectRex = selectSex;
    
    BMIViewController *bmiViewController = [[BMIViewController alloc]init];
    
    XiantiViewController *xiantiViewController = [[XiantiViewController alloc]init];
    
    FuzhiViewController *fuzhiViewController = [[FuzhiViewController alloc]init];
    

    if (_homeView.sexSegment.selectedSegmentIndex >= 0) {
        switch (self.controller) {
            case 1:
                [self.navigationController pushViewController:quizViewController animated:YES];
                break;
            case 2:
                [self.navigationController pushViewController:xiantiViewController animated:YES];
                break;
            case 3:
                [self.navigationController pushViewController:bmiViewController animated:YES];
                break;
            case 4:
                [self.navigationController pushViewController:fuzhiViewController animated:YES];
                break;
            default:
                break;
        }
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请选择性别！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIndetifier = @"cell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIndetifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndetifier];
    }
    
    cell.textLabel.text = [_ageArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _homeView.ageResultLabel.text = [_ageArray objectAtIndex:indexPath.row];
    [_ageTableView setHidden:YES];
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
