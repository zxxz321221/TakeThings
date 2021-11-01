//
//  PatCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/30.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "PatCell.h"
@interface PatCell()
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
@property (nonatomic , strong) UILabel * accountL;//出价账号文字
@property (nonatomic , strong) UILabel * account;//出价账号
@property (nonatomic , strong) UILabel * entrustTimeL;//委托时间
@property (nonatomic , strong) UILabel * entrustTime;
@property (nonatomic , strong) UILabel * endOfTimeL;//结标时间
@property (nonatomic , strong) UILabel * endOfTime;
@property (nonatomic , strong) UILabel * time;//时间
@property (nonatomic , strong) UILabel * line2;
@property (nonatomic , strong) UILabel * highestBidL;//最高出价
@property (nonatomic , strong) UILabel * highestBid;
@property (nonatomic , strong) UIButton * oriPage;//原始页面
@property (nonatomic , strong) UIButton * bargain;//砍单
@property (nonatomic , strong) UIButton * premium;//加价
//@property (nonatomic , strong) UIButton * readBtn;//编辑
@property (nonatomic , strong) UIButton * goodsBtn;

@property (nonatomic , strong) NSTimer * timer;
@property (nonatomic , strong) NSDictionary *dict;
@end

@implementation PatCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [self patCellView];
    }
    return self;
}
- (void)patCellView{
    [self.contentView addSubview:self.backView];
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:353])];
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
        [_backView addSubview:self.accountL];
        [_backView addSubview:self.account];
        [_backView addSubview:self.entrustTimeL];
        [_backView addSubview:self.entrustTime];
        [_backView addSubview:self.endOfTimeL];
        [_backView addSubview:self.endOfTime];
        [_backView addSubview:self.time];
        [_backView addSubview:self.line2];
        [_backView addSubview:self.highestBidL];
        [_backView addSubview:self.highestBid];
        [_backView addSubview:self.oriPage];
        [_backView addSubview:self.bargain];
        [_backView addSubview:self.premium];
        
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
        _numberL.font = [UIFont systemFontOfSize:FontSize(14)];
        _numberL.textAlignment = NSTextAlignmentLeft;
    }
    return _numberL;
}
- (UILabel *)statusL{
    if (!_statusL) {
        _statusL = [[UILabel alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:80], _numberL.top, [Unity countcoordinatesW:70], _numberL.height)];
//        _statusL.text = @"进行中";
        _statusL.textColor = [Unity getColor:@"f18e00"];
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
        _offerL = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitle.left, _goodsTitle.bottom+[Unity countcoordinatesH:7], [Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
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
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _goodsBtn.bottom, _backView.width-[Unity countcoordinatesW:10], 1)];
        _line1.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line1;
}
- (UILabel *)accountL{
    if (!_accountL) {
        _accountL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line1.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
        _accountL.textColor = LabelColor3;
        _accountL.text = @"出价账号";
        _accountL.textAlignment = NSTextAlignmentLeft;
        _accountL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _accountL;
}
- (UILabel *)account{
    if (!_account) {
        _account = [[UILabel alloc]initWithFrame:CGRectMake(_accountL.right, _accountL.top, _backView.width-[Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _account.textColor = LabelColor6;
        _account.text = @"";
        _account.textAlignment = NSTextAlignmentRight;
        _account.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _account;
}
- (UILabel *)entrustTimeL{
    if (!_entrustTimeL) {
        _entrustTimeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _accountL.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
        _entrustTimeL.textColor = LabelColor3;
        _entrustTimeL.text = @"委托时间";
        _entrustTimeL.textAlignment = NSTextAlignmentLeft;
        _entrustTimeL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _entrustTimeL;
}
- (UILabel *)entrustTime{
    if (!_entrustTime) {
        _entrustTime = [[UILabel alloc]initWithFrame:CGRectMake(_entrustTimeL.right, _entrustTimeL.top, _backView.width-[Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _entrustTime.textColor = LabelColor6;
        _entrustTime.text = @"";
        _entrustTime.textAlignment = NSTextAlignmentRight;
        _entrustTime.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _entrustTime;
}
- (UILabel *)endOfTimeL{
    if (!_endOfTimeL) {
        _endOfTimeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _entrustTimeL.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
        _endOfTimeL.textColor = LabelColor3;
        _endOfTimeL.text = @"结束时间";
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
- (UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _endOfTime.bottom+[Unity countcoordinatesH:10], _backView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _time.text = @"";
        _time.textColor = LabelColor3;
        _time.textAlignment = NSTextAlignmentRight;
        _time.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _time;
}
- (UILabel *)line2{
    if (!_line2) {
        _line2 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _time.bottom+[Unity countcoordinatesH:10], _backView.width-[Unity countcoordinatesW:10], 1)];
        _line2.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line2;
}
- (UILabel *)highestBidL{
    if (!_highestBidL) {
        _highestBidL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line2.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:120], [Unity countcoordinatesH:20])];
        _highestBidL.textColor = LabelColor3;
        _highestBidL.text = @"最高出价";
        _highestBidL.textAlignment = NSTextAlignmentLeft;
        _highestBidL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _highestBidL;
}
- (UILabel *)highestBid{
    if (!_highestBid) {
        _highestBid = [[UILabel alloc]initWithFrame:CGRectMake(_highestBidL.right, _highestBidL.top, _backView.width-[Unity countcoordinatesW:140], [Unity countcoordinatesH:20])];
        _highestBid.textColor = [Unity getColor:@"#aa112d"];
        _highestBid.text = @"";
        _highestBid.textAlignment = NSTextAlignmentRight;
        _highestBid.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _highestBid;
}
- (UIButton *)oriPage{
    if (!_oriPage) {
        _oriPage = [[UIButton alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:240], _highestBidL.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
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
- (UIButton *)bargain{
    if (!_bargain) {
        _bargain = [[UIButton alloc]initWithFrame:CGRectMake(_oriPage.right+[Unity countcoordinatesW:10], _highestBidL.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_bargain addTarget:self action:@selector(bargainClick) forControlEvents:UIControlEventTouchUpInside];
        //设置边框颜色
        _bargain.layer.borderColor = [[Unity getColor:@"#aa112d"] CGColor];
        //设置边框宽度
        _bargain.layer.borderWidth = 1.0f;
        [_bargain setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        [_bargain setTitle:@"砍单" forState:UIControlStateNormal];
        _bargain.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _bargain.layer.cornerRadius = [Unity countcoordinatesH:15];
        _bargain.layer.masksToBounds = YES;
    }
    return _bargain;
}
- (UIButton *)premium{
    if (!_premium) {
        _premium = [[UIButton alloc]initWithFrame:CGRectMake(_bargain.right+[Unity countcoordinatesW:10], _highestBidL.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_premium addTarget:self action:@selector(premiumClick) forControlEvents:UIControlEventTouchUpInside];
        _premium.backgroundColor = [Unity getColor:@"#aa112d"];
        [_premium setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_premium setTitle:@"加价" forState:UIControlStateNormal];
        _premium.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _premium.layer.cornerRadius = [Unity countcoordinatesH:15];
        _premium.layer.masksToBounds = YES;
    }
    return _premium;
}

- (void)configWithData:(NSDictionary *)dic{
    self.dict = dic;
    NSString * sta = @"";
    if ([dic[@"w_ykj"] isEqualToString:@"2"]) {
        sta = @"立即购买";
    }else{
        sta = @"结束前购买";
    }
    self.statusL.text = [Unity getState:[dic[@"w_state"] intValue] WithPage:1];
    self.offerL.frame = CGRectMake(_goodsTitle.left, _goodsTitle.bottom+[Unity countcoordinatesH:7], 20+[Unity widthOfString:sta OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:20]], [Unity countcoordinatesH:20]);
    self.offerL.layer.cornerRadius = [Unity countcoordinatesH:10];
    self.offerL.layer.masksToBounds = YES;
    self.offerL.text = sta;
    
    self.numberL.text = [NSString stringWithFormat:@"订单编号 %@/%@",dic[@"id"],dic[@"w_jpnid"]];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:dic[@"w_imgsrc"]] placeholderImage:[UIImage imageNamed:@"Loading"]];
    self.goodsTitle.text = dic[@"w_object"];
    self.goodsNum.text = [NSString stringWithFormat:@"x%@",dic[@"w_tbsl"]];
    if ([dic[@"w_cc"]isEqualToString:@"0"]) {
        self.goodsAmount.text = [NSString stringWithFormat:@"%@円",dic[@"w_maxpay_jp"]];
        // 当前时间的时间戳
        NSString *nowStr = [Unity getCurrentTimeyyyymmdd];
        // 计算时间差值
        NSInteger secondsCountDown = [Unity getDateDifferenceWithNowDateStr:nowStr deadlineStr:dic[@"w_overtime"]];
        [self daojishi:secondsCountDown-3600];
        self.highestBid.text = [NSString stringWithFormat:@"%@円",dic[@"w_maxpay_jp"]];
        if ([dic[@"w_biduser"] isEqualToString:@""]) {
            self.account.text = @"";
        }else{
            self.account.text = [NSString stringWithFormat:@"%@/雅虎显示%@",dic[@"w_biduser"],dic[@"w_signal"]];
        }
        
    }else{
        self.goodsAmount.text = [NSString stringWithFormat:@"%@美元",dic[@"w_maxpay_jp"]];
        self.highestBid.text = [NSString stringWithFormat:@"%@美元",dic[@"w_maxpay_jp"]];
        if ([dic[@"w_biduser"] isEqualToString:@""]) {
            self.account.text = @"";
        }else{
            self.account.text = [NSString stringWithFormat:@"%@/易贝显示%@",dic[@"w_biduser"],dic[@"w_signal"]];
        }
    }
    
    self.entrustTime.text = dic[@"w_ordertime"];
    self.endOfTime.text = dic[@"w_overtime"];
}
- (void)daojishi:(NSInteger)ss{
    __weak __typeof(self) weakSelf = self;
    
    if (_timer == nil) {
        __block NSInteger timeout = ss; // 倒计时时间
        
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC,  0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout <= 0){ //  当倒计时结束时做需要的操作: 关闭 活动到期不能提交
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //                        weakSelf.timeLabel.text = @"";
                        //                        NSLog(@"当前活动已结束");
                        self.time.text = @"已结束";
                    });
                } else { // 倒计时重新计算 时/分/秒
                    NSInteger days = (int)(timeout/(3600*24));
                    NSInteger hours = (int)((timeout-days*24*3600)/3600);
                    NSInteger minute = (int)(timeout-days*24*3600-hours*3600)/60;
//                    NSInteger second = timeout - days*24*3600 - hours*3600 - minute*60;
                    NSString *strTime = [NSString stringWithFormat:@"%ld天%02ld时%02ld分", (long)days,hours, minute];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.time.text = strTime;
                    });
                    timeout--; // 递减 倒计时-1(总时间以秒来计算)
                }
            });
            dispatch_resume(_timer);
        }
    }
}

- (void)oriPageClick{
    [self.delegate oriPage:self.dict];
}
- (void)bargainClick{
    [self.delegate bargain:self.dict with:self];
}
- (void)premiumClick{
    [self.delegate premium:self.dict  with:self];
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
