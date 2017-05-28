//
//  SheetView.h
//  studyDrive
//
//  Created by GDaYao on 2017/5/25.
//  Copyright © 2017年 GDaYao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SheetViewDelegate
- (void)SheetViewClick:(int)index;
@end


@interface SheetView : UIView
{
    @public
     UIView *_backView;
}
@property(nonatomic,weak)id<SheetViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame withSuperView:(UIView *)superView andQuesCount:(int)count;
@end
