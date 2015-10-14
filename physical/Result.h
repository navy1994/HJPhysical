//
//  Result.h
//  physical
//
//  Created by mac- t4 on 15/7/8.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Result : NSObject{
    int ID;
    NSString *tiZhi;
    NSString *tezheng;
    NSString *yangsheng;
    NSString *med;
    NSString *medtips;
    NSString *image;
    NSString *url;
}

@property (nonatomic) int ID;
@property (nonatomic,strong) NSString *tiZhi;
@property (nonatomic,strong) NSString *tezheng;
@property (nonatomic,strong) NSString *yangsheng;
@property (nonatomic,strong) NSString *med;
@property (nonatomic,strong) NSString *medtips;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *url;

@end
