//
//  GoodsCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/15.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "GoodsCell.h"
@interface GoodsCell()
@property (nonatomic , strong) UIView * backV;
@property (nonatomic , strong) UIImageView * bgimg;
@property (nonatomic , strong) UIImageView * icon;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UILabel *titleLabel;//商品标题
@property (nonatomic , strong) UILabel * currPrice;//当前价格
@property (nonatomic , strong) UILabel * converPrice;//换算价格
@property (nonatomic , strong) UILabel * auctionNum;//竞拍次数
@property (nonatomic , strong) UILabel * remaiDay;//剩余天数
@property (nonatomic , strong) NSArray * dataArr;
@property (nonatomic , strong) NSDictionary * dict;

@property (nonatomic , strong) NSTimer * timer;

@end
@implementation GoodsCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [self loadGoodsView];
    }
    return self;
}
- (void)loadGoodsView{
    [self.contentView addSubview:self.backV];
    UIImageView * bgimg = [Unity imageviewAddsuperview_superView:_backV _subViewFrame:CGRectMake((_backV.width-[Unity countcoordinatesW:200])/2, [Unity countcoordinatesH:15],[Unity countcoordinatesW:200] , [Unity countcoordinatesH:10]) _imageName:@"brand_bgimg" _backgroundColor:nil];
    self.bgimg = bgimg;
    _titleL = [Unity lableViewAddsuperview_superView:_backV _subViewFrame:CGRectMake(0, [Unity countcoordinatesH:10], _backV.width, [Unity countcoordinatesH:20]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(17)] _lableTxtColor:[Unity getColor:@"#42146e"] _textAlignment:NSTextAlignmentCenter];
    
    for (int i=0; i<4; i++) {
        UIButton * btn = [Unity buttonAddsuperview_superView:_backV _subViewFrame:CGRectMake([Unity countcoordinatesW:15]+((i%2)*[Unity countcoordinatesW:135])+(i%2*[Unity countcoordinatesW:10]), _titleL.bottom+[Unity countcoordinatesH:10]+((i/2)*[Unity countcoordinatesH:205])+(i/2*[Unity countcoordinatesH:10]), [Unity countcoordinatesW:135], [Unity countcoordinatesH:205]) _tag:self _action:@selector(GoodsClick:) _string:@"" _imageName:nil];
        btn.tag = 1000+i;
        
        _icon = [Unity imageviewAddsuperview_superView:btn _subViewFrame:CGRectMake(0, 0, [Unity countcoordinatesW:135], [Unity countcoordinatesH:135]) _imageName:@"" _backgroundColor:[UIColor clearColor]];
        _icon.layer.cornerRadius = 10;
        _icon.contentMode = UIViewContentModeScaleAspectFill;
        _icon.layer.masksToBounds = YES;
        _icon.tag = 2000+i;
        
        _titleLabel = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake(0, _icon.bottom, _icon.width, [Unity countcoordinatesH:30]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.numberOfLines = 0;
        _titleLabel.preferredMaxLayoutWidth = _icon.width;
        _titleLabel.tag = 3000+i;
        
        _currPrice = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake(0, _titleLabel.bottom, _titleLabel.width, [Unity countcoordinatesH:15]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentLeft];
        _currPrice.tag = 4000+i;
        
        _converPrice = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake(0, _currPrice.bottom, _currPrice.width, _currPrice.height) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:[Unity getColor:@"#aa112d"] _textAlignment:NSTextAlignmentLeft];
        _converPrice.tag = 5000+i;
        
//        NSString * str = @"换算价格:2215元";
//        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
//        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(12)] range:NSMakeRange(0, 5)];
//        [attributedString addAttribute:NSForegroundColorAttributeName value:LabelColor3 range:NSMakeRange(0, 5)];
//         _converPrice.attributedText = attributedString;
        /*
        _auctionNum = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake(0, _converPrice.bottom, _converPrice.width, _converPrice.height) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentLeft];
        _auctionNum.tag = 6000+i;
        
        
        _remaiDay = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake(0, _auctionNum.bottom, _auctionNum.width, _auctionNum.height) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentLeft];
        _remaiDay.tag = 7000+i;
        */
        UIButton * moreBtn = [Unity buttonAddsuperview_superView:_backV _subViewFrame:CGRectMake((_backV.width-[Unity countcoordinatesW:100])/2, [Unity countcoordinatesH:475], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15]) _tag:self _action:@selector(moreClick) _string:@"查看更多>>" _imageName:nil];
        [moreBtn setTitleColor:[Unity getColor:@"#999999"] forState:UIControlStateNormal];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
    }
}
- (void)GoodsClick:(UIButton *)btn{
    NSLog(@"%ld",(long)btn.tag);
    //传入字典数据  btn-1000
    [self.delegate goodsCellData:self.dict[@"product"][btn.tag-1000]];
}
- (void)moreClick{
    [self.delegate goodsCellMore:self.dict];
}
- (UIView *)backV{
    if (_backV == nil) {
        _backV = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], 0, SCREEN_WIDTH-[Unity countcoordinatesW:10], [Unity countcoordinatesH:500])];
        _backV.layer.cornerRadius = 10;
        _backV.backgroundColor = [UIColor whiteColor];
    }
    return _backV;
}
- (void)configWithGoods:(NSDictionary *)dic{
    //0.创建队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    //1.创建GCD中的定时器
    /*
     第一个参数:创建source的类型 DISPATCH_SOURCE_TYPE_TIMER:定时器
     第二个参数:0
     第三个参数:0
     第四个参数:队列
     */
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //2.设置时间等
    /*
     第一个参数:定时器对象
     第二个参数:DISPATCH_TIME_NOW 表示从现在开始计时
     第三个参数:间隔时间 GCD里面的时间最小单位为 纳秒
     第四个参数:精准度(表示允许的误差,0表示绝对精准)
     */
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    //3.要调用的任务
    dispatch_source_set_event_handler(timer, ^{
        [self forData:dic];
    });
    
    //4.开始执行
    dispatch_resume(timer);
    
    //
    self.timer = timer;
}
- (void)forData:(NSDictionary *)dic{
    self.dict = dic;
    if (dic.count != 0) {
        self.dataArr = dic[@"product"];
        self.titleL.text = dic[@"a_title"];
        for (int i=0; i<self.dataArr.count; i++) {
            UIImageView * imageView = (UIImageView *)[self.contentView viewWithTag:2000+i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.dataArr[i][@"Image"][@"0"]] placeholderImage:[UIImage imageNamed:@"Loading"]];
            
            UILabel * titleLabel = (UILabel *)[self.contentView viewWithTag:3000+i];
            titleLabel.text = self.dataArr[i][@"Title"][@"0"];
            
            UILabel * currPrice = (UILabel *)[self.contentView viewWithTag:4000+i];
            currPrice.text = [NSString stringWithFormat:@"当前价格:%@円",self.dataArr[i][@"CurrentPrice"][@"0"]];
            
            UILabel * converPrice = (UILabel *)[self.contentView viewWithTag:5000+i];
            NSString * str = [NSString stringWithFormat:@"换算价格:%@RMB",[Unity configWithCurrentCurrency:@"jp" WithTargetCurrency:@"cn" WithAmount:self.dataArr[i][@"CurrentPrice"][@"0"]]];
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(12)] range:NSMakeRange(0, 5)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0, 5)];
            converPrice.attributedText = attributedString;
            
            UILabel * auctionNum = (UILabel *)[self.contentView viewWithTag:6000+i];
            auctionNum.text = [NSString stringWithFormat:@"参与次数:%@",self.dataArr[i][@"Bids"][@"0"]];
            
            UILabel * remaiDayL = (UILabel *)[self.contentView viewWithTag:7000+i];
            remaiDayL.text = [NSString stringWithFormat:@"剩余时间:%@",[self countdownWithCurrentDate:[self UTCDateFromTimeStamap:self.dataArr[i][@"EndTime"]]]];
        }
    }
}

