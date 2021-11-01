//
//  RechargeViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/10.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "RechargeViewController.h"
#import "Keyboard.h"
#import "paymentTpye.h"
#import "RechargeSuccess.h"
#import "RechargeFailure.h"
#import "AllPaySDK.h"
@interface RechargeViewController ()<UITextFieldDelegate,keyboardDelegate,paymentTpyeDelegate,RechargeSuccessDelegate>
{
    NSInteger payIndex;//0 银联  1 支付宝 2 微信支付   默认银联
}
@property (nonatomic,strong) UIView * backView;
@property (nonatomic , strong) UILabel * rechargeTL;
@property (nonatomic , strong) UITextField * placeText;
@property (nonatomic , strong) UILabel * rmbL;
@property (nonatomic , strong) UIView * line;

@property (nonatomic , strong) Keyboard * keyboard;

@property (nonatomic , strong) UIButton * paymentType;
@property (nonatomic , strong) UIImageView * paymentImg;

@property (nonatomic , strong) UIButton * rechargeBtn;
@property (nonatomic , strong) paymentTpye * tView;
@property (nonatomic , strong) RechargeSuccess * rView;
@property (nonatomic , strong) RechargeFailure * fView;
@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    payIndex = 0;
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.title = @"充值";
    self.view.backgroundColor = [Unity getColor:@"#f0f0f0"];
}
- (void)createUI{
    [self.view addSubview:self.backView];
    [self.view addSubview:self.paymentType];
    [self.view addSubview:self.rechargeBtn];
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:135])];
        _backView.backgroundColor = [UIColor whiteColor];
        [_backView addSubview:self.rechargeTL];
        [_backView addSubview:self.placeText];
        [_backView addSubview:self.rmbL];
        [_backView addSubview:self.line];
    }
    return _backView;
}
- (UILabel *)rechargeTL{
    if (!_rechargeTL) {
        _rechargeTL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:22], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15])];
        _rechargeTL.text = @"充值金额";
        _rechargeTL.textColor = LabelColor3;
        _rechargeTL.textAlignment = NSTextAlignmentLeft;
        _rechargeTL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _rechargeTL;
}
- (UITextField *)placeText{
    if (!_placeText) {
        _placeText = [[UITextField alloc]initWithFrame:CGRectMake(_rechargeTL.left, _rechargeTL.bottom+[Unity countcoordinatesH:27], [Unity countcoordinatesW:270], [Unity countcoordinatesH:50])];
//        _placeText.placeholder = @"请输入充值金额";
        _placeText.delegate = self;
        _placeText.font = [UIFont systemFontOfSize:FontSize(55)];
//        [_placeText setValue:[UIFont boldSystemFontOfSize:FontSize(20)] forKeyPath:@"_placeholderLabel.font"];
        _placeText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入充值金额" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:FontSize(20)],NSForegroundColorAttributeName:[Unity getColor:@"#999999"]}];
    }
    return _placeText;
}
- (UILabel *)rmbL{
    if (!_rmbL) {
        _rmbL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:10]-[Unity widthOfString:@"RMB" OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:15]], _placeText.top+[Unity countcoordinatesH:30], [Unity widthOfString:@"RMB" OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:15]], [Unity countcoordinatesH:15])];
        _rmbL.text = @"RMB";
        _rmbL.textColor = LabelColor6;
        _rmbL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _rmbL;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _placeText.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:1])];
        _line.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line;
}
- (UIButton *)paymentType{
    if (!_paymentType) {
        _paymentType = [[UIButton alloc]initWithFrame:CGRectMake(0, _backView.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        _paymentType.backgroundColor = [UIColor whiteColor];
        [_paymentType addTarget:self action:@selector(typeClick) forControlEvents:UIControlEventTouchUpInside];
        UILabel * typeL = [Unity lableViewAddsuperview_superView:_paymentType _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20]) _string:@"充值方式" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentLeft];
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
- (UIButton *)rechargeBtn{
    if (!_rechargeBtn) {
        _rechargeBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _paymentType.bottom+[Unity countcoordinatesH:35], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        [_rechargeBtn addTarget:self action:@selector(rechargeClick) forControlEvents:UIControlEventTouchUpInside];
        [_rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
        [_rechargeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rechargeBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
        _rechargeBtn.layer.cornerRadius = _rechargeBtn.height/2;
        _rechargeBtn.backgroundColor = [Unity getColor:@"#aa112d"];
    }
    return _rechargeBtn;
}


- (Keyboard *)keyboard{
    if (_keyboard == nil) {
        _keyboard = [Keyboard setKeyboard:self.view];
        _keyboard.delegate = self;
    }
    return _keyboard;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.keyboard hiddenKeyboard];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.keyboard showKeyboard];
    return NO;
}
- (void)keyboardKeys:(NSString *)keys{
    if ([keys isEqualToString:@"X"]) {
        self.placeText.text = @"";
    }else if ([keys isEqualToString:@"."]){
        NSArray *array = [self.placeText.text componentsSeparatedByString:@"."];
        if (array.count>=2) {
            return;
        }else{
            self.placeText.text = [self.placeText.text stringByAppendingString:keys];
        }
    }else if ([keys isEqualToString:@"-"]){
        if (self.placeText.text.length>0) {
            self.placeText.text =[self.placeText.text substringToIndex:self.placeText.text.length-1];
        }
    }else if ([keys isEqualToString:@"enter"]){
        [self.keyboard hiddenKeyboard];
    }else{
        self.placeText.text = [self.placeText.text stringByAppendingString:keys];
    }
}
- (void)typeClick{
//    [self.tView showType];
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
//充值
- (void)rechargeClick{
//    self.rView.amountL.text = @"5000.00";
//    [self.rView showRechargeSuccess];
//    self.fView.amountL.text = @"5000.00";
//    self.fView.msgL.text = @"转出账户余额不足";
//    [self.fView showRechargeFailure];
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    [Unity showanimate];
    NSDictionary * dic = @{@"customer":userInfo[@"member_id"],@"why":@"1",@"amount":self.placeText.text,@"type":@"UP",@"coin":@"CNY"};

    [GZMrequest postWithURLString:[GZMUrl get_recharge_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        NSLog(@"%@",data);
        if ([data[@"code"]isEqualToString:@"success"]) {
            [AllPaySDK pay:data[@"tn"] mode:YES scheme:@"com.dyh.shaogood.cn" ViewController:self onResult: ^(NSDictionary *resultDic) {
                if ([resultDic[@"state"] isEqualToString:@"success"]) {//支付成功
                    //更新余额
                    NSMutableDictionary * dict = [NSMutableDictionary new];
                    dict = [userInfo mutableCopy];
                    float balan = [userInfo[@"w_yk_tw"] floatValue]+[self.placeText.text floatValue];
                    [dict setObject:[NSString stringWithFormat:@"%.2f",balan] forKey:@"w_yk_tw"];
                    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"userInfo"];
    
                    self.rView.amountL.text = self.placeText.text;
                    [self.rView showRechargeSuccess];
                }else if ([resultDic[@"state"] isEqualToString:@"cancel"]){//用户手动取消时租房
                    [WHToast showMessage:@"取消支付" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
                }else{//支付失败
                    self.fView.amountL.text = self.placeText.text;
                    self.fView.msgL.text = resultDic[@"errorDetail"];
                    [self.fView showRechargeFailure];
                }
            }];
        }else{
            [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (RechargeSuccess *)rView{
    if (!_rView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _rView = [RechargeSuccess setRechrgeSuccess:window];
        _rView.delegate = self;
    }
    return _rView;
}
- (RechargeFailure *)fView{
    if (!_fView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _fView = [RechargeFailure setRechrgeFailure:window];
    }
    return _fView;
}
- (void)rechargeSuccessConfirm{
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate rechargeSuccReload];
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
