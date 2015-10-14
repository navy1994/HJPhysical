//
//  ResultViewController.m
//  physical
//
//  Created by mac- t4 on 15/7/3.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//
#import <ShareSDK/ShareSDK.h>
#import "ResultViewController.h"
#import "PhysicalPrefix.pch"
#import "PhysicalTestViewController.h"
#import "MedDetailViewController.h"
#import "NTChartView.h"
#import "Question.h"
#import "ResultView.h"
#import "QuizDB.h"
#import "Quiz.h"
#import "Result.h"
#import "Chameleon.h"

@interface ResultViewController (){
    UIScrollView *_scrollView;
    float zhaunhuaScore;//转化分
    float stepScore1,stepScore2,stepScore3,stepScore4,stepScore5,stepScore6,stepScore7,stepScore8,stepScore9;//9步各自的分
    QuizDB *_dbQuiz;
}

@property (strong, nonatomic) NSMutableArray *stepScoreArray;//转化分数组
@property (strong, nonatomic) NSMutableArray *keyArray;
@property (strong, nonatomic) NSString *tiZhi;//体质
@property (strong, nonatomic) NSMutableArray *dbArray;
@property (strong, nonatomic) NSString *medTitle;
@property (strong, nonatomic) NSString *medUrl;
@property (strong, nonatomic) NSString *shardImage;

/**
 *计算测试分值
 */
- (void)calculateScore;

/**
 *绘制图表
 */
//-(void)drawChart:(UITableViewCell*)cell;
@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:[UIScreen mainScreen].bounds andColors:@[[UIColor whiteColor],[UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f]]];
    
    self.title = @"测试结果";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_chbackbtn"] style:UIBarButtonItemStylePlain target:self action:@selector(previousToViewController)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(clickShardBtn)];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight)];
    _scrollView.contentSize = CGSizeMake(fDeviceWidth, fDeviceWidth*2/3+250+fDeviceWidth*5/6);
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    //计算结果值
    [self calculateScore];
    //根据结果值从数据库加载对应数据
    _dbQuiz = [[QuizDB alloc]init];
    self.dbArray = [_dbQuiz getAllResultData:@"resultTable"];
    
    [self drawChart];
    
    [self layoutResult];
}

- (void)clickShardBtn{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:self.shardImage ofType:@"png"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"食方生活健康在线测试平台，测出您的健康！http://test.hpp18.com/?action=test&cmd=tizhi&step=1"
                                       defaultContent:@"食方生活健康在线测试平台，测出您的健康！"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"食方生活"
                                                  url:@"http://test.hpp18.com/?action=test&cmd=tizhi&step=1"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:nil arrowDirect:UIPopoverArrowDirectionUp];
    
    
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"分享成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                    [alert show];
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSString *typeString;
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                    if (type == ShareTypeQQ) { //QQ
                                        typeString = @"未安装QQ";
                                    }else if(type == ShareTypeWeixiSession     /**< 微信好友 */
                                             || type == ShareTypeWeixiTimeline  /**< 微信朋友圈 */
                                             || type == ShareTypeWeixiFav /**< 微信收藏 */){
                                        typeString = @"未安装微信";
                                    }else{
                                        typeString = @"链接失败";
                                    }
                                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"分享失败" message:typeString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                    [alert show];
                                }
                            }];
    
}

