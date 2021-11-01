//
//  EntrustHeaderCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/27.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "EntrustHeaderCell.h"
@interface EntrustHeaderCell()
{
    NSString * rete;//汇率
}
@property (nonatomic  , strong) UILabel * time;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UIImageView * goodsImg;
@property (nonatomic , strong) UILabel * CurrentPrice;//目前出价
@property (nonatomic , strong) UILabel * onePrice;//直购价
@property (nonatomic , strong) UILabel * increment;//出价增额
@property (nonatomic , strong) UIButton * incrementBtn;
@property (nonatomic , strong) UILabel * markingTime;//截标时间
@property (nonatomic , strong) UILabel * markL;//截标下面警告文字
@property (nonatomic , strong) UIView * line;

@property (nonatomic , strong) UILabel * highestBidL;//最高出价文本
@property (nonatomic , strong) UITextField * highestBidText;//输入框
@property (nonatomic , strong) UILabel * DwL;//单位
@property (nonatomic , strong) UILabel * rmbL;
@property (nonatomic , strong) UIView * line1;
@property (nonatomic , strong) UIImageView * pointImg;
@property (nonatomic , strong) UILabel * pointL;
@property (nonatomic , strong) UIView * line2;

@property (nonatomic , strong) NSTimer * timer;


@property (nonatomic , strong) UILabel * describeL;
@property (nonatomic , strong) UITextField * describeText;
@property (nonatomic , strong) UILabel * describeLine;
@property (nonatomic , strong) UILabel * describeMark;
@end
@implementation EntrustHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView) name:@"huoqujiaodian" object:nil];
    }
    return self;
}
- (void)setup{
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.titleL];
    [self.contentView addSubview:self.goodsImg];
    [self.contentView addSubview:self.CurrentPrice];
    [self.contentView addSubview:self.onePrice];
    [self.contentView addSubview:self.increment];
//    [self.contentView addSubview:self.incrementBtn];
    [self.contentView addSubview:self.markingTime];
    [self.contentView addSubview:self.markL];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.highestBidL];
    [self.contentView addSubview:self.highestBidText];
    [self.contentView addSubview:self.DwL];
    [self.contentView addSubview:self.rmbL];
    [self.contentView addSubview:self.line1];
    [self.contentView addSubview:self.pointImg];
    [self.contentView addSubview:self.pointL];
