//
//  Question.h
//  physical
//
//  Created by mac- t4 on 15/7/6.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject{
    int ID;
    int step;
    int result;
    int numQuestion;
}

@property (nonatomic) int ID;
@property (nonatomic) int step;
@property (nonatomic) int result;
@property (nonatomic) int numQuestion;

@end
