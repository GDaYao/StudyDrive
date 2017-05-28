//
//  TestSelectViewController.h
//  studyDrive
//
//  Created by GDaYao on 2017/5/20.
//  Copyright © 2017年 GDaYao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestSelectViewController : UIViewController
    //从上一个控制器中传下来数据。这是作为cell中的内容数据，使用几个数字代替，后期传入数据;
@property(nonatomic,copy)NSArray *dataArray;
    //type=1 章节；type=2 专项
@property(nonatomic,assign)int type;

@end
