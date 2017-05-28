//
//  AnswerModel.h
//  studyDrive
//
//  Created by GDaYao on 2017/5/22.
//  Copyright © 2017年 GDaYao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswerModel : NSObject
    //这里一共10个属性
@property(nonatomic,copy)NSString *mquestion;
@property(nonatomic,copy)NSString *mdesc;
@property(nonatomic,copy)NSString *mid;
@property(nonatomic,copy)NSString *manswer;
@property(nonatomic,copy)NSString *mimage;
@property(nonatomic,copy)NSString *pid;
@property(nonatomic,copy)NSString *pname;
@property(nonatomic,copy)NSString *sid;
@property(nonatomic,copy)NSString *sname;
@property(nonatomic,copy)NSString *mtype;

@end
