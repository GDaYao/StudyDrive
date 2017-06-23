//  FirstViewController.m
//  studyDrive
//  Created by GDaYao on 2017/5/19.
//  Copyright © 2017年 GDaYao. All rights reserved.

//FirstViewController-->2.“科目一理论考试”视图控制器

#import "FirstViewController.h"
#import "FirstTableViewCell.h"
#import "TestSelectViewController.h"
#import "MyDataManager.h"
#import "AnswerViewController.h"
#import "MainTestViewController.h"


@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title=@"科目一理论考试";
    self.view.backgroundColor=[UIColor whiteColor];
    self.edgesForExtendedLayout=UIRectEdgeNone;  //自动去除导航栏的高度64.
    
    self.dataArray=@[@"章节练习",@"顺序练习",@"随机练习",@"专项练习",@"仿真模拟考试"];
    
    [self createTableView];
    
    [self createNextView];
    
}

- (void)createTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300) style:UITableViewStylePlain];
    _tableView.bounces=NO;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
}

- (void)createNextView{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-170, self.view.bounds.size.height-64-220, self.view.bounds.size.width-20, 30)];
    
    label.textAlignment=NSTextAlignmentCenter;
    label.text=@"•••••••••••••••我的考试分析•••••••••••••••";
    [self.view addSubview:label];
    NSArray *arr=@[@"我的错题",@"我的收藏"];  //,@"我的成绩",@"练习统计"+self.view.bounds.size.width/4/2-30
    for (int i=0; i<2; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(self.view.bounds.size.width/2*i+self.view.bounds.size.width/2/2-30, self.view.bounds.size.height-64-150, 60, 60);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+12]] forState:UIControlStateNormal];
        btn.tag=201+i;
        [btn addTarget:self action:@selector(clickToolsBtn:) forControlEvents:UIControlEventTouchUpInside];
//        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2*i+self.view.bounds.size.width/2/2-30, btn.frame.origin.y+70, 60, 20)];
        lab.textAlignment=NSTextAlignmentCenter;
        lab.font=[UIFont boldSystemFontOfSize:13];
        lab.text=arr[i];
        [self.view addSubview:lab];
    }
    
}

- (void)clickToolsBtn:(UIButton *)btn{
    switch (btn.tag) {
        case 201:
        {
            AnswerViewController *answer =[[AnswerViewController alloc]init];
            answer.type=7;
            answer.title=@"顺序练习";
            [self.navigationController pushViewController:answer animated:YES];
        }
            break;
        case 202:
        {
            AnswerViewController *answer =[[AnswerViewController alloc]init];
            answer.type=8;
            answer.title=@"顺序练习";
            [self.navigationController pushViewController:answer animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"FirstTableViewCell";
    FirstTableViewCell *firstTVCell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (firstTVCell==nil) {
        firstTVCell=[[[NSBundle mainBundle]loadNibNamed:cellId owner:self options:nil] lastObject];  //加载xib文件，返回数组
    }
    firstTVCell.myImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%ld.png",indexPath.row+7]];
    firstTVCell.myLabel.text=self.dataArray[indexPath.row];
    
    return firstTVCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:  //章节练习
        {
                //跳转到“章节练习”页面
            TestSelectViewController *con=[[TestSelectViewController alloc]init];
                //调用下一个控制器数组 dataArray-->MyDataManager选择chapter，获取数据库中的属性。
            con.dataArray=[MyDataManager getData:chapter];
            con.title=@"章节练习";
            con.type=1;
            
            UIBarButtonItem *testItem=[[UIBarButtonItem alloc]init];
            testItem.title=@"";
            self.navigationItem.backBarButtonItem=testItem;
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
        case 1:  //顺序练习
        {
            AnswerViewController *answer =[[AnswerViewController alloc]init];
            answer.type=2;
            answer.title=@"顺序练习";
            [self.navigationController pushViewController:answer animated:YES];
        }
            break;
        case 2:  //随机练习
        {
            AnswerViewController *answer =[[AnswerViewController alloc]init];
            answer.type=3;
            answer.title=@"随机练习";
            [self.navigationController pushViewController:answer animated:YES];
        }
            break;
        case 3:  //专项练习
        {
            TestSelectViewController *con=[[TestSelectViewController alloc]init];
            //调用下一个控制器数组 dataArray-->MyDataManager选择chapter，获取数据库中的属性。
            con.dataArray=[MyDataManager getData:subChapter];
            con.title=@"专项练习";
            con.type=2;
            
            UIBarButtonItem *testItem=[[UIBarButtonItem alloc]init];
            testItem.title=@"";
            self.navigationItem.backBarButtonItem=testItem;
            [self.navigationController pushViewController:con animated:YES];

        }
            break;
        case 4:  //模拟考试
        {
            UIBarButtonItem *testItem=[[UIBarButtonItem alloc]init];
            testItem.title=@"";
            self.navigationItem.backBarButtonItem=testItem;
            MainTestViewController *con=[[MainTestViewController alloc]init];
            [self.navigationController pushViewController:con animated:YES];
            
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
