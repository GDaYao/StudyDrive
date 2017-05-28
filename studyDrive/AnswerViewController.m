//
//  AnswerViewController.m
//  studyDrive
//
//  Created by GDaYao on 2017/5/22.
//  Copyright © 2017年 GDaYao. All rights reserved.

//AnswerViewController-->4.有问题和答案的视图控制器

#import "AnswerViewController.h"
#import "AnswerScrollView.h"
#import "MyDataManager.h"
#import "AnswerModel.h"
#import "SelectModelView.h"
#import "SheetView.h"
#import "QuestionCollectManager.h"


@interface AnswerViewController ()<SheetViewDelegate>
{
    AnswerScrollView *answerScrollView;
    SelectModelView *modelView;
    SheetView *_sheetView;
    NSTimer *_timer;
    UILabel *_timeLabel;
}

@end

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.title=@"章节练习";
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self createModelView];
    [self createData];
    [self.view addSubview:answerScrollView];
    [self createSheetView];
    
}

- (void)createData{
    if (_type==1) {
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        NSArray *array=[MyDataManager getData:answer];
        for (int i=0; i<array.count-1; i++) {
            AnswerModel *answerM=array[i];
            if ([answerM.pid intValue]==_number+1) {
                [arr addObject:answerM];
            }
        }
        answerScrollView=[[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64-60) withDataArray:arr];
    }else if(_type==2){
        //随机练习
        answerScrollView=[[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64-60) withDataArray:[MyDataManager getData:answer]];
    }else if(_type==3){
        NSMutableArray *temArr=[[NSMutableArray alloc]init];
        NSArray *array=[MyDataManager getData:answer];
        NSMutableArray *dataArray=[[NSMutableArray alloc]init];
        [temArr addObjectsFromArray:array];
        for (int i=0; i<temArr.count-1; i++) {
            int index=arc4random()%(temArr.count);
            [dataArray addObject:temArr[index]];
            [temArr removeObjectAtIndex:index];
        }
        answerScrollView=[[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64-60) withDataArray:dataArray];
    }else if (_type==4) {
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        NSArray *array=[MyDataManager getData:answer];
        for (int i=0; i<array.count-1; i++) {
            AnswerModel *answerM=array[i];
            if ([answerM.sid isEqualToString:_subStrNumber]) {
                [arr addObject:answerM];
            }
        }
        answerScrollView=[[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64-60) withDataArray:arr];
    }else if(_type==5){
        NSMutableArray *temArr=[[NSMutableArray alloc]init];
        NSArray *array=[MyDataManager getData:answer];
        NSMutableArray *dataArray=[[NSMutableArray alloc]init];
        [temArr addObjectsFromArray:array];
        for (int i=0; i<100; i++) {
            int index=arc4random()%(temArr.count);
            [dataArray addObject:temArr[index]];
            [temArr removeObjectAtIndex:index];
        }
        answerScrollView=[[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64-60) withDataArray:dataArray];
        
        [self createNavBtn];
        
    }
    if(_type==7){
        //读取错题
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        NSArray *array=[MyDataManager getData:answer];
        
        NSArray *wrongArray=[QuestionCollectManager getWrongQuestion];
        for (AnswerModel *model in array) {
            for (NSString *num in wrongArray) {
                if([num isEqualToString:model.mid]){
                    [arr addObject:model];
                }
            }
        }
        answerScrollView=[[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64-60) withDataArray:arr];
    }
    if(_type==8){
        //读取收藏
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        NSArray *array=[MyDataManager getData:answer];
        
        NSArray *wrongArray=[QuestionCollectManager getCollectQuestion];
        for (AnswerModel *model in array) {
            for (NSString *num in wrongArray) {
                if([num isEqualToString:model.mid]){
                    [arr addObject:model];
                }
            }
        }
        answerScrollView=[[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64-60) withDataArray:arr];
    }
    if (_type!=5&&_type!=6) {
        [self createToolBar];
    }else{
        [self createTestToolBar];
        _timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runTime) userInfo:nil repeats:YES];
        _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 64)];
        _timeLabel.text=@"60:00";  //初始化时间，让他减一即可。
        _timeLabel.textAlignment=NSTextAlignmentCenter;
        self.navigationItem.titleView=_timeLabel;
    }
  
}

- (void)runTime{
    static int Time=3600;
    Time--;
    _timeLabel.text=[NSString stringWithFormat:@"%d:%d",Time/60,Time%60];
}

- (void)createNavBtn{
    UIBarButtonItem *itemLeft=[[UIBarButtonItem alloc]init];
    itemLeft.title=@"返回";
    [itemLeft setTarget:self];
    [itemLeft setAction:@selector(clickNavBtnReturn)];
    self.navigationItem.leftBarButtonItem=itemLeft;
    
    UIBarButtonItem *itemRight=[[UIBarButtonItem alloc]init];
    itemRight.title=@"交卷";
    [itemRight setTarget:self];
    [itemRight setAction:@selector(clickRightItem)];
    self.navigationItem.rightBarButtonItem=itemRight;
    
}

