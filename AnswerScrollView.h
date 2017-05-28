//  AnswerScrollView.h
//  studyDrive
//  Created by GDaYao on 2017/5/21.
//  Copyright © 2017年 GDaYao. All rights reserved.

//这是科目一-->章节练习-->答题页面（继承自UIView视图）

#import <UIKit/UIKit.h>

@interface AnswerScrollView : UIView
{
    @public
    UIScrollView *_scrollView;
}


    //初始化的时候会使用array数组在传进来一个数组
- (instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)array;

@property(nonatomic,readonly,assign)int currentPage;

@property(nonatomic,strong)NSMutableArray *hadAnswerArray;
@property(nonatomic,strong)NSArray *dataArray;

@end
