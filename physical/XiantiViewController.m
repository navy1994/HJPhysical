//
//  XiantiViewController.m
//  physical
//
//  Created by mac- t4 on 15/8/10.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import "XiantiViewController.h"
#import "Quiz.h"
#import "QuizDB.h"
#import "MGLRadioButton.h"
#import "PhysicalPrefix.pch"
#import "XiantiResultViewController.h"

@interface XiantiViewController ()<QRadioButtonDelegate>{
    QuizDB *dbQuiz;
    NSUInteger page;
    BOOL isClick;
    NSString *result;
}
@property (nonatomic, strong) UILabel *questionNum;
@property (nonatomic, strong) UILabel *quizLabel;
@property (nonatomic, strong) MGLRadioButton *radioA;
@property (nonatomic, strong) MGLRadioButton *radioB;

@property (nonatomic, strong) NSMutableArray *quizArray;
@property (nonatomic, strong) XianTi *quiz;
@end


@implementation XiantiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:[UIScreen mainScreen].bounds andColors:@[[UIColor whiteColor],[UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f]]];
    //初始化数据
    dbQuiz = [[QuizDB alloc]initWithDBName:@"XiantiQuiz"];
    self.quizArray = [dbQuiz getAllXiantiData:@"result"];
    page = 0;
    isClick = NO;
    //初始化布局
    [self initLayout:page];
    [NSTimer scheduledTimerWithTimeInterval: 0.4 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
}

- (void)levelTimerCallback:(NSTimer *)timer {
    if (isClick) {
        page++;
        if (page<13) {
            [self reloadLayout:page];
            
        }
        isClick = NO;
    }
}

- (void)pushViewController{
    XiantiResultViewController *resultViewController = [[XiantiResultViewController alloc]init];
    resultViewController.resultString = result;
    [self.navigationController pushViewController:resultViewController animated:YES];
}


- (void)initLayout:(NSUInteger)page{
    /**
     *  初始化第一道题
     */
    self.quiz = [_quizArray objectAtIndex:page];
    self.questionNum = [[UILabel alloc]initWithFrame:CGRectMake(40, 130, fDeviceWidth-80, 40)];
    _questionNum.textAlignment = NSTextAlignmentCenter;
    _questionNum.text = [NSString stringWithFormat:@"%d/%lu",_quiz.ID+1,(unsigned long)_quizArray.count];
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
    
}

#pragma mark - QRadioButtonDelegate
- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId {
    NSLog(@"did selected radio:%@ groupId:%@", radio.titleLabel.text, groupId);
    isClick = YES;
    switch (page) {
        case 0:
            [self calculateResult:groupId isReverse:YES];
            break;
        case 1:
            [self calculateResult:groupId isReverse:NO];
            break;
        case 2:
            [self calculateResult:groupId isReverse:NO];
            break;
        case 3:
            [self calculateResult:groupId isReverse:NO];
            break;
        case 4:
            [self calculateResult:groupId isReverse:YES];
            break;
        case 5:
            [self calculateResult:groupId isReverse:NO];
            break;
        case 6:
            [self calculateResult:groupId isReverse:YES];
            break;
        case 7:
            [self calculateResult:groupId isReverse:YES];
            break;
        case 8:
            [self calculateResult:groupId isReverse:YES];
            break;
        case 9:
            if ([groupId isEqual:@"groupId1"]) {
                result = @"C型";
                [self pushViewController];
            }
            break;
        case 10:
            if ([groupId isEqual:@"groupId2"]) {
                result = @"E型";
                [self pushViewController];
            }
            break;
        case 11:
            if ([groupId isEqual:@"groupId2"]) {
                result = @"A型";
                [self pushViewController];
            }
            break;
        case 12:
            if ([groupId isEqual:@"groupId1"]) {
                result = @"B型";
                [self pushViewController];
            }else{
                result = @"D型";
                [self pushViewController];
            }
            break;
        default:
            break;
    }
    
}

- (void)calculateResult:(NSString *)groupId isReverse:(BOOL)reverse{
    if (reverse) {
        if ([groupId isEqual:@"groupId1"]) {
            page ++;
        }
    }else{
        
        if ([groupId isEqual:@"groupId2"]) {
            page ++;
        }
    }
}

- (void)reloadLayout:(NSUInteger)page{
    [_questionNum removeFromSuperview];
    [_quizLabel removeFromSuperview];
    [_radioA removeFromSuperview];
    [_radioB removeFromSuperview];
    
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