- (void)clickRightItem{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"时间还多，确定要离开考试吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"不，谢谢" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        nil;
    }];
    UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"我要交卷"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //交卷处理
        int sorce=0;
        NSArray *myAnswerArray=answerScrollView.hadAnswerArray;
        NSArray *answerArray=answerScrollView.dataArray;
        for (int i=0; i<myAnswerArray.count; i++) {
            AnswerModel *model=answerArray [i];
            
#warning 做题目类型判断
            NSString *answerStr=model.manswer;
            NSString *myAnswerStr=[NSString stringWithFormat:@"%c",'A'-1+[myAnswerArray[i] intValue]];
            if([answerStr isEqualToString:myAnswerStr]){
                //这道题答对了
                sorce++;
            }
        }
        
        
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)clickNavBtnReturn{
    //下面的警告框的使用，已经过时了，现在使用UIAlertControll然后加入UIAlertAction
//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"时间还多，确定要离开考试吗？" delegate:self cancelButtonTitle:@"不，谢谢" otherButtonTitles:@"我要离开", nil];
//    [alert show];
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"时间还多，确定要离开考试吗？" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"不，谢谢" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        nil;
    }];
    UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"我要离开"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];

    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)createSheetView{
    _sheetView=[[SheetView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-80) withSuperView:self.view andQuesCount:answerScrollView.dataArray.count];
    _sheetView.delegate=self;  //代理将调用下面的 SeetViewClick: 方法并传入点击的题目按钮。
    [self.view addSubview:_sheetView];
}

#pragma mark - delegate 
- (void)SheetViewClick:(int)index{
    UIScrollView *scroll=answerScrollView->_scrollView;
    scroll.contentOffset=CGPointMake((index-1)*scroll.frame.size.width, 0);
    [scroll.delegate scrollViewDidEndDecelerating:scroll];
}

- (void)createModelView{
    modelView=[[SelectModelView alloc]initWithFrame:self.view.frame andTouch:^(SelectModel model) {
        NSLog(@"当前模式：%d",model);
    }];
    [self.view addSubview:modelView];
    modelView.alpha=0;
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithTitle:@"答题模式" style:UIBarButtonItemStylePlain target:self action:@selector(modelChange:)];
    self.navigationItem.rightBarButtonItem=item;
}

- (void)modelChange:(UIBarButtonItem *)item{
    [UIView animateWithDuration:0.4 animations:^{
        modelView.alpha=1;
    }];
}

- (void)createToolBar{
    UIView *barView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-60-64, self.view.frame.size.width, 60)];
    barView.backgroundColor=[UIColor whiteColor];
    NSArray *arr=@[[NSString stringWithFormat:@"%ld",answerScrollView.dataArray.count],@"查看答案",@"收藏本题"];
    for(int i=0;i<3;i++){
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(self.view.frame.size.width/3*i+self.view.frame.size.width/3/2-22 , 0, 36,36) ;
        btn.tag=301+i;  //则三个toolbar按钮的tag分别是：301，302，303；
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",16+i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-2.png",16+i]] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(clickToolBar:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(btn.center.x-30, 40, 60, 18)];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=arr[i];  //此方法中已经声明了这个array数组。
        label.font=[UIFont systemFontOfSize:14];
        [barView addSubview:label];
        [barView addSubview:btn];
        
    }
    [self.view addSubview:barView ];
}

- (void)createTestToolBar{
    UIView *barView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-60-64, self.view.frame.size.width, 60)];
    barView.backgroundColor=[UIColor whiteColor];
    NSArray *arr=@[[NSString stringWithFormat:@"%ld",answerScrollView.dataArray.count],@"收藏本题"];
    for(int i=0;i<2;i++){
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(self.view.frame.size.width/2*i+self.view.frame.size.width/2/2-22 , 0, 36,36) ;
        btn.tag=301+i;  //则三个toolbar按钮的tag分别是：301，302，303；
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",16+i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-2.png",16+i]] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(clickToolBar:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(btn.center.x-30, 40, 60, 18)];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=arr[i];  //此方法中已经声明了这个array数组。
        label.font=[UIFont systemFontOfSize:14];
        [barView addSubview:label];
        [barView addSubview:btn];
        
    }
    [self.view addSubview:barView ];

}

- (void)clickToolBar:(UIButton *)btn{
    switch (btn.tag) {
        case 301:
        {
            [UIView animateWithDuration:0.3 animations:^{
                _sheetView.frame=CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-80);
                _sheetView->_backView.alpha=0.8;
            }];
        }
            break;
        case 302:  //查看答案
        {
            if(_type!=5&&_type!=6){
                if ([answerScrollView.hadAnswerArray[answerScrollView.currentPage] intValue]!=0) {
                    return;
                }else{
                    AnswerModel *model=[answerScrollView.dataArray objectAtIndex:answerScrollView.currentPage];
                    NSString *answer=model.manswer;
                    char an=[answer characterAtIndex:0];
                    [answerScrollView.hadAnswerArray replaceObjectAtIndex:answerScrollView.currentPage withObject:[NSString stringWithFormat:@"%d",an-'A'+1]];
                }
            }
        }
            break;
        case 303:  //收藏
        {
            AnswerModel *model=answerScrollView.dataArray[answerScrollView.currentPage];
            [QuestionCollectManager addCollectQuesion:[model.mid intValue]];
        NSLog(@"%@",[QuestionCollectManager getCollectQuestion]);

        }
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