- (void)calculateScore{//计算测试分值
    int sumStep1=0,sumStep2=0,sumStep3=0,sumStep4=0,sumStep5=0,sumStep6=0,sumStep7=0,sumStep8=0,sumStep9=0;
    Question *question = [[Question alloc]init];
    for (int i = 0; i < _resultArray.count; i++) {
        question = [_resultArray objectAtIndex:i];
        switch (question.step) {
            case 8:
                sumStep1++;
                stepScore1 += question.result;//特禀
                break;
            case 1:
                sumStep2++;
                stepScore2 += question.result;//气虚
                break;
            case 2:
                sumStep3++;
                stepScore3 += question.result;//阳虚
                break;
            case 3:
                sumStep4++;
                stepScore4 += question.result;//阴虚
                break;
            case 4:
                sumStep5++;
                stepScore5 += question.result;//痰湿
                break;
            case 5:
                sumStep6++;
                stepScore6 += question.result;//湿热
                break;
            case 6:
                sumStep7++;
                stepScore7 += question.result;//血瘀
                break;
            case 7:
                sumStep8++;
                stepScore8 += question.result;//气郁
                break;
            case 0:
            {
                sumStep9++;
                if (question.ID==1 || question.ID==2 || question.ID==3 || question.ID==4 || question.ID==6 || question.ID==7) {//标有*的条目需要先逆向计分，即：1→5，2→4，3→3，4→2，5→1，再用公式计算转化分
                    switch (question.result) {
                        case 1:
                            stepScore9 += 5.0;
                            break;
                        case 2:
                            stepScore9 += 4.0;
                            break;
                        case 3:
                            stepScore9 += 3.0;
                            break;
                        case 4:
                            stepScore9 += 2.0;
                            break;
                        case 5:
                            stepScore9 += 1.0;
                            break;
                        default:
                            break;
                    }

                }else{
                    stepScore9 += question.result;//平和
                }
           }
                
                break;
            default:
                break;
        }
    }
    //计算转化分
    
    stepScore1 = (stepScore1 - sumStep1)*100.0/(sumStep1*4);
    stepScore2 = (stepScore2 - sumStep2)*100.0/(sumStep2*4);
    stepScore3 = (stepScore3 - sumStep3)*100.0/(sumStep3*4);
    stepScore4 = (stepScore4 - sumStep4)*100.0/(sumStep4*4);
    stepScore5 = (stepScore5 - sumStep5)*100.0/(sumStep5*4);
    stepScore6 = (stepScore6 - sumStep6)*100.0/(sumStep6*4);
    stepScore7 = (stepScore7 - sumStep7)*100.0/(sumStep7*4);
    stepScore8 = (stepScore8 - sumStep8)*100.0/(sumStep8*4);
    stepScore9 = (stepScore9 - sumStep9)*100.0/(sumStep9*4);
    NSLog(@"stepScore9:%f",stepScore9);
    
    self.stepScoreArray = [NSMutableArray arrayWithObjects:
                           [NSNumber numberWithFloat:stepScore1],
                           [NSNumber numberWithFloat:stepScore2],
                           [NSNumber numberWithFloat:stepScore3],
                           [NSNumber numberWithFloat:stepScore4],
                           [NSNumber numberWithFloat:stepScore5],
                           [NSNumber numberWithFloat:stepScore6],
                           [NSNumber numberWithFloat:stepScore7],
                           [NSNumber numberWithFloat:stepScore8],nil];
    self.keyArray = [NSMutableArray arrayWithObjects:@1,@2,@3,@4,@5,@6,@7,@8,nil];//@1特禀,@2气虚,@3阳虚,@4阴虚,@5痰湿,@6湿热,@7血瘀,@8气郁

    //对其他8种体质转化分进行排序
    NSLog(@"排序前：%@",self.stepScoreArray);
    NSMutableArray *sortResult = [[NSMutableArray alloc]init];
    sortResult = [self bubble:self.stepScoreArray andKey:self.keyArray];//进行冒泡排序，从小到大排序
    NSLog(@"排序后:%@",[sortResult objectAtIndex:0]);
    if (stepScore1>=60 && [[[sortResult objectAtIndex:0]objectAtIndex:7] floatValue]<30) {
        //平和质
        self.tiZhi = @"平和";
    }else if(stepScore1>=60 && [[[sortResult objectAtIndex:0]objectAtIndex:7] floatValue]<40){
        //基本是平和质
        [self judgePhysical:[[sortResult objectAtIndex:1]objectAtIndex:7]];
    }else{
       //偏颇体质
        if (stepScore1 >=40) {
            //偏颇体质
          [self judgePhysical:[[sortResult objectAtIndex:1]objectAtIndex:7]];
        }else if(stepScore1>=30 && stepScore1<=39){
            //基本是偏颇体质
          [self judgePhysical:[[sortResult objectAtIndex:1]objectAtIndex:7]];
        }
    }
}

