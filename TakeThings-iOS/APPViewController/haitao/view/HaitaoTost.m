
//
//  HaitaoTost.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/12.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "HaitaoTost.h"
@interface HaitaoTost()
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UILabel * markL;
@property (nonatomic , strong) UIButton * okBtn;
@end
@implementation HaitaoTost

+(instancetype)setHaitaoTost:(UIView *)view{
    HaitaoTost * haitao = [[HaitaoTost alloc]initWithFrame:view.frame];
    [[UIApplication sharedApplication].keyWindow addSubview:haitao];
    return haitao;
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
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], (SCREEN_HEIGHT-[Unity countcoordinatesH:170])/2, SCREEN_WIDTH-[Unity countcoordinatesW:40], [Unity countcoordinatesH:170])];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 15;
        
        [_backView addSubview:self.titleL];
        [_backView addSubview:self.markL];
        [_backView addSubview:self.okBtn];
    }
    return _backView;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:20], _backView.width, [Unity countcoordinatesH:20])];
        _titleL.text = @"提醒";
        _titleL.textColor = LabelColor3;
        _titleL.font = [UIFont systemFontOfSize:FontSize(17)];
        _titleL.textAlignment = NSTextAlignmentCenter;
    }
    return _titleL;
}
- (UILabel *)markL{
    if (!_markL) {
        _markL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _titleL.bottom+[Unity countcoordinatesH:10], _backView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:45])];
        _markL.text = @"一次海淘委托最多可填写10件商品,同款不同规格(尺寸,颜色等)也计算为不同商品,请会员注意!";
        _markL.textColor = LabelColor6;
        _markL.font = [UIFont systemFontOfSize:FontSize(14)];
        _markL.numberOfLines = 0;
    }
    return _markL;
}
- (UIButton *)okBtn{
    if (!_okBtn) {
        _okBtn = [[UIButton alloc]initWithFrame:CGRectMake((_backView.width-[Unity countcoordinatesW:140])/2, _markL.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:140], [Unity countcoordinatesH:40])];
        [_okBtn addTarget:self action:@selector(okClick) forControlEvents:UIControlEventTouchUpInside];
        _okBtn.backgroundColor = [Unity getColor:@"aa112d"];
        [_okBtn setTitle:@"OK" forState:UIControlStateNormal];
        [_okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _okBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
        _okBtn.layer.cornerRadius = _okBtn.height/2;
    }
    return _okBtn;
}
- (void)okClick{
    self.hidden = YES;
}



- (void)showHaitaoView{
    self.hidden = NO;
}
@end
