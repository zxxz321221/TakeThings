//
//  OrderPayViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/10.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "OrderPayViewController.h"
#import "PayWebViewController.h"
@interface OrderPayViewController ()
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) UILabel * line3;
@property (nonatomic , strong) UIImageView * icon;//商品图片
@property (nonatomic , strong) UILabel * goodsTitle;//商品标题
@property (nonatomic , strong) UILabel * goodsNum;//竞拍商品数量
@property (nonatomic , strong) UILabel * placeLabel;//商品价格
@property (nonatomic , strong) UILabel * offerL;//出价竞标
@property (nonatomic , strong) UILabel * line;
@property (nonatomic , strong) UILabel * currPlaceL;//当前价格
@property (nonatomic , strong) UILabel * currPlace;//
@property (nonatomic , strong) UILabel * bidPlaceL;//投标价格
@property (nonatomic , strong) UILabel * bidPlace;
@property (nonatomic , strong) UILabel * djL;//定金比例
@property (nonatomic , strong) UILabel * dj;
@property (nonatomic , strong) UILabel * rateL;//汇率
@property (nonatomic , strong) UILabel * rate;
@property (nonatomic , strong) UILabel * line1;
@property (nonatomic , strong) UILabel * djPayL;
@property (nonatomic , strong) UILabel * djPay;

@property (nonatomic , strong) UIView * bottomView;//底部View
@property (nonatomic , strong) UIButton * confirmPay;

@end

@implementation OrderPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"定金支付详情";
    [self createUI];
    
}
- (void)createUI{
    [self.view addSubview:self.line3];
    [self.view addSubview:self.icon];
    [self.view addSubview:self.goodsTitle];
    [self.view addSubview:self.goodsNum];
    [self.view addSubview:self.placeLabel];
    [self.view addSubview:self.offerL];
    [self.view addSubview:self.line];
    [self.view addSubview:self.currPlaceL];
    [self.view addSubview:self.currPlace];
    [self.view addSubview:self.bidPlaceL];
    [self.view addSubview:self.bidPlace];
    [self.view addSubview:self.djL];
    [self.view addSubview:self.dj];
    [self.view addSubview:self.rateL];
    [self.view addSubview:self.rate];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.djPayL];
    [self.view addSubview:self.djPay];
    [self.view addSubview:self.bottomView];
}
/**
 headerView  初始化控件
 */
- (UILabel *)line3{
    if (!_line3) {
        _line3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        _line3.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line3;
}
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:70])];
        //添加边框
        CALayer * layer = [_icon layer];
        layer.borderColor = [[Unity getColor:@"#e0e0e0"] CGColor];
        layer.borderWidth = 1.0f;
        _icon.contentMode = UIViewContentModeScaleAspectFit;
//        NSArray * arr = [NSArray new];
//        if (![self.dataDic[@"goods_img"] isKindOfClass:[NSDictionary class]]) {
//            arr = [[Unity dictionaryWithJsonString:self.dataDic[@"goods_img"]] allKeys];
            [_icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[Unity dictionaryWithJsonString:[Unity get_image:self.dataDic[@"goods_img"]]]]] placeholderImage:[UIImage imageNamed:@"Loading"]];
