//  MyDataManager.h
//  studyDrive
//  Created by GDaYao on 2017/5/21.
//  Copyright © 2017年 GDaYao. All rights reserved.

//class: 数据管理类
//向外提供一个数组的接口，控制器需要使用数据可以直接调用接口。

#import <Foundation/Foundation.h>

typedef enum {
 chapter,  //章节练习
    answer,  //章节练习中题目的答案以及选项
    subChapter //专项练习
}DataType;

@interface MyDataManager : NSObject

+ (NSArray *)getData:(DataType)type;

@end
