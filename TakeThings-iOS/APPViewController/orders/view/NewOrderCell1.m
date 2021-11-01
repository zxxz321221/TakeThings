//
//  NewOrderCell1.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/9.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "NewOrderCell1.h"
@interface NewOrderCell1()
{
    NSInteger btnStatus;//1 委托单结算  2委托单详情 3 通知发货  4包裹详情
}
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UILabel * numberL;
@property (nonatomic , strong) UILabel * statusL;
@property (nonatomic , strong) UILabel * line0;
@property (nonatomic , strong) UIImageView * icon;//商品图片
@property (nonatomic , strong) UILabel * goodsTitle;//商品标题
@property (nonatomic , strong) UILabel * goodsNum;//竞拍商品数量
@property (nonatomic , strong) UILabel * placeLabel;//商品价格
@property (nonatomic , strong) UILabel * offerL;//出价竞标
@property (nonatomic , strong) UILabel * line1;
@property (nonatomic , strong) UILabel * accountL;//出价账号文字
@property (nonatomic , strong) UILabel * account;//出价账号
@property (nonatomic , strong) UILabel * endOfTimeL;//结标时间
@property (nonatomic , strong) UILabel * endOfTime;
@property (nonatomic , strong) UILabel * highestBidL;//最高出价
@property (nonatomic , strong) UILabel * highestBid;
@property (nonatomic , strong) UILabel * bidPlaceL;//得标价
@property (nonatomic , strong) UILabel * bidPlace;

@property (nonatomic , strong) UILabel * line2;
@property (nonatomic , strong) UILabel * djL;//定金
@property (nonatomic , strong) UILabel * dj;

@property (nonatomic , strong) UIView * btnView;
@property (nonatomic , strong) UIButton * detailBtn;//详情
@property (nonatomic , strong) UIButton * settlementBtn;//委托单结算

