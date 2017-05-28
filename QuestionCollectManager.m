//
//  QuestionCollectManager.m
//  studyDrive
//
//  Created by GDaYao on 2017/5/26.
//  Copyright © 2017年 GDaYao. All rights reserved.
//

#import "QuestionCollectManager.h"

@implementation QuestionCollectManager

#pragma mark -错题
+ (NSArray *)getWrongQuestion{
    NSArray *array=[[NSUserDefaults standardUserDefaults] objectForKey:@"WRONG_QUESTION"];
    if(array!=nil){
        return array;
    }else{
        return @[];
    }
}

+ (void)addWrongQuesion:(int)mid{
    NSArray *array=[[NSUserDefaults standardUserDefaults] objectForKey:@"WRONG_QUESTION"];
    NSMutableArray *muArr=[NSMutableArray arrayWithArray:array];
    [muArr addObject:[NSString stringWithFormat:@"%d",mid]];
    [[NSUserDefaults standardUserDefaults] setObject:muArr forKey:@"WRONG_QUESTION"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+(void)removeWrongQuestion:(int)mid{
    NSArray *array=[[NSUserDefaults standardUserDefaults] objectForKey:@"WRONG_QUESTION"];
    NSMutableArray *muArr=[NSMutableArray arrayWithArray:array];
    for (int i=(int)muArr.count-1; i>=0; i--) {
        if ([muArr[i] intValue]==mid) {
            [muArr removeObjectAtIndex :i];
        }
    }
}

#pragma mark - 收藏
+ (NSArray *)getCollectQuestion{
    NSArray *array=[[NSUserDefaults standardUserDefaults] objectForKey:@"WRONG_QUESTION"];
    if(array!=nil){
        return array;
    }else{
        return @[];
    }
}

+ (void)addCollectQuesion:(int)mid{
    NSArray *array=[[NSUserDefaults standardUserDefaults] objectForKey:@"COLLECT_QUESTION"];
    NSMutableArray *muArr=[NSMutableArray arrayWithArray:array];
    [muArr addObject:[NSString stringWithFormat:@"%d",mid]];
    [[NSUserDefaults standardUserDefaults] setObject:muArr forKey:@"COLLECT_QUESTION"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+(void)removeCollectQuestion:(int)mid{
    NSArray *array=[[NSUserDefaults standardUserDefaults] objectForKey:@"COLLECT_QUESTION"];
    NSMutableArray *muArr=[NSMutableArray arrayWithArray:array];
    for (int i=(int)muArr.count-1; i>=0; i--) {
        if ([muArr[i] intValue]==mid) {
            [muArr removeObjectAtIndex :i];
        }
    }
}



+ (int)getMySorce{
    int sorce=(int)[[NSUserDefaults standardUserDefaults] integerForKey:@"MY_SORCE"];
    return sorce;
}

+ (void)setMySorce:(int)sorce{
    [[NSUserDefaults standardUserDefaults] setInteger:sorce forKey:@"MY_SORCE"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
