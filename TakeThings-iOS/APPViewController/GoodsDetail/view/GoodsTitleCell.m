//
//  GoodsTitleCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/22.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "GoodsTitleCell.h"
@interface GoodsTitleCell()
{
    NSString * platform;
}
@property (nonatomic , strong) UIView * redView;
@property (nonatomic , strong) UILabel * timeL;//倒计时
@property (nonatomic , strong) UILabel * annotationL;//商品提醒
@property (nonatomic , strong) UILabel * goodsTitle;//商品标题
@property (nonatomic , strong) UILabel * offerL;//目前出价
@property (nonatomic , strong) UILabel * currencyL;//币种
@property (nonatomic , strong) UILabel * currentOffer;//当前出价
@property (nonatomic , strong) UILabel * RMBL;//人民币显示
@property (nonatomic , strong) UILabel * numberL;//竞拍人数
@property (nonatomic , strong) UILabel * winL;//当前赢标人
@property (nonatomic , strong) UILabel * taxL;//附加税

@property (nonatomic , strong) NSTimer * timer;

@end
@implementation GoodsTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self goodsTitleView];
    }
    return self;
}
- (void)goodsTitleView{
    [self addSubview:self.redView];
    [self.redView addSubview:self.timeL];
    [self addSubview:self.annotationL];
    [self addSubview:self.goodsTitle];
    [self addSubview:self.offerL];
    [self addSubview:self.currencyL];
    [self addSubview:self.currentOffer];
    [self addSubview:self.RMBL];
    
    for (int i=1; i<=2; i++) {
        UILabel * line = [Unity lableViewAddsuperview_superView:self _subViewFrame:CGRectMake(i*(SCREEN_WIDTH/3), self.RMBL.bottom+[Unity countcoordinatesH:15], 1, [Unity countcoordinatesH:15]) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentLeft];
        line.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    
    [self addSubview:self.numberL];
    [self addSubview:self.winL];
    [self addSubview:self.taxL];
}
- (UIView *)redView{
    if (!_redView) {
        _redView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        _redView.backgroundColor = [Unity getColor:@"#e5294c"];
        UILabel * label = [Unity lableViewAddsuperview_superView:_redView _subViewFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:15], [Unity countcoordinatesW:160], [Unity countcoordinatesH:20]) _string:@"离竞拍时间截止还剩下" _lableFont:[UIFont systemFontOfSize:FontSize(18)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
    }
    return _redView;
}
- (UILabel *)timeL{
    if (!_timeL) {
        _timeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:165], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:170], [Unity countcoordinatesH:30])];
        _timeL.text = @"";
        _timeL.textAlignment = NSTextAlignmentRight;
        _timeL.textColor = [UIColor whiteColor];
        _timeL.font = [UIFont systemFontOfSize:FontSize(30)];
    }
    return _timeL;
}
- (UILabel *)annotationL{
    if (!_annotationL) {
        _annotationL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _redView.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:10], [Unity countcoordinatesH:20])];
        _annotationL.text = @"提醒：倒计时可能存在误差，请及时刷新提前出价";
        _annotationL.textColor = LabelColor9;
        _annotationL.font = [UIFont systemFontOfSize:FontSize(12)];
        _annotationL.textAlignment = NSTextAlignmentLeft;
    }
    return _annotationL;
}
- (UILabel *)goodsTitle{
    if (!_goodsTitle) {
        _goodsTitle = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _annotationL.bottom+[Unity countcoordinatesH:12], SCREEN_WIDTH-[Unity countcoordinatesW:10], [Unity countcoordinatesH:40])];
        _goodsTitle.text = @"";
        _goodsTitle.textColor = LabelColor3;
        _goodsTitle.font = [UIFont systemFontOfSize:FontSize(16)];
        _goodsTitle.numberOfLines = 0;//表示label可以多行显示
    }
    return _goodsTitle;
}
- (UILabel *)offerL{
    if (!_offerL) {
        _offerL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _goodsTitle.bottom+[Unity countcoordinatesH:25], [Unity widthOfString:@"目前出价:" OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:20]], [Unity countcoordinatesH:20])];
        _offerL.text= @"目前出价:";
        _offerL.textColor = LabelColor6;
        _offerL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _offerL;
}
- (UILabel *)currencyL{
    if (!_currencyL) {
        _currencyL = [[UILabel alloc]initWithFrame:CGRectMake(_offerL.right, _goodsTitle.bottom+[Unity countcoordinatesH:25], [Unity widthOfString:@"日币" OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:20]], [Unity countcoordinatesH:20])];
        _currencyL.text= @"";
        _currencyL.textColor = [Unity getColor:@"#aa112d"];
        _currencyL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _currencyL;
}
- (UILabel *)currentOffer{
    if (!_currentOffer) {
        _currentOffer = [[UILabel alloc]initWithFrame:CGRectMake(_currencyL.right, _goodsTitle.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:200], [Unity countcoordinatesH:30])];
        _currentOffer.text = @"";
        _currentOffer.font = [UIFont systemFontOfSize:FontSize(34)];
        _currentOffer.textColor = [Unity getColor:@"#aa112d"];
    }
    return  _currentOffer;
}
- (UILabel *)RMBL{
    if (!_RMBL) {
        _RMBL = [[UILabel  alloc]initWithFrame:CGRectMake(_currencyL.left, _currencyL.bottom, [Unity countcoordinatesW:200], [Unity countcoordinatesH:15])];
        _RMBL.text = @"";
        _RMBL.textColor = LabelColor6;
        _RMBL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _RMBL;
}
- (UILabel *)numberL{
    if (!_numberL) {
        _numberL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], self.RMBL.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH/3-[Unity countcoordinatesW:5], [Unity countcoordinatesH:15])];
        _numberL.text = @"";
        _numberL.textColor = LabelColor3;
        _numberL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _numberL;
}
- (UILabel *)winL{
    if (!_winL) {
        _winL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, self.RMBL.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH/3, [Unity countcoordinatesH:15])];
        _winL.text = @"";
        
        _winL.textColor = LabelColor3;
        _winL.textAlignment = NSTextAlignmentCenter;
        _winL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _winL;
}
- (UILabel *)taxL{
    if (!_taxL) {
        _taxL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, self.RMBL.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH/3-[Unity countcoordinatesW:5], [Unity countcoordinatesH:15])];
        _taxL.text = @"附加税0%";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_taxL.text];
        [str addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0,3)];
        _taxL.textColor = LabelColor3;
        _taxL.attributedText = str;
        _taxL.textAlignment = NSTextAlignmentRight;
        _taxL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _taxL;
}
- (void)configWithDict:(NSDictionary *)dict WithPlaform:(NSString *)plaform{
    if (!dict || dict.count ==0) {
        return;
    }
    platform = plaform;
    if ([plaform isEqualToString:@"0"]) {
        NSString * bf = @"%";
        self.taxL.text = [NSString stringWithFormat:@"附加税%@%@",dict[@"goods"][@"Result"][@"TaxRate"],bf];
        self.currencyL.text = @"日币";
        self.goodsTitle.text = dict[@"goods"][@"Result"][@"Title"];
        self.currentOffer.text = [NSString stringWithFormat:@"%@元",dict[@"goods"][@"Result"][@"Price"]];
        self.RMBL.text = [NSString stringWithFormat:@"约人民币:%@元",[Unity configWithCurrentCurrency:@"jp" WithTargetCurrency:@"cn" WithAmount:dict[@"goods"][@"Result"][@"Price"]]];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"竞拍人数 %@",dict[@"goods"][@"Result"][@"Bids"]]];
        [str addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0,4)];
        self.numberL.attributedText = str;
        
        NSDictionary *zidian =dict[@"goods"][@"Result"][@"HighestBidders"];
        if([[zidian allKeys] containsObject:@"Bidder"]){
            //        NSLog(@"有");
//            NSLog(@"dict=%@",dict);
//            NSLog(@"%@",[dict[@"goods"][@"Result"][@"HighestBidders"][@"Bidder"] class]);
            NSMutableAttributedString * str1;
            if ([dict[@"goods"][@"Result"][@"HighestBidders"][@"Bidder"] isKindOfClass:[NSArray class]]) {
                 str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"当前赢标人 %@",dict[@"goods"][@"Result"][@"HighestBidders"][@"Bidder"][0][@"Id"]]];
                [str1 addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0,5)];
            }else if ([dict[@"goods"][@"Result"][@"HighestBidders"][@"Bidder"] isKindOfClass:[NSDictionary class]]){
                str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"当前赢标人 %@",dict[@"goods"][@"Result"][@"HighestBidders"][@"Bidder"][@"Id"]]];
                [str1 addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0,5)];
            }else{
                str1 = [[NSMutableAttributedString alloc] initWithString:@"当前赢标人 无"];
                [str1 addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0,5)];
            }
            
            _winL.attributedText = str1;
        }else{
            //        NSLog(@"没有 ");
            NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"当前赢标人 无"];
            [str1 addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0,5)];
            _winL.attributedText = str1;
        }
        NSString * time = dict[@"goods"][@"Result"][@"EndTime"];
        NSArray *array = [time componentsSeparatedByString:@"+"];
        NSLog(@"array:%@",array);
        NSArray * array1 = [array[0] componentsSeparatedByString:@"T"];
        NSLog(@"array1:%@",array1);
        time = [NSString stringWithFormat:@"%@ %@",array1[0],array1[1]];
        NSLog(@"time:%@",time);
        [self countdownWithCurrentDate:time];
    }else{
        self.currencyL.text = @"美金";
        self.goodsTitle.text = dict[@"goods"][@"Item"][@"Title"];
        self.currentOffer.text = [NSString stringWithFormat:@"%@元",dict[@"goods"][@"Item"][@"CurrentPrice"]];
        self.RMBL.text = [NSString stringWithFormat:@"约人民币:%@元",[Unity configWithCurrentCurrency:@"us" WithTargetCurrency:@"cn" WithAmount:dict[@"goods"][@"Item"][@"CurrentPrice"]]];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"竞拍人数 0"];
