//
//  ShippedCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/13.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "ShippedCell.h"
@interface ShippedCell()
{
    float chae;
}
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UILabel * numberL;//投标编号
@property (nonatomic , strong) UILabel * courierL;//快递
@property (nonatomic , strong) UILabel * line0;//
@property (nonatomic , strong) UIImageView * icon;//商品图片
@property (nonatomic , strong) UILabel * goodsTitle;//商品标题
@property (nonatomic , strong) UILabel * goodsNum;//竞拍商品数量
@property (nonatomic , strong) UILabel * line1;
@property (nonatomic , strong) UILabel * sendDataL;//发货日期
@property (nonatomic , strong) UILabel * sendData;
@property (nonatomic , strong) UILabel * biddingPriceL;// 得标价
@property (nonatomic , strong) UILabel * biddingPrice;
@property (nonatomic , strong) UILabel * sumL;//现况总价
@property (nonatomic , strong) UILabel * sum;
@property (nonatomic , strong) UILabel * advanceL;//预付金
@property (nonatomic , strong) UILabel * advance;
@property (nonatomic , strong) UILabel * line2;
@property (nonatomic , strong) UILabel * differenceL;//差额
@property (nonatomic , strong) UILabel * difference;
@property (nonatomic , strong) UIButton * oriPage;//原始页面
@property (nonatomic , strong) UIButton * handle;//处理
@property (nonatomic , strong) UIButton * detail;//明细
@property (nonatomic , strong) UIButton * goodsBtn;

@property (nonatomic , strong) NSDictionary * dict;


@end
@implementation ShippedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [self shipView];
    }
    return self;
}
- (void)shipView{
    [self.contentView addSubview:self.backView];
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:335])];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 10;
        
        [_backView addSubview:self.numberL];
        [_backView addSubview:self.courierL];
        [_backView addSubview:self.line0];
        [_backView addSubview:self.goodsBtn];
//        [_backView addSubview:self.goodsTitle];
//        [_backView addSubview:self.goodsNum];
        [_backView addSubview:self.line1];
        [_backView addSubview:self.sendDataL];
        [_backView addSubview:self.sendData];
        [_backView addSubview:self.biddingPriceL];
        [_backView addSubview:self.biddingPrice];
        [_backView addSubview:self.sumL];
        [_backView addSubview:self.sum];
        [_backView addSubview:self.advanceL];
        [_backView addSubview:self.advance];
        [_backView addSubview:self.line2];
        [_backView addSubview:self.differenceL];
        [_backView addSubview:self.difference];
        [_backView addSubview:self.oriPage];
