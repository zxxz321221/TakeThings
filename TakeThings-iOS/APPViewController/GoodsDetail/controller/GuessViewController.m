//
//  GuessViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/9/20.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "GuessViewController.h"

@interface GuessViewController ()
@property (nonatomic , strong) UIScrollView * scrollView;

@property (nonatomic , strong) UIView * oneView;
@property (nonatomic , strong) UILabel * timeL;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UIImageView * goodsImg;
@property (nonatomic , strong) UILabel * CurrentPrice;//目前出价
@property (nonatomic , strong) UILabel * onePrice;//直购价
@property (nonatomic , strong) UILabel * increment;//出价增额
@property (nonatomic , strong) UIButton * incrementBtn;
@property (nonatomic , strong) UILabel * markingTime;//截标时间
@property (nonatomic , strong) UILabel * markL;//截标下面警告文字

/**
 规则
 */
@property (nonatomic , strong) UIView * twoView;
@property (nonatomic  , strong) UIImageView * ruleImg;
@property (nonatomic , strong) UILabel * ruleL;
@property (nonatomic , strong) UIImageView * goImg;

@property (nonatomic , strong) UIView * threeView;
@property (nonatomic , strong) UILabel * highestBidL;//最高出价文本
@property (nonatomic , strong) UITextField * highestBidText;//输入框
@property (nonatomic , strong) UILabel * DwL;//单位
@property (nonatomic , strong) UILabel * rmbL;
@property (nonatomic , strong) UIView * line1;
@property (nonatomic , strong) UIImageView * pointImg;
@property (nonatomic , strong) UILabel * pointL;

/**
 积分view
 */
@property (nonatomic , strong) UIView * fourView;
@property (nonatomic , strong) UILabel * integralL;
@property (nonatomic , strong) UITextField * integralText;
@property (nonatomic , strong) UILabel * DwL1;//单位
@property (nonatomic , strong) UIView * line2;
@property (nonatomic , strong) UILabel * defL;//默认积分
@property (nonatomic , strong) UILabel * balanL;//剩余积分

@property (nonatomic , strong) UIButton * confirmBtn;

@property (nonatomic , strong) NSTimer * timer;
@end

@implementation GuessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"猜价委托单";
    self.view.backgroundColor = [Unity getColor:@"f0f0f0"];
    [self setupUI];
    
    [self requestSeleteGuess];
}
- (void)setupUI{
    _scrollView = [UIScrollView new];
//    _scrollView.delegate=self;
    _scrollView.showsVerticalScrollIndicator = FALSE;//垂直滚动条
    _scrollView.showsHorizontalScrollIndicator = FALSE;//水平滚动条
    
    [self.view addSubview:_scrollView];
    _scrollView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }//解决导航栏设置透明的情况下 scrollView发生偏移的问题：
    
    [self.scrollView addSubview:self.oneView];
    [self.scrollView addSubview:self.twoView];
//    [self.scrollView addSubview:self.twoView];
    [self.scrollView addSubview:self.threeView];
    [self.scrollView addSubview:self.fourView];
//    [self.scrollView addSubview:self.wkWebView];
    //
    //    /*将ui添加到scrollView数组中*/
//    [self.scrollView sd_addSubviews:@[self.cycleScrollView,self.topView,self.twoView,self.threeView,self.fourView,self.wkWebView]];
    
    // scrollview自动contentsize
    [self.scrollView setupAutoContentSizeWithBottomView:self.fourView bottomMargin:bottomH+10];
    
    [self.view addSubview:self.confirmBtn];
}
- (UIView *)oneView{
    if (!_oneView) {
        _oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:221])];
        _oneView.backgroundColor = [UIColor whiteColor];
        
        [_oneView addSubview:self.timeL];
        [_oneView addSubview:self.titleL];
        [_oneView addSubview:self.goodsImg];
        [_oneView addSubview:self.CurrentPrice];
        [_oneView addSubview:self.onePrice];
        [_oneView addSubview:self.increment];
        [_oneView addSubview:self.incrementBtn];
        [_oneView addSubview:self.markingTime];
        [_oneView addSubview:self.markL];
    }
    return _oneView;
}
- (UILabel *)timeL{
    if (!_timeL) {
        _timeL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:36])];