- (void)judgePhysical:(NSNumber *)number{
    switch ([number intValue]) {
        case 1:
            //阳虚
            self.tiZhi = @"特禀";
            break;
        case 2:
            //阴虚
            self.tiZhi = @"气虚";
            break;
        case 3:
            //气虚
            self.tiZhi = @"阳虚";
            break;
        case 4:
            //痰湿
            self.tiZhi = @"阴虚";
            break;
        case 5:
            //湿热
            self.tiZhi = @"痰湿";
            break;
        case 6:
            //血瘀
            self.tiZhi = @"湿热";
            break;
        case 7:
            //特禀
            self.tiZhi = @"血瘀";
            break;
        case 8:
            //气郁
            self.tiZhi = @"气郁";
            break;
        default:
            break;
    }
}

- (void)layoutResult{
    
    ResultView *resultView = [[ResultView alloc]initWithFrame:CGRectMake(0,fDeviceWidth*2/3 + 5, fDeviceWidth, 250+fDeviceWidth*5/6)];
    //resultView.contentSize = CGSizeMake(fDeviceWidth, 460);
    NSLog(@"dbArray:%@",self.dbArray);
    NSLog(@"tizhi:%@",self.tiZhi);
    for (Result *result in self.dbArray) {
        if ([result.tiZhi isEqual:self.tiZhi]) {
            resultView.tezhengName.text = [NSString stringWithFormat:@"%@体质特征：",result.tiZhi];
            [resultView.tezhengName sizeToFit];
            resultView.tezheng.text     = result.tezheng;
            resultView.tezheng.frame = CGRectMake(5, resultView.tezhengName.frame.origin.y+resultView.tezhengName.frame.size.height, fDeviceWidth-10, 80);
            [resultView.tezheng sizeToFit];
            resultView.yangsheng.text   = [NSString stringWithFormat:@"养生要点：%@",result.yangsheng];
            resultView.yangsheng.frame = CGRectMake(5, resultView.tezheng.frame.origin.y+resultView.tezheng.frame.size.height, fDeviceWidth-10, 20);
            [resultView.yangsheng sizeToFit];
            resultView.medName.text     = [NSString stringWithFormat:@"%@体质专用产品",result.tiZhi];
            resultView.medName.frame = CGRectMake(5, resultView.yangsheng.frame.origin.y+resultView.yangsheng.frame.size.height+10, fDeviceWidth-10, 20);
            [resultView.medName sizeToFit];
            resultView.med.text         = [NSString stringWithFormat:@"天天平衡每日一杯——%@",result.med];
            resultView.med.frame = CGRectMake(5, resultView.medName.frame.origin.y+resultView.medName.frame.size.height, fDeviceWidth-10, 20);
            [resultView.med sizeToFit];
            self.medTitle               = result.med;
            self.shardImage             = result.image;
            resultView.imageView.image  = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",result.image]];
            //resultView.medtips.text = result.medtips;
            resultView.medtips.text     = nil;
            self.medUrl                 = result.url;
        }
    }
    UIButton *clickBtnDetailMed = [UIButton buttonWithType:UIButtonTypeCustom];
    clickBtnDetailMed.frame = CGRectMake(0, 120, resultView.frame.size.width, 200);
    clickBtnDetailMed.backgroundColor = [UIColor clearColor];
    [clickBtnDetailMed addTarget:self action:@selector(clickBtnToDetailMed) forControlEvents:UIControlEventTouchUpInside];
    [resultView addSubview:clickBtnDetailMed];
    [_scrollView addSubview:resultView];
    
}

- (void)clickBtnToDetailMed{
    NSLog(@"==================");
    MedDetailViewController *medDetailVC = [[MedDetailViewController alloc]init];
    medDetailVC.medTitle = self.medTitle;
    medDetailVC.urlString = self.medUrl;
    [self.navigationController pushViewController:medDetailVC animated:YES];
}