//        [_backView addSubview:self.handle];
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
- (UILabel *)line1{
    if (!_line1) {
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _goodsBtn.bottom, _backView.width-[Unity countcoordinatesW:10], 1)];
        _line1.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line1;
}
- (UILabel *)sendDataL{
    if (!_sendDataL) {
        _sendDataL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _goodsBtn.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
        _sendDataL.textColor = LabelColor3;
        _sendDataL.text = @"发货日期";
        _sendDataL.textAlignment = NSTextAlignmentLeft;
        _sendDataL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _sendDataL;
}
- (UILabel *)sendData{
    if (!_sendData) {
        _sendData = [[UILabel alloc]initWithFrame:CGRectMake(_sendDataL.right, _sendDataL.top, _backView.width-[Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _sendData.textColor = LabelColor6;
        _sendData.text = @"";
        _sendData.textAlignment = NSTextAlignmentRight;
        _sendData.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _sendData;
}
- (UILabel *)biddingPriceL{
    if (!_biddingPriceL) {
        _biddingPriceL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _sendDataL.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:120], [Unity countcoordinatesH:20])];
        _biddingPriceL.textColor = LabelColor3;
        _biddingPriceL.text = @"购得价";
        _biddingPriceL.textAlignment = NSTextAlignmentLeft;
        _biddingPriceL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _biddingPriceL;
}
- (UILabel *)biddingPrice{
    if (!_biddingPrice) {
        _biddingPrice = [[UILabel alloc]initWithFrame:CGRectMake(_biddingPriceL.right, _biddingPriceL.top, _backView.width-[Unity countcoordinatesW:140], [Unity countcoordinatesH:20])];
        _biddingPrice.textColor = LabelColor3;
        _biddingPrice.text = @"";
        _biddingPrice.textAlignment = NSTextAlignmentRight;
        _biddingPrice.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _biddingPrice;
}
- (UILabel *)sumL{
    if (!_sumL) {
        _sumL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _biddingPriceL.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:120], [Unity countcoordinatesH:20])];
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
        _sum.textColor = LabelColor3;
        _sum.text = @"850.00RMB";
        _sum.textAlignment = NSTextAlignmentRight;
        _sum.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _sum;
}
- (UILabel *)advanceL{
    if (!_advanceL) {
        _advanceL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _sumL.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:120], [Unity countcoordinatesH:20])];
        _advanceL.textColor = LabelColor3;
        _advanceL.text = @"预付金";
        _advanceL.textAlignment = NSTextAlignmentLeft;
        _advanceL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _advanceL;
}
- (UILabel *)advance{
    if (!_advance) {
        _advance = [[UILabel alloc]initWithFrame:CGRectMake(_advanceL.right, _advanceL.top, _backView.width-[Unity countcoordinatesW:140], [Unity countcoordinatesH:20])];
        _advance.textColor = LabelColor3;
        _advance.text = @"";
        _advance.textAlignment = NSTextAlignmentRight;
        _advance.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _advance;
}
- (UILabel *)line2{
    if (!_line2) {
        _line2 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _advanceL.bottom+[Unity countcoordinatesH:10], _backView.width-[Unity countcoordinatesW:10], 1)];
        _line2.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line2;
}
- (UILabel *)differenceL{
    if (!_differenceL) {
        _differenceL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _advanceL.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:120], [Unity countcoordinatesH:20])];
        _differenceL.textColor = LabelColor3;
        _differenceL.text = @"需补差额";
        _differenceL.textAlignment = NSTextAlignmentLeft;
        _differenceL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _differenceL;
}
- (UILabel *)difference{
    if (!_difference) {
        _difference = [[UILabel alloc]initWithFrame:CGRectMake(_differenceL.right, _differenceL.top, _backView.width-[Unity countcoordinatesW:140], [Unity countcoordinatesH:20])];
        _difference.textColor = [Unity getColor:@"aa112d"];
        _difference.text = @"";
        _difference.textAlignment = NSTextAlignmentRight;
        _difference.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _difference;
}
- (UIButton *)oriPage{
    if (!_oriPage) {
        _oriPage = [[UIButton alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:160], _differenceL.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
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
- (UIButton *)handle{
    if (!_handle) {
        _handle = [[UIButton alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:160], _differenceL.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_handle addTarget:self action:@selector(handleClick) forControlEvents:UIControlEventTouchUpInside];
        //设置边框颜色
        _handle.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        //设置边框宽度
        _handle.layer.borderWidth = 1.0f;
        [_handle setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
        [_handle setTitle:@"处理" forState:UIControlStateNormal];
        _handle.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _handle.layer.cornerRadius = [Unity countcoordinatesH:15];
        _handle.layer.masksToBounds = YES;
        
    }
    return _handle;
}
- (UIButton *)detail{
    if (!_detail) {
        _detail = [[UIButton alloc]initWithFrame:CGRectMake(_oriPage.right+[Unity countcoordinatesW:10], _differenceL.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
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
- (void)oriPageClick{
    [self.delegate oriPage:self.dict];
}
- (void)handleClick{
    [self.delegate handlePlace:[NSString stringWithFormat:@"%.2f",chae]];
}
- (void)detailClick{
    [self.delegate detail:self.dict];
}
- (void)configWithData:(NSDictionary *)dic{
    self.dict = dic;
    self.numberL.text = [NSString stringWithFormat:@"订单编号 %@/%@",dic[@"w_lsh"],dic[@"w_jpnid"]];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:dic[@"w_imgsrc"]] placeholderImage:[UIImage imageNamed:@"Loading"]];
    self.goodsTitle.text = dic[@"w_object"];
    self.goodsNum.text = [NSString stringWithFormat:@"x%@",dic[@"w_tbsl"]];
    self.sendData.text = dic[@"w_time_jp"];
    if ([dic[@"w_cc"]isEqualToString:@"0"]) {
        self.biddingPrice.text = [NSString stringWithFormat:@"%@円",dic[@"w_jbj_jp"]];
    }else{
        self.biddingPrice.text = [NSString stringWithFormat:@"%@美元",dic[@"w_jbj_jp"]];
    }
    self.sum.text = [NSString stringWithFormat:@"%@RMB",dic[@"w_total_tw"]];
    self.advance.text = [NSString stringWithFormat:@"%@RMB",dic[@"w_prepay_tw"]];
    chae = [dic[@"w_total_tw"] floatValue]-[dic[@"w_prepay_tw"]floatValue];
    self.difference.text = [NSString stringWithFormat:@"%.2fRMB",chae];
//    if (chae == 0) {
//        self.handle.layer.borderColor = LabelColor9.CGColor;
//        [self.handle setTitleColor:LabelColor9 forState:UIControlStateNormal];
//        self.handle.userInteractionEnabled = NO;
//    }
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
