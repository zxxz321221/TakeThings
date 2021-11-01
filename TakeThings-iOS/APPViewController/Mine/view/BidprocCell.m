//
//  BidprocCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/13.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "BidprocCell.h"
@interface BidprocCell()
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UILabel * numberL;//投标编号
@property (nonatomic , strong) UILabel * courierL;//快递
@property (nonatomic , strong) UILabel * line0;//
@property (nonatomic , strong) UIImageView * icon;//商品图片
@property (nonatomic , strong) UILabel * goodsTitle;//商品标题
@property (nonatomic , strong) UILabel * goodsNum;//竞拍商品数量
@property (nonatomic , strong) UILabel * offerL;//海外已付款
@property (nonatomic , strong) UILabel * offerL1;//海外已发货
@property (nonatomic , strong) UILabel * line1;
@property (nonatomic , strong) UILabel * endOfTimeL;//结标时间
@property (nonatomic , strong) UILabel * endOfTime;
@property (nonatomic , strong) UILabel * highestBidL;//最高出价
@property (nonatomic , strong) UILabel * highestBid;
@property (nonatomic , strong) UILabel * line2;
@property (nonatomic , strong) UILabel * sumL;//现况总价
@property (nonatomic , strong) UILabel * sum;
@property (nonatomic , strong) UIButton * oriPage;//原始页面
@property (nonatomic , strong) UIButton * detail;//砍单
@property (nonatomic , strong) UIButton * goodsBtn;

@property (nonatomic , strong) NSDictionary * dic;
@end
@implementation BidprocCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [self BidprocView];
    }
    return self;
}
- (void)BidprocView{
    [self.contentView addSubview:self.backView];
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:285])];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 10;
        
        [_backView addSubview:self.numberL];
        [_backView addSubview:self.courierL];
        [_backView addSubview:self.line0];
        [_backView addSubview:self.goodsBtn];
