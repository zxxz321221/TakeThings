//
//  EntrustTwoCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/28.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "EntrustTwoCell.h"
#import "UILabel+YBAttributeTextTapAction.h"
@interface EntrustTwoCell()
{
    BOOL isBefore;//yes结标前  no立即出价  默认 结标前yes
    BOOL isSms;//yes短信通知  no不要通知我  默认yes
    BOOL isIns;//yes 购买保险  no 不购买    默认no
}
@property (nonatomic , strong) UILabel * numL;//投标数量
@property (nonatomic , strong) UIButton * minusB;
@property (nonatomic , strong) UILabel * numberL;
@property (nonatomic , strong) UIImageView * numberBackG;
@property (nonatomic , strong) UIButton * addB;
@property (nonatomic , strong) UILabel * typeL;//出价方式
@property (nonatomic , strong) UIButton * typeBtn1;
@property (nonatomic , strong) UIButton * typeBtn2;

@property (nonatomic , strong) UILabel * markType1;
@property (nonatomic , strong) UIButton * whBtn;
@property (nonatomic , strong) UILabel * markType2;

@property (nonatomic , strong) UILabel * offerL;//出价被超过文本  短信通知 不要通知我
@property (nonatomic , strong) UIButton * smsBtn;
@property (nonatomic , strong) UIButton * smsNoBtn;
@property (nonatomic , strong) UILabel * validationL;//手机尚未验证

@property (nonatomic , strong) UILabel * insL;//诈骗保险文本
@property (nonatomic , strong) UIButton * insBtn;

@property (nonatomic , strong) UILabel * markL;
@property (nonatomic , strong) UIButton * button;//问号按钮

