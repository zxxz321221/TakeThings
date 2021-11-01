//
//  PremiumView.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/30.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "PremiumView.h"
@interface PremiumView()
{
    NSInteger btnIndex;
    NSString * ytpye;//默认null
}
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UILabel * title;
@property (nonatomic , strong) UILabel * numberL;//编号文本
@property (nonatomic , strong) UILabel * goodsNameL;//商品名称文本
@property (nonatomic , strong) UILabel * bidPriceL;//投标价格文本
@property (nonatomic , strong) UILabel * currentPriceL;//当前价格文本
@property (nonatomic , strong) UILabel * newPriceL;//重新出价
@property (nonatomic , strong) UITextField * textField;
@property (nonatomic , strong) UIView * line;
@property (nonatomic , strong) UILabel * tsL;
@property (nonatomic ,strong) UILabel * rmbL;
@property (nonatomic ,strong) UILabel * rmb;
@property (nonatomic ,strong) UILabel * bidType;

@property (nonatomic , strong) UIButton * selectBtn;

@property (nonatomic ,strong) UILabel * mark;//最下方注释

@property (nonatomic ,strong) UIButton * shutDownBtn;
@property (nonatomic , strong) UIButton * updateBtn;

@end
@implementation PremiumView

+(instancetype)setPremiumView:(UIView *)view{
    PremiumView * pView = [[PremiumView alloc]initWithFrame:view.frame];
    [[UIApplication sharedApplication].keyWindow addSubview:pView];
    return pView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        ytpye = @"null";
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.hidden = YES;
        [self addSubview:self.backView];
    }
    return self;
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], (SCREEN_HEIGHT-[Unity countcoordinatesH:320])/2, SCREEN_WIDTH-[Unity countcoordinatesW:30], [Unity countcoordinatesH:320])];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 10;
        
        [_backView addSubview:self.title];
        [_backView addSubview:self.numberL];
        [_backView addSubview:self.number];
        [_backView addSubview:self.goodsNameL];
        [_backView addSubview:self.goodsName];
        [_backView addSubview:self.bidPriceL];
        [_backView addSubview:self.bidPrice];
        [_backView addSubview:self.currentPriceL];
        [_backView addSubview:self.currentPrice];
        [_backView addSubview:self.markL];
        [_backView addSubview:self.newPriceL];
        [_backView addSubview:self.textField];
        [_backView addSubview:self.line];
        [_backView addSubview:self.currencyL];