//        _timeL.text = @"1111";
        _timeL.textAlignment = NSTextAlignmentCenter;
        _timeL.textColor = [UIColor whiteColor];
        _timeL.backgroundColor = [Unity getColor:@"#e5294c"];
        _timeL.font = [UIFont systemFontOfSize:FontSize(16)];
        // 当前时间的时间戳
        NSString *nowStr = [Unity getCurrentTimeyyyymmdd];
        // 计算时间差值
        NSInteger secondsCountDown = [Unity getDateDifferenceWithNowDateStr:nowStr deadlineStr:self.countdown];
        if ([self.platform isEqualToString:@"0"]) {
            [self daojishi:secondsCountDown-3600];
        }else{
            [self daojishi:secondsCountDown];
        }
        
    }
    return _timeL;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _timeL.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        _titleL.text = self.goodsTitle;
        _titleL.font = [UIFont systemFontOfSize:FontSize(14)];
        _titleL.textColor = LabelColor6;
        _titleL.textAlignment = NSTextAlignmentLeft;
        _titleL.numberOfLines = 0;
    }
    return _titleL;
}
- (UIImageView *)goodsImg{
    if (!_goodsImg) {
        _goodsImg = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _titleL.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:90], [Unity countcoordinatesH:90])];
        [_goodsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.imageUrl]] placeholderImage:[UIImage imageNamed:@"Loading"]];
        _goodsImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _goodsImg;
}
- (UILabel *)CurrentPrice{
    if (!_CurrentPrice) {
        _CurrentPrice = [[UILabel alloc]initWithFrame:CGRectMake(_goodsImg.right+[Unity countcoordinatesW:7], _goodsImg.top, [Unity countcoordinatesW:200], [Unity countcoordinatesH:15])];
        if ([self.platform isEqualToString:@"0"]) {
            _CurrentPrice.text = [NSString stringWithFormat:@"目前价格: %@円",self.currentPrice];
        }else{
            _CurrentPrice.text = [NSString stringWithFormat:@"目前价格: %@美元",self.currentPrice];
        }
        _CurrentPrice.textAlignment = NSTextAlignmentLeft;
        _CurrentPrice.textColor = LabelColor6;
        _CurrentPrice.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _CurrentPrice;
}
- (UILabel *)onePrice{
    if (!_onePrice) {
        _onePrice = [[UILabel alloc]initWithFrame:CGRectMake(_goodsImg.right+[Unity countcoordinatesW:7], _CurrentPrice.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:200], [Unity countcoordinatesH:15])];
        _onePrice.textAlignment = NSTextAlignmentLeft;
        _onePrice.textColor = LabelColor6;
        _onePrice.font = [UIFont systemFontOfSize:FontSize(14)];
        if (self.price == nil) {
            _onePrice.hidden = YES;
        }else{
            if ([self.platform isEqualToString:@"0"]) {
                _onePrice.text = [NSString stringWithFormat:@"直购价：    %@円",self.price];
            }else{
                _onePrice.hidden = YES;
//                _onePrice.text = [NSString stringWithFormat:@"直购价：    %@美元",self.price];
            }
        }

    }
    return _onePrice;
}
- (UILabel *)increment{
    if (!_increment) {
        _increment = [[UILabel alloc]initWithFrame:CGRectMake(_goodsImg.right+[Unity countcoordinatesW:7], _onePrice.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:200], [Unity countcoordinatesH:15])];
        if ([self.platform isEqualToString:@"0"]) {
            _increment.text = [NSString stringWithFormat:@"最小价格单位: %@円",self.incrementStr];
        }else{
            _increment.text = [NSString stringWithFormat:@"最小价格单位: %@美元",self.incrementStr];
        }
        _increment.textAlignment = NSTextAlignmentLeft;
        _increment.textColor = LabelColor6;
        _increment.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _increment;
}
- (UIButton *)incrementBtn{
    if (!_incrementBtn) {
        _incrementBtn = [[UIButton alloc]initWithFrame:CGRectMake(_goodsImg.right+[Unity countcoordinatesW:14]+[Unity widthOfString:_increment.text OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:15]], _increment.top+[Unity countcoordinatesH:1], [Unity countcoordinatesW:13], [Unity countcoordinatesH:13])];
        [_incrementBtn setBackgroundImage:[UIImage imageNamed:@"?"] forState:UIControlStateNormal];
        [_incrementBtn addTarget:self action:@selector(incrementClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _incrementBtn;
}
- (UILabel *)markingTime{
    if (!_markingTime) {
        _markingTime = [[UILabel alloc]initWithFrame:CGRectMake(_goodsImg.right+[Unity countcoordinatesW:7], _increment.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:200], [Unity countcoordinatesH:15])];
//        _markingTime.text = @"jieshushijian";
        _markingTime.textAlignment = NSTextAlignmentLeft;
        _markingTime.textColor = LabelColor6;
        _markingTime.font = [UIFont systemFontOfSize:FontSize(14)];
        NSArray * array = [self.countdown componentsSeparatedByString:@"/"];
        _markingTime.text = [NSString stringWithFormat:@"结束时间：%@-%@-%@",array[0],array[1],array[2]];
    }
    return _markingTime;
}
- (UILabel *)markL{
    if (!_markL) {
        _markL = [[UILabel alloc]initWithFrame:CGRectMake(_goodsImg.right+[Unity countcoordinatesW:7], _markingTime.bottom, [Unity countcoordinatesW:203], [Unity countcoordinatesH:30])];
        _markL.text = @"(此时间为日本时间，换算中国时间需减1小时)";
        _markL.textAlignment = NSTextAlignmentLeft;
        _markL.textColor = LabelColor9;
        _markL.font = [UIFont systemFontOfSize:FontSize(12)];
        _markL.numberOfLines = 0;
        [_markL sizeToFit];
        if (![self.platform isEqualToString:@"0"]) {
            _markL.hidden = YES;
        }
    }
    return _markL;
}

- (UIView *)twoView{
    if (!_twoView) {
        _twoView = [[UIView alloc]initWithFrame:CGRectMake(0, _oneView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:30])];
//        _twoView.backgroundColor = [Unity getColor:@"e0e0e0"];
        [_twoView addSubview:self.ruleImg];
        [_twoView addSubview:self.ruleL];
        [_twoView addSubview:self.goImg];
    }
    return _twoView;
}
- (UIImageView *)ruleImg{
    if (!_ruleImg) {
        _ruleImg = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:8], [Unity countcoordinatesW:11], [Unity countcoordinatesH:14])];
        _ruleImg.image = [UIImage imageNamed:@"规则"];
    }
    return _ruleImg;
}
- (UILabel *)ruleL{
    if (!_ruleL) {
        _ruleL = [[UILabel alloc]initWithFrame:CGRectMake(_ruleImg.right+[Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:150], _twoView.height)];
        _ruleL.text = @"查看猜价游戏流程和规则";
        _ruleL.textColor = LabelColor3;
        _ruleL.font = [UIFont systemFontOfSize:FontSize(12)];
        _ruleL.textAlignment = NSTextAlignmentLeft;
    }
    return _ruleL;
}
- (UIImageView *)goImg{
    if (!_goImg) {
        _goImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:15], [Unity countcoordinatesH:10], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10])];
        _goImg.image = [UIImage imageNamed:@"go"];
    }
    return _goImg;
}

