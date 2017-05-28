//
//  SheetView.m
//  studyDrive
//
//  Created by GDaYao on 2017/5/25.
//  Copyright © 2017年 GDaYao. All rights reserved.

//“章节练习->答题页面”->底部第一个按钮点击后出现的视图-->并继承自UIView

#import "SheetView.h"

@interface SheetView ()
{
    UIView *_superView;
    BOOL _startMoving;
    float _height;
    float _width;
    float _y;
    UIScrollView *_scrollView;
    int _count;
}

@end

@implementation SheetView

- (instancetype)initWithFrame:(CGRect)frame withSuperView:(UIView *) superView andQuesCount:(int)count{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor  whiteColor];
        _height=frame.size.height;
        _width=frame.size.width;
        _y=frame.origin.y;
        _superView=superView;
        _count=count;
        [self createView];
    }
    return self;
}

#pragma mark - first create view
- (void)createView{
    _backView=[[UIView alloc]initWithFrame:_superView.frame];
    _backView.backgroundColor=[UIColor blackColor];
    _backView.alpha=0;
    [_superView addSubview:_backView];
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 70, self.frame.size.width, self.frame.size.height-70)];
    [self addSubview:_scrollView];
    for (int i=0; i<_count; i++) {
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake((_width-44*6)/2+44*(i%6), 10+44*(i/6), 40, 40);
        btn.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        if (i==0) {
            btn.backgroundColor=[UIColor orangeColor];
        }
        [btn setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        btn.layer.masksToBounds=YES;
        btn.layer.cornerRadius=8;
        btn.tag=101+i;  //tag=101,102,103,104...
        [btn addTarget:self action:@selector(clickNumber:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:btn];
    }
    int tip=(_count%6)?1:0;
    _scrollView.contentSize=CGSizeMake(0, 20+44*(_count/6+1+tip));
    
}

- (void)clickNumber:(UIButton *)btn{
    int index =(int)btn.tag-100;  // =1,2,3,4...
    for(int i=0;i<_count;i++){  //i=0,1,2,3,4...
        UIButton *button=(UIButton *)[self viewWithTag:i+101];  //从新初始化一个按钮，把赋值的属性传给前面的题目按钮
        if (i!=index-1) {
            button.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        }else{
            button.backgroundColor=[UIColor orangeColor];
        }
    }
    [_delegate SheetViewClick:index];  //并在这里把index题号传给外面的视图控制器，以便点击题号可以改变外面的题目。
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:[touch view]];
    
    if (point.y<25) {
        _startMoving=YES;
    }
    if(_startMoving&&self.frame.origin.y>=_y-_height&&[self convertPoint:point toView:_superView].y>=80){
        self.frame=CGRectMake(0, [self convertPoint:point toView:_superView].y, _width, _height);
        float offset=(_superView.frame.size.height-self.frame.origin.y)/_superView.frame.size.height*0.8;
        _backView.alpha=offset;
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _startMoving=NO;
    if(self.frame.origin.y<_y-_height/2){
        [UIView animateWithDuration:0.3 animations:^{
            self.frame=CGRectMake(0, _y, _width, _height);
            _backView.alpha=0;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.frame=CGRectMake(0, _y-_height, _width, _height);
            _backView.alpha=0.8;
        }];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