//        [_backView addSubview:self.tsL];
        [_backView addSubview:self.rmbL];
        [_backView addSubview:self.rmb];
        [_backView addSubview:self.bidType];
        
        NSArray * arr = @[@"结束前购买",@"立即购买"];
        for (int i=0; i<2; i++) {
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(self.bidType.right+i*[Unity countcoordinatesW:100], self.bidType.top+[Unity countcoordinatesH:1.5], [Unity countcoordinatesW:12], [Unity countcoordinatesH:12])];
            btn.tag = i+1000;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
            [_backView addSubview:btn];
            UILabel * name = [Unity lableViewAddsuperview_superView:_backView _subViewFrame:CGRectMake(btn.right+[Unity countcoordinatesW:5], self.bidType.top, [Unity countcoordinatesW:70], [Unity countcoordinatesH:15]) _string:arr[i] _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentLeft];
            name.backgroundColor = [UIColor clearColor];
            if (i==0) {
                btnIndex=0;
                btn.selected = YES;
                self.selectBtn = btn;
            }
        }
        [_backView addSubview:self.mark];
        [_backView addSubview:self.shutDownBtn];
        [_backView addSubview:self.updateBtn];
    }
    return _backView;
}
- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:15], _backView.width, [Unity countcoordinatesH:15])];
        _title.text = @"商品加价";
        _title.textColor = LabelColor3;
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _title;
}
- (UILabel *)numberL{
    if (!_numberL) {
        _numberL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _title.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:70], [Unity countcoordinatesH:15])];
        _numberL.text = @"订单编号:";
        _numberL.textColor = LabelColor3;
        _numberL.textAlignment = NSTextAlignmentLeft;
        _numberL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _numberL;
}
- (UILabel *)number{
    if (!_number) {
        _number = [[UILabel alloc]initWithFrame:CGRectMake(_numberL.right, _numberL.top, _backView.width-[Unity countcoordinatesW:90], _numberL.height)];
        _number.textColor = LabelColor6;
        _number.textAlignment = NSTextAlignmentLeft;
        _number.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _number;
}
- (UILabel *)goodsNameL{
    if (!_goodsNameL) {
        _goodsNameL = [[UILabel alloc]initWithFrame:CGRectMake(_numberL.left, _numberL.bottom+[Unity countcoordinatesH:10], _numberL.width, _numberL.height)];
        _goodsNameL.text = @"商品名称:";
        _goodsNameL.textColor = LabelColor3;
        _goodsNameL.textAlignment = NSTextAlignmentLeft;
        _goodsNameL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _goodsNameL;
}
- (UILabel *)goodsName{
    if (!_goodsName) {
        _goodsName = [[UILabel alloc]initWithFrame:CGRectMake(_goodsNameL.right, _goodsNameL.top, _backView.width-[Unity countcoordinatesW:90], _goodsNameL.height)];
        _goodsName.textColor = LabelColor6;
        _goodsName.textAlignment = NSTextAlignmentLeft;
        _goodsName.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _goodsName;
}
- (UILabel *)bidPriceL{
    if (!_bidPriceL) {
        _bidPriceL = [[UILabel alloc]initWithFrame:CGRectMake(_goodsNameL.left, _goodsNameL.bottom+[Unity countcoordinatesH:10], _goodsNameL.width, _goodsNameL.height)];
        _bidPriceL.text = @"我的价格:";
        _bidPriceL.textColor = LabelColor3;
        _bidPriceL.textAlignment = NSTextAlignmentLeft;
        _bidPriceL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _bidPriceL;
}
- (UILabel *)bidPrice{
    if (!_bidPrice) {
        _bidPrice = [[UILabel alloc]initWithFrame:CGRectMake(_bidPriceL.right, _bidPriceL.top, _backView.width-[Unity countcoordinatesW:90], _bidPriceL.height)];
        _bidPrice.textColor = LabelColor6;
        _bidPrice.textAlignment = NSTextAlignmentLeft;
        _bidPrice.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _bidPrice;
}
- (UILabel *)currentPriceL{
    if (!_currentPriceL) {
        _currentPriceL = [[UILabel alloc]initWithFrame:CGRectMake(_bidPriceL.left, _bidPriceL.bottom+[Unity countcoordinatesH:10], _bidPriceL.width, _bidPriceL.height)];
        _currentPriceL.text = @"当前价格:";
        _currentPriceL.textColor = LabelColor3;
        _currentPriceL.textAlignment = NSTextAlignmentLeft;
        _currentPriceL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _currentPriceL;
}
- (UILabel *)currentPrice{
    if (!_currentPrice) {
        _currentPrice = [[UILabel alloc]initWithFrame:CGRectMake(_currentPriceL.right, _currentPriceL.top, _backView.width-[Unity countcoordinatesW:90], _currentPriceL.height)];
        _currentPrice.textColor = LabelColor6;
        _currentPrice.textAlignment = NSTextAlignmentLeft;
        _currentPrice.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _currentPrice;
}
- (UILabel *)markL{
    if (!_markL) {
        _markL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _currentPriceL.bottom+[Unity countcoordinatesH:5], _backView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:15])];
        _markL.textColor = LabelColor9;
        _markL.textAlignment = NSTextAlignmentLeft;
        _markL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _markL;
}
- (UILabel *)newPriceL{
    if (!_newPriceL) {
        _newPriceL = [[UILabel alloc]initWithFrame:CGRectMake(_currentPriceL.left, _markL.bottom+[Unity countcoordinatesH:10], _currentPriceL.width, _currentPriceL.height)];
        _newPriceL.text = @"重新出价:";
        _newPriceL.textColor = LabelColor3;
        _newPriceL.textAlignment = NSTextAlignmentLeft;
        _newPriceL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _newPriceL;
}
- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(_currentPrice.left, _newPriceL.top, [Unity countcoordinatesW:80], [Unity countcoordinatesH:15])];
        _textField.textColor = [Unity getColor:@"#aa112d"];
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.placeholder = @"请输入价格";
        _textField.font = [UIFont systemFontOfSize:FontSize(14)];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        [_textField addTarget:self action:@selector(textFieldClick:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]initWithFrame:CGRectMake(_textField.left, _textField.bottom, _textField.width, 1)];
        _line.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return _line;
}
- (UILabel *)currencyL{
    if (!_currencyL) {
        _currencyL = [[UILabel alloc]initWithFrame:CGRectMake(_textField.right+[Unity countcoordinatesW:5], _textField.top, [Unity countcoordinatesW:20], [Unity countcoordinatesH:15])];
        _currencyL.textColor = LabelColor3;
        _currencyL.textAlignment = NSTextAlignmentLeft;
        _currencyL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _currencyL;
}
- (UILabel *)tsL{
    if (!_tsL) {
        _tsL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _newPriceL.bottom+[Unity countcoordinatesH:5], _backView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:15])];
        _tsL.text = @"如果想更改[购买方式],请保持[重新出价]内容为空";
        _tsL.textColor = LabelColor9;
        _tsL.textAlignment = NSTextAlignmentLeft;
        _tsL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _tsL;
}
- (UILabel *)rmbL{
    if (!_rmbL) {
        _rmbL = [[UILabel alloc]initWithFrame:CGRectMake(_newPriceL.left, _newPriceL.bottom+[Unity countcoordinatesH:10], _newPriceL.width, _newPriceL.height)];
        _rmbL.text = @"约人民币:";
        _rmbL.textColor = LabelColor9;
        _rmbL.textAlignment = NSTextAlignmentLeft;
        _rmbL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _rmbL;
}
- (UILabel *)rmb{
    if (!_rmb) {
        _rmb = [[UILabel alloc]initWithFrame:CGRectMake(_rmbL.right, _rmbL.top, [Unity countcoordinatesW:200], _rmbL.height)];
        _rmb.text = @"0.00元";
        _rmb.textColor = LabelColor9;
        _rmb.textAlignment = NSTextAlignmentLeft;
        _rmb.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _rmb;
}
- (UILabel *)bidType{
    if (!_bidType) {
        _bidType = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesH:10], _rmbL.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:15])];
        _bidType.text = @"购买方式:";
        _bidType.textColor = LabelColor3;
        _bidType.textAlignment = NSTextAlignmentLeft;
        _bidType.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _bidType;
}
- (UILabel *)mark{
    if (!_mark) {
        _mark = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _bidType.bottom+[Unity countcoordinatesH:5], _backView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:15])];
        _mark.text = @"若剩余时间小于7分钟,仅能立即出价以免出价失败！";
        _mark.textColor = LabelColor9;
        _mark.textAlignment = NSTextAlignmentLeft;
        _mark.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _mark;
}
- (UIButton *)shutDownBtn{
    if (!_shutDownBtn) {
        _shutDownBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _mark.bottom+[Unity countcoordinatesH:10], (_backView.width-[Unity countcoordinatesW:30])/2, [Unity countcoordinatesH:40])];
        [_shutDownBtn addTarget:self action:@selector(shutdownClick) forControlEvents:UIControlEventTouchUpInside];
        _shutDownBtn.layer.borderColor = [Unity getColor:@"#aa112d"].CGColor;
        _shutDownBtn.layer.borderWidth = 1;
        _shutDownBtn.layer.cornerRadius = _shutDownBtn.height/2;
        [_shutDownBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [_shutDownBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        _shutDownBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _shutDownBtn;
}
- (UIButton *)updateBtn{
    if (!_updateBtn) {
        _updateBtn = [[UIButton alloc]initWithFrame:CGRectMake(_shutDownBtn.right+[Unity countcoordinatesW:10], _shutDownBtn.top, _shutDownBtn.width, _shutDownBtn.height)];
        [_updateBtn addTarget:self action:@selector(updateClick) forControlEvents:UIControlEventTouchUpInside];
        _updateBtn.layer.cornerRadius = _shutDownBtn.height/2;
        _updateBtn.backgroundColor = [Unity getColor:@"#aa112d"];
        [_updateBtn setTitle:@"更新" forState:UIControlStateNormal];
        [_updateBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
        _updateBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _updateBtn;
}

- (void)showPremiumView{
    self.hidden = NO;
}
- (void)btnClick:(UIButton *)btn{
    btnIndex = btn.tag-1000;
    if (btn != self.selectBtn) {
        self.selectBtn.selected = NO;
        btn.selected = YES;
        self.selectBtn = btn;
    }
    if (btnIndex == 0) {
        ytpye = @"null";
    }else{
        ytpye = @"2";
    }
}
- (void)shutdownClick{
    self.textField.text = @"";
    self.rmb.text = @"0.00元";
    self.hidden = YES;
}
- (void)updateClick{
    NSDictionary * dic = @{@"place":self.textField.text,@"type":ytpye};
    [self.delegate updatePlace:dic];
    [self shutdownClick];
}
- (void)textFieldClick:(UITextField *)textField{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"exrate"];
    if ([self.w_cc isEqualToString:@"0"]) {
        float renminb = [textField.text floatValue]*[dic[@"w_tw_jp"] floatValue];
        self.rmb.text = [NSString stringWithFormat:@"%.2f元",renminb];
    }else{
        float renminb = [textField.text floatValue]*[dic[@"w_tw_us"] floatValue];
        self.rmb.text = [NSString stringWithFormat:@"%.2f元",renminb];
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