//    [self.contentView addSubview:self.describeL];
//    [self.contentView addSubview:self.describeText];
//    [self.contentView addSubview:self.describeLine];
//    [self.contentView addSubview:self.describeMark];
    [self.contentView addSubview:self.line2];
}
- (UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:36])];
        _time.text = @"";
        _time.textAlignment = NSTextAlignmentCenter;
        _time.textColor = [UIColor whiteColor];
        _time.backgroundColor = [Unity getColor:@"#e5294c"];
        _time.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _time;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _time.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        _titleL.text = @"";
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
        _goodsImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _goodsImg;
}
- (UILabel *)CurrentPrice{
    if (!_CurrentPrice) {
        _CurrentPrice = [[UILabel alloc]initWithFrame:CGRectMake(_goodsImg.right+[Unity countcoordinatesW:7], _goodsImg.top, [Unity countcoordinatesW:200], [Unity countcoordinatesH:15])];
        _CurrentPrice.text = @"";
        _CurrentPrice.textAlignment = NSTextAlignmentLeft;
        _CurrentPrice.textColor = LabelColor6;
        _CurrentPrice.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _CurrentPrice;
}
- (UILabel *)onePrice{
    if (!_onePrice) {
        _onePrice = [[UILabel alloc]initWithFrame:CGRectMake(_goodsImg.right+[Unity countcoordinatesW:7], _CurrentPrice.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:200], [Unity countcoordinatesH:15])];
        _onePrice.text = @"";
        _onePrice.textAlignment = NSTextAlignmentLeft;
        _onePrice.textColor = LabelColor6;
        _onePrice.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _onePrice;
}
- (UILabel *)increment{
    if (!_increment) {
        _increment = [[UILabel alloc]initWithFrame:CGRectMake(_goodsImg.right+[Unity countcoordinatesW:7], _onePrice.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:200], [Unity countcoordinatesH:15])];
        _increment.text = @"";
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
        _markingTime.text = @"";
        _markingTime.textAlignment = NSTextAlignmentLeft;
        _markingTime.textColor = LabelColor6;
        _markingTime.font = [UIFont systemFontOfSize:FontSize(14)];
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
    }
    return _markL;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]initWithFrame:CGRectMake(0, _markL.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        _line.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return _line;
}
- (UILabel *)highestBidL{
    if (!_highestBidL) {
        _highestBidL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:30])];
        _highestBidL.text = @"我的价格:";
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
    }
    return _highestBidText;
}
- (UILabel *)DwL{
    if (!_DwL) {
        _DwL = [[UILabel alloc]initWithFrame:CGRectMake(_highestBidText.right+[Unity countcoordinatesW:0], _highestBidText.top+[Unity countcoordinatesH:10], [Unity countcoordinatesW:25], [Unity countcoordinatesH:15])];
        _DwL.text = @"";
        _DwL.textAlignment = NSTextAlignmentRight;
        _DwL.textColor = [Unity getColor:@"#aa112d"];
        _DwL.font = [UIFont systemFontOfSize:14];
    }
    return _DwL;
}
- (UILabel *)rmbL{
    if (!_rmbL) {
        _rmbL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _highestBidL.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _rmbL.text = @"";
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
    }
    return _pointL;
}
- (UILabel *)describeL{
    if (!_describeL) {
        _describeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _pointL.bottom+[Unity countcoordinatesW:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _describeL.text = @"中文描述:";
        _describeL.textColor = LabelColor3;
        _describeL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _describeL;
}
- (UITextField *)describeText{
    if (!_describeText) {
        _describeText = [[UITextField alloc]initWithFrame:CGRectMake(_describeL.right, _describeL.top, [Unity countcoordinatesW:200], _describeL.height)];
        _describeText.textColor = LabelColor6;
        _describeText.font = [UIFont systemFontOfSize:FontSize(12)];
        _describeText.textAlignment = NSTextAlignmentRight;
        [_describeText addTarget:self action:@selector(describeText:) forControlEvents:UIControlEventEditingChanged];
    }
    return _describeText;
}
- (UILabel *)describeLine{
    if (!_describeLine) {
        _describeLine = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _describeL.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], 1)];
        _describeLine.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return _describeLine;
}
- (UILabel *)describeMark{
    if (!_describeMark) {
        _describeMark = [[UILabel alloc]initWithFrame:CGRectMake(_describeLine.left, _describeLine.bottom+[Unity countcoordinatesH:5], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _describeMark.text = @"请简单填写商品中文描述，方便管理您的投标商品";
        _describeMark.textColor = [Unity getColor:@"#aa112d"];
        _describeMark.textAlignment = NSTextAlignmentLeft;
        _describeMark.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _describeMark;
}
- (UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc]initWithFrame:CGRectMake(0, _pointL.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        _line2.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return _line2;
}





- (void)incrementClick{
    NSLog(@"出价增额后？");
    [self.delegate incrementBtn];
    
}

- (void)configWithGoodsName:(NSString *)goodsName WithPrice:(NSString *)price WithEndTime:(NSString *)endTime WithImageUrl:(NSString *)imageUrl WithIncrement:(NSString *)inc WithPlatform:(NSString *)platform WithBidorbuy:(NSString *)bidorbuy{
    
    if (goodsName.length>10) {
        self.describeText.placeholder = [goodsName substringWithRange:NSMakeRange(0,10)];
    }else{
        self.describeText.placeholder = goodsName;
    }
    if ([platform isEqualToString:@"0"]) {
//        self.markL.text = @"(此时间为日本时间，换算中国时间需减1小时)";
        self.DwL.text = @"円";
        NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"exrate"];
        CGFloat p = [price floatValue]+[inc floatValue];
        CGFloat rmb = [price floatValue]*[dic[@"w_tw_jp"] floatValue];
        rete = dic[@"w_tw_jp"];
        self.highestBidText.placeholder = [NSString stringWithFormat:@"%.2f",p];
        self.rmbL.text = [NSString stringWithFormat:@"合人民币%.2f元",rmb];
        self.titleL.text = goodsName;
        self.CurrentPrice.text = [NSString stringWithFormat:@"当前价格：%@円",price];
        NSArray * array = [endTime componentsSeparatedByString:@"/"];
        self.increment.text = [NSString stringWithFormat:@"最小价格单位：%@円",inc];
        self.incrementBtn.frame = CGRectMake(_goodsImg.right+[Unity countcoordinatesW:14]+[Unity widthOfString:_increment.text OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:15]],_increment.top+[Unity countcoordinatesH:1], [Unity countcoordinatesW:13], [Unity countcoordinatesH:13]);
        self.markingTime.text = [NSString stringWithFormat:@"结束时间：%@-%@-%@",array[0],array[1],array[2]];
        [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageUrl]] placeholderImage:[UIImage imageNamed:@"Loading"]];
        //    [self countdownWithCurrentDate:[NSString stringWithFormat:@"%@-%@-%@",array[0],array[1],array[2]]];
        
        NSString *deadlineStr = [NSString stringWithFormat:@"%@-%@-%@",array[0],array[1],array[2]];//结束时间
        // 当前时间的时间戳
        NSString *nowStr = [Unity getCurrentTimeyyyymmdd];
        // 计算时间差值
        NSInteger secondsCountDown = [Unity getDateDifferenceWithNowDateStr:nowStr deadlineStr:deadlineStr];
        [self daojishi:secondsCountDown-3600];
        if (bidorbuy == nil) {
            self.onePrice.hidden = YES;
        }else{
           self.onePrice.text = [NSString stringWithFormat:@"直购价：    %@円",bidorbuy];
        }
        
    }else{
        self.markL.hidden = YES;
//        self.pointImg.hidden= YES;
        self.pointL.hidden= YES;
        self.DwL.text = @"美元";
        NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"exrate"];
        CGFloat p = [price floatValue]+[inc floatValue];
        CGFloat rmb = [price floatValue]*[dic[@"w_tw_us"] floatValue];
        rete = dic[@"w_tw_us"];
        self.highestBidText.placeholder= [NSString stringWithFormat:@"%.2f",p];
        self.rmbL.text = [NSString stringWithFormat:@"合人民币%.2f元",rmb];
        self.titleL.text = goodsName;
        self.CurrentPrice.text = [NSString stringWithFormat:@"当前价格：%@美元",price];
        NSArray * array = [endTime componentsSeparatedByString:@"/"];
        self.increment.text = [NSString stringWithFormat:@"最小价格单位：%@美元",inc];
        self.incrementBtn.frame = CGRectMake(_goodsImg.right+[Unity countcoordinatesW:14]+[Unity widthOfString:_increment.text OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:15]],_increment.top+[Unity countcoordinatesH:1], [Unity countcoordinatesW:13], [Unity countcoordinatesH:13]);
        self.markingTime.text = [NSString stringWithFormat:@"结束时间：%@-%@-%@",array[0],array[1],array[2]];
        [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageUrl]] placeholderImage:[UIImage imageNamed:@"Loading"]];
        
        NSString *deadlineStr = [NSString stringWithFormat:@"%@-%@-%@",array[0],array[1],array[2]];//结束时间
        // 当前时间的时间戳
        NSString *nowStr = [Unity getCurrentTimeyyyymmdd];
        // 计算时间差值
        NSInteger secondsCountDown = [Unity getDateDifferenceWithNowDateStr:nowStr deadlineStr:deadlineStr];
        [self daojishi:secondsCountDown];
        self.onePrice.hidden =YES;
    }
    
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
                if(timeout > 0){ // 倒计时重新计算 时/分/秒
                    NSInteger days = (int)(timeout/(3600*24));
                    NSInteger hours = (int)((timeout-days*24*3600)/3600);
                    NSInteger minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    NSInteger second = timeout - days*24*3600 - hours*3600 - minute*60;
                    NSString *strTime = [NSString stringWithFormat:@"剩余时间: %ld天%02ld小时%02ld分%02ld秒", (long)days,hours, minute, second];
                    dispatch_async(dispatch_get_main_queue(), ^{
//                        NSLog(@"%@",strTime);
                        self.time.text = strTime;
                    });
                    timeout--; // 递减 倒计时-1(总时间以秒来计算)
                } else {
                    //  当倒计时结束时做需要的操作: 关闭 活动到期不能提交
                    
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //                        weakSelf.timeLabel.text = @"";
//                        NSLog(@"当前活动已结束");
                        self.time.text = @"已结束";
                    });

                }
            });
            dispatch_resume(_timer);
        }
    }
}
- (void)highestBidText:(UITextField *)textField{
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"exrate"];
    CGFloat rmb = [textField.text floatValue]*[rete floatValue];
    self.rmbL.text = [NSString stringWithFormat:@"合人民币%.2f元",rmb];
    
    [self.delegate placeText:textField.text];
    
}
- (void)refreshTableView{
    [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:0.5];
    
    
}
- (void)delayMethod{
    [self.highestBidText becomeFirstResponder];
}
- (void)describeText:(UITextField *)textField{
    NSLog(@"%@",textField.text);
    if (textField.text.length > 10) {
        [WHToast showMessage:@"不能超过10个字" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
        self.describeText.text = [textField.text substringWithRange:NSMakeRange(0,10)];
    }
    [self.delegate descriText:self.describeText.text];
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
