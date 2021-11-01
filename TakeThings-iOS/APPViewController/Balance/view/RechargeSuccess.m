//
//  RechargeSuccess.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/10.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "RechargeSuccess.h"
@interface RechargeSuccess()
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UIImageView * imageView;
@property (nonatomic , strong) UILabel * successL;
@property (nonatomic , strong) UIButton * confirm;
@end
@implementation RechargeSuccess

+(instancetype)setRechrgeSuccess:(UIView *)view{
    RechargeSuccess * rechargeSucc = [[RechargeSuccess alloc]initWithFrame:view.frame];
    [view addSubview:rechargeSucc];
    return rechargeSucc;
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
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:40], (SCREEN_HEIGHT-[Unity countcoordinatesH:275])/2, [Unity countcoordinatesW:240], [Unity countcoordinatesH:275])];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 10;
        [_backView addSubview:self.imageView];
        [_backView addSubview:self.successL];
        [_backView addSubview:self.amountL];
        [_backView addSubview:self.confirm];
    }
    return _backView;
}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((_backView.width-[Unity countcoordinatesW:60])/2, [Unity countcoordinatesH:40], [Unity countcoordinatesW:60], [Unity countcoordinatesH:60])];
        _imageView.image = [UIImage imageNamed:@"充值成功"];
    }
    return _imageView;
}
- (UILabel *)successL{
    if (!_successL) {
        _successL = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageView.bottom+[Unity countcoordinatesH:20], _backView.width, [Unity countcoordinatesH:20])];
        _successL.text = @"充值成功";
        _successL.textColor = LabelColor3;
        _successL.textAlignment = NSTextAlignmentCenter;
        _successL.font = [UIFont systemFontOfSize:FontSize(18)];
    }
    return _successL;
}
- (UILabel *)amountL{
    if (!_amountL) {
        _amountL = [[UILabel alloc]initWithFrame:CGRectMake(0, _successL.bottom+[Unity countcoordinatesH:10], _backView.width, [Unity countcoordinatesH:30])];
        _amountL.textColor = LabelColor3;
        _amountL.textAlignment = NSTextAlignmentCenter;
        _amountL.font = [UIFont systemFontOfSize:FontSize(29)];
    }
    return _amountL;
}
- (UIButton *)confirm{
    if (!_confirm) {
        _confirm = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _amountL.bottom+[Unity countcoordinatesH:40], _backView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:35])];
        [_confirm addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        [_confirm setTitle:@"完成" forState:UIControlStateNormal];
        _confirm.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
        [_confirm setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        _confirm.layer.borderWidth = 1;
        _confirm.layer.borderColor = [Unity getColor:@"#aa112d"].CGColor;
        _confirm.layer.cornerRadius = _confirm.height/2;
    }
    return _confirm;
}
- (void)confirmClick{
    self.hidden = YES;
    [self.delegate rechargeSuccessConfirm];
}
- (void)showRechargeSuccess{
    self.hidden = NO;
}
@end
