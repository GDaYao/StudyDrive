//  AnswerScrollView.m
//  studyDrive
//  Created by GDaYao on 2017/5/21.
//  Copyright © 2017年 GDaYao. All rights reserved.

//AnswerScrollView-->"章节练习"答题界面

#import "AnswerScrollView.h"
#import "AnswerTableViewCell.h"
#import "AnswerModel.h"
#import "Tools.h"
#import "QuestionCollectManager.h"

#define SIZE self.frame.size

@interface AnswerScrollView()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
}
@end

@implementation AnswerScrollView
{
    UITableView *_leftTabelView;
    UITableView *_mainTableView;
    UITableView *_rightTableView;

}

- (instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)array{
    self=[super initWithFrame:frame];
    if(self){
        _currentPage=0; //初始化当前答题页面为0，即第一页；
        _dataArray=[[NSArray alloc]initWithArray:array];
        _hadAnswerArray=[[NSMutableArray alloc]init];
        for (int i=0; i<array.count; i++) {
            [_hadAnswerArray addObject:@"0"];
        }
        _scrollView=[[UIScrollView alloc]initWithFrame:frame];
        _scrollView.delegate=self;
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.pagingEnabled=YES;
        _scrollView.bounces=NO;
        _leftTabelView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _mainTableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _rightTableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _leftTabelView.bounces=NO;
        _mainTableView.bounces=NO;
        _rightTableView.bounces=NO;
        _leftTabelView.dataSource=self;
        _leftTabelView.delegate=self;
        _mainTableView.delegate=self;
        _mainTableView.dataSource=self;
        _rightTableView.delegate=self;
        _rightTableView.dataSource=self;
        
        if (_dataArray.count>1) {
            _scrollView.contentSize=CGSizeMake(SIZE.width*2, 0);
        }
        
        [self createView];
    }
    
    return  self;
}

- (void)createView{
    _leftTabelView.frame=CGRectMake(0, 0, SIZE.width,SIZE.height);
    _mainTableView.frame=CGRectMake(SIZE.width, 0,SIZE.width,SIZE.height);
    _rightTableView.frame=CGRectMake(SIZE.width*2, 0, SIZE.width, SIZE.height);
    [_scrollView addSubview:_leftTabelView];
    [_scrollView addSubview:_mainTableView];
    [_scrollView addSubview:_rightTableView];
    [self addSubview:_scrollView];
    
}

#pragma  mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    AnswerModel *model=[self getTheFitModel:tableView];
    NSString *str=[NSString stringWithFormat:@"答案解析：%@",model.mdesc];
    UIFont *font=[UIFont systemFontOfSize:16];
    return [Tools getSizeWithString:str withFont:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 100;
    AnswerModel *model=[self getTheFitModel:tableView];
    CGFloat height;
    if ([model.mtype intValue]==1) {
        NSString *str=[[Tools getAnswerWithString:model.mquestion] objectAtIndex:0];
        UIFont *font=[UIFont systemFontOfSize:16];
        height= [Tools getSizeWithString:str withFont:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    }else{
        NSString *str=model.mquestion;
        UIFont *font=[UIFont systemFontOfSize:16];
        height= [Tools getSizeWithString:[NSString stringWithFormat:@"%d.%@",[self getQuestionNumber:tableView andCurrentPage:_currentPage],str] withFont:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    }
    if (height<=80) {
        return 80;
    }else{
        return height;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    CGFloat height;
    NSString *str;
    AnswerModel *model=[self getTheFitModel:tableView];
    str=[NSString stringWithFormat:@"答案解析：%@",model.mdesc];
    UIFont *font=[UIFont systemFontOfSize:16];
    height= [Tools getSizeWithString:str withFont:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, height)];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, tableView.frame.size.width-20, height-20)];
    label.text=str;
    label.font=[UIFont systemFontOfSize:16];
    label.numberOfLines=0;
    label.textColor=[UIColor greenColor];
    [view addSubview:label];
    
    int page=[self getQuestionNumber:tableView andCurrentPage:_currentPage];
    if([_hadAnswerArray[page-1] intValue]!=0 ){
        return  view;
    }
    return  nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat height;
    NSString *str;
    AnswerModel *model=[self getTheFitModel:tableView];
    if ([model.mtype intValue]==1) {
        str=[[Tools getAnswerWithString:model.mquestion] objectAtIndex:0];
        UIFont *font=[UIFont systemFontOfSize:16];
        height= [Tools getSizeWithString:[NSString stringWithFormat:@"%d.%@",[self getQuestionNumber:tableView andCurrentPage:_currentPage],str] withFont:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    }else{
        str=model.mquestion;
        UIFont *font=[UIFont systemFontOfSize:16];
        height= [Tools getSizeWithString:[NSString stringWithFormat:@"%d.%@",[self getQuestionNumber:tableView andCurrentPage:_currentPage],str] withFont:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    }

    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, height)];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, tableView.frame.size.width-20, height-20)];
    label.text=[NSString stringWithFormat:@"%d.%@",[self getQuestionNumber:tableView andCurrentPage:_currentPage],str];
    label.font=[UIFont systemFontOfSize:16];
    label.numberOfLines=0;
    [view addSubview:label];
    return  view;
}