- (UIView *)threeView{
    if (!_threeView) {
        _threeView = [[UIView alloc]initWithFrame:CGRectMake(0, _twoView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:128])];
        _threeView.backgroundColor = [UIColor whiteColor];
        [_threeView addSubview:self.highestBidL];
        [_threeView addSubview:self.highestBidText];
        [_threeView addSubview:self.DwL];
        [_threeView addSubview:self.rmbL];
        [_threeView addSubview:self.line1];
        [_threeView addSubview:self.pointImg];
        [_threeView addSubview:self.pointL];
    }
    return _threeView;
}
- (UILabel *)highestBidL{
    if (!_highestBidL) {
        _highestBidL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:30])];
        _highestBidL.text = @"猜价金额:";
        _highestBidL.font = [UIFont systemFontOfSize:FontSize(18)];
        _highestBidL.textColor = LabelColor3;
    }
    return _highestBidL;
}
- (UITextField *)highestBidText{
    if (!_highestBidText) {
        _highestBidText = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:140], _highestBidL.top, [Unity countcoordinatesW:145], [Unity countcoordinatesH:30])];
        _highestBidText.textAlignment = NSTextAlignmentRight;
        _highestBidText.font = [UIFont systemFontOfSize:FontSize(29)];
        _highestBidText.textColor = [Unity getColor:@"#aa112d"];
        _highestBidText.keyboardType = UIKeyboardTypeNumberPad;
        [_highestBidText addTarget:self action:@selector(highestBidText:) forControlEvents:UIControlEventEditingChanged];
        //        [_highestBidText becomeFirstResponder];
        CGFloat p = [self.currentPrice floatValue]+[self.incrementStr floatValue];
        self.highestBidText.placeholder = [NSString stringWithFormat:@"%.2f",p];
    }
    return _highestBidText;
}
- (UILabel *)DwL{
    if (!_DwL) {
        _DwL = [[UILabel alloc]initWithFrame:CGRectMake(_highestBidText.right+[Unity countcoordinatesW:0], _highestBidText.top+[Unity countcoordinatesH:10], [Unity countcoordinatesW:25], [Unity countcoordinatesH:15])];
        if ([self.platform isEqualToString:@"0"]) {
            _DwL.text = @"円";
        }else{
            _DwL.text = @"美元";
        }
        _DwL.textAlignment = NSTextAlignmentRight;
        _DwL.textColor = [Unity getColor:@"#aa112d"];
        _DwL.font = [UIFont systemFontOfSize:14];
    }
    return _DwL;
}
- (UILabel *)rmbL{
    if (!_rmbL) {
        _rmbL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _highestBidL.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _rmbL.text = @"合人民币0.00元";
        _rmbL.textColor = LabelColor9;
        _rmbL.textAlignment = NSTextAlignmentRight;
        _rmbL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _rmbL;
}
- (UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc]initWithFrame:CGRectMake(_rmbL.left, _rmbL.bottom+[Unity countcoordinatesH:10], _rmbL.width, [Unity countcoordinatesH:1])];
        _line1.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return _line1;
}
- (UIImageView *)pointImg{
    if (!_pointImg) {
        _pointImg = [[UIImageView alloc]initWithFrame:CGRectMake(_line1.left, _line1.bottom+[Unity countcoordinatesH:11], [Unity countcoordinatesW:12], [Unity countcoordinatesH:12])];
        _pointImg.image = [UIImage imageNamed:@"!"];
        if (![self.platform isEqualToString:@"0"]) {
            _pointImg.hidden = YES;
        }
    }
    return _pointImg;
}
- (UILabel *)pointL{
    if (!_pointL) {
        _pointL = [[UILabel alloc]initWithFrame:CGRectMake(_pointImg.right+[Unity countcoordinatesW:5], _line1.bottom+[Unity countcoordinatesH:7], SCREEN_WIDTH-[Unity countcoordinatesW:50], [Unity countcoordinatesH:20])];
        _pointL.text = @"建议尾数多加111円 可增加约20%的机会";
        _pointL.textColor = [Unity getColor:@"#aa112d"];
        _pointL.textAlignment = NSTextAlignmentLeft;
        _pointL.font = [UIFont systemFontOfSize:FontSize(12)];
        if (![self.platform isEqualToString:@"0"]) {
            _pointL.hidden = YES;
        }
    }
    return _pointL;
}

