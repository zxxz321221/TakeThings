//
//  SslCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/9/20.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "SslCell.h"
@interface SslCell()
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UILabel * numberL;//投标编号
@property (nonatomic , strong) UILabel * statusL;//竞拍状态
@property (nonatomic , strong) UILabel * line0;//
@property (nonatomic , strong) UIImageView * icon;//商品图片
@property (nonatomic , strong) UILabel * goodsTitle;//商品标题
@property (nonatomic , strong) UILabel * goodsNum;//竞拍商品数量
@property (nonatomic , strong) UILabel * offerL;//出价竞标
@property (nonatomic , strong) UILabel * goodsAmount;//价格
@property (nonatomic , strong) UILabel * line1;
@property (nonatomic , strong) UIButton * goodsBtn;

@property (nonatomic , strong) UILabel * priceL;
@property (nonatomic , strong) UILabel * priceNum;
@property (nonatomic , strong) UILabel * jifenL;
@property (nonatomic , strong) UILabel * jifenNum;

@property (nonatomic , strong) UIButton * confirmBtn;
@property (nonatomic , strong) UILabel * markL;
@property (nonatomic , strong) NSString * goods_id;
@property (nonatomic , strong) NSString * type;
@end
@implementation SslCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [Unity getColor:@"f0f0f0"];
        [self setUPcell];
    }
    return self;
}
- (void)setUPcell{
    [self.contentView addSubview:self.backView];
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:230])];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 5;
        
        [_backView addSubview:self.numberL];
        [_backView addSubview:self.statusL];
        [_backView addSubview:self.line0];
        [_backView addSubview:self.goodsBtn];
        [_backView addSubview:self.line1];
        [_backView addSubview:self.priceL];
        [_backView addSubview:self.priceNum];
        [_backView addSubview:self.jifenL];
        [_backView addSubview:self.jifenNum];
        [_backView addSubview:self.confirmBtn];
        [_backView addSubview:self.markL];
    }
    return _backView;
}
- (UILabel *)numberL{
    if (!_numberL) {
        _numberL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:200], [Unity countcoordinatesH:40])];
        _numberL.text = @"";
        _numberL.textColor = LabelColor3;
        _numberL.font = [UIFont systemFontOfSize:14];
        _numberL.textAlignment = NSTextAlignmentLeft;
    }
    return _numberL;
}
- (UILabel *)statusL{
    if (!_statusL) {
        _statusL = [[UILabel alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:80], _numberL.top, [Unity countcoordinatesW:70], _numberL.height)];
//        _statusL.text = @"购买成功";
//        _statusL.textColor = [Unity getColor:@"0fac0b"];
        _statusL.font = [UIFont systemFontOfSize:14];
        _statusL.textAlignment = NSTextAlignmentRight;
    }
    return _statusL;
}
- (UILabel *)line0{
    if (!_line0) {
        _line0 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:40], _backView.width-[Unity countcoordinatesW:10], [Unity countcoordinatesH:1])];
        _line0.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line0;
}
- (UIButton *)goodsBtn{
    if (!_goodsBtn) {
        _goodsBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _line0.bottom, _backView.width, [Unity countcoordinatesH:90])];
        [_goodsBtn addTarget:self action:@selector(goodBtn) forControlEvents:UIControlEventTouchUpInside];
        [_goodsBtn addSubview:self.icon];
        [_goodsBtn addSubview:self.goodsTitle];
        [_goodsBtn addSubview:self.goodsNum];
        [_goodsBtn addSubview:self.offerL];
        [_goodsBtn addSubview:self.goodsAmount];
    }
    return _goodsBtn;
}
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:70])];
        //添加边框
        CALayer * layer = [_icon layer];
        layer.borderColor = [[Unity getColor:@"#e0e0e0"] CGColor];
        layer.borderWidth = 1.0f;
        _icon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _icon;
}
- (UILabel *)goodsTitle{
    if (!_goodsTitle) {
        _goodsTitle = [[UILabel alloc]initWithFrame:CGRectMake(_icon.right+[Unity countcoordinatesW:5], _icon.top, _backView.width-[Unity countcoordinatesW:125], [Unity countcoordinatesH:40])];
        _goodsTitle.text = @"";
        _goodsTitle.numberOfLines = 0;
        _goodsTitle.textColor = LabelColor3;
        _goodsTitle.font = [UIFont systemFontOfSize:FontSize(14)];
        _goodsTitle.textAlignment = NSTextAlignmentLeft;
    }
    return _goodsTitle;
}
- (UILabel *)goodsNum{
    if (!_goodsNum) {
        _goodsNum = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitle.right+[Unity countcoordinatesW:10], _goodsTitle.top+[Unity countcoordinatesH:5], [Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _goodsNum.text = @"x1";
        _goodsNum.textColor = LabelColor6;
        _goodsNum.font = [UIFont systemFontOfSize:FontSize(12)];
        _goodsNum.textAlignment = NSTextAlignmentRight;
    }
    return _goodsNum;
}
- (UILabel *)offerL{
    if (!_offerL) {
        _offerL = [[UILabel alloc]initWithFrame: CGRectMake(_goodsTitle.left, _goodsTitle.bottom+[Unity countcoordinatesH:7], 20+[Unity widthOfString:@"猜价游戏" OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:20]], [Unity countcoordinatesH:20])];
        _offerL.text = @"猜价游戏";
        self.offerL.layer.cornerRadius = [Unity countcoordinatesH:10];
        self.offerL.layer.masksToBounds = YES;
        _offerL.backgroundColor = [Unity getColor:@"#f6e7ea"];
        _offerL.textColor = [Unity getColor:@"#aa112d"];
        _offerL.textAlignment = NSTextAlignmentCenter;
        _offerL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _offerL;
}
- (UILabel *)goodsAmount{
    if (!_goodsAmount) {
        _goodsAmount = [[UILabel alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:150], _offerL.top, [Unity countcoordinatesW:140], _offerL.height)];
        _goodsAmount.textColor = LabelColor3;
        _goodsAmount.text = @"";
        _goodsAmount.textAlignment = NSTextAlignmentRight;
        _goodsAmount.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _goodsAmount;
}
- (UILabel *)line1{
    if (!_line1) {
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _goodsBtn.bottom, _backView.width-[Unity countcoordinatesW:10], [Unity countcoordinatesH:1])];
        _line1.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line1;
}

