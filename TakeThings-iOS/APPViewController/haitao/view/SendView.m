//
//  SendView.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/14.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "SendView.h"
#import "UILabel+YBAttributeTextTapAction.h"
@interface SendView()
@property (nonatomic , strong) UIView * backView;

@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UILabel * contentL;

@property (nonatomic , strong) UIButton * otherBtn;
@property (nonatomic , strong) UIButton * homeBtn;
@end
@implementation SendView
+(instancetype)setSendView:(UIView *)view{
    SendView * sView = [[SendView alloc]initWithFrame:view.frame];
    [[UIApplication sharedApplication].keyWindow addSubview:sView];
    return sView;
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
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], (SCREEN_HEIGHT-[Unity countcoordinatesH:170])/2-[Unity countcoordinatesH:50], SCREEN_WIDTH-[Unity countcoordinatesW:40], [Unity countcoordinatesH:170])];
        _backView.layer.cornerRadius = 20;
        _backView.backgroundColor = [UIColor whiteColor];
        
        [_backView addSubview:self.titleL];
        [_backView addSubview:self.contentL];
        [_backView addSubview:self.otherBtn];
        [_backView addSubview:self.homeBtn];
    }
    return _backView;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:20], _backView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _titleL.textColor = LabelColor3;
        NSString *label_text2 = @"您的1笔海淘委托单均已送出！";
        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"aa112d"] range:NSMakeRange(2, 1)];
        _titleL.attributedText = attributedString2;
        _titleL.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _titleL;
}
- (UILabel *)contentL{
    if (!_contentL) {
        _contentL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _titleL.bottom+[Unity countcoordinatesH:10], _backView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:60])];
        _contentL.textColor = LabelColor3;
        _contentL.numberOfLines = 0;
        _contentL.textAlignment = NSTextAlignmentLeft;
        NSString *label_text2 = @"工作人员将会在1~2个工作天内将所需费用报价给您，请您记得返回[海淘委托单]查看报价(将不另行通知)，若是您在假日送出委托单，工作人员报价给您的时间将会延长。";
        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"aa112d"] range:NSMakeRange(32, 5)];
        _contentL.attributedText = attributedString2;
        _contentL.font = [UIFont systemFontOfSize:FontSize(14)];
        [_contentL yb_addAttributeTapActionWithStrings:@[@"海淘委托单"] tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {
            NSLog(@"点击了");
        }];
    }
    return _contentL;
}
- (UIButton *)otherBtn{
    if (!_otherBtn) {
        _otherBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _contentL.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:140], [Unity countcoordinatesH:35])];
        [_otherBtn addTarget:self action:@selector(otherClick) forControlEvents:UIControlEventTouchUpInside];
        _otherBtn.backgroundColor = [Unity getColor:@"aa112d"];
        [_otherBtn setTitle:@"委托海淘其他商品" forState:UIControlStateNormal];
        [_otherBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _otherBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
        _otherBtn.layer.cornerRadius = _otherBtn.height/2;
    }
    return _otherBtn;
}
- (UIButton *)homeBtn{
    if (!_homeBtn) {
        _homeBtn = [[UIButton alloc]initWithFrame:CGRectMake(_otherBtn.right+[Unity countcoordinatesW:15], _otherBtn.top, [Unity countcoordinatesW:105], [Unity countcoordinatesH:35])];
        [_homeBtn addTarget:self action:@selector(homeClick) forControlEvents:UIControlEventTouchUpInside];
        _homeBtn.backgroundColor = [Unity getColor:@"aa112d"];
        [_homeBtn setTitle:@"回到首页" forState:UIControlStateNormal];
        [_homeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _homeBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
        _homeBtn.layer.cornerRadius = _homeBtn.height/2;
    }
    return _homeBtn;
}

- (void)showSendView{
    self.hidden = NO;
}
- (void)otherClick{
    [self.delegate popOrderPage];
    self.hidden = YES;
}
- (void)homeClick{
    [self.delegate popHome];
    self.hidden = YES;
}
@end