- (int)getQuestionNumber:(UITableView *)tableView andCurrentPage:(int)page{
    if (tableView==_leftTabelView && page==0) {
        return 1;
    }else if (tableView==_leftTabelView && page>0){
        return page;
    }else if(tableView==_mainTableView&&page>0&&page<_dataArray.count-1){
        return page+1;
    }else if (tableView==_mainTableView&&page==0){
        return 2;
    }else if (tableView==_mainTableView&&page==_dataArray.count-1){
        return page;
    }else if(tableView==_rightTableView&&page<_dataArray.count-1){
        return page+2;
    }else if (tableView==_rightTableView&&page==_dataArray.count-1){
        return page+1;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int page=[self getQuestionNumber:tableView andCurrentPage:_currentPage];
    if([_hadAnswerArray[page-1] intValue]!=0){
        return;
    }else{
        [_hadAnswerArray replaceObjectAtIndex:page-1 withObject:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
    }
    //错题存档
    AnswerModel *model=[self getTheFitModel:tableView];
    if (![model.manswer isEqualToString:[NSString stringWithFormat:@"%c",'A'+(int)indexPath.row]]) {
        [QuestionCollectManager addWrongQuesion:[model.mid intValue]];
//        NSLog(@"%@",[QuestionCollectManager getWrongQuestion]);
    }
    
    
    [self reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *answerCellId=@"AnswerTableViewCell";
    AnswerTableViewCell *answerCell=[tableView dequeueReusableCellWithIdentifier:answerCellId];
    if (answerCell==nil) {
        answerCell=[[[NSBundle mainBundle]loadNibNamed:answerCellId owner:self options:nil] lastObject];
        answerCell.numberLabel.layer.masksToBounds=YES;
        answerCell.numberLabel.layer.cornerRadius=10;
        answerCell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    answerCell.numberLabel.text=[NSString stringWithFormat:@"%c",(char)('A'+indexPath.row)];//numberLabel->A,B.
    
    AnswerModel *model=[self getTheFitModel:tableView];
    if([model.mtype intValue]==1){
        answerCell.answerLabel.text=[[Tools getAnswerWithString:model.mquestion] objectAtIndex:indexPath.row+1];
    }
    int page=[self getQuestionNumber:tableView andCurrentPage:_currentPage];
    if([_hadAnswerArray[page-1] intValue]!=0) {
        if([model.manswer isEqualToString:[NSString stringWithFormat:@"%c",'A'+(int)indexPath.row]]){
            answerCell.numberImage.image=nil;
            answerCell.numberImage.hidden=NO;
            answerCell.numberImage.image=[UIImage imageNamed:@"19.png"];
        }else if (![model.manswer isEqualToString:[NSString stringWithFormat:@"%c",'A'+[_hadAnswerArray[page-1] intValue]-1]]&&indexPath.row==[_hadAnswerArray[page-1] intValue]-1) {
            answerCell.numberImage.image=nil;
            answerCell.numberImage.hidden=NO;
            answerCell.numberImage.image=[UIImage imageNamed:@"20.png"];
        }else{
            answerCell.numberImage.hidden=YES;
        }
    }else{
        answerCell.numberImage.hidden=YES;
    }
    
    return answerCell; 
}

- (AnswerModel *)getTheFitModel:(UITableView *)tableView{
    AnswerModel *answerM=[[AnswerModel alloc]init];
    if (tableView==_leftTabelView&&_currentPage==0) { //当前页面为第一个页面
        answerM=_dataArray[_currentPage];
    }else if (tableView==_leftTabelView&&_currentPage>0){  //从当前页面向右滑动，即要显示前一个页面
        answerM=_dataArray[_currentPage-1];
    }else if (tableView==_mainTableView&&_currentPage==0){  //显示左边视图，向左拖动显示下一个页面
        answerM=_dataArray[_currentPage+1];
    }else if (tableView==_mainTableView&&_currentPage>0&&_currentPage<_dataArray.count-1){
        answerM=_dataArray[_currentPage];
    }else if(tableView==_mainTableView&&_currentPage==_dataArray.count-1){
        answerM=_dataArray[_currentPage-1];
    }else if(tableView==_rightTableView&&_currentPage==_dataArray.count-1){
        answerM=_dataArray[_currentPage];
    }else if (tableView==_rightTableView&&_currentPage<_dataArray.count-1){
        answerM=_dataArray[_currentPage+1];
    }
    return answerM;
}

    /* 滑动结束，执行这个方法，进行相关判断 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint currentOffset=scrollView.contentOffset;
    int page=(int)currentOffset.x/SIZE.width;
    if (page<_dataArray.count-1&&page>0) {  //&&page=0
        _scrollView.contentSize=CGSizeMake(currentOffset.x+SIZE.width*2,0);
        _mainTableView.frame=CGRectMake(currentOffset.x, 0, SIZE.width, SIZE.height) ;
        _leftTabelView.frame=CGRectMake(currentOffset.x-SIZE.width, 0, SIZE.width, SIZE.height);
        _rightTableView.frame=CGRectMake(currentOffset.x+SIZE.width, 0, SIZE.width, SIZE.height);        
    }
    _currentPage=page;
    [self reloadData];
}

- (void)reloadData{
    [_leftTabelView reloadData];
    [_mainTableView reloadData];
    [_rightTableView reloadData];
}


@end