- (UILabel *)priceL{
    if (!_priceL) {
        _priceL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line1.bottom+[Unity countcoordinatesH:7], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15])];
        _priceL.text = @"猜价价格";
        _priceL.textColor = LabelColor3;
        _priceL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _priceL;
}
- (UILabel *)priceNum{
    if (!_priceNum) {
        _priceNum = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], _priceL.top, _backView.width-[Unity countcoordinatesW:160], _priceL.height)];
        _priceNum.text = @"5000yuan";
        _priceNum.textColor = [Unity getColor:@"aa112d"];
        _priceNum.font = [UIFont systemFontOfSize:FontSize(14)];
        _priceNum.textAlignment = NSTextAlignmentRight;
    }
    return _priceNum;
}
- (UILabel *)jifenL{
    if (!_jifenL) {
        _jifenL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _priceL.bottom+[Unity countcoordinatesH:7], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15])];
        _jifenL.text = @"抵积分";
        _jifenL.textColor = LabelColor3;
        _jifenL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _jifenL;
}
- (UILabel *)jifenNum{
    if (!_jifenNum) {
        _jifenNum = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], _jifenL.top, _backView.width-[Unity countcoordinatesW:160], _jifenL.height)];
//        _jifenNum.text = @"5000yuan";
        _jifenNum.textColor = LabelColor6;
        _jifenNum.font = [UIFont systemFontOfSize:FontSize(14)];
        _jifenNum.textAlignment = NSTextAlignmentRight;
    }
    return _jifenNum;
}
- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:80], _jifenNum.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBtn setTitle:@"确认领取" forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = LabelColor9;
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmBtn.layer.cornerRadius = _confirmBtn.height/2;
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _confirmBtn.userInteractionEnabled = NO;
    }
    return _confirmBtn;
}
- (UILabel *)markL{
    if (!_markL) {
        _markL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _confirmBtn.bottom, _backView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _markL.text = @"请在24小时内领取，过时失效";
        _markL.textColor = LabelColor9;
        _markL.font = [UIFont systemFontOfSize:FontSize(12)];
        _markL.textAlignment = NSTextAlignmentRight;
        _markL.hidden = YES;
    }
    return _markL;
}
- (void)configWithGoodId:(NSString *)goodId WithStatus:(NSInteger)status WithImage:(NSString *)image WithGoodName:(NSString *)goodName WithGoodPrice:(NSString *)goodPrice WithGuessPrice:(NSString *)guessPrice WithJifen:(NSString *)jifen WithSource:(NSString *)source WithUser_confirm:(NSInteger)user_confirm WithNeed_confirm:(NSInteger)need_confirm{
    self.numberL.text = [NSString stringWithFormat:@"商品编号 %@",goodId];
    if (status == 1) {
        self.statusL.text = @"等待结果";
        self.statusL.textColor = [Unity getColor:@"f18e00"];
    }else if (status == 2){
        self.statusL.text = @"竞猜成功";
        self.statusL.textColor = [Unity getColor:@"0fac0b"];
        if (user_confirm == 1) {//已确认
            self.confirmBtn.backgroundColor = LabelColor9;
            [self.confirmBtn setTitle:@"已确认" forState:UIControlStateNormal];
            self.confirmBtn.userInteractionEnabled = NO;
        }else{//未确认
            if (need_confirm == 1) {//需要确认
                self.confirmBtn.backgroundColor = [Unity getColor:@"aa112d"];
                self.confirmBtn.userInteractionEnabled = YES;
            }else{//不需要确认
                self.confirmBtn.backgroundColor = LabelColor9;
                self.confirmBtn.userInteractionEnabled = NO;
            }
        }
    }else{
        self.markL.hidden = NO;
        self.backView.frame = CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:250]);
        self.statusL.text = @"竞猜失败";
        self.statusL.textColor = [Unity getColor:@"aa112d"];
        if (user_confirm == 1) {//已确认
            self.confirmBtn.backgroundColor = LabelColor9;
            [self.confirmBtn setTitle:@"已确认" forState:UIControlStateNormal];
            self.confirmBtn.userInteractionEnabled = NO;
        }else{//未确认
            if (need_confirm == 1) {//需要确认
                self.confirmBtn.backgroundColor = [Unity getColor:@"aa112d"];
                self.confirmBtn.userInteractionEnabled = YES;
            }else{//不需要确认
                self.confirmBtn.backgroundColor = LabelColor9;
                self.confirmBtn.userInteractionEnabled = NO;
            }
        }
//        self.confirmBtn.backgroundColor = [Unity getColor:@"aa112d"];
//        self.confirmBtn.userInteractionEnabled = YES;
    }
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",image]] placeholderImage:[UIImage imageNamed:@"Loading"]];
    self.goodsTitle.text = goodName;
    if ([source isEqualToString:@"yahoo"]) {
        self.goodsAmount.text = [NSString stringWithFormat:@"%@円",goodPrice];
        self.priceNum.text = [NSString stringWithFormat:@"%@円",guessPrice];
        self.jifenNum.text = [NSString stringWithFormat:@"%@积分",jifen];
    }else{
        self.goodsAmount.text = [NSString stringWithFormat:@"%@美元",goodPrice];
        self.priceNum.text = [NSString stringWithFormat:@"%@美元",guessPrice];
        self.jifenNum.text = [NSString stringWithFormat:@"%@积分",jifen];
    }
    self.goods_id = goodId;
    self.type = source;
    
}
- (void)confirmClick{
    [self.delegate confirm:self.goods_id];
}
- (void)goodBtn{
    [self.delegate goodDetail:self.goods_id WithType:self.type];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