//        [_backView addSubview:self.goodsTitle];
//        [_backView addSubview:self.goodsNum];
//        [_backView addSubview:self.offerL];
//        [_backView addSubview:self.offerL1];
        [_backView addSubview:self.line1];
        [_backView addSubview:self.endOfTimeL];
        [_backView addSubview:self.endOfTime];
        [_backView addSubview:self.highestBidL];
        [_backView addSubview:self.highestBid];
        [_backView addSubview:self.line2];
        [_backView addSubview:self.sumL];
        [_backView addSubview:self.sum];
        [_backView addSubview:self.oriPage];
        [_backView addSubview:self.detail];
    }
    return _backView;
}
- (UILabel *)numberL{
    if (!_numberL) {
        _numberL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:200], [Unity countcoordinatesH:40])];
        _numberL.text = @"";
        _numberL.textColor = LabelColor3;
        _numberL.font = [UIFont systemFontOfSize:FontSize(14)];
        _numberL.textAlignment = NSTextAlignmentLeft;
    }
    return _numberL;
}
- (UILabel *)courierL{
    if (!_courierL) {
        _courierL = [[UILabel alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:80], _numberL.top, [Unity countcoordinatesW:70], _numberL.height)];
        _courierL.text = @"邮局运输";
        _courierL.textColor = [Unity getColor:@"aa112d"];
        _courierL.font = [UIFont systemFontOfSize:FontSize(14)];
        _courierL.textAlignment = NSTextAlignmentRight;
    }
    return _courierL;
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
        [_goodsBtn addSubview:self.offerL1];
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
        _goodsNum.text = @"";
        _goodsNum.textColor = LabelColor6;
        _goodsNum.font = [UIFont systemFontOfSize:FontSize(12)];
        _goodsNum.textAlignment = NSTextAlignmentRight;
    }
    return _goodsNum;
}
- (UILabel *)offerL{
    if (!_offerL) {
        _offerL = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitle.left, _goodsTitle.bottom+[Unity countcoordinatesH:7], 20+[Unity widthOfString:@"海外已付款" OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:20]], [Unity countcoordinatesH:20])];
        _offerL.layer.cornerRadius = [Unity countcoordinatesH:10];
        _offerL.layer.masksToBounds = YES;
        _offerL.text = @"海外已付款";
        _offerL.backgroundColor = [Unity getColor:@"#f6e7ea"];
        _offerL.textColor = [Unity getColor:@"#aa112d"];
        _offerL.textAlignment = NSTextAlignmentCenter;
        _offerL.font = [UIFont systemFontOfSize:FontSize(14)];
        _offerL.hidden = YES;
    }
    return _offerL;
}
- (UILabel *)offerL1{
    if (!_offerL1) {
        _offerL1 = [[UILabel alloc]initWithFrame:CGRectMake(_offerL.right+[Unity countcoordinatesW:5], _goodsTitle.bottom+[Unity countcoordinatesH:7], 20+[Unity widthOfString:@"海外已发货" OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:20]], [Unity countcoordinatesH:20])];
        _offerL1.layer.cornerRadius = [Unity countcoordinatesH:10];
        _offerL1.layer.masksToBounds = YES;
        _offerL1.text = @"海外已收货";
        _offerL1.backgroundColor = [Unity getColor:@"#f6e7ea"];
        _offerL1.textColor = [Unity getColor:@"#aa112d"];
        _offerL1.textAlignment = NSTextAlignmentCenter;
        _offerL1.font = [UIFont systemFontOfSize:FontSize(14)];
        _offerL1.hidden = YES;
    }
    return _offerL1;
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
        _endOfTimeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _goodsBtn.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
        _endOfTimeL.textColor = LabelColor3;
        _endOfTimeL.text = @"结标时间";
        _endOfTimeL.textAlignment = NSTextAlignmentLeft;
        _endOfTimeL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _endOfTimeL;
}
- (UILabel *)endOfTime{
    if (!_endOfTime) {
        _endOfTime = [[UILabel alloc]initWithFrame:CGRectMake(_endOfTimeL.right, _endOfTimeL.top, _backView.width-[Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _endOfTime.textColor = LabelColor6;
        _endOfTime.text = @"";
        _endOfTime.textAlignment = NSTextAlignmentRight;
        _endOfTime.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _endOfTime;
}
- (UILabel *)highestBidL{
    if (!_highestBidL) {
        _highestBidL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _endOfTimeL.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:120], [Unity countcoordinatesH:20])];
        _highestBidL.textColor = LabelColor3;
        _highestBidL.text = @"购得价";
        _highestBidL.textAlignment = NSTextAlignmentLeft;
        _highestBidL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _highestBidL;
}
- (UILabel *)highestBid{
    if (!_highestBid) {
        _highestBid = [[UILabel alloc]initWithFrame:CGRectMake(_highestBidL.right, _highestBidL.top, _backView.width-[Unity countcoordinatesW:140], [Unity countcoordinatesH:20])];
        _highestBid.textColor = LabelColor3;
        _highestBid.text = @"";
        _highestBid.textAlignment = NSTextAlignmentRight;
        _highestBid.font = [UIFont systemFontOfSize:FontSize(14)];
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
- (UILabel *)sumL{
    if (!_sumL) {
        _sumL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _highestBidL.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:120], [Unity countcoordinatesH:20])];
        _sumL.textColor = LabelColor3;
        _sumL.text = @"现况总价";
        _sumL.textAlignment = NSTextAlignmentLeft;
        _sumL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _sumL;
}
- (UILabel *)sum{
    if (!_sum) {
        _sum = [[UILabel alloc]initWithFrame:CGRectMake(_sumL.right, _sumL.top, _backView.width-[Unity countcoordinatesW:140], [Unity countcoordinatesH:20])];
        _sum.textColor = [Unity getColor:@"aa112d"];
        _sum.text = @"";
        _sum.textAlignment = NSTextAlignmentRight;
        _sum.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _sum;
}
- (UIButton *)oriPage{
    if (!_oriPage) {
        _oriPage = [[UIButton alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:160], _sum.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_oriPage addTarget:self action:@selector(oriPageClick) forControlEvents:UIControlEventTouchUpInside];
        //设置边框颜色
        _oriPage.layer.borderColor = [LabelColor9 CGColor];
        //设置边框宽度
        _oriPage.layer.borderWidth = 1.0f;
        [_oriPage setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_oriPage setTitle:@"原始页面" forState:UIControlStateNormal];
        _oriPage.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _oriPage.layer.cornerRadius = [Unity countcoordinatesH:15];
        _oriPage.layer.masksToBounds = YES;
    }
    return _oriPage;
}
- (UIButton *)detail{
    if (!_detail) {
        _detail = [[UIButton alloc]initWithFrame:CGRectMake(_oriPage.right+[Unity countcoordinatesW:10], _sum.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_detail addTarget:self action:@selector(detailClick) forControlEvents:UIControlEventTouchUpInside];
        _detail.backgroundColor = [Unity getColor:@"#aa112d"];
        [_detail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_detail setTitle:@"订单明细" forState:UIControlStateNormal];
        _detail.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _detail.layer.cornerRadius = [Unity countcoordinatesH:15];
        _detail.layer.masksToBounds = YES;
    }
    return _detail;
}
- (void)configWithData:(NSDictionary *)dic{
    self.dic = dic;
    self.numberL.text = [NSString stringWithFormat:@"订单编号 %@/%@",dic[@"w_lsh"],dic[@"w_jpnid"]];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:dic[@"w_imgsrc"]] placeholderImage:[UIImage imageNamed:@"Loading"]];
    self.goodsTitle.text = dic[@"w_object"];
    self.goodsNum.text = [NSString stringWithFormat:@"x%@",dic[@"w_tbsl"]];
    self.endOfTime.text = dic[@"w_overtime"];
    if ([dic[@"w_cc"]isEqualToString:@"0"]) {
        self.highestBid.text = [NSString stringWithFormat:@"%@円",dic[@"w_jbj_jp"]];
    }else{
        self.highestBid.text = [NSString stringWithFormat:@"%@美元",dic[@"w_jbj_jp"]];
    }
    self.sum.text = [NSString stringWithFormat:@"%@RMB",dic[@"w_total_tw"]];
    if ([dic[@"w_state"] intValue]>=3) {
        _offerL.hidden = NO;
    }
    if ([dic[@"w_state"] intValue]>=3 && [dic[@"w_hwsh"] intValue]==1) {
        _offerL1.hidden = NO;
    }
}

- (void)configWithGoodsData:(NSDictionary *)dic{
    self.dic = dic;
    self.numberL.text = [NSString stringWithFormat:@"订单编号 %@/%@",dic[@"w_lsh"],dic[@"w_jpnid"]];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:dic[@"w_imgsrc"]] placeholderImage:[UIImage imageNamed:@"Loading"]];
    self.goodsTitle.text = dic[@"w_object"];
    self.goodsNum.text = [NSString stringWithFormat:@"x%@",dic[@"w_tbsl"]];
    self.endOfTime.text = dic[@"w_overtime"];
    if ([dic[@"w_cc"]isEqualToString:@"0"]) {
        self.highestBid.text = [NSString stringWithFormat:@"%@円",dic[@"w_jbj_jp"]];
    }else{
        self.highestBid.text = [NSString stringWithFormat:@"%@美元",dic[@"w_jbj_jp"]];
    }
    self.sum.text = [NSString stringWithFormat:@"%@RMB",dic[@"w_total_tw"]];
    if ([dic[@"w_state"] intValue]>=3) {
        _offerL.hidden = NO;
    }
    if ([dic[@"w_state"] intValue]>=3 && [dic[@"w_hwsh"] intValue]==1) {
        _offerL1.hidden = NO;
    }
}
- (void)oriPageClick{
    [self.delegate oriPage:self.dic];
}
- (void)detailClick{
    [self.delegate detail:self.dic];
}
- (NSDictionary *)dic{
    if (!_dic) {
        _dic = [NSDictionary new];
    }
    return _dic;
}
- (void)goodBtn{
    [self.delegate goodsDetail:self.dic];
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
