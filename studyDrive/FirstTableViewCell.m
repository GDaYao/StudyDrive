//  FirstTableViewCell.m
//  studyDrive
//  Created by GDaYao on 2017/5/19.
//  Copyright © 2017年 GDaYao. All rights reserved.

//FirstTableViewCell-->FirstViewController的自定义cell

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}


- (void)createView{
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
