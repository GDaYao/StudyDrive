//
//  SelectModelView.h
//  studyDrive
//
//  Created by GDaYao on 2017/5/25.
//  Copyright © 2017年 GDaYao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    testModel,
    lookingModel
}SelectModel;
typedef void (^SelecTouch)(SelectModel model );
@interface SelectModelView : UIView

@property(nonatomic,assign)SelectModel model;

- (SelectModelView *)initWithFrame:(CGRect)frame andTouch:(SelecTouch)touch;
@end
