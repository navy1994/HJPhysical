//
//  Quiz.h
//  physical
//
//  Created by mac- t4 on 15/7/2.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Quiz : NSObject{
    int ID;
    NSString *quiz;
}

@property (nonatomic) int ID;
@property (strong,nonatomic) NSString *quiz;


@end


@interface XianTi : NSObject{
    int ID;
    NSString *quiz;
    NSString *resultA;
    NSString *resultB;
}

@property (nonatomic) int ID;
@property (nonatomic, strong) NSString *quiz;
@property (nonatomic, strong) NSString *resultA;
@property (nonatomic, strong) NSString *resultB;

@end

@interface FuZhi : NSObject{
    int ID;
    NSString *quiz;
    NSString *resultA;
    NSString *resultB;
    NSString *resultC;
    NSString *resultD;
}
@property (nonatomic) int ID;
@property (nonatomic, strong) NSString *quiz;
@property (nonatomic, strong) NSString *resultA;
@property (nonatomic, strong) NSString *resultB;
@property (nonatomic, strong) NSString *resultC;
@property (nonatomic, strong) NSString *resultD;

@end