//
//  GoodsGridCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/12.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "GoodsGridCell.h"
#import "JYTimerUtil.h"
@interface GoodsGridCell()<JYTimerListener>
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UIImageView * icon;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UILabel * currentAmount;
@property (nonatomic , strong) UILabel * rmbL;
@property (nonatomic , strong) UILabel * patNum;
@property (nonatomic , strong) UILabel * rTime;
@property (nonatomic , strong) NSTimer * timer;
@end
@implementation GoodsGridCell
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        //kvo监听time值改变（解决cell滚动时内容不及时刷新的问题）
        [self addObserver:self forKeyPath:@"time" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [[JYTimerUtil sharedInstance] addListener:self];
        [self.contentView addSubview:self.backView];
    }
    return self;
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
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:5], [Unity countcoordinatesW:150], [Unity countcoordinatesH:235])];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 5;
        
        [_backView addSubview:self.icon];
        [_backView addSubview:self.titleL];
        [_backView addSubview:self.currentAmount];
        [_backView addSubview:self.rmbL];
//        [_backView addSubview:self.patNum];
//        [_backView addSubview:self.rTime];
    }
    return _backView;
}
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [Unity countcoordinatesW:150], [Unity countcoordinatesH:150])];
//        _icon.layer.cornerRadius =5;
        
        // 左上和右上为圆角
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:_icon.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
        cornerRadiusLayer.frame = _icon.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        _icon.layer.mask = cornerRadiusLayer;
        _icon.contentMode = UIViewContentModeScaleAspectFill;
        _icon.layer.masksToBounds= YES;
    }
    return _icon;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _icon.bottom+[Unity countcoordinatesH:5], _backView.width-[Unity countcoordinatesW:10], [Unity countcoordinatesH:30])];
//        _titleL.text = @"扫地机房大家发来就发两节课阿是的垃圾费阿里打飞机ADSL副科级ADSL费劲";
        _titleL.textColor = LabelColor3;
        _titleL.textAlignment = NSTextAlignmentLeft;
        _titleL.numberOfLines = 2;
        _titleL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _titleL;
}
- (UILabel *)currentAmount{
    if (!_currentAmount) {
        _currentAmount = [[UILabel alloc]initWithFrame:CGRectMake(_titleL.left, _titleL.bottom+[Unity countcoordinatesH:5], _titleL.width, [Unity countcoordinatesH:15])];
//        _currentAmount.text = @"当前价格:30000000.00円";
        _currentAmount.textColor = LabelColor9;
        _currentAmount.textAlignment = NSTextAlignmentLeft;
        _currentAmount.numberOfLines = 2;
        _currentAmount.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _currentAmount;
}
- (UILabel *)rmbL{
    if (!_rmbL) {
        _rmbL = [[UILabel alloc]initWithFrame:CGRectMake(_currentAmount.left, _currentAmount.bottom+[Unity countcoordinatesH:5], _currentAmount.width, _currentAmount.height)];
//        _rmbL.text = @"换算价格:1230000.00 RMB";
        _rmbL.textColor = [Unity getColor:@"aa112d"];
        _rmbL.textAlignment = NSTextAlignmentLeft;
        _rmbL.numberOfLines = 2;
        _rmbL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _rmbL;
}
- (UILabel *)patNum{
    if (!_patNum) {
        _patNum = [[UILabel alloc]initWithFrame:CGRectMake(_rmbL.left, _rmbL.bottom+[Unity countcoordinatesH:5], _rmbL.width, _rmbL.height)];
//        _patNum.text = @"竞拍次数:1";
        _patNum.textColor = LabelColor9;
        _patNum.textAlignment = NSTextAlignmentLeft;
        _patNum.numberOfLines = 2;
        _patNum.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _patNum;
}
- (UILabel *)rTime{
    if (!_rTime) {
        _rTime = [[UILabel alloc]initWithFrame:CGRectMake(_patNum.left, _patNum.bottom+[Unity countcoordinatesH:5], _patNum.width, _patNum.height)];
        _rTime.text = @"";
        _rTime.textColor = LabelColor9;
        _rTime.textAlignment = NSTextAlignmentLeft;
        _rTime.numberOfLines = 2;
        _rTime.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _rTime;
}
//- (void)config:(NSDictionary *)dic WithPlatform:(NSString *)platform{
////    NSLog(@"---%@",dic);
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
////将对象类型的时间转换为NSDate类型
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
//    NSString *nowStr = [Unity getCurrentTimeyyyymmdd];
//    // 计算时间差值
//    NSInteger secondsCountDown = [Unity getDateDifferenceWithNowDateStr:nowStr deadlineStr:currentDate];
//
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
//                        self.rTime.text = @"剩余时间:已结束";
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
@end
