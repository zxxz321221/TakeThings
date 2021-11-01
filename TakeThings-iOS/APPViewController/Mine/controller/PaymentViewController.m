//
//  PaymentViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/7/8.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "PaymentViewController.h"
#import "paymentTpye.h"
@interface PaymentViewController ()<paymentTpyeDelegate>{
    NSInteger payIndex;
}
@property (nonatomic , strong) UIView * topView;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UILabel * placeL;

@property (nonatomic , strong) UIButton * paymentType;
@property (nonatomic , strong) UIImageView * paymentImg;
@property (nonatomic , strong) paymentTpye * tView;

@property (nonatomic , strong) UIButton * rechargeBtn;
@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.title = @"确认付款";
    self.view.backgroundColor = [Unity getColor:@"f0f0f0"];
}
- (void)createUI{
    [self.view addSubview:self.topView];
    [self.view addSubview:self.paymentType];
    [self.view addSubview:self.rechargeBtn];
}
- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:150])];
        _topView.backgroundColor = [UIColor whiteColor];
        
        [_topView addSubview:self.titleL];
        [_topView addSubview:self.placeL];
    }
    return _topView;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:20], 200, [Unity countcoordinatesH:15])];
        _titleL.text = @"付款金额(RMB)";
        _titleL.textColor = LabelColor3;
        _titleL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _titleL;
}
- (UILabel *)placeL{
    if (!_placeL) {
        _placeL = [[UILabel alloc]initWithFrame:CGRectMake(0, _titleL.bottom+[Unity countcoordinatesH:20], SCREEN_WIDTH, [Unity countcoordinatesH:55])];
        _placeL.text = [NSString stringWithFormat:@"%ld",(long)self.place];
        _placeL.textColor = LabelColor3;
        _placeL.textAlignment = NSTextAlignmentCenter;
        _placeL.font = [UIFont systemFontOfSize:FontSize(55)];
    }
    return _placeL;
}
- (UIButton *)paymentType{
    if (!_paymentType) {
        _paymentType = [[UIButton alloc]initWithFrame:CGRectMake(0, _topView.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        _paymentType.backgroundColor = [UIColor whiteColor];
        [_paymentType addTarget:self action:@selector(typeClick) forControlEvents:UIControlEventTouchUpInside];
        UILabel * typeL = [Unity lableViewAddsuperview_superView:_paymentType _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20]) _string:@"付款方式" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        typeL.backgroundColor = [UIColor clearColor];
        UIImageView * img = [Unity imageviewAddsuperview_superView:_paymentType _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:15], [Unity countcoordinatesH:20], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10]) _imageName:@"go" _backgroundColor:nil];
        img.backgroundColor = [UIColor clearColor];
        [_paymentType addSubview:self.paymentImg];
    }
    return _paymentType;
}
- (UIImageView *)paymentImg{
    if (!_paymentImg) {
        _paymentImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:105], [Unity countcoordinatesH:15], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
        _paymentImg.image = [UIImage imageNamed:@"unionPay"];
        _paymentImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _paymentImg;
}
- (void)typeClick{
    [self.tView showType];
}
- (paymentTpye *)tView{
    if (!_tView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _tView = [paymentTpye setPaymentType:window];
        _tView.delegate = self;
    }
    return _tView;
}
- (void)confirm:(NSInteger)index{
    if (index == 0) {
        self.paymentImg.image = [UIImage imageNamed:@"unionPay"];
    }else if (index == 1){
        self.paymentImg.image = [UIImage imageNamed:@"aliPay"];
    }else{
        self.paymentImg.image = [UIImage imageNamed:@"wechatPay"];
    }
    payIndex = index;
}
- (UIButton *)rechargeBtn{
    if (!_rechargeBtn) {
        _rechargeBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _paymentType.bottom+[Unity countcoordinatesH:35], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        [_rechargeBtn addTarget:self action:@selector(rechargeClick) forControlEvents:UIControlEventTouchUpInside];
        [_rechargeBtn setTitle:@"付款" forState:UIControlStateNormal];
        [_rechargeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rechargeBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
        _rechargeBtn.layer.cornerRadius = _rechargeBtn.height/2;
        _rechargeBtn.backgroundColor = [Unity getColor:@"#aa112d"];
    }
    return _rechargeBtn;
}
- (void)rechargeClick{
    
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
