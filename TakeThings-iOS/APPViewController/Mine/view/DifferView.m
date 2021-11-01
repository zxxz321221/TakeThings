//
//  DifferView.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/14.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "DifferView.h"
@interface DifferView()
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UILabel * title;
@property (nonatomic , strong) UIButton * recharge;

@end
@implementation DifferView
+(instancetype)setDifferView:(UIView *)view{
    DifferView * dView = [[DifferView alloc]initWithFrame:view.frame];
    [[UIApplication sharedApplication].keyWindow addSubview:dView];
    return dView;
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
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:25], (SCREEN_HEIGHT-[Unity countcoordinatesH:190])/2, SCREEN_WIDTH-[Unity countcoordinatesW:50], [Unity countcoordinatesH:190])];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 10;
        
        [_backView addSubview:self.title];
        [_backView addSubview:self.amount];
        [_backView addSubview:self.balance];
        [_backView addSubview:self.mark];
        [_backView addSubview:self.recharge];
        [_backView addSubview:self.confirm];
    }
    return _backView;
}
- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:15], _backView.width, [Unity countcoordinatesH:20])];
        _title.text = @"需补差额";
        _title.textColor = LabelColor3;
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _title;
}
- (UILabel *)amount{
    if (!_amount) {
        _amount = [[UILabel alloc]initWithFrame:CGRectMake(0, _title.bottom+[Unity countcoordinatesH:15], _backView.width, [Unity countcoordinatesH:35])];
        _amount.text = @"";
        _amount.textColor = [Unity getColor:@"aa112d"];
        _amount.textAlignment = NSTextAlignmentCenter;
        _amount.font = [UIFont systemFontOfSize:FontSize(34)];
    }
    return _amount;
}
- (UILabel *)balance{
    if (!_balance) {
        _balance = [[UILabel alloc]initWithFrame:CGRectMake(0, _amount.bottom, _backView.width, [Unity countcoordinatesH:15])];
        _balance.text = @"";
        _balance.textColor = LabelColor9;
        _balance.textAlignment = NSTextAlignmentCenter;
        _balance.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _balance;
}
- (UILabel *)mark{
    if (!_mark) {
        _mark = [[UILabel alloc]initWithFrame:CGRectMake(0, _balance.bottom, _backView.width, [Unity countcoordinatesH:15])];
        _mark.text = @"余额不足请充值";
        _mark.textColor = [Unity getColor:@"aa112d"];
        _mark.textAlignment = NSTextAlignmentCenter;
        _mark.font = [UIFont systemFontOfSize:FontSize(12)];
        _mark.hidden = YES;
    }
    return _mark;
}
- (UIButton *)recharge{
    if (!_recharge) {
        _recharge = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], _balance.bottom+[Unity countcoordinatesH:35], (_backView.width-[Unity countcoordinatesW:45])/2, [Unity countcoordinatesH:35])];
        [_recharge addTarget:self action:@selector(rechargeClick) forControlEvents:UIControlEventTouchUpInside];
        [_recharge setTitle:@"充值" forState:UIControlStateNormal];
        [_recharge setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
        _recharge.layer.cornerRadius =_recharge.height/2;
        _recharge.layer.borderWidth = 1;
        _recharge.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        _recharge.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _recharge;
}
- (UIButton *)confirm{
    if (!_confirm) {
        _confirm = [[UIButton alloc]initWithFrame:CGRectMake(_recharge.right+[Unity countcoordinatesW:15], _recharge.top, _recharge.width, _recharge.height)];
        [_confirm addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        [_confirm setTitle:@"确认" forState:UIControlStateNormal];
        [_confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirm.backgroundColor = [Unity getColor:@"aa112d"];
        _confirm.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
        _confirm.layer.cornerRadius =_confirm.height/2;
    }
    return _confirm;
}

- (void)showDifferView{
    self.hidden = NO;
}

- (void)rechargeClick{
    self.hidden = YES;
    [self.delegate recharge];
}
- (void)confirmClick{
    self.hidden = YES;
    [self.delegate confirm];
}
@end