- (NSMutableArray *)bubble:(NSMutableArray *)dataArr andKey:(NSMutableArray*)keyArray
{
    int i, j;
    for (i = 0; i<[dataArr count]; i++) {
        for (j=0; j<[dataArr count]-1; j++) {
            if([[dataArr objectAtIndex:j] compare:[dataArr objectAtIndex:j+1]]==1)
            {
                NSLog(@"进行比较中");
                [dataArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                [keyArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    NSMutableArray *array = [NSMutableArray arrayWithObjects:dataArr,keyArray, nil];
    return array;
}

- (void)drawChart{//绘制图表
    float x,y,width,height,scal;
    if (fDeviceWidth==375) {
        x = -187.5-fDeviceWidth/9;
        y = -190;
        width = fDeviceWidth*9/4;
        height = fDeviceWidth*5/3;
        scal = 0.44;
    }else if(fDeviceWidth==414){
        x = (-187.5-fDeviceWidth/9)*414/375;
        y = -190*736/667;
        width = fDeviceWidth*9/4;
        height = fDeviceWidth*5/3;
        scal = 0.44;
    }else{
        x = (-187.5-fDeviceWidth/9)*320/375-45;
        y = -190*568/667;
        width = fDeviceWidth*5/2;
        height = fDeviceWidth*5/3;
        scal = 0.4;
    }
    UIView *chartScrollView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceWidth*2/3)];
    [_scrollView addSubview:chartScrollView];
    NTChartView *v = [[NTChartView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    v.backgroundColor = [UIColor whiteColor];
    
    NSArray *g1 = [NSArray arrayWithObjects:
                   [NSNumber numberWithFloat:stepScore9],
                   [NSNumber numberWithFloat:stepScore3],
                   [NSNumber numberWithFloat:stepScore4],
                   
                   [NSNumber numberWithFloat:stepScore2],
                   [NSNumber numberWithFloat:stepScore5],
                   [NSNumber numberWithFloat:stepScore6],
                   [NSNumber numberWithFloat:stepScore7],
                   [NSNumber numberWithFloat:stepScore1],
                   [NSNumber numberWithFloat:stepScore8],nil];
    
    NSArray *g2 = [NSArray arrayWithObjects:
                   [NSNumber numberWithFloat:30.0],
                   [NSNumber numberWithFloat:30.0],
                   [NSNumber numberWithFloat:30.0],
                   [NSNumber numberWithFloat:30.0],
                   [NSNumber numberWithFloat:30.0],
                   [NSNumber numberWithFloat:30.0],
                   [NSNumber numberWithFloat:30.0],
                   [NSNumber numberWithFloat:30.0],
                   [NSNumber numberWithFloat:30.0],nil];
    
    NSArray *g = [NSArray arrayWithObjects:g1, g2, nil];
    
    NSArray *gt = [NSArray arrayWithObjects:@"用户体质",@"参考值", nil];
    NSArray *xL = [NSArray arrayWithObjects:@"平和",@"阳虚",@"阴虚",@"气虚",@"痰湿",@"湿热",@"血瘀",@"特禀",@"气郁", nil];
    NSArray *ct = [NSArray arrayWithObjects:[NSString stringWithFormat:@"您的体质：%@体质",self.tiZhi],@"", nil];
    
    
    v.groupData  = g;
    v.groupTitle = gt;
    v.xAxisLabel = xL;
    v.chartTitle = ct;
    
    v.backgroundColor  = [UIColor clearColor];

    v.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    v.transform        = CGAffineTransformScale(v.transform, scal, 0.4);
    
    [chartScrollView addSubview:v];

}

- (void)previousToViewController{
    PhysicalTestViewController *testController = [[PhysicalTestViewController alloc]init];
    testController.tips = @"本测试过程分为9步，可能占用你3-5分钟时间；为了保证测试结果的准确性，请根据您当前的特征认真选择。";
    testController.aboutString = @"本测试软件完全依据中华中医医药会颁布的《中国体质分类与判定》标准(标准号ZYYXH/T157-2009)设计,具有权威性,并已申请软件著作权登记(登记号2013SR137631).";
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[testController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
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
