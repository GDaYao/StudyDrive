//
//  Tools.h
//  studyDrive
//
//  Created by GDaYao on 2017/5/22.
//  Copyright © 2017年 GDaYao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tools : NSObject
+ (NSArray *)getAnswerWithString:(NSString *)str;

+ (CGSize)getSizeWithString:(NSString *)str withFont:(UIFont *)font withSize:(CGSize)size;

@end
