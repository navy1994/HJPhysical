//
//  PhysicalQuizViewController.m
//  physical
//
//  Created by mac- t4 on 15/7/2.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import "PhysicalQuizViewController.h"
#import "PhysicalPrefix.pch"
#import "QuizTableViewCell.h"
#import "ResultViewController.h"
#import "Question.h"
#import "QuizDB.h"
#import "Quiz.h"

@interface PhysicalQuizViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_quizTableView;
    QuizDB *_dbQuiz;
    int step;
    NSUInteger numQuestionStep;//当前页的题数
}

@property (strong, nonatomic) UIButton *homeBtn;
@property (strong, nonatomic) UIButton *nextBtn;
@property (strong, nonatomic) NSArray *stepArray;
@property (strong, nonatomic) NSMutableArray *tableTextArray;
@property (strong, nonatomic) NSMutableArray *resultArray;
@property (strong, nonatomic) UISwipeGestureRecognizer *rightSwipeGwstureRecognizer;
@property (strong, nonatomic) UISwipeGestureRecognizer *leftSwipeGwstureRecognizer;
@property (nonatomic, strong) UIView *backView;


/**
 *  初始化数据
 */
- (void)initDataToFirstStep;

@end

@implementation PhysicalQuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     数据库取值
     */
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, fDeviceWidth, fDeviceHeight-64)];
    _backView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_backView];
    
    _dbQuiz = [[QuizDB alloc]initWithDBName:@"PhysicalQuiz"];
    self.stepArray = @[@"mild",@"deficiency",@"qiyu",@"shire",@"tanshi",@"tebin",@"xueyu",@"yangxu",@"yinxu"];
    [self initDataToFirstStep];
    
//    self.title = @"体质测试";
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_chbackbtn"] style:UIBarButtonItemStylePlain target:self action:@selector(previousToViewController)];
    
    _quizTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 10, fDeviceWidth-20, _backView.frame.size.height-20) style:UITableViewStylePlain];
    _quizTableView.backgroundColor = [UIColor clearColor];

    _backView.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:[UIScreen mainScreen].bounds andColors:@[[UIColor whiteColor],[UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f]]];
    [self.view addSubview:_backView];
    [self reloadTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [_backView addSubview:_quizTableView];
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake((fDeviceWidth-80)/2, fDeviceHeight-35, 80, 30);
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    _nextBtn.backgroundColor = [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
    [_nextBtn addTarget:self action:@selector(clickNextBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBtn];
    
    [_nextBtn setHidden:YES];
    
    self.resultArray = [[NSMutableArray alloc]init];
    [NSTimer scheduledTimerWithTimeInterval: 0.4 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
}

- (void)levelTimerCallback:(NSTimer *)timer {
    if (!numQuestionStep) {
        [self clickNextBtn];
    }

}

- (void)initDataToFirstStep{
    //初始步为1，共9步
    step = 0;
    self.tableTextArray = [_dbQuiz getAllData:[_stepArray objectAtIndex:step]];
    numQuestionStep = _tableTextArray.count;//当前页的题数
}

- (void)reloadTableView{
    _quizTableView.tableHeaderView.hidden = YES;
    _quizTableView.tableFooterView.backgroundColor = [UIColor clearColor];
    _quizTableView.layer.cornerRadius = 8;
    _quizTableView.layer.masksToBounds = YES;
    _quizTableView.dataSource = self;
    _quizTableView.delegate = self;
    [_quizTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

//翻页动画
- (void)handleSwipe{
        _quizTableView.frame = CGRectMake(fDeviceWidth, 10, fDeviceWidth-20, _backView.frame.size.height-20);
        
        [UIView beginAnimations:@"animationID"context:nil];
        
        [UIView setAnimationDuration:0.3f];
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        [UIView setAnimationRepeatAutoreverses:NO];
        
        _quizTableView.frame = CGRectMake(10, 10, fDeviceWidth-20, _backView.frame.size.height-20);
        
        [UIView commitAnimations];

}



#pragma mark --- clickBtnEvent
- (void)clickNextBtn{
    
    if (numQuestionStep) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请做完所有题" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{
        if (step < 8) {
            step++;
            if(step == 8){
                [_nextBtn setTitle:@"查看结果" forState:UIControlStateNormal];
            }
        }else{
            ResultViewController *resultController = [[ResultViewController alloc]init];
            resultController.resultArray = self.resultArray;
            [self.navigationController pushViewController:resultController animated:NO];
        }
        
        self.tableTextArray = [_dbQuiz getAllData:[_stepArray objectAtIndex:step]];//更新题
        
        if (step == 5) {//根据性别判断第6步题目
            [self quizWithSex];
        }
        
        numQuestionStep = _tableTextArray.count;//当前页的题数
        [_quizTableView reloadData];
        [self handleSwipe];
    }
}

- (void)quizWithSex{//根据性别对应测试题
        if (_selectRex == 6) {
            [_tableTextArray removeObjectAtIndex:_selectRex-1];
        }else{
            [_tableTextArray removeObjectAtIndex:_selectRex+1];
        }
}

#pragma mark --- PhysicalNavigationDelegate
- (void)previousToViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonClickEvent{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        QuizTableViewCell *cell = (QuizTableViewCell*)[self tableView:_quizTableView cellForRowAtIndexPath:indexPath];
        NSLog(@"step:%d\trow:%ld\trowWithHegiht:%f",step,(long)indexPath.row,cell.frame.size.height);
        return cell.frame.size.height+4;
}

#pragma mark ----- UITableViewDatabase
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableTextArray.count;
}


- (QuizTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIndetifier = @"cell";
    QuizTableViewCell *cell = (QuizTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIndetifier];
    
    if (!cell) {
        cell = [[QuizTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndetifier];
    }

    Quiz *quiz = [[Quiz alloc]init];
    quiz = [self.tableTextArray objectAtIndex:indexPath.row];
   
    [cell setTitleText:[[NSString stringWithFormat:@"%d.%@",(int)indexPath.row+1,quiz.quiz] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    cell.resultSegment.tag = indexPath.row;
    cell.resultSegment.selectedSegmentIndex = -1;//题目默认选中索引
    [cell.resultSegment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)segmentAction:(UISegmentedControl *)Seg{
    BOOL isAdd = YES;
    NSInteger Index = Seg.selectedSegmentIndex;
    
    Question *quesrion = [[Question alloc]init];
    quesrion.ID = (int)Seg.tag;
    quesrion.step = step;
    quesrion.result = (int)Index+1;
    quesrion.numQuestion = (int)Seg.tag;
    //NSLog(@"suzhu.count:%d",(int)_resultArray.count);
    if (self.resultArray.count) {
        //判断当前题是否被选过
        for (Question *aQuestion in self.resultArray) {
            if (aQuestion.ID == quesrion.ID && aQuestion.step == quesrion.step) {
                isAdd = NO;
                break;
            }
        }
    }
    
    if (isAdd) {  //当选中新题时
        numQuestionStep --;
        [_resultArray addObject:quesrion];

    }
    
    float tag,count;
    if (fDeviceWidth==375) {
        tag = 5;
        count = 6;
    }else if(fDeviceWidth==414){
        tag = 6;
        count = 7;
    }else{
        tag = 4;
        count = 5;
    }
    
    //测试相关....
//    NSLog(@"第%d页,第%d题,回答:%d,numQuestion=%d",quesrion.step,quesrion.ID,quesrion.result,quesrion.numQuestion);
//    NSLog(@"数组个数:%d,resultArray:%@",(int)_resultArray.count,_resultArray);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"%d/9",step+1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
