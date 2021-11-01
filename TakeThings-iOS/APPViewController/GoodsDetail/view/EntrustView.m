//
//  EntrustView.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/29.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "EntrustView.h"
@interface EntrustView()

@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UILabel * contentL;

@property (nonatomic , strong) UIButton * knowBtn;
@property (nonatomic , strong) UIButton * membersBtn;

@end
@implementation EntrustView

+(instancetype)setEntrustView:(UIView *)view{
    EntrustView * eView = [[EntrustView alloc]initWithFrame:view.frame];
    [[UIApplication sharedApplication].keyWindow addSubview:eView];
    return eView;
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
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], (SCREEN_HEIGHT-[Unity countcoordinatesH:155])/2, SCREEN_WIDTH-[Unity countcoordinatesW:40], [Unity countcoordinatesH:155])];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 10;
        
        [_backView addSubview:self.titleL];
        [_backView addSubview:self.contentL];
        [_backView addSubview:self.knowBtn];
        [_backView addSubview:self.membersBtn];
    }
    return _backView;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:15], _backView.width, [Unity countcoordinatesH:20])];
        _titleL.text = @"温馨提示";
        _titleL.textColor = LabelColor3;
        _titleL.textAlignment = NSTextAlignmentCenter;
        _titleL.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _titleL;
}
- (UILabel *)contentL{
    if (!_contentL) {
        NSString *label_text2 = @"    您当前是非正式会员，可体验投标，但系统不会分配雅虎投标账号哦！您可以升级会员后重新填写委托单！(先砍单在投标)";
        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
        [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(14)] range:NSMakeRange(0, label_text2.length)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:LabelColor3 range:NSMakeRange(0, label_text2.length)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"#aa112d"] range:NSMakeRange(20, 15)];
        _contentL = [[UILabel alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:35], _backView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:50])];
        _contentL.attributedText = attributedString2;
        _contentL.numberOfLines = 0;
    }
    
    return _contentL;
}
- (UIButton *)knowBtn{
    if (!_knowBtn) {
        _knowBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _contentL.bottom+[Unity countcoordinatesH:10], (_backView.width-[Unity countcoordinatesW:30])/2, [Unity countcoordinatesH:35])];
        [_knowBtn addTarget:self action:@selector(knowClick) forControlEvents:UIControlEventTouchUpInside];
        _knowBtn.layer.borderColor = [[Unity getColor:@"#aa112d"] CGColor];
        _knowBtn.layer.borderWidth = 1.0f;
        [_knowBtn setTitle:@"我知道了" forState:UIControlStateNormal];
        [_knowBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        _knowBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];\
        _knowBtn.layer.cornerRadius = _knowBtn.height/2;
        _knowBtn.layer.masksToBounds = YES;
    }
    return _knowBtn;
}
- (UIButton *)membersBtn{
    if (!_membersBtn) {
        _membersBtn = [[UIButton alloc]initWithFrame:CGRectMake(_knowBtn.right+[Unity countcoordinatesW:10], _knowBtn.top, _knowBtn.width, _knowBtn.height)];
        [_membersBtn addTarget:self action:@selector(membersClick) forControlEvents:UIControlEventTouchUpInside];
        _membersBtn.backgroundColor = [Unity getColor:@"#aa112d"];
        [_membersBtn setTitle:@"会员升级" forState:UIControlStateNormal];
        [_membersBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
        _membersBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
        _membersBtn.layer.cornerRadius = _membersBtn.height/2;
        _membersBtn.layer.masksToBounds = YES;
    }
    return _membersBtn;
}

- (void)knowClick{
    self.hidden = YES;
    [self.delegate know];
}

- (void)membersClick{
    self.hidden = YES;
    [self.delegate update];
}

- (void)showEntrustView{
    self.hidden = NO;
}
@end
