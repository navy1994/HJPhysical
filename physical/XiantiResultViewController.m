//
//  XiantiResultViewController.m
//  physical
//
//  Created by mac- t4 on 15/8/11.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import "XiantiResultViewController.h"
#import "PhysicalPrefix.pch"
#import "PhysicalTestViewController.h"

@interface XiantiResultViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSString *typeString;
@property (nonatomic, strong) NSString *tipsString;

@property (nonatomic, strong) UILabel *type;
@property (nonatomic, strong) UILabel *tips;
@end

@implementation XiantiResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:[UIScreen mainScreen].bounds andColors:@[[UIColor whiteColor],[UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f]]];
    // Do any additional setup after loading the view from its nib.
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+200)];
    [self.view addSubview:_scrollView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_chbackbtn"] style:UIBarButtonItemStylePlain target:self action:@selector(previousToViewController)];
    
    UILabel *ceshi = [[UILabel alloc]initWithFrame:CGRectMake(30, 84, 80, 25)];
    ceshi.text = @"测试结果";
    [self.scrollView addSubview:ceshi];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(30, ceshi.frame.origin.y+ceshi.frame.size.height, fDeviceWidth-60, 350)];
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 3;
    view.layer.borderColor = [[UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f]CGColor];
    [self.scrollView addSubview:view];
    
    [self calculateResult];
    
    self.type = [[UILabel alloc]initWithFrame:CGRectMake(30, 20, view.frame.size.width-60, 30)];
    _type.text = _resultString;
    _type.font = [UIFont boldSystemFontOfSize:18];
    [view addSubview:_type];
    
    self.tips = [[UILabel alloc]initWithFrame:CGRectMake(20, self.type.frame.origin.y+self.type.frame.size.height+10, view.frame.size.width-40, view.frame.size.height - 90)];
    _tips.font = [UIFont boldSystemFontOfSize:15];
    _tips.numberOfLines = 0;
    _tips.text = _tipsString;
    [_tips sizeToFit];
    [view addSubview:_tips];
    
    view.frame = CGRectMake(30, ceshi.frame.origin.y+ceshi.frame.size.height, fDeviceWidth-60, 60+self.type.frame.size.height+_tips.frame.size.height);

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
    if ([_resultString isEqual:@"A型"]) {
        _tipsString = @"多喝水，吃不下东西就饱了\n\t一天八杯水是针对日常补水来说的哦，如果想要减肥却又很想吃东西的话怎么办呢?那就是在饿的时候喝水，每次一想吃东西的时候就喝很多水，这样胃就不会空空的，当然也不会觉得饿啦!这样简单的方法，平时不用特别去记忆，也没有一定的时间限制要求，对你来说小事一桩啦!不过记得，每天也要注意营养哦!吃些维生素的药片来保持吧!";
    }else if ([_resultString isEqual:@"B型"]){
        _tipsString = @"瑜珈减肥\n\t像你这样做事认真，能坚持到底的人，最适合你的就是做运动的减肥形式了，瑜伽的减肥就是在运动的过程中把你的脂肪消耗掉，但是瑜伽又讲究的是心情的平和，在身心一体的过程中，一人独自安静地冥想，不仅对你工作学习压力是一种释放，又可以在缓慢的对自己身体了解的过程中燃烧脂肪，何乐而不为呢?而且瑜伽还有局部减肥的方法哦，好好跟老师学吧!";
    }else if ([_resultString isEqual:@"C型"]){
        _tipsString = @"游泳\n\t其实你并不是很胖，自己喜欢的东西就一定要拿到手，穿衣服也没有许多限制，只是有人说你比她胖而已啦!或者局部的某些部位有那么点点赘肉，这样的话去游泳吧。游泳的时候整个人泡在水里，游动的过程中其实是在对整个身体塑形的过程!经常游泳的人不仅可以锻炼肌肉，而且该瘦的地方瘦该长肉的地方长肉，所以今年夏天经常去游泳吧!不要忘记涂防晒霜哦!";
    }else if ([_resultString isEqual:@"D型"]){
        _tipsString = @"瓜果蔬菜型\n\t多吃瓜果蔬菜，是王道。瓜果蔬菜经常吃，多吃，能清楚体内垃圾和毒素，除了瘦身，还能美容呢。";
    }else{
        _tipsString = @"穴位推拿瘦身\n\t这种减肥方法其实还满新式的哦，特别适合象你这样身体比较容易浮肿，而且不擅长运动平时又非常忙的人，但是一般在美容院或者有推拿师的地方才有这样的方法学呢。所以第一次去尝试以后回家自己学着点，一般针对手臂和腿上的赘肉，根据特定的穴位自己可以进行抓捏、拍打、按压等动作，直到有酸痛感，打造完美身材都是自己辛勤努力的结果哦!要加油哦!";
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