@end
@implementation NewOrderCell1
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [Unity getColor:@"f0f0f0"];
        [self.contentView addSubview:self.backView];
    }
    return self;
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:332])];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 5;
        
        [_backView addSubview:self.numberL];
        [_backView addSubview:self.statusL];
        [_backView addSubview:self.line0];
        [_backView addSubview:self.icon];
        [_backView addSubview:self.goodsTitle];
        [_backView addSubview:self.goodsNum];
        [_backView addSubview:self.offerL];
        [_backView addSubview:self.placeLabel];
        [_backView addSubview:self.line1];
        [_backView addSubview:self.accountL];
        [_backView addSubview:self.account];
        [_backView addSubview:self.endOfTimeL];
        [_backView addSubview:self.endOfTime];
        [_backView addSubview:self.highestBidL];
        [_backView addSubview:self.highestBid];
        [_backView addSubview:self.bidPlaceL];
        [_backView addSubview:self.bidPlace];
        [_backView addSubview:self.line2];
        [_backView addSubview:self.djL];
        [_backView addSubview:self.dj];
        [_backView addSubview:self.btnView];
    }
    return _backView;
}
- (UILabel *)numberL{
    if (!_numberL) {
        _numberL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:170], [Unity countcoordinatesH:40])];
        _numberL.text = @"案件编号XXXX";
        _numberL.textColor = LabelColor3;
        _numberL.font = [UIFont systemFontOfSize:FontSize(14)];
        _numberL.textAlignment = NSTextAlignmentLeft;
    }
    return _numberL;
}
- (UILabel *)statusL{
    if (!_statusL) {
        _statusL = [[UILabel alloc]initWithFrame:CGRectMake(_numberL.right, _numberL.top, [Unity countcoordinatesW:110], _numberL.height)];
        _statusL.text = @"XXX";
        _statusL.textColor = [Unity getColor:@"aa112d"];
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
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line0.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:70])];
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
        _offerL = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitle.left, _goodsTitle.bottom+[Unity countcoordinatesH:7], [Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _offerL.text =@"xxx";
        _offerL.backgroundColor = [Unity getColor:@"#f6e7ea"];
        _offerL.textColor = [Unity getColor:@"#aa112d"];
        _offerL.textAlignment = NSTextAlignmentCenter;
        _offerL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _offerL;
}
- (UILabel *)placeLabel{
    if (!_placeLabel) {
        _placeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitle.left, _goodsTitle.bottom+[Unity countcoordinatesH:10], _backView.width-[Unity countcoordinatesW:95], [Unity countcoordinatesH:20])];
        _placeLabel.text = @"xxx円";
        _placeLabel.textColor = LabelColor6;
        _placeLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _placeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _placeLabel;
}
- (UILabel *)line1{
    if (!_line1) {
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _icon.bottom+[Unity countcoordinatesH:10], _backView.width-[Unity countcoordinatesW:10], 1)];
        _line1.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line1;
}
- (UILabel *)accountL{
    if (!_accountL) {
        _accountL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line1.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:80], [Unity countcoordinatesH:25])];
        _accountL.textColor = LabelColor3;
        _accountL.text = @"出价账号";
        _accountL.textAlignment = NSTextAlignmentLeft;
        _accountL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _accountL;
}
- (UILabel *)account{
    if (!_account) {
        _account = [[UILabel alloc]initWithFrame:CGRectMake(_accountL.right, _accountL.top, _backView.width-[Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _account.textColor = LabelColor6;
        _account.text = @"";
        _account.textAlignment = NSTextAlignmentRight;
        _account.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _account;
}
- (UILabel *)endOfTimeL{
    if (!_endOfTimeL) {
        _endOfTimeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _accountL.bottom, [Unity countcoordinatesW:80], [Unity countcoordinatesH:25])];
        _endOfTimeL.textColor = LabelColor3;
        _endOfTimeL.text = @"结束时间";
        _endOfTimeL.textAlignment = NSTextAlignmentLeft;
        _endOfTimeL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _endOfTimeL;
}
- (UILabel *)endOfTime{
    if (!_endOfTime) {
        _endOfTime = [[UILabel alloc]initWithFrame:CGRectMake(_endOfTimeL.right, _endOfTimeL.top, _backView.width-[Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _endOfTime.textColor = LabelColor6;
        _endOfTime.text = @"";
        _endOfTime.textAlignment = NSTextAlignmentRight;
        _endOfTime.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _endOfTime;
}
- (UILabel *)highestBidL{
    if (!_highestBidL) {
        _highestBidL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _endOfTimeL.bottom, [Unity countcoordinatesW:80], [Unity countcoordinatesH:25])];
        _highestBidL.textColor = LabelColor3;
        _highestBidL.text = @"最高出标价";
        _highestBidL.textAlignment = NSTextAlignmentLeft;
        _highestBidL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _highestBidL;
}
- (UILabel *)highestBid{
    if (!_highestBid) {
        _highestBid = [[UILabel alloc]initWithFrame:CGRectMake(_highestBidL.right, _highestBidL.top, _backView.width-[Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _highestBid.textColor = [Unity getColor:@"aa112d"];
        _highestBid.text = @"";
        _highestBid.textAlignment = NSTextAlignmentRight;
        _highestBid.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _highestBid;
}
- (UILabel *)bidPlaceL{
    if (!_bidPlaceL) {
        _bidPlaceL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _highestBidL.bottom, [Unity countcoordinatesW:80], [Unity countcoordinatesH:25])];
        _bidPlaceL.textColor = LabelColor3;
        _bidPlaceL.text = @"得标价";
        _bidPlaceL.textAlignment = NSTextAlignmentLeft;
        _bidPlaceL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _bidPlaceL;
}
- (UILabel *)bidPlace{
    if (!_bidPlace) {
        _bidPlace = [[UILabel alloc]initWithFrame:CGRectMake(_bidPlaceL.right, _bidPlaceL.top, _backView.width-[Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _bidPlace.textColor = [Unity getColor:@"aa112d"];
        _bidPlace.text = @"";
        _bidPlace.textAlignment = NSTextAlignmentRight;
        _bidPlace.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _bidPlace;
}
- (UILabel *)line2{
    if (!_line2) {
        _line2 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _bidPlaceL.bottom+[Unity countcoordinatesH:5], _backView.width-[Unity countcoordinatesW:10], 1)];
        _line2.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line2;
}
- (UILabel *)djL{
    if (!_djL) {
        _djL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line2.bottom, [Unity countcoordinatesW:120], [Unity countcoordinatesH:30])];
        _djL.textColor = LabelColor3;
        _djL.text = @"定金(已退回)";
        _djL.textAlignment = NSTextAlignmentLeft;
        _djL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _djL;
}
- (UILabel *)dj{
    if (!_dj) {
        _dj = [[UILabel alloc]initWithFrame:CGRectMake(_djL.right, _djL.top, _backView.width-[Unity countcoordinatesW:140], [Unity countcoordinatesH:30])];
        _dj.textColor = [Unity getColor:@"#aa112d"];
        _dj.text = @"";
        _dj.textAlignment = NSTextAlignmentRight;
        _dj.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _dj;
}
- (UIView *)btnView{
    if (!_btnView) {
        _btnView = [[UIView alloc]initWithFrame:CGRectMake(0, _djL.bottom+[Unity countcoordinatesH:15], _backView.width, [Unity countcoordinatesH:30])];
        
        [_btnView addSubview:self.settlementBtn];
        [_btnView addSubview:self.detailBtn];
    }
    return _btnView;
}
- (UIButton *)settlementBtn{
    if (!_settlementBtn) {
        _settlementBtn = [[UIButton alloc]initWithFrame:CGRectMake(_btnView.width-[Unity countcoordinatesW:80], 0, [Unity countcoordinatesH:70], [Unity countcoordinatesH:30])];
        [_settlementBtn addTarget:self action:@selector(settlementClick) forControlEvents:UIControlEventTouchUpInside];
        _settlementBtn.backgroundColor = [Unity getColor:@"aa112d"];
        [_settlementBtn setTitle:@"委托单结算" forState:UIControlStateNormal];
        [_settlementBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _settlementBtn.layer.cornerRadius = _settlementBtn.height/2;
        _settlementBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _settlementBtn;
}
- (UIButton *)detailBtn{
    if (!_detailBtn) {
        _detailBtn = [[UIButton alloc]initWithFrame:CGRectMake(_btnView.width-[Unity countcoordinatesW:160], 0, [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_detailBtn addTarget:self action:@selector(detailClick) forControlEvents:UIControlEventTouchUpInside];
        [_detailBtn setTitle:@"商品详情" forState:UIControlStateNormal];
        [_detailBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        _detailBtn.layer.cornerRadius = _detailBtn.height/2;
        _detailBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _detailBtn.layer.borderColor = LabelColor9.CGColor;
        _detailBtn.layer.borderWidth = 1;
    }
    return _detailBtn;
}
- (void)configWithData:(NSDictionary *)dic{
    [self viewShow:dic[@"advance_rate"] WithStatus:[dic[@"order_bid_status_id"] intValue]];
    self.dj.text = [NSString stringWithFormat:@"%@RMB",dic[@"add_amount_all"]];
    self.numberL.text = [NSString stringWithFormat:@"案件编号 %@",dic[@"order_code"]];
    self.statusL.text = [Unity getStatus:dic[@"order_bid_status_id"]];
    self.goodsTitle.text = dic[@"goods_name"];
//    if ([dic[@"goods_img"] isKindOfClass:[NSArray class]]) {
//        [self.icon sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"Loading"]];
//    }else{
//        NSArray * arr = [dic[@"goods_img"] allKeys];
        [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[Unity get_image:dic[@"goods_img"]]]] placeholderImage:[UIImage imageNamed:@"Loading"]];
//    }
    self.goodsNum.text = [NSString stringWithFormat:@"x%@",dic[@"bid_num"]];
    self.placeLabel.text = [NSString stringWithFormat:@"%@%@",dic[@"over_price"],dic[@"currency"]];
    self.bidPlace.text = [NSString stringWithFormat:@"%@%@",dic[@"over_price"],dic[@"currency"]];
    self.endOfTime.text = dic[@"over_time_ch"];
    
    NSString * sta = @"";
    if ([dic[@"bid_mode"] intValue] == 2) {//结标前出价
          sta = @"结标前出价";
    }else{//立即出价
        sta = @"立即出价";
    }
    self.offerL.frame = CGRectMake(_goodsTitle.left, _goodsTitle.bottom+[Unity countcoordinatesH:7], 20+[Unity widthOfString:sta OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:20]], [Unity countcoordinatesH:20]);
    self.offerL.layer.cornerRadius = [Unity countcoordinatesH:10];
    self.offerL.layer.masksToBounds = YES;
    self.offerL.text = sta;
    
    if ([dic[@"bid_account"] isEqualToString:@""]) {
        self.account.text = @"";
    }else{
        if ([dic[@"currency"] isEqualToString:@"円"]) {
            self.account.text = [NSString stringWithFormat:@"%@/雅虎显示%@",dic[@"bid_account"],dic[@"w_signal"]];
        }else{
            self.account.text = [NSString stringWithFormat:@"%@/易贝显示%@",dic[@"bid_account"],dic[@"w_signal"]];
        }
        
    }
    self.highestBid.text = [NSString stringWithFormat:@"%@%@",dic[@"price_user"],dic[@"currency"]];
}
- (void)viewShow:(NSString *)show WithStatus:(NSInteger)status{
    if ([show floatValue] == 0) {//不显示定金
        self.backView.frame = CGRectMake([Unity countcoordinatesW:10], 0, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:302]);
        self.djL.hidden = YES;
        self.dj.hidden = YES;
        self.btnView.frame = CGRectMake(0, _line2.bottom+[Unity countcoordinatesH:15], _backView.width, [Unity countcoordinatesH:30]);
        [self btnStatus:status];
    }else{
        [self btnStatus:status];
    }
}
- (void)btnStatus:(NSInteger)status{
    if (status == 115) {//详情 结算
        self.djL.text = @"定金已支付";
        btnStatus = 1;
        self.settlementBtn.hidden = NO;
        [self.settlementBtn setTitle:@"委托单结算" forState:UIControlStateNormal];
    }else if (status == 120 || status == 123 || status == 125 || status == 127){//详情 委托单详情
        btnStatus = 2;
        self.settlementBtn.hidden = NO;
        [self.settlementBtn setTitle:@"委托单详情" forState:UIControlStateNormal];
    }else if (status == 130){//详情 通知发货
        btnStatus = 3;
        self.settlementBtn.hidden = NO;
        [self.settlementBtn setTitle:@"通知发货" forState:UIControlStateNormal];
    }else{//详情 包裹详情
//        btnStatus = 4;
        self.settlementBtn.hidden = YES;
        self.detailBtn.frame = CGRectMake(_btnView.width-[Unity countcoordinatesW:80], 0, [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
//        [self.settlementBtn setTitle:@"包裹详情" forState:UIControlStateNormal];
    }
}
- (void)settlementClick{
    [self.delegate goodsSettlement:self WithTag:btnStatus];
}
- (void)detailClick{
    [self.delegate goodsDetailT:self];
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
