//
//  PatientDB.m
//  MedicalSystem
//
//  Created by mac on 15/3/24.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "QuizDB.h"

@implementation QuizDB

FMDatabase *db;

- (id) initWithDBName:(NSString*)dbName{
	
	if ((self = [super init])) {
        [self initializeDatabase:dbName];
	}
	return self;
}

- (void) initializeDatabase:(NSString*)dbName{
	NSString *path = [[NSBundle mainBundle] pathForResource:dbName ofType:@"sqlite"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]){
        NSLog(@"表不存在");
    }
	//open the database
	db =[FMDatabase databaseWithPath:path];
	if ([db open]) {
		NSLog(@"open database success");
	}
	else{
		[self closeDatabase];
	}
}

- (void) closeDatabase
{
	[db close];
}

- (NSMutableArray*)getAllData:(NSString *)tableName{
	NSMutableArray *quizs = [[NSMutableArray alloc]init];
	FMResultSet *set = [db executeQuery:[NSString stringWithFormat:@"select * from %@Table",tableName]];
	while ([set next]) {
        Quiz *quiz = [[Quiz alloc]init];
        quiz.ID = [set intForColumn:@"ID"];
        quiz.quiz = [set stringForColumn:@"quiz"];
        [quizs addObject:quiz];
    }
	return quizs;
}

- (NSMutableArray*) getAllResultData:(NSString*)tableName{
    NSMutableArray *results = [[NSMutableArray alloc]init];
    FMResultSet *set = [db executeQuery:[NSString stringWithFormat:@"select * from %@",tableName]];
    while ([set next]) {
        Result *result = [[Result alloc]init];
        result.ID = [set intForColumn:@"ID"];
        result.tiZhi = [set stringForColumn:@"tizhi"];
        result.tezheng = [set stringForColumn:@"tezheng"];
        result.yangsheng = [set stringForColumn:@"yangsheng"];
        result.med = [set stringForColumn:@"med"];
        result.medtips = [set stringForColumn:@"medtips"];
        result.image = [set stringForColumn:@"image"];
        result.url = [set stringForColumn:@"url"];
        [results addObject:result];	}
    return results;
}

- (NSMutableArray*)getAllXiantiData:(NSString *)tableName{
    NSMutableArray *quizs = [[NSMutableArray alloc]init];
    FMResultSet *set = [db executeQuery:[NSString stringWithFormat:@"select * from %@Table",tableName]];
    while ([set next]) {
        XianTi *quiz = [[XianTi alloc]init];
        quiz.ID = [set intForColumn:@"ID"];
        quiz.quiz = [set stringForColumn:@"quiz"];
        quiz.resultA = [set stringForColumn:@"resultA"];
        quiz.resultB = [set stringForColumn:@"resultB"];
        [quizs addObject:quiz];
    }
    return quizs;}

- (NSMutableArray*)getAllFuzhiData:(NSString *)tableName{
    NSMutableArray *quizs = [[NSMutableArray alloc]init];
    FMResultSet *set = [db executeQuery:[NSString stringWithFormat:@"select * from %@Table",tableName]];
    while ([set next]) {
        FuZhi *quiz = [[FuZhi alloc]init];
        quiz.ID = [set intForColumn:@"ID"];
        quiz.quiz = [set stringForColumn:@"quiz"];
        quiz.resultA = [set stringForColumn:@"resultA"];
        quiz.resultB = [set stringForColumn:@"resultB"];
        quiz.resultC = [set stringForColumn:@"resultC"];
        quiz.resultD = [set stringForColumn:@"resultD"];
        [quizs addObject:quiz];
    }
    return quizs;
}

@end
