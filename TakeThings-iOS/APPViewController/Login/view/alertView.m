//
//  alertView.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/16.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "alertView.h"
@interface alertView()

@property (nonatomic,strong) UIView * backView;
@property (nonatomic,strong) UIImageView * imageView;
@end
@implementation alertView
+(instancetype)setAlertView:(UIView *)view{
    alertView * altView = [[alertView alloc]initWithFrame:view.frame];
    [view addSubview:altView];
    return altView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.hidden = YES;
        [self addSubview:self.backView];
        [self.backView addSubview:self.imageView];
        [self.backView addSubview:self.msgL];
    }
    return self;
}
- (UIView *)backView{
    if (_backView == nil) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-[Unity countcoordinatesW:170])/2, (SCREEN_HEIGHT-NavBarHeight-[Unity countcoordinatesH:100])/2, [Unity countcoordinatesW:170], [Unity countcoordinatesH:100])];
        _backView.layer.cornerRadius = 10;
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.4;
    }
    return _backView;
}
- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((_backView.width-[Unity countcoordinatesW:30])/2, [Unity countcoordinatesH:15], [Unity countcoordinatesW:30], [Unity countcoordinatesH:30])];
        _imageView.image = [UIImage imageNamed:@"弹窗叹号"];
    }
    return _imageView;
}
- (UILabel *)msgL{
    if (_msgL == nil) {
        _msgL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _imageView.bottom+[Unity countcoordinatesH:10], _backView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        _msgL.textColor = [UIColor whiteColor];
        _msgL.numberOfLines = 0;
        _msgL.font = [UIFont systemFontOfSize:FontSize(14)];
        _msgL.textAlignment = NSTextAlignmentCenter;
    }
    return _msgL;
}
- (void)showAlertView{
    self.hidden=NO;
    [self performSelector:@selector(dimissAlert:) withObject:self afterDelay:3];
}
-(void) dimissAlert:(UIAlertView *)alert{
    self.hidden=YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
