//
//  TestSelectViewController.m
//  studyDrive
//  Created by GDaYao on 2017/5/20.
//  Copyright © 2017年 GDaYao. All rights reserved.

//TestSelectViewController-->3.“章节练习”视图控制器

#import "TestSelectViewController.h"
#import "TestSelectTableViewCell.h"
#import "TestSelectModel.h"
#import "AnswerViewController.h"
#import "SubTestSelectModel.h"

@interface TestSelectViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation TestSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.title=@"章节练习";  //放在上一个视图控制器中，设置控制器的title
    self.view.backgroundColor=[UIColor whiteColor];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    [self createTableView];
    
}

- (void)createTableView{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableView.bounces=NO;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;  //注释了这里的数据的count，使用了几个数字代替，后期传入数据。
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *testCellId=@"TestSelectTableViewCell";
    TestSelectTableViewCell *testSelectCell=[tableView dequeueReusableCellWithIdentifier:testCellId];
    if (testSelectCell==nil) {
        testSelectCell=[[[NSBundle mainBundle]loadNibNamed:testCellId owner:self options:nil] lastObject];
        testSelectCell.selectionStyle=UITableViewCellSelectionStyleNone;  //设置cell被选中时的背景颜色。
        testSelectCell.numberLabel.layer.masksToBounds=YES;
        testSelectCell.numberLabel.layer.cornerRadius=8;
        //    testSelectCell.contentLabel.adjustsFontSizeToFitWidth=YES;
    }
    if(_type==1){
        TestSelectModel *testSModel=[[TestSelectModel alloc]init];
        testSModel=_dataArray[indexPath.row];
        
        testSelectCell.numberLabel.text=testSModel.pid;
        testSelectCell.contentLabel.text=testSModel.pname;
    }else{
        SubTestSelectModel *model=[[SubTestSelectModel alloc]init];
        model=_dataArray[indexPath.row];
        testSelectCell.numberLabel.text=model.serial;
        testSelectCell.contentLabel.text=model.sname;
        
    }
    
    return testSelectCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AnswerViewController *answerVC=[[AnswerViewController alloc]init];
    if (_type==1) {
        answerVC.type=1;
        
    }else{
        answerVC.type=4;
    }
    
    
    [self.navigationController pushViewController:answerVC animated:YES];
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
    item.title=@"";
    self.navigationItem.backBarButtonItem=item;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
