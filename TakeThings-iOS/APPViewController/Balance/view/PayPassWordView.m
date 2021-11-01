//
//  PayPassWordView.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/11.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "PayPassWordView.h"
@interface PayPassWordView()
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic  , strong) UIButton * cancel;
@property (nonatomic , strong) UIButton * setting;
@end
@implementation PayPassWordView

+(instancetype)setPayPassWordView:(UIView *)view{
    PayPassWordView * pView = [[PayPassWordView alloc]initWithFrame:view.frame];
    [view addSubview:pView];
    return pView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self addSubview:self.backView];
        self.hidden = YES;
    }
    return self;
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:30], (SCREEN_HEIGHT-[Unity countcoordinatesH:110])/2, [Unity countcoordinatesW:260], [Unity countcoordinatesH:110])];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 10;
        [_backView addSubview:self.titleL];
        [_backView addSubview:self.cancel];
        [_backView addSubview:self.setting];
    }
    return _backView;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], [Unity countcoordinatesH:20], _backView.width-[Unity countcoordinatesW:40], [Unity countcoordinatesH:20])];
        _titleL.text = @"请您先设置支付密码";
        _titleL.textColor = LabelColor3;
        _titleL.textAlignment = NSTextAlignmentLeft;
        _titleL.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _titleL;
}
- (UIButton *)cancel{
    if (!_cancel) {
        _cancel = [[UIButton alloc]initWithFrame:CGRectMake(0, _titleL.bottom+[Unity countcoordinatesH:30], _backView.width/2, [Unity countcoordinatesH:20])];
        [_cancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [_cancel setTitle:@"取消" forState:UIControlStateNormal];
        [_cancel setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        _cancel.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _cancel;
}
- (UIButton *)setting{
    if (!_setting) {
        _setting = [[UIButton alloc]initWithFrame:CGRectMake(_cancel.right, _titleL.bottom+[Unity countcoordinatesH:30], _backView.width/2, [Unity countcoordinatesH:20])];
        [_setting addTarget:self action:@selector(setClick) forControlEvents:UIControlEventTouchUpInside];
        [_setting setTitle:@"去设置" forState:UIControlStateNormal];
        [_setting setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        _setting.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _setting;
}
- (void)cancelClick{
    self.hidden = YES;
}
- (void)setClick{
    self.hidden = YES;
    [self.delegate set];
}
- (void)showPayPasswordView{
    self.hidden = NO;
}
@end
