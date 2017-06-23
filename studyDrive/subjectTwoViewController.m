//
//  subjectTwoViewController.m
//  studyDrive
//
//  Created by GDaYao on 2017/5/27.
//  Copyright © 2017年 GDaYao. All rights reserved.
//

#import "subjectTwoViewController.h"
#import "subjectTwoTableViewCell.h"
//#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>

@interface subjectTwoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
}

@end

@implementation subjectTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"subjectTwoTableViewCell";
    subjectTwoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell==nil){
        cell=[[[NSBundle mainBundle]loadNibNamed:cellId owner:self options:nil] lastObject];
    }
    cell.titleImageView.image=[UIImage imageNamed:@"drive-Spotlight@2x.png"]; //科目二视频
    cell.theTitleLabel.text=[NSString stringWithFormat:@"视频:%ld",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString *path=[[NSBundle mainBundle]pathForResource:@"shipin" ofType:@"mp4"]; //视频文件
//    NSURL *url=[NSURL fileURLWithPath:path];
    
//    MPMoviePlayerController *movie=[[MPMoviePlayerController alloc]initWithContentURL:url];
//    movie.moviePlayer.shouldAutoPlayer=YES;
    AVPlayerViewController *movie=[[AVPlayerViewController alloc]initWithNibName:@"subjectTwoTableViewCell" bundle:[[NSBundle mainBundle]pathForResource:@"shipin" ofType:@"mp4"]];
//    movie.player=;
    
//    [self.navigationController pushViewController:movie animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
