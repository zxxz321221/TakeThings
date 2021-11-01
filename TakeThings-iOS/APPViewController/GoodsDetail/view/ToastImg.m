//
//  ToastImg.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/8/13.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "ToastImg.h"
@interface ToastImg()
@property (nonatomic , strong) UIImageView * imageView;
@end
@implementation ToastImg

+(instancetype)setToastImg:(UIView *)view{
    ToastImg * tView = [[ToastImg alloc]initWithFrame:view.frame];
    [[UIApplication sharedApplication].keyWindow addSubview:tView];
    return tView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.hidden = YES;
        [self addSubview:self.imageView];
    }
    return self;
}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, NavBarHeight+[Unity countcoordinatesH:200], SCREEN_WIDTH, [Unity countcoordinatesH:246])];
        _imageView.image = [UIImage imageNamed:@"toastImg"];
//        [_imageView sizeToFit];
        UITapGestureRecognizer *singleTap =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskAction)];
        singleTap.numberOfTapsRequired = 1; //点击次数
        singleTap.numberOfTouchesRequired = 1; //点击手指数
        [_imageView addGestureRecognizer:singleTap];
        _imageView.userInteractionEnabled = YES;
        
    }
    return _imageView;
}
- (void)showToastImg{
    self.hidden = NO;
}
- (void)maskAction{
    self.hidden = YES;
}
@end
