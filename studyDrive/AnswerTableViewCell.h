//
//  AnswerTableViewCell.h
//  studyDrive
//
//  Created by GDaYao on 2017/5/22.
//  Copyright © 2017年 GDaYao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *numberImage;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

@end
