//
//  paymentTpye.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/10.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "paymentTpye.h"
@interface paymentTpye()
{
    NSInteger index;
}
@property (nonatomic , strong) UIView * typeView;
@property (nonatomic , strong) UILabel * typeL;
@property (nonatomic , strong) UIButton * confirmBtn;
@property (nonatomic , strong) UIView * line;
@property (nonatomic , strong) UIButton * unionpayBtn;
@property (nonatomic , strong) UIButton * alipayBtn;
@property (nonatomic , strong) UIButton * wechatpayBtn;
@property (nonatomic , strong) UIButton * unionRead;
@property (nonatomic , strong) UIButton * aliRead;
@property (nonatomic , strong) UIButton * wechatRead;
@end
@implementation paymentTpye
+(instancetype)setPaymentType:(UIView *)view{
    paymentTpye * paymentType = [[paymentTpye alloc]initWithFrame:view.frame];
    [view addSubview:paymentType];
    return paymentType;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        index = 0;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        [self addSubview:self.typeView];
        self.hidden = YES;
    }
    return self;
}
- (UIView *)typeView{
    if (!_typeView) {
        _typeView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, [Unity countcoordinatesH:190])];
        _typeView.backgroundColor = [UIColor whiteColor];
        [_typeView addSubview:self.typeL];
        [_typeView addSubview:self.confirmBtn];
        [_typeView addSubview:self.line];
        [_typeView addSubview:self.unionpayBtn];
        [_typeView addSubview:self.alipayBtn];
        [_typeView addSubview:self.wechatpayBtn];
    }
    
    return _typeView;
}
- (UILabel *)typeL{
    if (!_typeL) {
        _typeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:150], [Unity countcoordinatesH:20])];
        _typeL.text = @"选择充值方式";
        _typeL.textColor = LabelColor3;
        _typeL.textAlignment = NSTextAlignmentLeft;
        _typeL.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _typeL;
}
- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:60], [Unity countcoordinatesH:10], [Unity countcoordinatesW:50], [Unity countcoordinatesH:20])];
        [_confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
        _confirmBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _confirmBtn;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:39], SCREEN_WIDTH,1)];
        _line.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line;
}
- (UIButton *)unionpayBtn{
    if (!_unionpayBtn) {
        _unionpayBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:40], SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        [_unionpayBtn addTarget:self action:@selector(unionClick) forControlEvents:UIControlEventTouchUpInside];
        UIImageView * img = [Unity imageviewAddsuperview_superView:_unionpayBtn _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20]) _imageName:@"unionPay" _backgroundColor:nil];
        img.contentMode = UIViewContentModeScaleAspectFit;
        [_unionpayBtn addSubview:self.unionRead];
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:49], SCREEN_WIDTH, 1)];
        line.backgroundColor = [Unity getColor:@"#e0e0e0"];
        [_unionpayBtn addSubview:line];
        
    }
    return _unionpayBtn;
}
- (UIButton *)alipayBtn{
    if (!_alipayBtn) {
        _alipayBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _unionpayBtn.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        [_alipayBtn addTarget:self action:@selector(aliClick) forControlEvents:UIControlEventTouchUpInside];
        UIImageView * img = [Unity imageviewAddsuperview_superView:_alipayBtn _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:55], [Unity countcoordinatesH:20]) _imageName:@"aliPay" _backgroundColor:nil];
        img.contentMode = UIViewContentModeScaleAspectFit;
        [_alipayBtn addSubview:self.aliRead];
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:49], SCREEN_WIDTH, 1)];
        line.backgroundColor = [Unity getColor:@"#e0e0e0"];
        [_alipayBtn addSubview:line];
    }
    return _alipayBtn;
}
- (UIButton *)wechatpayBtn{
    if (!_wechatpayBtn) {
        _wechatpayBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _alipayBtn.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        [_wechatpayBtn addTarget:self action:@selector(wechatClick) forControlEvents:UIControlEventTouchUpInside];
        UIImageView * img = [Unity imageviewAddsuperview_superView:_wechatpayBtn _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20]) _imageName:@"wechatPay" _backgroundColor:nil];
        img.contentMode = UIViewContentModeScaleAspectFit;
        [_wechatpayBtn addSubview:self.wechatRead];
    }
    return _wechatpayBtn;
}
- (UIButton *)unionRead{
    if (!_unionRead) {
        _unionRead = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:25], [Unity countcoordinatesH:17.5], [Unity countcoordinatesW:15], [Unity countcoordinatesH:15])];
        [_unionRead setBackgroundImage:[UIImage imageNamed:@"不中"] forState:UIControlStateNormal];
        [_unionRead setBackgroundImage:[UIImage imageNamed:@"中"] forState:UIControlStateSelected];
        _unionRead.selected = YES;
    }
    return _unionRead;
}
- (UIButton *)aliRead{
    if (!_aliRead) {
        _aliRead = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:25], [Unity countcoordinatesH:17.5], [Unity countcoordinatesW:15], [Unity countcoordinatesH:15])];
        [_aliRead setBackgroundImage:[UIImage imageNamed:@"不中"] forState:UIControlStateNormal];
        [_aliRead setBackgroundImage:[UIImage imageNamed:@"中"] forState:UIControlStateSelected];
    }
    return _aliRead;
}
- (UIButton *)wechatRead{
    if (!_wechatRead) {
        _wechatRead = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:25], [Unity countcoordinatesH:17.5], [Unity countcoordinatesW:15], [Unity countcoordinatesH:15])];
        [_wechatRead setBackgroundImage:[UIImage imageNamed:@"不中"] forState:UIControlStateNormal];
        [_wechatRead setBackgroundImage:[UIImage imageNamed:@"中"] forState:UIControlStateSelected];
    }
    return _wechatRead;
}

- (void)showType{
    self.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.typeView.frame = CGRectMake(0, SCREEN_HEIGHT-[Unity countcoordinatesH:190], SCREEN_WIDTH, [Unity countcoordinatesH:190]);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }];
}
- (void)hiddenType{
    [UIView animateWithDuration:0.5 animations:^{
        self.typeView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, [Unity countcoordinatesH:190]);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    }];
    [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:0.5];
}
- (void)delayMethod{
    self.hidden = YES;
}
- (void)confirmClick{
    [self hiddenType];
    [self.delegate confirm:index];
}
- (void)unionClick{
    self.unionRead.selected = YES;
    self.aliRead.selected = NO;
    self.wechatRead.selected = NO;
    index = 0;
}
- (void)aliClick{
    self.unionRead.selected = NO;
    self.aliRead.selected = YES;
    self.wechatRead.selected = NO;
    index = 1;
}
- (void)wechatClick{
    self.unionRead.selected = NO;
    self.aliRead.selected = NO;
    self.wechatRead.selected = YES;
    index = 2;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hiddenType];
}
@end