//        [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"竞拍人数 %@",dict[@"goods"][@"Result"][@"Bids"]]];
        [str addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0,4)];
        self.numberL.attributedText = str;
        
        NSDictionary *zidian =dict[@"goods"][@"Result"][@"HighestBidders"];
        if([[zidian allKeys] containsObject:@"Bidder"]){
            //        NSLog(@"有");
            NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"当前赢标人 %@",dict[@"goods"][@"Result"][@"HighestBidders"][@"Bidder"][@"Id"]]];
            [str1 addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0,5)];
            _winL.attributedText = str1;
        }else{
            //        NSLog(@"没有 ");
            NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"当前赢标人 无"];
            [str1 addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0,5)];
            _winL.attributedText = str1;
        }
        NSString * time = dict[@"goods"][@"Item"][@"EndTime"];
        NSArray *array = [time componentsSeparatedByString:@"."];
//        NSLog(@"array:%@",array);
        NSArray * array1 = [array[0] componentsSeparatedByString:@"T"];
//        NSLog(@"array1:%@",array1);
        time = [NSString stringWithFormat:@"%@ %@",array1[0],array1[1]];
//        NSLog(@"time:%@",time);
        [self countdownWithCurrentDate:time];
    }
    
}
- (void)countdownWithCurrentDate:(NSString *)currentDate{
    // 当前时间的时间戳
    NSString *nowStr = [Unity getCurrentTimeyyyymmdd];
    // 计算时间差值
    NSInteger secondsCountDown = [Unity getDateDifferenceWithNowDateStr:nowStr deadlineStr:currentDate];
    if ([platform isEqualToString:@"0"]) {
        [self daojishi:secondsCountDown-3600];
    }else{
        [self daojishi:secondsCountDown+28800];
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
//                NSLog(@"%ld",(long)timeout);
                if(timeout <= 0){ //  当倒计时结束时做需要的操作: 关闭 活动到期不能提交
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //倒计时结束
//                        NSLog(@"++++++++++++");
                        self.timeL.text = @"已结束";
                    });
                } else { // 倒计时重新计算 时/分/秒
                    NSInteger days = (int)(timeout/(3600*24));
                    NSInteger hours = (int)((timeout-days*24*3600)/3600);
                    NSInteger minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    NSInteger second = timeout - days*24*3600 - hours*3600 - minute*60;
                    NSString *strTime;
                        strTime = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hours+days*24, (long)minute, second];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.timeL.text = strTime;
                    });
                    timeout--; // 递减 倒计时-1(总时间以秒来计算)
                }
            });
            dispatch_resume(_timer);
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//{
//    code = success;
//    data =     {
//        content = "";
//        goods =         {
//            Ack = Success;
//            Build = "E1089_CORE_APILW_18879361_R1";
//            Item =             {
//                AutoPay = true;
//                BestOfferEnabled = false;
//                BidCount = 0;
//                ConvertedCurrentPrice = "31.99";
//                Country = US;
//                CurrentPrice = "31.99";
//                Description = "<html>\n<head>\n<title>adidas</title>\n</head>\n<body style=\"font-family: verdana,arial,sans-serif; font-size: 15px;\">\n<img>\n<table cellpadding=\"0\" cellspacing=\"0\" width=\"990\">\n  <tbody>\n    <tr>\n      <td width=\"100%\">\n      <div style=\"font-family: verdana,arial,sans-serif; font-size: 15px;\" align=\"left\">\n      <table style=\"width: 990px; height: 138px;\" border=\"0\"  cellpadding=\"0\" cellspacing=\"0\">\n\t<tbody>\n\t\t<tr>\n\t\t\t<td width=\"33%\"><div align=\"left\">\n\t\t\t</div>\n            </td>\n          </tr>\n          <tr>\n            <td colspan=\"3\"><br>\n            <div style=\"border-top: 1px solid rgb(224, 224, 224);\" align=\"center\"></div>\n            <div style=\"padding-left: 5px; font-size: 18px; font-weight: bold;\">\n\t\t\t\tadidas Nizza Hi Shoes Men's \n\t\t\t\t<br>\n            </div>\n            </td>\n          </tr>\n          <tr>\n            <td colspan=\"3\" rowspan=\"1\"></td>\n          </tr>\n        </tbody>\n      </table>\n      <img src=\"https://www.adidas.com/dw/image/v2/aaqx_prd/on/demandware.static/-/Sites-adidas-products/en_US/dw1ad515f2/zoom/CQ2366_00_plp_standard.jpg?sw=2000&sm=fit&t=EFV51\" style=\"max-height: 1200px; max-width: 600px;\">\n      <br>\n      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"80%\">\n        <tbody>\n          <tr>\n            <td colspan=\"3\">\n            <div align=\"left\">\n            <div style=\"font-size: 15px;\" align=\"left\"><br>\n            <br>\n            <table border=\"0\" cellpadding=\"0\" cellspacing=\"5\" width=\"990\">\n              <tbody>\n                <tr>\n                  <td colspan=\"1\">\n                  <div style=\"border-top: 1px solid rgb(224, 224, 224); padding-top: 5px; padding-bottom: 5px; padding-left: 0px; font-size: 15px; font-weight: bold;\" align=\"left\">\n\t\t\t\t  Features of the adidas Nizza Hi Shoes Men's \n\t\t\t\t  </div>\n                  </td>\n                </tr>\n                <tr>\n                  <td colspan=\"1\">\n                  <div align=\"left\">\n\t\t\t\t\t<ul>\n\t\t\t\t\t<li>Naturally breathable canvas upper</li>\n\t\t\t\t\t<li>Rubber toe bumper</li>\n\t\t\t\t\t\n\t\t\t\t\t\n\t\t\t\t\t\n\t\t\t\t\t<!--Additional feature can be added here-->\n\t\t\t\t\t\n\t\t\t\t\t\n                  </ul>\n                  </div>\n                  </td>\n                </tr>\n              </tbody>\n            </table>\n            <br>\n\t\t\t\n\t\t\t<div style=\"padding-left: 7px; padding-top: 5px; font-size: 15px;\" align=\"left\">\n\t\t\t\t<div style=\"border-top: 1px solid rgb(224, 224, 224); padding-top: 5px; padding-bottom: 5px; padding-left: 0px; font-size: 15px; font-weight: bold;\" align=\"left\">\n\t\t\t\tSize Chart:</div><br>\n\n\t\t\t\t\t<img src=\"https://i.ibb.co/48RpdwR/size-chart-adult-shoes.jpg\">\n\n\n\n\t\t\t\n            <div style=\"padding-left: 7px; padding-top: 5px; font-size: 15px;\" align=\"left\">\n\t\t\t\t<div style=\"border-top: 1px solid rgb(224, 224, 224); padding-top: 5px; padding-bottom: 5px; padding-left: 0px; font-size: 15px; font-weight: bold;\" align=\"left\">\n\t\t\t\t\tDescription of the adidas Nizza Hi Shoes Men's :</div><br>\n\t\t\t\t\tEndlessly stylish, born as a basketball shoe, the Nizza has become a go-to canvas streetwear sensation. Clean design lines combine with textured, naturally breathable canvas to create the signature look of these shoes. The high-walled vulc outsole provides classic cushioning.<br>\n\t\t\t\t<br>\n\t\t\t<div style=\"border-top: 1px solid rgb(224, 224, 224); padding-top: 5px; padding-bottom: 5px; padding-left: 0px; font-size: 15px; font-weight: bold;\" align=\"left\">Shipping</div>\n\t\t\t\t\t\t<p>Warehouse location Spartanburg, SC.<br />\n\t\t\t\t\t\tFREE SHIPPING with Standard Shipping (FedEx Ground or FedEx Home Delivery)<br />\n\t\t\t\t\t\tEstimated delivery: Within 10 business days of receiving a cleared payment</p>\t\n\t\t\t</div>\n\t\t\t\t<div style=\"border-top: 1px solid rgb(224, 224, 224); padding-top: 5px; padding-bottom: 5px; padding-left: 0px; font-size: 15px; font-weight: bold;\" align=\"left\">Return Policy</div>\n\t\t\t\t\t\t<p>FREE 30 DAY RETURNS<br />\n\t\t\t\t\t\tRefund will be given as Money Back<br />\n\t\t\t\t\t\tSeller Pays for return Shipping<br />\n\t\t\t\t\t\t</p>\n\t\t\t</div>\n\t\t\t\t<div style=\"border-top: 1px solid rgb(224, 224, 224); padding-top: 5px; padding-bottom: 5px; padding-left: 0px; font-size: 15px; font-weight: bold;\" align=\"left\">Shop Safe Guarantee</div>\n\t\t\t\t<br>We offer caring customer service and no hassle refunds. If for any reason you feel that you cannot leave positive feedback and 5 star ratings, please contact us within 30 days from the date of order for a return or refund. <br>\n\t\t\t\t<br>We are not satisfied until you are.<br><br>\n\t\t\t\t<div style=\"border-top: 1px solid rgb(224, 224, 224); padding-top: 5px; padding-bottom: 5px; padding-left: 0px; font-size: 15px; font-weight: bold;\"  align=\"left\">About Us</div>\n\t\t\t\t\t\t<p>ADIDAS SPORT:</p>\n\t\t\t\t\t\t<p>\n\t\t\t\t\t\tadidas Sport&nbsp;is mainly targeting competitive sports. The division's focus is primarily on innovation and technology. Target consumers range from sports participants at the highest level to those inspired by sport. Everything at adidas reflects the spirit of our founder Adi Dassler. His main objective back in those days already was to make athletes better, with innovation at the heart of all adidas Sport&nbsp;products. To underline our credibility as the multi-sport specialist and leverage brand strength, there is hardly any category that we don't produce products for. adidas is everywhere where the best meet the best, such as the FIFA World Cup, or the Olympic Games, but also everywhere else around the globe where sports are simply played, watched, enjoyed and celebrated.</p>\n\t\t\t\t\t\t<p>\n\t\t\t\t\t\tHowever, we are not just designing products for all kinds of sports. We are designing products for athletes. Athletes always strive for their personal best. Athletes find inspiration in sports no matter what they do. We help them to achieve their peak performance by making them faster, stronger, smarter and cooler.</p>\n\t\t\t\t\t\t<p>ADIDAS ORIGINALS:</p>\n\t\t\t\t\t\t<p>\n\t\t\t\t\t\tNo matter how serious you are about sports, a sporting lifestyle does not end in the locker room. This is why we have adidas Originals, our sub-brand that brings our iconic DNA from the courts to the streets. For well over a decade, it has been celebrating originality in a globally trendsetting way and, as the first brand leveraging its sports assets in the lifestyle area, it is regarded as a legitimate sports lifestyle brand. To ensure sustainable success, adidas Originals has to keep up to date with and set trends as well as remain committed to serving consumer groups who are constantly looking for more options to express their individuality.</p>\n\t\t\t</div>\n            </div>\n            </div>\n            </td>\n          </tr>\n        </tbody>\n      </table>\n      <br>\n      </div>\n      </td>\n    </tr>\n  </tbody>\n</table>\n</body>\n</html>";
//                DiscountPriceInfo =                 {
//                    PricingTreatment = STP;
//                };
//                EndTime = "2019-07-11T02:09:57.000Z";
//                ExcludeShipToLocation =                 (
//                                                         "US Protectorates",
//                                                         "APO/FPO",
//                                                         "PO Box"
//                                                         );
//                GlobalShipping = false;
//                HandlingTime = 3;
//                HitCount = 32573;
//                IntegratedMerchantCreditCardEnabled = false;
//                ItemID = 153522642789;
//                ItemSpecifics =                 {
//                    NameValueList =                     (
//                                                         {
//                                                             Name = "Restocking Fee";
//                                                             Value = No;
//                                                         },
//                                                         {
//                                                             Name = "All returns accepted";
//                                                             Value = "Returns Accepted";
//                                                         },
//                                                         {
//                                                             Name = "Item must be returned within";
//                                                             Value = "30 Days";
//                                                         },
//                                                         {
//                                                             Name = "Refund will be given as";
//                                                             Value = "Money Back";
//                                                         },
//                                                         {
//                                                             Name = "Return shipping will be paid by";
//                                                             Value = Seller;
//                                                         },
//                                                         {
//                                                             Name = Brand;
//                                                             Value = adidas;
//                                                         },
//                                                         {
//                                                             Name = Manufacturer;
//                                                             Value = adidas;
//                                                         },
//                                                         {
//                                                             Name = "Model Number";
//                                                             Value = EFV51;
//                                                         },
//                                                         {
//                                                             Name = Style;
//                                                             Value = "Hi Tops";
//                                                         }
//                                                         );
//                };
//                ListingStatus = Active;
//                ListingType = FixedPriceItem;
//                Location = "Spartanburg, South Carolina";
//                NewBestOffer = false;
//                PaymentMethods = PayPal;
//                PictureURL =                 (
//                                              "https://i.ebayimg.com/00/s/MTYwMFgxNjAw/z/k6EAAOSwCtJc1fdH/$_1.JPG?set_id=880000500F",
//                                              "https://i.ebayimg.com/00/s/MTYwMFgxNjAw/z/mbAAAOSwNeNc1fdI/$_1.JPG?set_id=880000500F",
//                                              "https://i.ebayimg.com/00/s/MTYwMFgxNjAw/z/G24AAOSw2S9c1fdI/$_1.JPG?set_id=880000500F",
//                                              "https://i.ebayimg.com/00/s/MTYwMFgxNjAw/z/8HgAAOSwwyVc1fdI/$_1.JPG?set_id=880000500F",
//                                              "https://i.ebayimg.com/00/s/MTYwMFgxNjAw/z/N70AAOSwFuBc1fdI/$_1.JPG?set_id=880000500F",
//                                              "https://i.ebayimg.com/00/s/MTYwMFgxNjAw/z/WGIAAOSw68hc1fdI/$_1.JPG?set_id=880000500F",
//                                              "https://i.ebayimg.com/00/s/MTYwMFgxNjAw/z/NcIAAOSwh8dc1fdI/$_1.JPG?set_id=880000500F",
//                                              "https://i.ebayimg.com/00/s/MTYwMFgxNjAw/z/yasAAOSwd5xc1fdH/$_1.JPG?set_id=880000500F"
//                                              );
//                PostalCode = 29301;
//                PrimaryCategoryID = 15709;
//                PrimaryCategoryIDPath = "11450:93427:15709";
//                PrimaryCategoryName = "Clothing, Shoes & Accessories:Men's Shoes:Athletic Shoes";
//                Quantity = 1144;
//                QuantityAvailableHint = Limited;
//                QuantitySold = 892;
//                QuantitySoldByPickupInStore = 0;
//                ReturnPolicy =                 {
//                    Refund = "Money Back";
//                    ReturnsAccepted = "Returns Accepted";
//                    ReturnsWithin = "30 Days";
//                    ShippingCostPaidBy = Seller;
//                };
//                SKU = EFV51;
//                SecondaryCategoryID = 24087;
//                SecondaryCategoryIDPath = "11450:93427:24087";
//                SecondaryCategoryName = "Clothing, Shoes & Accessories:Men's Shoes:Casual Shoes";
//                Seller =                 {
//                    FeedbackRatingStar = RedShooting;
//                    FeedbackScore = 159020;
//                    PositiveFeedbackPercent = "95.5";
//                    UserID = "adidas_official";
//                };
//                ShipToLocations = US;
//                Site = US;
//                StartTime = "2019-06-11T02:09:57.000Z";
//                Storefront =                 {
//                    StoreName = adidas;
//                    StoreURL = "https://stores.ebay.com/id=1536260425";
//                };
//                Subtitle = "Official adidas eBay Store - Free Returns";
//                TimeLeft = P22DT1H2M43S;
//                Title = "adidas Nizza Hi Shoes Men's ";
//                ViewItemURLForNaturalSearch = "https://www.ebay.com/itm/adidas-Nizza-Hi-Shoes-Mens-/153522642789?var=";
//            };
//            Timestamp = "2019-06-19T01:07:14.870Z";
//            Version = 1089;
//        };
//    };
//    msg = "获取商品信息成功。";
//}
@end
