//
//  CashSuccess.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/10.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "CashSuccess.h"
@interface CashSuccess()
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UIImageView * imageView;
@property (nonatomic , strong) UILabel * successL;
@property (nonatomic , strong) UIButton * confirm;
@end
@implementation CashSuccess

+(instancetype)setCashSuccess:(UIView *)view{
    CashSuccess * cashSucc = [[CashSuccess alloc]initWithFrame:view.frame];
    [view addSubview:cashSucc];
    return cashSucc;
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
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:40], (SCREEN_HEIGHT-[Unity countcoordinatesH:290])/2, [Unity countcoordinatesW:240], [Unity countcoordinatesH:290])];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 10;
        [_backView addSubview:self.imageView];
        [_backView addSubview:self.successL];
        [_backView addSubview:self.msgL];
        [_backView addSubview:self.amountL];
        [_backView addSubview:self.confirm];
    }
    return _backView;
}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((_backView.width-[Unity countcoordinatesW:60])/2, [Unity countcoordinatesH:40], [Unity countcoordinatesW:60], [Unity countcoordinatesH:60])];
        _imageView.image = [UIImage imageNamed:@"审核中"];
    }
    return _imageView;
}
- (UILabel *)successL{
    if (!_successL) {
        _successL = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageView.bottom+[Unity countcoordinatesH:20], _backView.width, [Unity countcoordinatesH:20])];
        _successL.text = @"审核中";
        _successL.textColor = LabelColor3;
        _successL.textAlignment = NSTextAlignmentCenter;
        _successL.font = [UIFont systemFontOfSize:FontSize(18)];
    }
    return _successL;
}
- (UILabel *)msgL{
    if (!_msgL) {
        _msgL = [[UILabel alloc]initWithFrame:CGRectMake(0, _successL.bottom, _backView.width, [Unity countcoordinatesH:15])];
        _msgL.text = @"已提交审核，请等待工作人员审核";
        _msgL.textColor = LabelColor9;
        _msgL.textAlignment = NSTextAlignmentCenter;
        _msgL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _msgL;
}
- (UILabel *)amountL{
    if (!_amountL) {
        _amountL = [[UILabel alloc]initWithFrame:CGRectMake(0, _msgL.bottom+[Unity countcoordinatesH:10], _backView.width, [Unity countcoordinatesH:30])];
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
        [_confirm setTitle:@"确定" forState:UIControlStateNormal];
        [_confirm setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        _confirm.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
        _confirm.layer.borderWidth = 1;
        _confirm.layer.borderColor = [Unity getColor:@"#aa112d"].CGColor;
        _confirm.layer.cornerRadius = _confirm.height/2;
    }
    return _confirm;
}
- (void)confirmClick{
    self.hidden = YES;
    [self.delegate cashSuccessConfirm];
}
- (void)showCashSuccess{
    self.hidden = NO;
}

@end
