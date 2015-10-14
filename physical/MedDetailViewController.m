//
//  MedDetailViewController.m
//  physical
//
//  Created by mac- t4 on 15/7/8.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import "MedDetailViewController.h"
#import "PhysicalPrefix.pch"
#import "MBProgressHUD.h"

@interface MedDetailViewController ()<UIWebViewDelegate,MBProgressHUDDelegate>
@property(nonatomic,strong) UIWebView *newsWebView;
@property(strong , nonatomic) MBProgressHUD * hud;   //进度指示器
@property(strong , nonatomic) NSMutableSet * historySet; //记录已浏览过的网页
@end

@implementation MedDetailViewController
@synthesize historySet;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _medTitle;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_chbackbtn"] style:UIBarButtonItemStylePlain target:self action:@selector(previousToViewController)];
    
    historySet = [[NSMutableSet alloc] init];
    self.newsWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight)];
    _newsWebView.delegate = self;
    [_newsWebView setScalesPageToFit:YES];
    NSString *encodedString = [_urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [_newsWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:encodedString]]];
    [self.view addSubview:_newsWebView];
    
    _hud = [[MBProgressHUD alloc]initWithView:self.view];
    _hud.delegate = self;
    _hud.dimBackground = TRUE;
    _hud.labelText = @"正在加载";
    [self.view addSubview:_hud];
    
}

- (void)previousToViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- UIWEbViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [_hud show:YES];
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_hud hide:YES];
    NSLog(@"webViewDidFinishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [_hud hide:YES];
    NSLog(@"webViewFaildLoad%@",error);
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
