//
//  GoodsListCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/12.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "GoodsListCell.h"
#import "JYTimerUtil.h"
@interface GoodsListCell()<JYTimerListener>
@property (nonatomic , strong) UIImageView * icon;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UILabel * currentAmount;
@property (nonatomic , strong) UILabel * rmbL;
@property (nonatomic , strong) UILabel * patNum;
@property (nonatomic , strong) UILabel * rTime;
@property (nonatomic , strong) UIView * line;

@property (nonatomic  , strong) NSTimer * timer;
@end
@implementation GoodsListCell
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        //kvo监听time值改变（解决cell滚动时内容不及时刷新的问题）
        [self addObserver:self forKeyPath:@"time" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [[JYTimerUtil sharedInstance] addListener:self];
        
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.currentAmount];
        [self.contentView addSubview:self.rmbL];
//        [self.contentView addSubview:self.patNum];
//        [self.contentView addSubview:self.rTime];
        [self.contentView addSubview:self.line];
    }
    return self;
}
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:5], [Unity countcoordinatesW:115], [Unity countcoordinatesH:115])];
        _icon.layer.cornerRadius = 5;
        _icon.contentMode = UIViewContentModeScaleAspectFill;
        _icon.layer.masksToBounds = YES;
    }
    return _icon;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(_icon.right+[Unity countcoordinatesW:5], _icon.top+[Unity countcoordinatesH:6], SCREEN_WIDTH-[Unity countcoordinatesW:130], [Unity countcoordinatesH:30])];
        _titleL.text = @"";
        _titleL.textColor = LabelColor3;
        _titleL.textAlignment = NSTextAlignmentLeft;
        _titleL.numberOfLines = 2;
        _titleL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _titleL;
}
- (UILabel *)currentAmount{
    if (!_currentAmount) {
        _currentAmount = [[UILabel alloc]initWithFrame:CGRectMake(_titleL.left, _titleL.bottom, _titleL.width, [Unity countcoordinatesH:15])];
        _currentAmount.text = @"";
        _currentAmount.textColor = LabelColor9;
        _currentAmount.textAlignment = NSTextAlignmentLeft;
        _currentAmount.numberOfLines = 2;
        _currentAmount.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _currentAmount;
}
- (UILabel *)rmbL{
    if (!_rmbL) {
        _rmbL = [[UILabel alloc]initWithFrame:CGRectMake(_currentAmount.left, _currentAmount.bottom, _currentAmount.width, _currentAmount.height)];
        _rmbL.text = @"";
        _rmbL.textColor = LabelColor9;
        _rmbL.textAlignment = NSTextAlignmentLeft;
        _rmbL.numberOfLines = 2;
        _rmbL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _rmbL;
}
- (UILabel *)patNum{
    if (!_patNum) {
        _patNum = [[UILabel alloc]initWithFrame:CGRectMake(_rmbL.left, _rmbL.bottom+[Unity countcoordinatesH:15], _rmbL.width, _rmbL.height)];
        _patNum.text = @"";
        _patNum.textColor = LabelColor9;
        _patNum.textAlignment = NSTextAlignmentLeft;
        _patNum.numberOfLines = 2;
        _patNum.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _patNum;
}
- (UILabel *)rTime{
    if (!_rTime) {
        _rTime = [[UILabel alloc]initWithFrame:CGRectMake(_patNum.left, _patNum.bottom, _patNum.width, _patNum.height)];
        _rTime.text = @"";
        _rTime.textColor = LabelColor9;
        _rTime.textAlignment = NSTextAlignmentLeft;
        _rTime.numberOfLines = 2;
        _rTime.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _rTime;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]initWithFrame:CGRectMake(_icon.right, self.contentView.height-1, SCREEN_WIDTH-[Unity countcoordinatesW:120], 1)];
        _line.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line;
}
-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"time"];
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
        NSInteger second = lefTime - days*24*3600 - hours*3600 - minute*60;
        self.rTime.text = [NSString stringWithFormat:@"剩余时间:%02ld天%02ld时%02ld分%02ld秒",(long)days,(long)hours,minute,second];
    }else {
        self.rTime.text = @"剩余时间:已结束";
    }
    [self.icon setImageWithURL:[NSURL URLWithString:self.imageUrl] placeholderImage:[UIImage imageNamed:@"Loading"]];
    self.titleL.text = self.goodTitle;
    if ([self.w_cc isEqualToString:@"0"]) {
        self.currentAmount.text = [NSString stringWithFormat:@"当前价格:%@円",self.currPlace];
        self.patNum.text = [NSString stringWithFormat:@"参与次数:%@",self.countNum];
        NSString * str = [NSString stringWithFormat:@"换算价格:%@RMB",[Unity configWithCurrentCurrency:@"jp" WithTargetCurrency:@"cn" WithAmount:self.currPlace]];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
        [attributedString addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0, 5)];
        self.rmbL.attributedText = attributedString;
    }else{
        self.currentAmount.text = [NSString stringWithFormat:@"当前价格:%@美元",self.currPlace];
        self.patNum.text = @"参与次数:0";
        //                [NSString stringWithFormat:@"竞拍次数:%@",dic[@"Bids"][@"0"]];
        NSString * str = [NSString stringWithFormat:@"换算价格:%@RMB",[Unity configWithCurrentCurrency:@"us" WithTargetCurrency:@"cn" WithAmount:self.currPlace]];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
        [attributedString addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0, 5)];
        self.rmbL.attributedText = attributedString;
    }
}
//- (void)config:(NSDictionary *)dic WithPlatform:(NSString *)platform{
//
//    [self.icon setImageWithURL:[NSURL URLWithString:dic[@"Image"][@"0"]] placeholderImage:[UIImage imageNamed:@"Loading"]];
//    self.titleL.text = dic[@"Title"][@"0"];
//    [self countdownWithCurrentDate:[self  getTimeFromTimestamp:dic[@"EndTime"]]];
//    if ([platform isEqualToString:@"0"]) {
//        self.currentAmount.text = [NSString stringWithFormat:@"当前价格:%@円",dic[@"CurrentPrice"][@"0"]];
//        self.patNum.text = [NSString stringWithFormat:@"竞拍次数:%@",dic[@"Bids"][@"0"]];
//        NSString * str = [NSString stringWithFormat:@"换算价格:%@RMB",[Unity configWithCurrentCurrency:@"jp" WithTargetCurrency:@"cn" WithAmount:dic[@"CurrentPrice"][@"0"]]];
//        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
//        [attributedString addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0, 5)];
//        self.rmbL.attributedText = attributedString;
//    }else{
//        self.currentAmount.text = [NSString stringWithFormat:@"当前价格:%@美元",dic[@"CurrentPrice"][@"0"]];
//        self.patNum.text = @"竞拍次数:0";
////        [NSString stringWithFormat:@"竞拍次数:%@",dic[@"Bids"][@"0"]];
//        NSString * str = [NSString stringWithFormat:@"换算价格:%@RMB",[Unity configWithCurrentCurrency:@"us" WithTargetCurrency:@"cn" WithAmount:dic[@"CurrentPrice"][@"0"]]];
//        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
//        [attributedString addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0, 5)];
//        self.rmbL.attributedText = attributedString;
//    }
//}
//#pragma mark ---- 将时间戳转换成时间
//
//- (NSString *)getTimeFromTimestamp:(NSString *)time1{
//    //将对象类型的时间转换为NSDate类型
//    double time =[time1 doubleValue];
//    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time];
//    //设置时间格式
//    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    //将时间转换为字符串
//    NSString * timeStr=[formatter stringFromDate:myDate];
//
//    return timeStr;
//
//}
//
//- (void)countdownWithCurrentDate:(NSString *)currentDate{
//    // 当前时间的时间戳
//    NSString *nowStr = [self getCurrentTimeyyyymmdd];
//    // 计算时间差值
//    NSInteger secondsCountDown = [self getDateDifferenceWithNowDateStr:nowStr deadlineStr:currentDate];
//    [self daojishi:secondsCountDown];
//}
//- (void)daojishi:(NSInteger)ss{
//    __weak __typeof(self) weakSelf = self;
//
//    if (_timer == nil) {
//        __block NSInteger timeout = ss; // 倒计时时间
//
//        if (timeout!=0) {
//            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//            dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC,  0); //每秒执行
//            dispatch_source_set_event_handler(_timer, ^{
//                if(timeout <= 0){ //  当倒计时结束时做需要的操作: 关闭 活动到期不能提交
//                    dispatch_source_cancel(_timer);
//                    _timer = nil;
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        //倒计时结束
//                    });
//                } else { // 倒计时重新计算 时/分/秒
//                    NSInteger days = (int)(timeout/(3600*24));
//                    NSInteger hours = (int)((timeout-days*24*3600)/3600);
//                    NSInteger minute = (int)(timeout-days*24*3600-hours*3600)/60;
//                    NSInteger second = timeout - days*24*3600 - hours*3600 - minute*60;
//                    NSString *strTime = [NSString stringWithFormat:@"剩余时间:%02ld天%02ld时%02ld分%02ld秒",days, hours, minute, second];
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        self.rTime.text = strTime;
//                    });
//                    timeout--; // 递减 倒计时-1(总时间以秒来计算)
//                }
//            });
//            dispatch_resume(_timer);
//        }
//    }
//}
///**
// *  获取当天的字符串
// *
// *  @return 格式为年-月-日 时分秒
// */
//- (NSString *)getCurrentTimeyyyymmdd {
//
//    NSDate *now = [NSDate date];
//    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
//    formatDay.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    NSString *dayStr = [formatDay stringFromDate:now];
//
//    return dayStr;
//}
///**
// *  获取时间差值  截止时间-当前时间
// *  nowDateStr : 当前时间
// *  deadlineStr : 截止时间
// *  @return 时间戳差值
// */
//- (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr {
//
//    NSInteger timeDifference = 0;
//
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yy-MM-dd HH:mm:ss"];
//    NSDate *nowDate = [formatter dateFromString:nowDateStr];
//    NSDate *deadline = [formatter dateFromString:deadlineStr];
//    NSTimeInterval oldTime = [nowDate timeIntervalSince1970];
//    NSTimeInterval newTime = [deadline timeIntervalSince1970];
//    timeDifference = newTime - oldTime;
//
//    return timeDifference;
//}
@end