//        }else{
//            arr = [self.dataDic[@"goods_img"] allKeys];
//            [_icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.dataDic[@"goods_img"][arr[0]]]] placeholderImage:[UIImage imageNamed:@"Loading"]];
//        }
    }
    return _icon;
}
- (UILabel *)goodsTitle{
    if (!_goodsTitle) {
        _goodsTitle = [[UILabel alloc]initWithFrame:CGRectMake(_icon.right+[Unity countcoordinatesW:5], _icon.top, SCREEN_WIDTH-[Unity countcoordinatesW:125], [Unity countcoordinatesH:40])];
        _goodsTitle.numberOfLines = 0;
        _goodsTitle.textColor = LabelColor3;
        _goodsTitle.font = [UIFont systemFontOfSize:FontSize(14)];
        _goodsTitle.textAlignment = NSTextAlignmentLeft;
        _goodsTitle.text = self.dataDic[@"goods_name"];
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
        _goodsNum.text = [NSString stringWithFormat:@"x%@",self.dataDic[@"bid_num"]];
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
        
        NSString * sta = @"";
        if ([self.dataDic[@"bid_mode"] intValue] == 2) {//结标前出价
              sta = @"结标前出价";
        }else{//立即出价
            sta = @"立即出价";
        }
        _offerL.frame = CGRectMake(_goodsTitle.left, _goodsTitle.bottom+[Unity countcoordinatesH:7], 20+[Unity widthOfString:sta OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:20]], [Unity countcoordinatesH:20]);
        _offerL.layer.cornerRadius = [Unity countcoordinatesH:10];
        _offerL.layer.masksToBounds = YES;
        _offerL.text = sta;
    }
    return _offerL;
}
- (UILabel *)placeLabel{
    if (!_placeLabel) {
        _placeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitle.left, _goodsTitle.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:95], [Unity countcoordinatesH:20])];
        _placeLabel.textColor = LabelColor6;
        _placeLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _placeLabel.textAlignment = NSTextAlignmentRight;
        _placeLabel.text = [NSString stringWithFormat:@"%@%@",self.dataDic[@"over_price"],self.dataDic[@"currency"]];
    }
    return _placeLabel;
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(0, _icon.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, 1)];
        _line.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line;
}
- (UILabel *)currPlaceL{
    if (!_currPlaceL) {
        _currPlaceL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:80], [Unity countcoordinatesH:25])];
        _currPlaceL.textColor = LabelColor6;
        _currPlaceL.text = @"当前价格";
        _currPlaceL.textAlignment = NSTextAlignmentLeft;
        _currPlaceL.font = [UIFont systemFontOfSize:FontSize(14)];
        
    }
    return _currPlaceL;
}
- (UILabel *)currPlace{
    if (!_currPlace) {
        _currPlace = [[UILabel alloc]initWithFrame:CGRectMake(_currPlaceL.right, _currPlaceL.top, SCREEN_WIDTH-[Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _currPlace.textColor = LabelColor6;
        _currPlace.textAlignment = NSTextAlignmentRight;
        _currPlace.font = [UIFont systemFontOfSize:FontSize(14)];
        _currPlace.text = [NSString stringWithFormat:@"%@%@",self.dataDic[@"over_price"],self.dataDic[@"currency"]];
    }
    return _currPlace;
}
- (UILabel *)bidPlaceL{
    if (!_bidPlaceL) {
        _bidPlaceL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _currPlaceL.bottom, [Unity countcoordinatesW:80], [Unity countcoordinatesH:25])];
        _bidPlaceL.textColor = LabelColor6;
        _bidPlaceL.text = @"投标价格";
        _bidPlaceL.textAlignment = NSTextAlignmentLeft;
        _bidPlaceL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _bidPlaceL;
}
- (UILabel *)bidPlace{
    if (!_bidPlace) {
        _bidPlace = [[UILabel alloc]initWithFrame:CGRectMake(_bidPlaceL.right, _bidPlaceL.top, SCREEN_WIDTH-[Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _bidPlace.textColor = LabelColor6;
        _bidPlace.textAlignment = NSTextAlignmentRight;
        _bidPlace.font = [UIFont systemFontOfSize:FontSize(14)];
        _bidPlace.text = [NSString stringWithFormat:@"%@%@",self.dataDic[@"price_user"],self.dataDic[@"currency"]];
    }
    return _bidPlace;
}
- (UILabel *)djL{
    if (!_djL) {
        _djL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _bidPlaceL.bottom, [Unity countcoordinatesW:80], [Unity countcoordinatesH:25])];
        _djL.textColor = LabelColor6;
        _djL.text = @"定金比例";
        _djL.textAlignment = NSTextAlignmentLeft;
        _djL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _djL;
}
- (UILabel *)dj{
    if (!_dj) {
        _dj = [[UILabel alloc]initWithFrame:CGRectMake(_djL.right, _djL.top, SCREEN_WIDTH-[Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _dj.textColor = LabelColor6;
        _dj.textAlignment = NSTextAlignmentRight;
        _dj.font = [UIFont systemFontOfSize:FontSize(14)];
        NSString * str = @"%";
        _dj.text = [NSString stringWithFormat:@"%@%@",self.dataDic[@"advance_rate"],str];
    }
    return _dj;
}
- (UILabel *)rateL{
    if (!_rateL) {
        _rateL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _djL.bottom, [Unity countcoordinatesW:80], [Unity countcoordinatesH:25])];
        _rateL.textColor = LabelColor6;
        _rateL.text = @"汇率";
        _rateL.textAlignment = NSTextAlignmentLeft;
        _rateL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _rateL;
}
- (UILabel *)rate{
    if (!_rate) {
        _rate = [[UILabel alloc]initWithFrame:CGRectMake(_rateL.right, _rateL.top, SCREEN_WIDTH-[Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _rate.textColor = LabelColor6;
        _rate.text = self.dataDic[@"exchange_rate"];
        _rate.textAlignment = NSTextAlignmentRight;
        _rate.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _rate;
}
- (UILabel *)line1{
    if (!_line1) {
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, _rateL.bottom+[Unity countcoordinatesH:5], SCREEN_WIDTH, 1)];
        _line1.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line1;
}
- (UILabel *)djPayL{
    if (!_djPayL) {
        _djPayL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line1.bottom, [Unity countcoordinatesW:80], [Unity countcoordinatesH:40])];
        _djPayL.textColor = LabelColor3;
        _djPayL.text = @"待支付定金";
        _djPayL.textAlignment = NSTextAlignmentLeft;
        _djPayL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _djPayL;
}
- (UILabel *)djPay{
    if (!_djPay) {
        _djPay = [[UILabel alloc]initWithFrame:CGRectMake(_djPayL.right, _djPayL.top, SCREEN_WIDTH-[Unity countcoordinatesW:100], [Unity countcoordinatesH:40])];
        _djPay.textColor = [Unity getColor:@"aa112d"];
        _djPay.text = [NSString stringWithFormat:@"%@RMB",self.dataDic[@"add_amount_all"]];
        _djPay.textAlignment = NSTextAlignmentRight;
        _djPay.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _djPay;
}
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-[Unity countcoordinatesH:60]-NavBarHeight, SCREEN_WIDTH, [Unity countcoordinatesH:60])];
        _bottomView.backgroundColor = [UIColor whiteColor];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        label.backgroundColor = [Unity getColor:@"f0f0f0"];
        [_bottomView addSubview:label];
        [_bottomView addSubview:self.confirmPay];
    }
    return _bottomView;
}
- (UIButton *)confirmPay{
    if (!_confirmPay) {
        _confirmPay = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:35])];
        [_confirmPay addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
        _confirmPay.layer.cornerRadius = _confirmPay.height/2;
        _confirmPay.backgroundColor = [Unity getColor:@"aa112d"];
        [_confirmPay setTitle:@"付款" forState:UIControlStateNormal];
        [_confirmPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmPay.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _confirmPay;
}
/**
 支付
 */
- (void)payClick{
    NSDictionary * info = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSDictionary *  dic = @{@"login_token":info[@"token"],@"user":info[@"w_email"],@"bid_id":self.dataDic[@"id"],@"device_type":@"1",@"os":@"1",@"redirect_url":[NSString stringWithFormat:@"%@/shaogood/member/mybid-bid-b-test.php",[[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"]]};
    
    NSLog(@"%@",dic);
    [Unity showanimate];
    [GZMrequest postWithURLString:[GZMUrl get_newPay_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([data[@"status"] intValue] == 0) {
            PayWebViewController * pvc = [[PayWebViewController alloc]init];
            pvc.url = data[@"pay_url"];
            [self.navigationController pushViewController:pvc animated:YES];
        }else{
            [WHToast showMessage:data[@"mes"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
@end
