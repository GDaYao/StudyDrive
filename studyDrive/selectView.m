//  selectView.m
//  studyDrive
//  Created by GDaYao on 2017/5/17.
//  Copyright © 2017年 GDaYao. All rights reserved.

//selectView-->ViewController中的继承UIView,"考驾照"首页的View视图,显示灰色背景和四个车型切换按钮。

#import "selectView.h"

@implementation selectView
{
    UIButton *_button;  //This is button of get button data from outside;
}

- (instancetype)initWithFrame:(CGRect)frame andBtn:(UIButton *)seclectBtn{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        _button=seclectBtn;  //把外界传进来的UIButton数据传给这个视图内部的UIButton。
        [self createBtn];
    }
    return self;
}

- (void)createBtn{
    for (int i=0; i<4; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(self.bounds.size.width/4*i+self.bounds.size.width/4/2-30, self.bounds.size.height-80, 60, 60);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+1]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
    }
}

#pragma mark - 车型选择的视图点击事件
- (void)click:(UIButton *)btn{
    [_button setImage:[btn backgroundImageForState:UIControlStateNormal] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=0;
    }];
}

//添加手势-->关闭视图
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //执行动画使得视图淡入淡出
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=0;
    }];
}



@end
