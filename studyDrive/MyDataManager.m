//  MyDataManager.m
//  studyDrive
//  Created by GDaYao on 2017/5/21.
//  Copyright © 2017年 GDaYao. All rights reserved.
//
// 数据管理类

#import "MyDataManager.h"
#import "FMDatabase.h"
#import "TestSelectModel.h"
#import "AnswerModel.h"
#import "SubTestSelectModel.h"

@implementation MyDataManager

+ (NSArray *)getData:(DataType)type{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    static FMDatabase *dataBase;
    if (dataBase==nil) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"data" ofType:@"sqlite"];
        dataBase=[[FMDatabase alloc]initWithPath:path];
    }
    if ([dataBase open]) {
        NSLog(@"打开成功");
    }else{
        return array;
    }
    switch (type) {
        case chapter:
        {
            NSString *sql=@"SELECT pid,pname,pcount FROM firstlevel";
            FMResultSet *res=[dataBase executeQuery:sql];
            while ([res next]) {
                TestSelectModel *model=[[TestSelectModel alloc]init];
                model.pid=[NSString stringWithFormat:@"%d",[res intForColumn:@"pid"]];
                model.pname=[res stringForColumn:@"pname"];
                model.pcount=[NSString stringWithFormat:@"%d",[res intForColumn:@"pcount"]];
                [array addObject:model];
            }
        }
            break;
        case answer:
        {
        NSString *Asql=@"SELECT mquestion,mdesc,mid,manswer,mimage,pid,pname,sid,sname,mtype FROM leaflevel";
            FMResultSet *res=[dataBase executeQuery:Asql];
            while ([res next]) {
                AnswerModel *answerM=[[AnswerModel alloc]init];
                answerM.mquestion=[res stringForColumn:@"mquestion"];
                answerM.mdesc=[res stringForColumn:@"mdesc"];
                answerM.mid=[NSString stringWithFormat:@"%d",[res intForColumn:@"mid"]];
                answerM.manswer=[res stringForColumn:@"manswer"];
                answerM.mimage=[res stringForColumn:@"mimage"];
                answerM.pid=[NSString stringWithFormat:@"%d",[res intForColumn:@"pid"]];
                answerM.pname=[res stringForColumn:@"pname"];
                answerM.sid=[NSString stringWithFormat:@"%.2f",[res doubleForColumn:@"sid"]];
                answerM.sname=[res stringForColumn:@"sname"];
                answerM.mtype=[NSString stringWithFormat:@"%d",[res intForColumn:@"mtype"]];
                
                [array addObject:answerM];
            }
        }
            break;
        case subChapter:  //专项练习，获得数据
        {
            NSString *sql=@"SELECT pid,sname,scount,sid,serial FROM secondlevel";
            FMResultSet *res=[dataBase executeQuery:sql];
            while ([res next]) {
                SubTestSelectModel *model=[[SubTestSelectModel alloc]init];
                model.pid=[NSString stringWithFormat:@"%d",[res intForColumn:@"pid"]];
                model.sid=[NSString stringWithFormat:@"%.2f",[res doubleForColumn:@"sid"]];
                model.sname=[res stringForColumn:@"sname"];
                model.scount=[NSString stringWithFormat:@"%d",[res intForColumn:@"scount"]];
                model.serial=[NSString stringWithFormat:@"%d",[res intForColumn:@"serial"]];
                [array addObject:model];
            }
        }
            break;
            
        default:
            break;
    }
    [dataBase close];
    return array;
}
@end
