//  ViewController.m
//  studyDrive
//  Created by GDaYao on 2017/5/16.
//  Copyright © 2017年 GDaYao. All rights reserved.

//ViewController-->1."考驾照"首页视图控制器

#import "ViewController.h"
#import "selectView.h"
#import "FirstViewController.h"
#import "subjectTwoViewController.h"
#import "WebViewController.h"
#import "WebViewControllerNew.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end

@implementation ViewController
{
    selectView *_selectV;
}
- (IBAction)selectBtn:(UIButton *)sender {
    switch (sender.tag) {
        case 100:
        {
           [ UIView animateWithDuration:0.3 animations:^{
               _selectV.alpha=1;
           }];
            
        }
            break;
        case 101:   //科目一
        {
            UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
            item.title=@"";
            self.navigationItem.backBarButtonItem=item;
            FirstViewController *firstVC=[[FirstViewController alloc]init];
            firstVC.title=@"科目一理论考试";
            [self.navigationController pushViewController:firstVC animated:YES];
        }
            break;
        case 102:   //科目二
        {
            UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
            item.title=@"";
            self.navigationItem.backBarButtonItem=item;
            [self.navigationController pushViewController:[[subjectTwoViewController alloc]init] animated:YES];
            
        }
            break;
        case 103:   //科目三
        {
            UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
            item.title=@"";
            self.navigationItem.backBarButtonItem=item;
            [self.navigationController pushViewController:[[subjectTwoViewController alloc]init] animated:YES];
        }
            break;
        case 104:   //科目四
        {
            UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
            item.title=@"";
            self.navigationItem.backBarButtonItem=item;
            FirstViewController *firstVC=[[FirstViewController alloc]init];
            firstVC.title=@"科目四理论考试";
            [self.navigationController pushViewController:firstVC animated:YES];
        }
            break;
        case 105:  //报名须知
        {
            UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
            item.title=@"";
            self.navigationItem.backBarButtonItem=item;
            [self.navigationController pushViewController:[[WebViewController alloc]init] animated:YES];
        }
            break;
        case 106:  //新手上路
        {
            UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
            item.title=@"";
            self.navigationItem.backBarButtonItem=item;
            [self.navigationController pushViewController:[[WebViewControllerNew alloc]init] animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
        //设置导航栏返回按钮的颜色为：白色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    _selectV=[[selectView alloc]initWithFrame: self.view.frame andBtn:self.selectBtn];  //call UIButton to subView.
    _selectV.alpha=0;  //alpha是不透明度，数值是从0～1，完全透明～完全不透明，alpha主要用于实现隐藏的动画效果，但区别于hidden设置为YES无动画效果。
    [self.view addSubview:_selectV];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