- (UIView *)fourView{
    if (!_fourView) {
        _fourView = [[UIView alloc]initWithFrame:CGRectMake(0, _threeView.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:110])];
        _fourView.backgroundColor = [UIColor whiteColor];
        
        [_fourView addSubview:self.integralL];
        [_fourView addSubview:self.integralText];
        [_fourView addSubview:self.DwL1];
        [_fourView addSubview:self.line2];
        
        UILabel * jifenL = [Unity lableViewAddsuperview_superView:_fourView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], self.line2.bottom+[Unity countcoordinatesH:7], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15]) _string:@"账户默认积分:" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        UILabel * jifenL1 = [Unity lableViewAddsuperview_superView:_fourView _subViewFrame:CGRectMake(jifenL.left, jifenL.bottom+[Unity countcoordinatesH:7], jifenL.width, jifenL.height) _string:@"剩余积分:" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        jifenL1.backgroundColor = [UIColor clearColor];
        
        [_fourView addSubview:self.defL];
        [_fourView addSubview:self.balanL];
    }
    return _fourView;
}
- (UILabel *)integralL{
    if (!_integralL) {
        _integralL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:30])];
        _integralL.text = @"积分:";
        _integralL.font = [UIFont systemFontOfSize:FontSize(18)];
        _integralL.textColor = LabelColor3;
    }
    return _integralL;
}
- (UITextField *)integralText{
    if (!_integralText) {
        _integralText = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:140], _integralL.top, [Unity countcoordinatesW:145], [Unity countcoordinatesH:30])];
        _integralText.textAlignment = NSTextAlignmentRight;
        _integralText.font = [UIFont systemFontOfSize:FontSize(29)];
        _integralText.textColor = [Unity getColor:@"#aa112d"];
        _integralText.keyboardType = UIKeyboardTypeNumberPad;
        _integralText.placeholder = @"请输入积分";
