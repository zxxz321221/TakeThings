
//
//  BidCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/5.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "BidCell.h"
@interface BidCell()
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
@property (nonatomic , strong) UILabel * endOfTimeL;//结标时间
@property (nonatomic , strong) UILabel * endOfTime;
@property (nonatomic , strong) UILabel * highestBidL;//最高出价
@property (nonatomic , strong) UILabel * highestBid;
@property (nonatomic , strong) UILabel * line2;
@property (nonatomic , strong) UILabel * supplementaryMoneyL;//应补款
@property (nonatomic , strong) UILabel * supplementaryMoney;
@property (nonatomic , strong) UIButton * oriPage;//原始页面
@property (nonatomic , strong) UIButton * dischargeIntoCases;//排入案件
@property (nonatomic , strong) UIButton * recharge;//充值
@property (nonatomic , strong) UIButton * readBtn;//编辑
@property (nonatomic , strong) UIButton * goodsBtn;

@property (nonatomic , strong) NSDictionary * dict;
@end
@implementation BidCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [Unity getColor:@"#e0e0e0"];
        [self bidCellView];
    }
    return self;
}
- (void)bidCellView{
    [self.contentView addSubview:self.backView];
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:293])];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 10;
        
//        [_backView addSubview:self.readBtn];
        [_backView addSubview:self.numberL];
        [_backView addSubview:self.statusL];
        [_backView addSubview:self.line0];
        [_backView addSubview:self.goodsBtn];
