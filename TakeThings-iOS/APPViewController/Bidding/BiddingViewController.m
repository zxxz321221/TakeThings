
//
//  BiddingViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/11.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "BiddingViewController.h"
#import "alertView.h"
#import "TrialViewController.h"
#import "UsTrialViewController.h"
#import "UIViewController+YINNav.h"
@interface BiddingViewController ()
{
    NSString * platForm;
}
@property (nonatomic , strong) UILabel * navLine;
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UILabel * webL;
@property (nonatomic , strong) UIButton * yahooBtn;
@property (nonatomic , strong) UIImageView * yahooImg;
@property (nonatomic , strong) UIButton * ebayBtn;
@property (nonatomic , strong) UIImageView * ebayImg;
@property (nonatomic , strong) UIButton * clearBtn;

@property (nonatomic , strong) UILabel * goodId;
@property (nonatomic , strong) UITextField * goodText;

@property (nonatomic , strong) UIButton * nextBtn;
@property (nonatomic , strong) alertView * aView;
@end

@implementation BiddingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.y_navBarBgColor = [UIColor whiteColor];
    platForm = @"0";
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [Unity getColor:@"f0f0f0"];
}
- (void)createUI{
    [self.view addSubview:self.navLine];
    [self.view addSubview:self.backView];
    [self.view addSubview:self.nextBtn];
}
- (UILabel *)navLine{
    if (!_navLine) {
        _navLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        _navLine.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _navLine;
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, [Unity countcoordinatesH:90])];
        _backView.backgroundColor = [UIColor whiteColor];
        
        [_backView addSubview:self.webL];
        [_backView addSubview:self.yahooBtn];
        [_backView addSubview:self.yahooImg];
        [_backView addSubview:self.ebayBtn];
        [_backView addSubview:self.ebayImg];
        
        [_backView addSubview:self.goodId];
        [_backView addSubview:self.goodText];
        [_backView addSubview:self.clearBtn];
    }
    return _backView;
}
- (UILabel *)webL{
    if (!_webL) {
        _webL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:20], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15])];
        _webL.text = @"选择网站:";
        _webL.textColor = LabelColor3;
        _webL.font = [UIFont systemFontOfSize:FontSize(14)];
        [_webL sizeToFit];
    }
    return _webL;
}
- (UIButton *)yahooBtn{
    if (!_yahooBtn) {
        _yahooBtn = [[UIButton alloc]initWithFrame:CGRectMake(_webL.right+[Unity countcoordinatesW:10], [Unity countcoordinatesH:20], [Unity countcoordinatesW:15], [Unity countcoordinatesW:15])];
        [_yahooBtn addTarget:self action:@selector(yahooClick:) forControlEvents:UIControlEventTouchUpInside];
        [_yahooBtn setBackgroundImage:[UIImage imageNamed:@"未选啊"] forState:UIControlStateNormal];
        [_yahooBtn setBackgroundImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
        _yahooBtn.selected = YES;
    }
    return _yahooBtn;
}
- (UIImageView *)yahooImg{
    if (!_yahooImg) {
        _yahooImg = [[UIImageView alloc]initWithFrame:CGRectMake(_yahooBtn.right+[Unity countcoordinatesW:10], [Unity countcoordinatesH:22.5], [Unity countcoordinatesW:50], [Unity countcoordinatesH:10])];
        _yahooImg.image = [UIImage imageNamed:@"雅虎"];
    }
    return _yahooImg;
}
- (UIButton *)ebayBtn{
    if (!_ebayBtn) {
        _ebayBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:220], [Unity countcoordinatesH:20], [Unity countcoordinatesW:15], [Unity countcoordinatesW:15])];
        [_ebayBtn addTarget:self action:@selector(ebayClick:) forControlEvents:UIControlEventTouchUpInside];
        [_ebayBtn setBackgroundImage:[UIImage imageNamed:@"未选啊"] forState:UIControlStateNormal];
        [_ebayBtn setBackgroundImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
    }
    return _ebayBtn;
}
- (UIImageView *)ebayImg{
    if (!_ebayImg) {
        _ebayImg = [[UIImageView alloc]initWithFrame:CGRectMake(_ebayBtn.right+[Unity countcoordinatesW:10], [Unity countcoordinatesH:20], [Unity countcoordinatesW:38], [Unity countcoordinatesH:15])];
        _ebayImg.image = [UIImage imageNamed:@"易贝"];
    }
    return _ebayImg;
}
- (UILabel *)goodId{
    if (!_goodId) {
        _goodId = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:55], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15])];
        _goodId.text = @"商品ID:";
        _goodId.textColor = LabelColor3;
        _goodId.font = [UIFont systemFontOfSize:FontSize(14)];
        [_goodId sizeToFit];
    }
    return _goodId;
}
- (UITextField *)goodText{
    if (!_goodText) {
        _goodText = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:120], _goodId.top, SCREEN_WIDTH-[Unity countcoordinatesW:154], [Unity countcoordinatesH:15])];
        _goodText.placeholder = @"请输入ID";
        _goodText.font = [UIFont systemFontOfSize:FontSize(14)];
        _goodText.textAlignment = NSTextAlignmentRight;
        _goodText.keyboardType = UIKeyboardTypeNamePhonePad;
    }
    return _goodText;
}
- (UIButton *)clearBtn{
    if (!_clearBtn) {
        _clearBtn = [[UIButton alloc]initWithFrame:CGRectMake(_goodText.right+[Unity countcoordinatesW:10], _goodText.top+[Unity countcoordinatesH:0.5], [Unity countcoordinatesW:14], [Unity countcoordinatesW:14])];
        [_clearBtn setBackgroundImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
        [_clearBtn addTarget:self action:@selector(clearClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _clearBtn;
}
- (UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _backView.bottom+[Unity countcoordinatesH:35], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        [_nextBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.layer.cornerRadius = _nextBtn.height/2;
        _nextBtn.layer.borderWidth =1 ;
        _nextBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
    }
    return _nextBtn;
}
- (alertView *)aView{
    if (!_aView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _aView = [alertView setAlertView:window];
    }
    return _aView;
}




- (void)yahooClick:(UIButton *)btn{
    if (!btn.selected) {
        platForm = @"0";
        btn.selected = YES;
        self.ebayBtn.selected = NO;
    }
}
- (void)ebayClick:(UIButton *)btn{
    if (!btn.selected) {
        platForm = @"5";
        btn.selected = YES;
        self.yahooBtn.selected = NO;
    }
}
- (void)nextClick{
    [self.goodText resignFirstResponder];
    [self requestData];
}

- (void)requestData{
    [Unity showanimate];
    NSDictionary *params = @{@"platform":platForm,@"item":self.goodText.text,@"os":@"1"};
    NSLog(@"详情参数  %@",params);
    [GZMrequest getWithURLString:[GZMUrl get_goodsDetail_url] parameters:params success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        NSLog(@"-------%@",data);
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            if ([platForm isEqualToString:@"0"]) {
                TrialViewController * tvc = [[TrialViewController alloc]init];
                tvc.platform = platForm;
                tvc.price = data[@"data"][@"goods"][@"Result"][@"Price"];
                tvc.goodsTitle = data[@"data"][@"goods"][@"Result"][@"Title"];
                tvc.imageUrl = data[@"data"][@"goods"][@"Result"][@"Img"][@"Image1"];
                tvc.taxRate = data[@"data"][@"goods"][@"Result"][@"TaxRate"];
                tvc.increment = [Unity getSmallestUnitOfBid:data[@"data"][@"goods"][@"Result"][@"Price"]];
                tvc.goodsID= data[@"data"][@"goods"][@"Result"][@"AuctionID"];
                tvc.bidorbuy = data[@"data"][@"goods"][@"Result"][@"Bidorbuy"];
                tvc.link = data[@"data"][@"goods"][@"Result"][@"AuctionItemUrl"];
                NSString * time = data[@"data"][@"goods"][@"Result"][@"EndTime"];
                NSArray *array = [time componentsSeparatedByString:@"+"];
                NSArray * array1 = [array[0] componentsSeparatedByString:@"T"];
                NSArray * array2 = [array1[0] componentsSeparatedByString:@"-"];
                tvc.endTime = [NSString stringWithFormat:@"%@/%@/%@ %@",array2[0],array2[1],array2[2],array1[1]];
                tvc.hidesBottomBarWhenPushed = YES;
                tvc.isDetail = NO;
                [self.navigationController pushViewController:tvc animated:YES];
            }else{
                UsTrialViewController * tvc = [[UsTrialViewController alloc]init];
                tvc.platform = platForm;
                tvc.price = data[@"data"][@"goods"][@"Item"][@"CurrentPrice"];
                tvc.goodsTitle = data[@"data"][@"goods"][@"Item"][@"Title"];
                tvc.imageUrl = [NSString stringWithFormat:@"%@",data[@"data"][@"goods"][@"Item"][@"PictureURL"][0]];;
                tvc.increment = [Unity getSmallestUnitOfBid:data[@"data"][@"goods"][@"Item"][@"CurrentPrice"] WithCount:data[@"data"][@"goods"][@"Item"][@"BidCount"]];
                tvc.goodsID = data[@"data"][@"goods"][@"Item"][@"ItemID"];
                tvc.bidorbuy = @"";
                NSString * time = data[@"data"][@"goods"][@"Item"][@"EndTime"];
                NSArray *array = [time componentsSeparatedByString:@"."];
                NSArray * array1 = [array[0] componentsSeparatedByString:@"T"];
                NSArray * array2 = [array1[0] componentsSeparatedByString:@"-"];
                NSDateFormatter *format = [[NSDateFormatter alloc] init];
                format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                NSString *timeStr = [NSString stringWithFormat:@"%@ %@",array1[0],array1[1]]; //将时间字符串默认当本地时区处理，转成NSDate时 -8，打印时再 +8
                format.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"]; //将时间字符串当utc处理，打印时根据本地时区自动打印 +8
                NSDate *utcDate = [format dateFromString:timeStr];  // Summary 2017-10-25 02:07:39 UTC
                NSString * ssss = [self getLocalDateFormateUTCDate:[format stringFromDate:utcDate]];
                NSArray * array10 = [ssss componentsSeparatedByString:@"-"];
                tvc.endTime = [NSString stringWithFormat:@"%@/%@/%@",array10[0],array10[1],array10[2]];
                tvc.hidesBottomBarWhenPushed = YES;
                tvc.isDetail = NO;
                tvc.link = data[@"data"][@"goods"][@"Item"][@"ViewItemURLForNaturalSearch"];
                [self.navigationController pushViewController:tvc animated:YES];
            }
            
        }else{
            self.aView.msgL.text = data[@"msg"];
            [self.aView showAlertView];
        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (NSString *)getLocalDateFormateUTCDate:(NSString *)utcStr {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    format.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSDate *utcDate = [format dateFromString:utcStr];
    format.timeZone = [NSTimeZone localTimeZone];
    NSString *dateString = [format stringFromDate:utcDate];
    return dateString;
}
- (void)clearClick{
    self.goodText.text = @"";
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