//        [_integralText addTarget:self action:@selector(integralText:) forControlEvents:UIControlEventEditingChanged];
    }
    return _integralText;
}
- (UILabel *)DwL1{
    if (!_DwL1) {
        _DwL1 = [[UILabel alloc]initWithFrame:CGRectMake(_integralText.right+[Unity countcoordinatesW:0], _integralText.top+[Unity countcoordinatesH:10], [Unity countcoordinatesW:25], [Unity countcoordinatesH:15])];
        _DwL1.text = @"积分";
        _DwL1.textAlignment = NSTextAlignmentRight;
        _DwL1.textColor = [Unity getColor:@"#aa112d"];
        _DwL1.font = [UIFont systemFontOfSize:14];
    }
    return _DwL1;
}
- (UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _integralL.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:10], [Unity countcoordinatesH:1])];
        _line2.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return _line2;
}
- (UILabel *)defL{
    if (!_defL) {
        _defL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:100], _line2.bottom+[Unity countcoordinatesH:7], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15])];
        _defL.text = @"0";
        _defL.textColor = LabelColor6;
        _defL.font = [UIFont systemFontOfSize:FontSize(14)];
        _defL.textAlignment = NSTextAlignmentLeft;
    }
    return _defL;
}
- (UILabel *)balanL{
    if (!_balanL) {
        _balanL = [[UILabel alloc]initWithFrame:CGRectMake(_defL.left, _defL.bottom+[Unity countcoordinatesH:7], _defL.width, _defL.height)];
        _balanL.text = @"0";
        _balanL.textColor = [Unity getColor:@"aa112d"];
        _balanL.textAlignment = NSTextAlignmentLeft;
        _balanL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _balanL;
}
- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NavBarHeight-bottomH, SCREEN_WIDTH, bottomH)];
        [_confirmBtn addTarget:self action:@selector(guessClick) forControlEvents:UIControlEventTouchUpInside];
        CAGradientLayer *layerG = [CAGradientLayer layer];
        layerG.colors=@[(__bridge id)[Unity getColor:@"#aa112d"].CGColor,(__bridge id)[Unity getColor:@"#e5294c"].CGColor];
        layerG.startPoint = CGPointMake(0, 0.5);
        layerG.endPoint = CGPointMake(1, 0.5);
        layerG.frame = _confirmBtn.bounds;
        [_confirmBtn.layer addSublayer:layerG];
        [_confirmBtn setTitle:@"猜价" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
        
    }
    return _confirmBtn;
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
                        self.timeL.text = @"已结束";
                    });
                } else { // 倒计时重新计算 时/分/秒
                    NSInteger days = (int)(timeout/(3600*24));
                    NSInteger hours = (int)((timeout-days*24*3600)/3600);
                    NSInteger minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    NSInteger second = timeout - days*24*3600 - hours*3600 - minute*60;
                    NSString *strTime = [NSString stringWithFormat:@"剩余时间: %ld天%02ld小时%02ld分%02ld秒", (long)days,hours, minute, second];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //                        NSLog(@"%@",strTime);
                        self.timeL.text = strTime;
                    });
                    timeout--; // 递减 倒计时-1(总时间以秒来计算)
                }
            });
            dispatch_resume(_timer);
        }
    }
}
- (void)highestBidText:(UITextField *)textField{
    NSString * rete;
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"exrate"];
    if ([self.platform isEqualToString:@"0"]) {
        rete = dic[@"w_tw_jp"];
    }else{
        rete = dic[@"w_tw_us"];
    }
    CGFloat rmb = [textField.text floatValue]*[rete floatValue];
    self.rmbL.text = [NSString stringWithFormat:@"合人民币%.2f元",rmb];
}
- (void)guessClick{
    if ([self.highestBidText.text isEqualToString:@""]) {
        [WHToast showMessage:@"猜价金额不能为空" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
        return;
    }
    if ([self.integralText.text isEqualToString:@""]) {
        [WHToast showMessage:@"抵押积分不能为空" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
        return;
    }
    if ([self.integralText.text integerValue] % 100 != 0) {
        [WHToast showMessage:@"抵押积分必须是100的倍数" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
        return;
    }
    if ([self.integralText.text floatValue] > [self.balanL.text floatValue]) {
        [WHToast showMessage:@"积分余额不足" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
        return;
    }
    
    NSDictionary * info = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSString * type;
    if ([self.platform isEqualToString:@"0"]) {
        type = @"yahoo";
    }else{
        type = @"ebay";
    }
    NSDictionary * dic = @{@"user":info[@"w_email"],@"auction_id":self.goodId,@"goods_img":self.imageUrl,@"goods_name":self.goodsTitle,@"goods_url":self.link,@"type":type,@"user_point":self.integralText.text,@"user_price":self.highestBidText.text,@"old_price":self.currentPrice,@"auction_over_time":self.countdown};
    [Unity showanimate];
    [GZMrequest postWithURLString:[GZMUrl get_guessPrice_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([data[@"status"] intValue] == 0) {
            int i = [self.balanL.text intValue]-[self.integralText.text intValue];
            self.balanL.text = [NSString stringWithFormat:@"%d",i];
        }
        NSLog(@"%@",data);
        [WHToast showMessage:data[@"mes"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"请求失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
    }];
}
- (void)requestSeleteGuess{
    NSDictionary * info = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSLog(@"%@",info);
    NSDictionary * dic = @{@"user":info[@"w_email"],@"auction_id":self.goodId};
    [Unity showanimate];
    [GZMrequest postWithURLString:[GZMUrl get_seleteGuess_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        NSLog(@"%@",data);
        if ([data[@"status"] intValue]==0) {//已猜价
            [WHToast showMessage:data[@"mes"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            self.confirmBtn.userInteractionEnabled = NO;
            NSNumber * his = [NSNumber numberWithInteger:[data[@"data"][@"user_price"] integerValue]];
            NSNumber * ints = [NSNumber numberWithInteger:[data[@"data"][@"user_point"] integerValue]];
            self.highestBidText.text = [his stringValue];;
            self.integralText.text = [ints stringValue];;
            self.highestBidText.enabled = NO;
            self.integralText.enabled = NO;
            self.defL.text = [data[@"user_point"][@"base_point"] stringValue];
            self.balanL.text = [data[@"user_point"][@"point_val"] stringValue];
            
        }else{
            self.confirmBtn.userInteractionEnabled = YES;
            self.defL.text = [data[@"user_point"][@"base_point"] stringValue];
            self.balanL.text = [data[@"user_point"][@"point_val"] stringValue];
            
        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"请求失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
    
    }];
}
@end
