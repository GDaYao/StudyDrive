//
//  QuestionCollectManager.h
//  studyDrive
//
//  Created by GDaYao on 2017/5/26.
//  Copyright © 2017年 GDaYao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionCollectManager : NSObject

+ (NSArray *)getWrongQuestion;
+ (void)addWrongQuesion:(int)mid;
+ (void)removeWrongQuestion:(int)mid;

+ (NSArray *)getCollectQuestion;
+ (void)addCollectQuesion:(int)mid;
+ (void)removeCollectQuestion:(int)mid;

+ (int)getMySorce;
+ (void)setMySorce:(int)sorce;
@end
