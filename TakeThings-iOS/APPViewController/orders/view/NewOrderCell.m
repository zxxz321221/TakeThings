//
//  NewOrderCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/7.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "NewOrderCell.h"
#import "JYTimerUtil.h"
@interface NewOrderCell()<JYTimerListener>
{
    NSInteger btnStatus;//1 加价  2定金支付
    NSInteger btnStatus1;//1 砍单  2联系客服
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
@property (nonatomic , strong) UILabel * entrustTimeL;//委托时间
@property (nonatomic , strong) UILabel * entrustTime;
@property (nonatomic , strong) UILabel * endOfTimeL;//结标时间
@property (nonatomic , strong) UILabel * endOfTime;
@property (nonatomic , strong) UILabel * timeL;//时间
@property (nonatomic , strong) UILabel * line2;
@property (nonatomic , strong) UILabel * highestBidL;//最高出价
@property (nonatomic , strong) UILabel * highestBid;
@property (nonatomic , strong) UILabel * djL;//定金
@property (nonatomic , strong) UILabel * dj;
@property (nonatomic , strong) UIView * btnView;

@property (nonatomic , strong) UIButton * detailBtn;//详情
@property (nonatomic , strong) UIButton * cutBtn;//砍单
@property (nonatomic , strong) UIButton * confirmBtn;//1加价 2定金支付 3联系客服
@end
@implementation NewOrderCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //kvo监听time值改变（解决cell滚动时内容不及时刷新的问题）
        [self addObserver:self forKeyPath:@"newOrderCellTime" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [[JYTimerUtil sharedInstance] addListener:self];
        self.contentView.backgroundColor = [Unity getColor:@"f0f0f0"];
        [self.contentView addSubview:self.backView];
    }
    return self;
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:352])];
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
        [_backView addSubview:self.entrustTimeL];
        [_backView addSubview:self.entrustTime];
        [_backView addSubview:self.endOfTimeL];
        [_backView addSubview:self.endOfTime];
        [_backView addSubview:self.timeL];
        [_backView addSubview:self.line2];
        [_backView addSubview:self.highestBidL];
        [_backView addSubview:self.highestBid];
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
- (UILabel *)entrustTimeL{
    if (!_entrustTimeL) {
        _entrustTimeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _accountL.bottom, [Unity countcoordinatesW:80], [Unity countcoordinatesH:25])];
        _entrustTimeL.textColor = LabelColor3;
        _entrustTimeL.text = @"委托时间";
        _entrustTimeL.textAlignment = NSTextAlignmentLeft;
        _entrustTimeL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _entrustTimeL;
}
- (UILabel *)entrustTime{
    if (!_entrustTime) {
        _entrustTime = [[UILabel alloc]initWithFrame:CGRectMake(_entrustTimeL.right, _entrustTimeL.top, _backView.width-[Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _entrustTime.textColor = LabelColor6;
        _entrustTime.text = @"";
        _entrustTime.textAlignment = NSTextAlignmentRight;
        _entrustTime.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _entrustTime;
}
- (UILabel *)endOfTimeL{
    if (!_endOfTimeL) {
        _endOfTimeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _entrustTimeL.bottom, [Unity countcoordinatesW:80], [Unity countcoordinatesH:25])];
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
- (UILabel *)timeL{
    if (!_timeL) {
        _timeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _endOfTime.bottom, _backView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:25])];
        _timeL.text = @"";
        _timeL.textColor = LabelColor3;
        _timeL.textAlignment = NSTextAlignmentRight;
        _timeL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _timeL;
}
- (UILabel *)line2{
    if (!_line2) {
        _line2 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _timeL.bottom+[Unity countcoordinatesH:5], _backView.width-[Unity countcoordinatesW:10], 1)];
        _line2.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line2;
}
- (UILabel *)highestBidL{
    if (!_highestBidL) {
        _highestBidL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line2.bottom, [Unity countcoordinatesW:120], [Unity countcoordinatesH:30])];
        _highestBidL.textColor = LabelColor3;
        _highestBidL.text = @"最高出价";
        _highestBidL.textAlignment = NSTextAlignmentLeft;
        _highestBidL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _highestBidL;
}
- (UILabel *)highestBid{
    if (!_highestBid) {
        _highestBid = [[UILabel alloc]initWithFrame:CGRectMake(_highestBidL.right, _highestBidL.top, _backView.width-[Unity countcoordinatesW:140], [Unity countcoordinatesH:30])];
        _highestBid.textColor = [Unity getColor:@"#aa112d"];
        _highestBid.text = @"";
        _highestBid.textAlignment = NSTextAlignmentRight;
        _highestBid.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _highestBid;
}
- (UILabel *)djL{
    if (!_djL) {
        _djL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _highestBid.bottom, [Unity countcoordinatesW:120], [Unity countcoordinatesH:20])];
        _djL.textColor = LabelColor3;
        _djL.text = @"定金待支付";
        _djL.textAlignment = NSTextAlignmentLeft;
        _djL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _djL;
}
- (UILabel *)dj{
    if (!_dj) {
        _dj = [[UILabel alloc]initWithFrame:CGRectMake(_djL.right, _djL.top, _backView.width-[Unity countcoordinatesW:140], [Unity countcoordinatesH:20])];
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
        
        [_btnView addSubview:self.confirmBtn];
        [_btnView addSubview:self.cutBtn];
        [_btnView addSubview:self.detailBtn];
    }
    return _btnView;
}
- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(_btnView.width-[Unity countcoordinatesW:80], 0, [Unity countcoordinatesH:70], [Unity countcoordinatesH:30])];
        [_confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.backgroundColor = [Unity getColor:@"aa112d"];
        [_confirmBtn setTitle:@"加价" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmBtn.layer.cornerRadius = _confirmBtn.height/2;
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _confirmBtn;
}
- (UIButton *)cutBtn{
    if (!_cutBtn) {
        _cutBtn = [[UIButton alloc]initWithFrame:CGRectMake(_btnView.width-[Unity countcoordinatesW:160], 0, [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_cutBtn addTarget:self action:@selector(cutClick) forControlEvents:UIControlEventTouchUpInside];
        [_cutBtn setTitle:@"砍单" forState:UIControlStateNormal];
        [_cutBtn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
        _cutBtn.layer.cornerRadius = _cutBtn.height/2;
        _cutBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _cutBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        _cutBtn.layer.borderWidth = 1;
    }
    return _cutBtn;
}
- (UIButton *)detailBtn{
    if (!_detailBtn) {
        _detailBtn = [[UIButton alloc]initWithFrame:CGRectMake(_btnView.width-[Unity countcoordinatesW:240], 0, [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_detailBtn addTarget:self action:@selector(detailClick) forControlEvents:UIControlEventTouchUpInside];
        [_detailBtn setTitle:@"商品详情" forState:UIControlStateNormal];
        [_detailBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        _detailBtn.layer.cornerRadius = _cutBtn.height/2;
        _detailBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _detailBtn.layer.borderColor = LabelColor9.CGColor;
        _detailBtn.layer.borderWidth = 1;
    }
    return _detailBtn;
}
- (void)viewShow:(NSString *)show WithStatus:(NSInteger)status{
    if ([show floatValue] == 0) {//不显示定金
        self.backView.frame = CGRectMake([Unity countcoordinatesW:10], 0, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:332]);
        self.djL.hidden = YES;
        self.dj.hidden = YES;
        self.btnView.frame = CGRectMake(0, _highestBidL.bottom+[Unity countcoordinatesH:15], _backView.width, [Unity countcoordinatesH:30]);
        [self btnStatus:status];
    }else{
        [self btnStatus:status];
    }
}
- (void)btnStatus:(NSInteger)status{
    if (status == 10 || status == 40 || status == 70) {//详情 砍单 加价
        btnStatus = 1;
        btnStatus1 = 1;
        self.confirmBtn.hidden = NO;
        self.confirmBtn.frame = CGRectMake(_btnView.width-[Unity countcoordinatesW:80], 0, [Unity countcoordinatesH:70], [Unity countcoordinatesH:30]);
        self.cutBtn.frame = CGRectMake(_btnView.width-[Unity countcoordinatesW:160], 0, [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
        self.detailBtn.frame = CGRectMake(_btnView.width-[Unity countcoordinatesW:240], 0, [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
        [self.confirmBtn setTitle:@"加价" forState:UIControlStateNormal];
    }else if (status == 30){//详情 定金支付
        btnStatus = 2;
        btnStatus1 = 1;
        self.confirmBtn.hidden = NO;
        self.confirmBtn.frame = CGRectMake(_btnView.width-[Unity countcoordinatesW:80], 0, [Unity countcoordinatesH:70], [Unity countcoordinatesH:30]);
        self.cutBtn.frame = CGRectMake(_btnView.width-[Unity countcoordinatesW:160], 0, [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
        self.detailBtn.frame = CGRectMake(_btnView.width-[Unity countcoordinatesW:240], 0, [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
        [self.confirmBtn setTitle:@"定金支付" forState:UIControlStateNormal];
    }else{//详情 联系客服
        btnStatus1 = 2;
        self.cutBtn.frame = CGRectMake(_btnView.width-[Unity countcoordinatesW:80], 0, [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
        [self.cutBtn setTitle:@"联系客服" forState:UIControlStateNormal];
        self.confirmBtn.hidden = YES;
        self.detailBtn.frame = CGRectMake(_btnView.width-[Unity countcoordinatesW:160], 0, [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
    }
}
- (void)configWithData:(NSDictionary *)dic{
    [self viewShow:dic[@"advance_rate"] WithStatus:[dic[@"order_bid_status_id"] intValue]];
    self.dj.text = [NSString stringWithFormat:@"%@RMB",dic[@"add_amount_all"]];
    self.numberL.text = [NSString stringWithFormat:@"案件编号 %@",dic[@"order_code"]];
    self.statusL.text = [Unity getStatus:dic[@"order_bid_status_id"]];
    self.goodsTitle.text = dic[@"goods_name"];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[Unity get_image:dic[@"goods_img"]]]] placeholderImage:[UIImage imageNamed:@"Loading"]];
    self.goodsNum.text = [NSString stringWithFormat:@"x%@",dic[@"bid_num"]];
    self.placeLabel.text = [NSString stringWithFormat:@"%@%@",dic[@"over_price"],dic[@"currency"]];
    
    self.entrustTime.text = dic[@"create_time"];
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

-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"newOrderCellTime"];
    [[JYTimerUtil sharedInstance] removeListener:self];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self onTimer];
}

-(void)didOnTimer:(JYTimerUtil *)timerUtil timeInterval:(NSTimeInterval)timeInterval
{
    [self onTimer];
}
-(void)onTimer
{
    NSTimeInterval lefTime = [[JYTimerUtil sharedInstance] lefTimeInterval:self.time];
    //    NSLog(@"left%f",lefTime);
    if (lefTime>0) {
        NSInteger days = (int)(lefTime/(3600*24));
        NSInteger hours = (int)((lefTime-days*24*3600)/3600);
        NSInteger minute = (int)(lefTime-days*24*3600-hours*3600)/60;
//        NSInteger second = lefTime - days*24*3600 - hours*3600 - minute*60;
        self.timeL.text = [NSString stringWithFormat:@"%ld天%ld时%ld分",(long)days,(long)hours,minute];
    }else {
        self.timeL.text = @"已结束";
    }
}

- (void)confirmClick{
    [self.delegate goodsConfirm:self WithTag:btnStatus];
}
- (void)cutClick{
    [self.delegate goodsCut:self WithTag:btnStatus1];
}
- (void)detailClick{
    [self.delegate goodsDetail:self];
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