-(NSDate *)UTCDateFromTimeStamap:(NSString *)timeStamap{
    NSTimeInterval timeInterval=[timeStamap doubleValue];
    //  /1000;传入的时间戳timeStamap如果是精确到毫秒的记得要/1000
    NSDate *UTCDate=[NSDate dateWithTimeIntervalSince1970:timeInterval];
    return UTCDate;
}
- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray new];
    }
    return _dataArr;
}
//倒计时
- (NSString * )countdownWithCurrentDate:(NSData *)currentDate{
    // 当前时间的时间戳
    NSData * nowStr = [self getCurrentTimeyyyymmdd];
//    NSLog(@"nostr%@end%@",nowStr,currentDate);

    return [self calcDaysFromBegin:nowStr end:currentDate];
}
- (NSString *) calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    
    NSTimeInterval time=[endDate timeIntervalSinceDate:beginDate];
    NSInteger days = (int)(time/(3600*24));
    NSInteger hours = (int)((time-days*24*3600)/3600);
    NSInteger minute = (int)(time-days*24*3600-hours*3600)/60;
    NSInteger second = time - days*24*3600 - hours*3600 - minute*60;
    NSString *strTime = [NSString stringWithFormat:@"%ld天%02ld时%02ld分%02ld秒", (long)days,hours, minute, second];
    if (days<=0 && hours<=0 && minute<=0 && second <=0) {
        return @"已结束";
    }
    return strTime;
    
}
/**
 *  获取当天的字符串
 *
 *  @return 格式为年-月-日 时分秒
 */
- (NSData *)getCurrentTimeyyyymmdd {
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    NSLog(@"now  %@",now);
//    NSString *dayStr = [formatDay stringFromDate:now];
    
    return now;
}
- (NSDictionary *)dict{
    if (!_dict) {
        _dict = [NSDictionary new];
    }
    return _dict;
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