//        [_backView addSubview:self.goodsTitle];
//        [_backView addSubview:self.goodsNum];
//        [_backView addSubview:self.offerL];
//        [_backView addSubview:self.goodsAmount];
        [_backView addSubview:self.line1];
        [_backView addSubview:self.endOfTimeL];
        [_backView addSubview:self.endOfTime];
        [_backView addSubview:self.highestBidL];
        [_backView addSubview:self.highestBid];
        [_backView addSubview:self.line2];
        [_backView addSubview:self.supplementaryMoneyL];
        [_backView addSubview:self.supplementaryMoney];
        [_backView addSubview:self.oriPage];
        [_backView addSubview:self.dischargeIntoCases];
        [_backView addSubview:self.recharge];
        
    }
    return _backView;
}
//- (UIButton *)readBtn{
//    if (!_readBtn) {
//        _readBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:12], [Unity countcoordinatesW:16], [Unity countcoordinatesH:16])];
//        [_readBtn setBackgroundImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
//        [_readBtn addTarget:self action:@selector(raadClick) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _readBtn;
//}
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
        _statusL.textColor = [Unity getColor:@"0fac0b"];
        _statusL.font = [UIFont systemFontOfSize:FontSize(14)];
        _statusL.textAlignment = NSTextAlignmentRight;
    }
    return _statusL;
}
- (UILabel *)line0{
    if (!_line0) {
        _line0 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:40], _backView.width-[Unity countcoordinatesW:10], 1)];
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
        _goodsTitle.font = [UIFont systemFontOfSize:14];
        _goodsTitle.textAlignment = NSTextAlignmentLeft;
    }
    return _goodsTitle;
}
- (UILabel *)goodsNum{
    if (!_goodsNum) {
        _goodsNum = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitle.right+[Unity countcoordinatesW:10], _goodsTitle.top+[Unity countcoordinatesH:5], [Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _goodsNum.text = @"";
        _goodsNum.textColor = LabelColor6;
        _goodsNum.font = [UIFont systemFontOfSize:12];
        _goodsNum.textAlignment = NSTextAlignmentRight;
    }
    return _goodsNum;
}
- (UILabel *)offerL{
    if (!_offerL) {
        _offerL = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitle.left, _goodsTitle.bottom+[Unity countcoordinatesH:7], [Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _offerL.backgroundColor = [Unity getColor:@"#f6e7ea"];
        _offerL.textColor = [Unity getColor:@"#aa112d"];
        _offerL.textAlignment = NSTextAlignmentCenter;
        _offerL.font = [UIFont systemFontOfSize:14];
    }
    return _offerL;
}
- (UILabel *)goodsAmount{
    if (!_goodsAmount) {
        _goodsAmount = [[UILabel alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:150], _offerL.top, [Unity countcoordinatesW:140], _offerL.height)];
        _goodsAmount.textColor = LabelColor3;
        _goodsAmount.text = @"";
        _goodsAmount.textAlignment = NSTextAlignmentRight;
        _goodsAmount.font = [UIFont systemFontOfSize:14];
    }
    return _goodsAmount;
}
- (UILabel *)line1{
    if (!_line1) {
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _goodsBtn.bottom, _backView.width-[Unity countcoordinatesW:10], 1)];
        _line1.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line1;
}
- (UILabel *)endOfTimeL{
    if (!_endOfTimeL) {
        _endOfTimeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line1.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
        _endOfTimeL.textColor = LabelColor3;
        _endOfTimeL.text = @"结束时间";
        _endOfTimeL.textAlignment = NSTextAlignmentLeft;
        _endOfTimeL.font = [UIFont systemFontOfSize:14];
    }
    return _endOfTimeL;
}
- (UILabel *)endOfTime{
    if (!_endOfTime) {
        _endOfTime = [[UILabel alloc]initWithFrame:CGRectMake(_endOfTimeL.right, _endOfTimeL.top, _backView.width-[Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _endOfTime.textColor = LabelColor6;
        _endOfTime.text = @"";
        _endOfTime.textAlignment = NSTextAlignmentRight;
        _endOfTime.font = [UIFont systemFontOfSize:14];
    }
    return _endOfTime;
}
- (UILabel *)highestBidL{
    if (!_highestBidL) {
        _highestBidL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _endOfTimeL.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:120], [Unity countcoordinatesH:20])];
        _highestBidL.textColor = LabelColor3;
        _highestBidL.text = @"购得价";
        _highestBidL.textAlignment = NSTextAlignmentLeft;
        _highestBidL.font = [UIFont systemFontOfSize:14];
    }
    return _highestBidL;
}
- (UILabel *)highestBid{
    if (!_highestBid) {
        _highestBid = [[UILabel alloc]initWithFrame:CGRectMake(_highestBidL.right, _highestBidL.top, _backView.width-[Unity countcoordinatesW:140], [Unity countcoordinatesH:20])];
        _highestBid.textColor = LabelColor3;
        _highestBid.text = @"";
        _highestBid.textAlignment = NSTextAlignmentRight;
        _highestBid.font = [UIFont systemFontOfSize:14];
    }
    return _highestBid;
}
- (UILabel *)line2{
    if (!_line2) {
        _line2 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _highestBidL.bottom+[Unity countcoordinatesH:10], _backView.width-[Unity countcoordinatesW:10], 1)];
        _line2.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line2;
}
- (UILabel *)supplementaryMoneyL{
    if (!_supplementaryMoneyL) {
        _supplementaryMoneyL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line2.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
        _supplementaryMoneyL.textColor = LabelColor3;
        _supplementaryMoneyL.text = @"预付款";
        _supplementaryMoneyL.textAlignment = NSTextAlignmentLeft;
        _supplementaryMoneyL.font = [UIFont systemFontOfSize:14];
    }
    return _supplementaryMoneyL;
}
- (UILabel *)supplementaryMoney{
    if (!_supplementaryMoney) {
        _supplementaryMoney = [[UILabel alloc]initWithFrame:CGRectMake(_supplementaryMoneyL.right, _supplementaryMoneyL.top, _backView.width-[Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _supplementaryMoney.textColor = [Unity getColor:@"#aa112d"];
        _supplementaryMoney.text = @"";
        _supplementaryMoney.textAlignment = NSTextAlignmentRight;
        _supplementaryMoney.font = [UIFont systemFontOfSize:14];
    }
    return _supplementaryMoney;
}
- (UIButton *)oriPage{
    if (!_oriPage) {
        _oriPage = [[UIButton alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:240], _supplementaryMoney.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_oriPage addTarget:self action:@selector(oriPageClick) forControlEvents:UIControlEventTouchUpInside];
        //设置边框颜色
        _oriPage.layer.borderColor = [LabelColor9 CGColor];
        //设置边框宽度
        _oriPage.layer.borderWidth = 1.0f;
        [_oriPage setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_oriPage setTitle:@"原始页面" forState:UIControlStateNormal];
        _oriPage.titleLabel.font = [UIFont systemFontOfSize:14];
        _oriPage.layer.cornerRadius = [Unity countcoordinatesH:15];
        _oriPage.layer.masksToBounds = YES;
    }
    return _oriPage;
}
- (UIButton *)dischargeIntoCases{
    if (!_dischargeIntoCases) {
        _dischargeIntoCases = [[UIButton alloc]initWithFrame:CGRectMake(_oriPage.right+[Unity countcoordinatesW:10], _supplementaryMoney.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_dischargeIntoCases addTarget:self action:@selector(dischargeIntoCasesClick) forControlEvents:UIControlEventTouchUpInside];
        //设置边框颜色
        _dischargeIntoCases.layer.borderColor = [[Unity getColor:@"#aa112d"] CGColor];
        //设置边框宽度
        _dischargeIntoCases.layer.borderWidth = 1.0f;
        [_dischargeIntoCases setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        [_dischargeIntoCases setTitle:@"排入案件" forState:UIControlStateNormal];
        _dischargeIntoCases.titleLabel.font = [UIFont systemFontOfSize:14];
        _dischargeIntoCases.layer.cornerRadius = [Unity countcoordinatesH:15];
        _dischargeIntoCases.layer.masksToBounds = YES;
    }
    return _dischargeIntoCases;
}
- (UIButton *)recharge{
    if (!_recharge) {
        _recharge = [[UIButton alloc]initWithFrame:CGRectMake(_dischargeIntoCases.right+[Unity countcoordinatesW:10], _supplementaryMoney.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_recharge addTarget:self action:@selector(rechargeClick) forControlEvents:UIControlEventTouchUpInside];
        _recharge.backgroundColor = [Unity getColor:@"#aa112d"];
        [_recharge setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_recharge setTitle:@"充值" forState:UIControlStateNormal];
        _recharge.titleLabel.font = [UIFont systemFontOfSize:14];
        _recharge.layer.cornerRadius = [Unity countcoordinatesH:15];
        _recharge.layer.masksToBounds = YES;
    }
    return _recharge;
}
- (void)confitWithData:(NSDictionary *)dic{
    self.dict = dic;
    NSString * sta = @"";
    if ([dic[@"w_ykj"] isEqualToString:@"2"]) {
        sta = @"立即购买";
    }else{
        sta = @"结束前购买";
    }
    self.statusL.text = [Unity getState:[dic[@"w_state"] intValue] WithPage:2];
    self.offerL.frame = CGRectMake(_goodsTitle.left, _goodsTitle.bottom+[Unity countcoordinatesH:7], 20+[Unity widthOfString:sta OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:20]], [Unity countcoordinatesH:20]);
    self.offerL.layer.cornerRadius = [Unity countcoordinatesH:10];
    self.offerL.layer.masksToBounds = YES;
    self.offerL.text = sta;
    
    self.numberL.text = [NSString stringWithFormat:@"订单编号 %@/%@",dic[@"w_lsh"],dic[@"w_jpnid"]];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:dic[@"w_imgsrc"]] placeholderImage:[UIImage imageNamed:@"Loading"]];
    self.goodsTitle.text = dic[@"w_object"];
    self.goodsNum.text = [NSString stringWithFormat:@"x%@",dic[@"w_tbsl"]];
    self.endOfTime.text = dic[@"w_overtime"];
    if ([dic[@"w_cc"]isEqualToString:@"0"]) {
        self.goodsAmount.text = [NSString stringWithFormat:@"%@円",dic[@"w_jbj_jp"]];
        self.highestBid.text = [NSString stringWithFormat:@"%@円",dic[@"w_jbj_jp"]];
    }else{
        self.goodsAmount.text = [NSString stringWithFormat:@"%@美元",dic[@"w_jbj_jp"]];
        self.highestBid.text = [NSString stringWithFormat:@"%@美元",dic[@"w_jbj_jp"]];
    }
    self.supplementaryMoney.text = [NSString stringWithFormat:@"%@元",dic[@"w_prepay_tw"]];
}
- (void)oriPageClick{
    [self.delegate oriPage:self.dict];
}
- (void)dischargeIntoCasesClick{
    [self.delegate drainInto:self];
}
- (void)rechargeClick{
    
}

- (NSDictionary *)dict{
    if (!_dict) {
        _dict = [NSDictionary new];
    }
    return _dict;
}
- (void)goodBtn{
    [self.delegate goodsDetail:self.dict];
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