@end
@implementation EntrustTwoCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        isBefore = YES;
        isSms = YES;
        isIns = NO;
        [self setup];
        
    }
    return self;
}
- (void)setup{
    [self.contentView addSubview:self.numL];
    [self.contentView addSubview:self.minusB];
    [self.contentView addSubview:self.numberBackG];
    [self.contentView addSubview:self.addB];
    [self.contentView addSubview:self.typeL];
    [self.contentView addSubview:self.typeBtn1];
    [self.contentView addSubview:self.typeBtn2];
    [self.contentView addSubview:self.markType1];
//    [self.contentView addSubview:self.whBtn];
    [self.contentView addSubview:self.markType2];
    [self.contentView addSubview:self.offerL];
//    [self.contentView addSubview:self.validationL];
    [self.contentView addSubview:self.smsBtn];
    [self.contentView addSubview:self.smsNoBtn];
    [self.contentView addSubview:self.insL];
    [self.contentView addSubview:self.insBtn];
    [self.contentView addSubview:self.markL];
//    [self.contentView addSubview:self.button];
}
- (UILabel *)numL{
    if (!_numL) {
        _numL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:90], [Unity countcoordinatesH:20])];
        _numL.text = @"购买数量:";
        _numL.textColor = LabelColor3;
        _numL.textAlignment = NSTextAlignmentLeft;
        _numL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _numL;
}
- (UIButton *)minusB{
    if (!_minusB) {
        _minusB = [[UIButton alloc]initWithFrame:CGRectMake(_numL.right, [Unity countcoordinatesH:15], [Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        [_minusB addTarget:self action:@selector(minusClick) forControlEvents:UIControlEventTouchUpInside];
        [_minusB setBackgroundImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
        [_minusB setTitle:@"-" forState:UIControlStateNormal];
        [_minusB setTitleColor:LabelColor9 forState:UIControlStateNormal];
        _minusB.userInteractionEnabled = NO;
        
    }
    return _minusB;
}
- (UIImageView *)numberBackG{
    if (!_numberBackG) {
        _numberBackG = [[UIImageView alloc]initWithFrame:CGRectMake(_minusB.right, _minusB.top, [Unity countcoordinatesW:30], [Unity countcoordinatesH:20])];
        _numberBackG.image = [UIImage imageNamed:@"中间"];
        [_numberBackG addSubview:self.numberL];
    }
    return _numberBackG;
}
- (UILabel *)numberL{
    if (!_numberL) {
        _numberL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [Unity countcoordinatesW:30], [Unity countcoordinatesH:20])];
        _numberL.text = @"1";
        _numberL.textColor = LabelColor3;
        _numberL.font = [UIFont systemFontOfSize:FontSize(12)];
        _numberL.textAlignment = NSTextAlignmentCenter;
    }
    return _numberL;
}
- (UIButton *)addB{
    if (!_addB) {
        _addB = [[UIButton alloc]initWithFrame:CGRectMake(_numberBackG.right, _numberBackG.top, [Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        [_addB addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
        [_addB setBackgroundImage:[UIImage imageNamed:@"右"] forState:UIControlStateNormal];
        [_addB setTitle:@"+" forState:UIControlStateNormal];
        [_addB setTitleColor:LabelColor9 forState:UIControlStateNormal];
    }
    return _addB;
}
- (UILabel *)typeL{
    if (!_typeL) {
        _typeL = [[UILabel alloc]initWithFrame:CGRectMake(_numL.left, _numL.bottom+[Unity countcoordinatesH:10], _numL.width, _numL.height)];
        _typeL.text = @"购买方式:";
        _typeL.textColor = LabelColor3;
        _typeL.textAlignment = NSTextAlignmentLeft;
        _typeL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _typeL;
}
- (UIButton *)typeBtn1{
    if (!_typeBtn1) {
        _typeBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(_typeL.right, _typeL.top, [Unity countcoordinatesW:110], _typeL.height)];
        [_typeBtn1 addTarget:self action:@selector(typebtn1Click) forControlEvents:UIControlEventTouchUpInside];
        [_typeBtn1 setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_typeBtn1 setTitle:@"  结束前购买" forState:UIControlStateNormal];
        _typeBtn1.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _typeBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_typeBtn1 setImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [_typeBtn1 setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
        _typeBtn1.selected = YES;
    }
    return _typeBtn1;
}
- (UIButton *)typeBtn2{
    if (!_typeBtn2) {
        _typeBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(_typeBtn1.right, _typeBtn1.top, [Unity countcoordinatesW:110], _typeBtn1.height)];
        [_typeBtn2 addTarget:self action:@selector(typebtn2Click) forControlEvents:UIControlEventTouchUpInside];
        [_typeBtn2 setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_typeBtn2 setTitle:@"  立即购买" forState:UIControlStateNormal];
        _typeBtn2.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _typeBtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_typeBtn2 setImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [_typeBtn2 setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
    }
    return _typeBtn2;
}
- (UILabel *)markType1{
    if (!_markType1) {
        NSString *label_text2 = @"结束前购买(系统出价时间：商品结束前900秒)建议选取";
        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
        [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(12)] range:NSMakeRange(0, label_text2.length)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0, 23)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"#aa112d"] range:NSMakeRange(23, 4)];
        
        _markType1 = [[UILabel alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:10], _typeL.bottom+[Unity countcoordinatesH:5], [Unity widthOfString:label_text2 OfFontSize:FontSize(12) OfHeight:[Unity countcoordinatesH:20]], [Unity countcoordinatesH:20])];
        _markType1.attributedText = attributedString2;
    }
    return _markType1;
}
- (UIButton *)whBtn{
    if (!_whBtn) {
        _whBtn = [[UIButton alloc]initWithFrame:CGRectMake(_markType1.right+[Unity countcoordinatesW:5], _typeL.bottom+[Unity countcoordinatesH:9], [Unity countcoordinatesW:12], [Unity countcoordinatesH:12])];
        [_whBtn setBackgroundImage:[UIImage imageNamed:@"?"] forState:UIControlStateNormal];
        [_whBtn addTarget:self action:@selector(whClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _whBtn;
}
- (UILabel *)markType2{
    if (!_markType2) {
        _markType2 = [[UILabel alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:10], _markType1.bottom+[Unity countcoordinatesH:0],SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _markType2.text = @"立即购买(系统出价时间：委托单完成后1~5秒钟)";
        _markType2.textColor = LabelColor9;
        _markType2.textAlignment = NSTextAlignmentLeft;
        _markType2.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _markType2;
}
- (UILabel *)offerL{
    if (!_offerL) {
        _offerL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _markType2.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:90], [Unity countcoordinatesH:20])];
        _offerL.text = @"价格被超过:";
        _offerL.textColor = LabelColor3;
        _offerL.textAlignment = NSTextAlignmentLeft;
        _offerL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _offerL;
}
- (UILabel *)validationL{
    if (!_validationL) {
        NSString *label_text2 = @"※您的手机尚未验证,请先去验证！";
        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
        [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(16)] range:NSMakeRange(0, 1)];
        [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(14)] range:NSMakeRange(1, label_text2.length-1)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"#aa112d"] range:NSMakeRange(0, 9)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:LabelColor6 range:NSMakeRange(10, 3)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"#4a90e2"] range:NSMakeRange(12, 4)];
        _validationL = [[UILabel alloc]initWithFrame:CGRectMake(_offerL.right, _offerL.top, [Unity countcoordinatesW:200], [Unity countcoordinatesH:20])];
        _validationL.attributedText = attributedString2;
//        [_validationL yb_addAttributeTapActionWithStrings:@[@"去验证！"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
//            NSLog(@"点击了");
//        }];
        [_validationL yb_addAttributeTapActionWithStrings:@[@"去验证！"] tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {
            NSLog(@"点击了");
        }];
    }
    return _validationL;
}
- (UIButton *)smsBtn{
    if (!_smsBtn) {
        _smsBtn = [[UIButton alloc] initWithFrame:CGRectMake(_offerL.right, _offerL.top, [Unity countcoordinatesW:110], _offerL.height)];
        [_smsBtn addTarget:self action:@selector(smsClick) forControlEvents:UIControlEventTouchUpInside];
        [_smsBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_smsBtn setTitle:@"  短信通知" forState:UIControlStateNormal];
        _smsBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _smsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_smsBtn setImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [_smsBtn setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
        _smsBtn.selected = YES;
    }
    return _smsBtn;
}
- (UIButton *)smsNoBtn{
    if (!_smsNoBtn) {
        _smsNoBtn = [[UIButton alloc] initWithFrame:CGRectMake(_smsBtn.right, _smsBtn.top, [Unity countcoordinatesW:110], _smsBtn.height)];
        [_smsNoBtn addTarget:self action:@selector(smsNoClick) forControlEvents:UIControlEventTouchUpInside];
        [_smsNoBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_smsNoBtn setTitle:@"  不要通知我" forState:UIControlStateNormal];
        _smsNoBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _smsNoBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_smsNoBtn setImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [_smsNoBtn setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
    }
    return _smsNoBtn;
}
- (UILabel *)insL{
    if (!_insL) {
        _insL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _offerL.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:90], [Unity countcoordinatesH:20])];
        _insL.text = @"购买诈骗保险:";
        _insL.textColor = LabelColor3;
        _insL.textAlignment = NSTextAlignmentLeft;
        _insL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _insL;
}
- (UIButton *)insBtn{
    if (!_insBtn) {
        _insBtn = [[UIButton alloc] initWithFrame:CGRectMake(_insL.right, _insL.top, [Unity countcoordinatesW:110], _insL.height)];
        [_insBtn addTarget:self action:@selector(insClick) forControlEvents:UIControlEventTouchUpInside];
        [_insBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_insBtn setTitle:@"  诈骗理赔保险" forState:UIControlStateNormal];
        _insBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _insBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_insBtn setImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [_insBtn setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
    }
    return _insBtn;
}
- (UILabel *)markL{
    if (!_markL) {
        NSString *label_text2 = @"※商品购得价的2%收取,遇到卖家不发货，捎东西全额理赔[卖家信用低于50(含)以下填写无效]";
        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
        [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(18)] range:NSMakeRange(0, 1)];
        [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(12)] range:NSMakeRange(1, label_text2.length-1)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"#aa112d"] range:NSMakeRange(0, 1)];
        
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(1, label_text2.length-1)];
        
        _markL = [[UILabel alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:10], _insL.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:35])];
        _markL.numberOfLines = 0;
        _markL.attributedText = attributedString2;
        
    }
    return _markL;
}
- (UIButton * )button{
    if (!_button) {
        _button = [[UIButton alloc]initWithFrame:CGRectMake([Unity widthOfString:@"商商品得标价的2%收取,遇到卖家不发货，捎东西全额理赔[卖家信用低于50(含)以下填写无效]" OfFontSize:FontSize(12) OfHeight:[Unity countcoordinatesH:35]]-(SCREEN_WIDTH-[Unity countcoordinatesW:20])+[Unity countcoordinatesW:20], _markL.top+[Unity countcoordinatesH:20], [Unity countcoordinatesW:12], [Unity countcoordinatesH:12])];
        [_button setBackgroundImage:[UIImage imageNamed:@"?"] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)buttonClick{
    [self.delegate goodsButton];
}



//-----------
- (void)minusClick{
    int i = [self.numberL.text intValue];
    if (i-1 == 1) {
        self.minusB.userInteractionEnabled = NO;
    }
    self.numberL.text = [NSString stringWithFormat:@"%d",i-1];
    [self.delegate shipNum:self.numberL.text];
}
- (void)addClick{
    int i = [self.numberL.text intValue];
    self.minusB.userInteractionEnabled = YES;
    self.numberL.text = [NSString stringWithFormat:@"%d",i+1];
    [self.delegate shipNum:self.numberL.text];
}
//街标前
- (void)typebtn1Click{
    isBefore = YES;
    self.typeBtn1.selected = YES;
    self.typeBtn2.selected = NO;
    [self.delegate bidWay:@"2"];
}
//后
- (void)typebtn2Click{
    isBefore = NO;
    self.typeBtn1.selected = NO;
    self.typeBtn2.selected = YES;
    [self.delegate bidWay:@"1"];
}
//出价方式后面的？
- (void)whClick{
    [self.delegate whBtn];
}
- (void)smsClick{
    isSms = YES;
    self.smsBtn.selected = YES;
    self.smsNoBtn.selected = NO;
    [self.delegate smsNoti:@"1"];
}
- (void)smsNoClick{
    isSms = NO;
    self.smsBtn.selected = NO;
    self.smsNoBtn.selected = YES;
    [self.delegate smsNoti:@"0"];
}
- (void)insClick{
    if (self.insBtn.selected) {
        self.insBtn.selected = NO;
        isIns = NO;
        [self.delegate shipIns:@"0"];
    }else{
        isIns = YES;
        self.insBtn.selected = YES;
        [self.delegate shipIns:@"1"];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
