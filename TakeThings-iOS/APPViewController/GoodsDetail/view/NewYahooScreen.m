//
//  NewYahooScreen.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/9/5.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "NewYahooScreen.h"
@interface NewYahooScreen()

@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UIView * navView;
@property (nonatomic , strong) UIButton * leftBtn;
@property (nonatomic , strong) UIButton * rightBtn;
@end
@implementation NewYahooScreen

+(instancetype)setNewYahooScreenView:(UIView *)view{
    NewYahooScreen * sView = [[NewYahooScreen alloc]initWithFrame:view.frame];
    [[UIApplication sharedApplication].keyWindow addSubview:sView];
    return sView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.hidden = YES;
    }
    return self;
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backView.backgroundColor = [UIColor whiteColor];
        
    }
    return _backView;
}
- (UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight)];
        _navView.backgroundColor = [UIColor whiteColor];
        
        [_navView addSubview:self.leftBtn];
        [_navView addSubview:self.rightBtn];
    }
    return _navView;
}
- (UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(12, NavBarHeight-44+7.5, 28.5, 28.5)];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"X"] forState:UIControlStateNormal];
//        [_leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}
- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-62, NavBarHeight-44+7.5, 50, 28.5)];
        [_rightBtn setTitle:@"重置" forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightBtn setTitleColor:LabelColor9 forState:UIControlStateNormal];
        _rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightBtn;
}
@end
