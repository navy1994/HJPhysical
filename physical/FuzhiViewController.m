//
//  FuzhiViewController.m
//  physical
//
//  Created by mac- t4 on 15/8/10.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import "FuzhiViewController.h"
#import "PhysicalPrefix.pch"
#import "QuizDB.h"
#import "Quiz.h"
#import "MGLRadioButton.h"
#import "FuzhiResultViewController.h"

@interface FuzhiViewController ()<QRadioButtonDelegate>{
    QuizDB *dbQuiz;
    NSUInteger page;
    BOOL isClick;
    int sumScore;
}
@property (nonatomic, strong) UILabel *questionNum;
@property (nonatomic, strong) UILabel *quizLabel;
@property (nonatomic, strong) MGLRadioButton *radioA;
@property (nonatomic, strong) MGLRadioButton *radioB;
@property (nonatomic, strong) MGLRadioButton *radioC;
@property (nonatomic, strong) MGLRadioButton *radioD;

@property (nonatomic, strong) NSMutableArray *quizArray;
@property (nonatomic, strong) FuZhi *quiz;

@end

@implementation FuzhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:[UIScreen mainScreen].bounds andColors:@[[UIColor whiteColor],[UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f]]];
    sumScore = 0;
    //初始化数据
    dbQuiz = [[QuizDB alloc]initWithDBName:@"XiantiQuiz"];
    self.quizArray = [dbQuiz getAllFuzhiData:@"fuzhi"];
    page = 0;
    isClick = NO;
    //初始化布局
    [self initLayout:page];
    [NSTimer scheduledTimerWithTimeInterval: 0.4 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
}
- (void)levelTimerCallback:(NSTimer *)timer {
    if (isClick) {
        page++;
        if (page<7) {
            [self reloadLayout:page];
            
        }else{
            FuzhiResultViewController *resultViewController = [[FuzhiResultViewController alloc]init];
            resultViewController.sumScore = sumScore;
            [self.navigationController pushViewController:resultViewController animated:YES];
        }
        isClick = NO;
    }
}


- (void)initLayout:(NSUInteger)page{
    /**
     *  初始化第一道题
     */
    self.quiz = [_quizArray objectAtIndex:page];
    self.questionNum = [[UILabel alloc]initWithFrame:CGRectMake(40, 130, fDeviceWidth-80, 40)];
    _questionNum.textAlignment = NSTextAlignmentCenter;
    _questionNum.text = [NSString stringWithFormat:@"%d/%lu",_quiz.ID+1,_quizArray.count];
    [self.view addSubview:_questionNum];
    
    self.quizLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, _questionNum.frame.origin.y+_questionNum.frame.size.height+40, fDeviceWidth-60, 60)];
    _quizLabel.text = _quiz.quiz;
    _quizLabel.numberOfLines = 0;
    [self.view addSubview:_quizLabel];
    
    self.radioA = [[MGLRadioButton alloc] initWithDelegate:self groupId:@"groupId1" andTitle:_quiz.resultA];
    _radioA.frame = CGRectMake(30, _quizLabel.frame.origin.y+_quizLabel.frame.size.height+20, fDeviceWidth-60, 40);
    [self.view addSubview:_radioA];
    
    self.radioB = [[MGLRadioButton alloc] initWithDelegate:self groupId:@"groupId2" andTitle:_quiz.resultB];
    _radioB.frame = CGRectMake(30, _radioA.frame.origin.y+_radioB.frame.size.height+40, fDeviceWidth-60, 40);
    [self.view addSubview:_radioB];
    
    self.radioC = [[MGLRadioButton alloc] initWithDelegate:self groupId:@"groupId3" andTitle:_quiz.resultC];
    _radioC.frame = CGRectMake(30, _radioB.frame.origin.y+_radioB.frame.size.height, fDeviceWidth-60, 40);
    [self.view addSubview:_radioC];
    
    self.radioD = [[MGLRadioButton alloc] initWithDelegate:self groupId:@"groupId4" andTitle:_quiz.resultD];
    _radioD.frame = CGRectMake(30, _radioC.frame.origin.y+_radioC.frame.size.height, fDeviceWidth-60, 40);
    [self.view addSubview:_radioD];
    
    if (!_quiz.resultA) {
        [_radioA setHidden:YES];
    }
    if (!_quiz.resultB) {
        [_radioB setHidden:YES];
    }
    if (!_quiz.resultC) {
        [_radioC setHidden:YES];
    }
    if (!_quiz.resultD) {
        [_radioD setHidden:YES];
    }
}

#pragma mark - QRadioButtonDelegate
- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId {
    NSLog(@"did selected radio:%@ groupId:%@", radio.titleLabel.text, groupId);
    isClick = YES;
   
        if ([groupId isEqual:@"groupId1"]) {
            sumScore += 1;
        }else if ([groupId isEqual:@"groupId2"]){
            sumScore += 2;
        }else if ([groupId isEqual:@"groupId3"]){
            sumScore += 3;
        }else {
            sumScore += 4;
        }
    NSLog(@"sumScore=%d",sumScore);
}

- (void)reloadLayout:(NSUInteger)page{
    [_questionNum removeFromSuperview];
    [_quizLabel removeFromSuperview];
    [_radioA removeFromSuperview];
    [_radioB removeFromSuperview];
    [_radioC removeFromSuperview];
    [_radioD removeFromSuperview];
    
    [self initLayout:page];
}

- (void)popViewController{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
