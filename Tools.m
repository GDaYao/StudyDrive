//
//  Tools.m
//  studyDrive
//
//  Created by GDaYao on 2017/5/22.
//  Copyright © 2017年 GDaYao. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+ (NSArray *)getAnswerWithString:(NSString *)str{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    NSArray * arr=[str componentsSeparatedByString:@"<BR>"];  //使用数组来获取，数据库中的整体数据,<BR>分隔开的,arr[0]。
    [array addObject:arr[0]];
    
    for (int i=0; i<4; i++) {
        [array addObject:[arr[i+1] substringFromIndex:2]];  //去掉了前2个，保存在可变数组array中；
    }
    return array;
}

+ (CGSize)getSizeWithString:(NSString *)str withFont:(UIFont *)font withSize:(CGSize)size{
    CGSize xinSize=[str sizeWithFont:font constrainedToSize:size];
    return xinSize;
 }

@end
