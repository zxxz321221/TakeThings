//
//  ToastView.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/11/4.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "ToastView.h"
@interface ToastView()
@property (nonatomic , strong)UIView * backView;

@property (nonatomic , strong) UILabel * title;
@property (nonatomic , strong) UIButton * confim;
@property (nonatomic , strong) UIButton * cancel;
@end
@implementation ToastView
+(instancetype)setToastView:(UIView *)view{
    ToastView * tView = [[ToastView alloc]initWithFrame:view.frame];
    [[UIApplication sharedApplication].keyWindow addSubview:tView];
    return tView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.hidden = YES;
        [self addSubview:self.backView];
    }
    return self;
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:30], (SCREEN_HEIGHT-[Unity countcoordinatesH:110])/2, SCREEN_WIDTH-[Unity countcoordinatesW:60], [Unity countcoordinatesH:130])];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 10;
        
        [_backView addSubview:self.title];
        [_backView addSubview:self.confim];
        [_backView addSubview:self.cancel];
    }
    return _backView;
}
- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:25], _backView.width, [Unity countcoordinatesH:15])];
        _title.text = @"该微信未注册，是否绑定已有账号";
        _title.textColor = LabelColor3;
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _title;
}
- (UIButton *)confim{
    if (!_confim) {
        _confim = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:30], _title.bottom+[Unity countcoordinatesH:30], (_backView.width-[Unity countcoordinatesW:80])/2, [Unity countcoordinatesH:40])];
        [_confim addTarget:self action:@selector(confimClick) forControlEvents:UIControlEventTouchUpInside];
        [_confim setTitle:@"去绑定" forState:UIControlStateNormal];
        [_confim setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        _confim.layer.borderColor = [Unity getColor:@"#aa112d"].CGColor;
        _confim.layer.borderWidth =1;
        _confim.layer.cornerRadius = _confim.height/2;
        
    }
    return _confim;
}
- (UIButton *)cancel{
    if (!_cancel) {
        _cancel = [[UIButton alloc]initWithFrame:CGRectMake(_confim.right+[Unity countcoordinatesW:20], _confim.top, _confim.width, _confim.height)];
        [_cancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [_cancel setTitle:@"去注册" forState:UIControlStateNormal];
        [_cancel setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
        _cancel.backgroundColor = [Unity getColor:@"#aa112d"];
        _cancel.layer.cornerRadius = _cancel.height/2;
    }
    return _cancel;
}

- (void)confimClick{
    self.hidden = YES;
    [self.delegate goToBinding];
}
- (void)cancelClick{
    self.hidden = YES;
    [self.delegate goToRegister];
}
- (void)showHackView{
    self.hidden = NO;
}

@end
