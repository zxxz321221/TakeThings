//
//  NewCashViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/8/2.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "NewCashViewController.h"
#import "CashWay.h"
#import "CashType.h"
#import "CashSuccess.h"
#import "CashFailure.h"
#import "PayPassWordView.h"
#import "AuthenticationViewController.h"
@interface NewCashViewController ()<CashWayDelegate,CashTypeDelegate,UITextFieldDelegate,PayPassWordViewDelegate,CashSuccessDelegate>
{
    NSString * tkWay;//退款原因
    NSString * tkType;//退款方式
    UIView * KeyView;
    BOOL isPass;
    NSString *password;
    UIView * passWordView;
    NSMutableArray * textMuArray;
}
@property (nonatomic , strong) UIScrollView * scrollView;
@property (nonatomic,strong) UIView * backView;
@property (nonatomic , strong) UILabel * cashTL;
@property (nonatomic , strong) UITextField * placeText;
@property (nonatomic , strong) UIButton * allBtn;
@property (nonatomic , strong) UILabel * rmbL;
@property (nonatomic , strong) UIView * line;

@property (nonatomic , strong) UIButton * cashWay;
@property (nonatomic , strong) UILabel * cashL;
@property (nonatomic , strong) UILabel * cashTypeL;

@property (nonatomic , strong) UIButton * cashChannel;
@property (nonatomic , strong) UIImageView * cashImg;

@property (nonatomic , strong) UIView * botView;
@property (nonatomic , strong) UITextField * textField;

@property (nonatomic , strong) UIButton * cashBtn;

@property (nonatomic , strong) CashWay * cView;
@property (nonatomic , strong) CashType * tView;
@property (nonatomic , strong) CashSuccess * sView;
@property (nonatomic , strong) CashFailure *fView;

@property (nonatomic,strong) UIView * maskView;
@end

@implementation NewCashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"退款";
    self.view.backgroundColor = [Unity getColor:@"f0f0f0"];
    // Do any additional setup after loading the view.
    password = @"";
    isPass=NO;
    [self creareUI];
    [self createKeyboard];
    [self inputPassWord];
}
- (void)creareUI{
    
    _scrollView = [UIScrollView new];
//    _scrollView.delegate=self;
    _scrollView.showsVerticalScrollIndicator = FALSE;//垂直滚动条
    _scrollView.showsHorizontalScrollIndicator = FALSE;//水平滚动条
    
    [self.view addSubview:_scrollView];
    _scrollView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }//解决导航栏设置透明的情况下 scrollView发生偏移的问题：
    
    [self.scrollView addSubview:self.backView];
    [self.scrollView addSubview:self.cashWay];
    [self.scrollView addSubview:self.cashChannel];
    [self.scrollView addSubview:self.botView];
    [self.scrollView addSubview:self.cashBtn];
    
    /*将ui添加到scrollView数组中*/
    [self.scrollView sd_addSubviews:@[self.backView,self.cashWay,self.cashChannel,self.botView,self.cashBtn]];
    
    // scrollview自动contentsize
    [self.scrollView setupAutoContentSizeWithBottomView:self.cashBtn bottomMargin:0];
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:135])];
        _backView.backgroundColor = [UIColor whiteColor];
        [_backView addSubview:self.cashTL];
        [_backView addSubview:self.placeText];
        [_backView addSubview:self.allBtn];
        [_backView addSubview:self.rmbL];
        [_backView addSubview:self.line];
    }
    return _backView;
}
- (UILabel *)cashTL{
    if (!_cashTL) {
        _cashTL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:22], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15])];
        _cashTL.text = @"退款金额";
        _cashTL.textColor = LabelColor3;
        _cashTL.textAlignment = NSTextAlignmentLeft;
        _cashTL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _cashTL;
}
- (UITextField *)placeText{
    if (!_placeText) {
        _placeText = [[UITextField alloc]initWithFrame:CGRectMake(_cashTL.left, _cashTL.bottom+[Unity countcoordinatesH:27], [Unity countcoordinatesW:200], [Unity countcoordinatesH:50])];
        _placeText.tag = 10000;
//        _placeText.placeholder = @"请输入退款金额";
        _placeText.delegate = self;
        _placeText.font = [UIFont systemFontOfSize:FontSize(55)];
//        [_placeText setValue:[UIFont boldSystemFontOfSize:FontSize(20)] forKeyPath:@"_placeholderLabel.font"];
        _placeText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入退款金额" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:FontSize(20)],NSForegroundColorAttributeName:[Unity getColor:@"#999999"]}];
    }
    return _placeText;
}
- (UIButton *)allBtn{
    if (!_allBtn) {
        _allBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:70], _placeText.top+[Unity countcoordinatesH:17.5], [Unity countcoordinatesW:60], [Unity countcoordinatesH:15])];
        [_allBtn addTarget:self action:@selector(allClick) forControlEvents:UIControlEventTouchUpInside];
        [_allBtn setTitle:@"全部退款" forState:UIControlStateNormal];
        [_allBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        _allBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _allBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _allBtn;
}
- (UILabel *)rmbL{
    if (!_rmbL) {
        _rmbL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:20]-[Unity widthOfString:@"全部退款" OfFontSize:FontSize(12) OfHeight:[Unity countcoordinatesH:15]]-[Unity widthOfString:@"RMB" OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:15]], _placeText.top+[Unity countcoordinatesH:30], [Unity widthOfString:@"RMB" OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:15]], [Unity countcoordinatesH:15])];
        _rmbL.text = @"RMB";
        _rmbL.textColor = LabelColor6;
        _rmbL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _rmbL;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _placeText.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:30]-[Unity widthOfString:@"全部退款" OfFontSize:FontSize(12) OfHeight:[Unity countcoordinatesH:15]], [Unity countcoordinatesH:1])];
        _line.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line;
}
- (UIButton *)cashWay{
    if (!_cashWay) {
        _cashWay = [[UIButton alloc]initWithFrame:CGRectMake(0, _backView.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        _cashWay.backgroundColor = [UIColor whiteColor];
        [_cashWay addTarget:self action:@selector(typeClick) forControlEvents:UIControlEventTouchUpInside];
        UILabel * typeL = [Unity lableViewAddsuperview_superView:_cashWay _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:60], [Unity countcoordinatesH:20]) _string:@"退款原因" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        typeL.backgroundColor = [UIColor clearColor];
        UIImageView * img = [Unity imageviewAddsuperview_superView:_cashWay _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:15], [Unity countcoordinatesH:20], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10]) _imageName:@"go" _backgroundColor:nil];
        img.backgroundColor = [UIColor clearColor];
        [_cashWay addSubview:self.cashL];
        
    }
    return _cashWay;
}
- (UILabel *)cashL{
    if (!_cashL) {
        _cashL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:80], [Unity countcoordinatesH:15], SCREEN_WIDTH-[Unity countcoordinatesW:105], [Unity countcoordinatesH:20])];
        _cashL.text = @"请选择";
        _cashL.textColor = LabelColor9;
        _cashL.textAlignment = NSTextAlignmentRight;
        _cashL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _cashL;
}
- (UIButton *)cashChannel{
    if (!_cashChannel) {
        _cashChannel = [[UIButton alloc]initWithFrame:CGRectMake(0, _cashWay.bottom+1, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        _cashChannel.backgroundColor = [UIColor whiteColor];
        [_cashChannel addTarget:self action:@selector(cashTypeClick) forControlEvents:UIControlEventTouchUpInside];
        UILabel * typeL = [Unity lableViewAddsuperview_superView:_cashChannel _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:60], [Unity countcoordinatesH:20]) _string:@"退款方式" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        typeL.backgroundColor = [UIColor clearColor];
        UIImageView * img = [Unity imageviewAddsuperview_superView:_cashChannel _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:15], [Unity countcoordinatesH:20], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10]) _imageName:@"go" _backgroundColor:nil];
        img.backgroundColor = [UIColor clearColor];
        [_cashChannel addSubview:self.cashTypeL];
        [_cashChannel addSubview:self.cashImg];
        
    }
    return _cashChannel;
}
- (UILabel *)cashTypeL{
    if (!_cashTypeL) {
        _cashTypeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:80], [Unity countcoordinatesH:15], SCREEN_WIDTH-[Unity countcoordinatesW:105], [Unity countcoordinatesH:20])];
        _cashTypeL.text = @"请选择";
        _cashTypeL.textColor = LabelColor9;
        _cashTypeL.textAlignment = NSTextAlignmentRight;
        _cashTypeL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _cashTypeL;
}
- (UIImageView *)cashImg{
    if (!_cashImg) {
        _cashImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:105], [Unity countcoordinatesH:15], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
        _cashImg.contentMode = UIViewContentModeScaleAspectFit;
        _cashImg.hidden= YES;
    }
    return _cashImg;
}
- (UIView *)botView{
    if (!_botView) {
        _botView = [[UIView alloc]initWithFrame:CGRectMake(0, _cashChannel.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        _botView.backgroundColor = [UIColor whiteColor];
        UILabel * typeL = [Unity lableViewAddsuperview_superView:_botView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:60], [Unity countcoordinatesH:20]) _string:@"账号" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        typeL.backgroundColor = [UIColor clearColor];
        
        [_botView addSubview:self.textField];
    }
    return _botView;
}
- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:80], [Unity countcoordinatesH:15], SCREEN_WIDTH-[Unity countcoordinatesW:90], [Unity countcoordinatesH:20])];
        _textField.tag = 10001;
        _textField.delegate = self;
        _textField.placeholder = @"请填写邮箱或手机号";
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _textField;
}
- (UIButton *)cashBtn{
    if (!_cashBtn) {
        _cashBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _botView.bottom+[Unity countcoordinatesH:35], SCREEN_WIDTH- [Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        [_cashBtn addTarget:self action:@selector(cashClick) forControlEvents:UIControlEventTouchUpInside];
        [_cashBtn setTitle:@"退款" forState:UIControlStateNormal];
        [_cashBtn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
        _cashBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
        _cashBtn.layer.cornerRadius = _cashBtn.height/2;
        _cashBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        _cashBtn.layer.borderWidth =1;
    }
    return _cashBtn;
}
- (CashWay *)cView{
    if (!_cView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _cView = [CashWay setCashWay:window];
        _cView.delegate = self;
    }
    return _cView;
}
- (CashType *)tView{
    if (!_tView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _tView = [CashType setCashType:window];
        _tView.delegate = self;
    }
    return _tView;
}
- (CashSuccess *)sView{
    if (!_sView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _sView = [CashSuccess setCashSuccess:window];
        _sView.delegate = self;
    }
    return _sView;
}
- (CashFailure *)fView{
    if (!_fView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _fView = [CashFailure setCashFailure:window];
    }
    return _fView;
}






- (void)allClick{
    
    //    if ([self.balance floatValue] >0) {
    self.placeText.text = self.balance;
    //    }
}
- (void)typeClick{
    [self hiddenKeyboard];
    [self.cView showCashWay];
}
- (void)cashTypeClick{
    [self hiddenKeyboard];
    [self.tView showCashType];
}
- (void)cashClick{
    if ([self.placeText.text isEqualToString:@""] || tkWay == nil || tkType == nil || [self.textField.text isEqualToString:@""]) {
        [WHToast showMessage:@"退款信息填写不完整" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        return;
    }
    if([self.placeText.text floatValue]>[self.balance floatValue] || [self.balance floatValue] <=0) {//
        [WHToast showMessage:@"账户余额不足" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        return;
    }

    [self showKeyboard];
    [self showPass];
}
#pragma mark 自定义view 代理回调
- (void)confirm:(NSString *)way{
    self.cashL.text = way;
    tkWay = way;
    self.cashL.textColor = LabelColor3;
}
- (void)cashTypeconfirm:(NSInteger)index{
//    NSLog(@"%ld",(long)index);
    self.cashTypeL.hidden = YES;
    self.cashImg.hidden = NO;
    if (index ==0) {
        self.cashImg.image = [UIImage imageNamed:@"rightalipay"];
        self.textField.placeholder = @"请填写邮箱或手机号";
        tkType = @"支付宝";
    }else{
        self.cashImg.image = [UIImage imageNamed:@"汇付天下"];
        tkType = @"汇付天下";
        self.textField.placeholder = @"请输入银行卡号";
    }
}
- (void)cashSuccessConfirm{
    [self.delegate reloadBalance];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark  - 自定义键盘 密码
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 10000) {
        [self showKeyboard];
        return NO;
    }else{
        NSLog(@"111");
        [self hiddenKeyboard];
        return YES;
    }
    
}
- (void)createKeyboard{
    NSArray * keylist = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"X",@"0",@"."];
    KeyView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64, SCREEN_WIDTH, [Unity countcoordinatesH:200])];
    KeyView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:KeyView];
    for (int i=0; i<keylist.count; i++) {
        UIButton * btn = [Unity buttonAddsuperview_superView:KeyView _subViewFrame:CGRectMake((i%3)*(SCREEN_WIDTH/4), (i/3)*[Unity countcoordinatesH:50], SCREEN_WIDTH/4, [Unity countcoordinatesH:50]) _tag:self _action:@selector(keyBoardClick:) _string:@"" _imageName:@""];
        [btn setTitle:keylist[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:24];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = 666+i;
    }
    NSArray * arr = @[@"key_s",@"key_d"];
    for (int j=0; j<arr.count; j++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4*3, j*[Unity countcoordinatesH:100], SCREEN_WIDTH/4, [Unity countcoordinatesH:100])];
        [KeyView addSubview:btn];
        [btn addTarget:self action:@selector(keyBoardClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[UIImage imageNamed:arr[j]] forState:UIControlStateNormal];
        btn.adjustsImageWhenHighlighted = NO;
        btn.tag = 678+j;
    }
}
- (void)showKeyboard{
    [UIView animateWithDuration:0.5 animations:^{
        self->KeyView.frame = CGRectMake(0, SCREEN_HEIGHT-[Unity countcoordinatesH:200]-NavBarHeight, SCREEN_WIDTH, [Unity countcoordinatesH:200]);
    }];
}
- (void)hiddenKeyboard{
    [UIView animateWithDuration:0.5 animations:^{
        self->KeyView.frame = CGRectMake(0, SCREEN_HEIGHT-NavBarHeight, SCREEN_WIDTH, [Unity countcoordinatesH:200]);
    }];
}
- (void)keyBoardClick:(UIButton *)btn{
    NSLog(@"%ld",(long)btn.tag);
    if (isPass) {
        if (btn.tag<675) {
            NSString * str = [NSString stringWithFormat:@"%ld",(long)btn.tag-665];
            [self passWordInput:str];
        }else if(btn.tag == 675){
            [self passWordInput:@""];
        }else if (btn.tag == 676){
            [self passWordInput:@"0"];
        }else if (btn.tag == 677){
            [self passWordInput:@"."];
        }else if (btn.tag == 678){
            [self passWordInput:@"-"];
        }
        
    }else{
        if (btn.tag<675) {
            NSString * str = [NSString stringWithFormat:@"%ld",btn.tag -665];
            self.placeText.text = [self.placeText.text stringByAppendingString:str];
        }else if(btn.tag == 675){
            self.placeText.text = @"";
        }else if (btn.tag == 676){
            NSString * str = [NSString stringWithFormat:@"%d",0];
            self.placeText.text = [self.placeText.text stringByAppendingString:str];
        }else if (btn.tag == 677){
            self.placeText.text = [self.placeText.text stringByAppendingString:@"."];
        }else if (btn.tag == 678){
            if (self.placeText.text.length>0) {
                self.placeText.text =[self.placeText.text substringToIndex:self.placeText.text.length-1];
            }
        }else if (btn.tag == 679){
            [self hiddenKeyboard];
        }
        
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!isPass) {
        [UIView animateWithDuration:0.5 animations:^{
            self->KeyView.frame = CGRectMake(0, SCREEN_HEIGHT-NavBarHeight, SCREEN_WIDTH, [Unity countcoordinatesH:200]);
        }];
    }
}
- (void)inputPassWord{
    self.maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-[Unity countcoordinatesH:200])];
    self.maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.maskView.hidden=YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskView];
    
    passWordView = [[UIView alloc]initWithFrame:CGRectMake(0, self.maskView.height-[Unity countcoordinatesH:150], SCREEN_WIDTH, [Unity countcoordinatesH:150])];
    passWordView.backgroundColor = [Unity getColor:@"#f0f0f0"];
    [_maskView addSubview:passWordView];
    
    UIButton * cancel = [Unity buttonAddsuperview_superView:passWordView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:12], [Unity countcoordinatesW:16], [Unity countcoordinatesH:16]) _tag:self _action:@selector(cancelClick) _string:@"" _imageName:@"X"];
    cancel.backgroundColor = [UIColor clearColor];
    UILabel * tishi = [Unity lableViewAddsuperview_superView:passWordView _subViewFrame:CGRectMake(80, [Unity countcoordinatesH:10], SCREEN_WIDTH-160, [Unity countcoordinatesH:20]) _string:@"请输入支付密码" _lableFont:[UIFont systemFontOfSize:FontSize(17)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentCenter];
    tishi.backgroundColor = [UIColor clearColor];
    textMuArray = [NSMutableArray new];
    
    for (int i = 0; i < 6; i++)
    {
        UITextField * pwdLabel = [[UITextField alloc] initWithFrame:CGRectMake(23+i*(SCREEN_WIDTH - 40)/6-(i+1), [Unity countcoordinatesH:40], (SCREEN_WIDTH - 40)/6, (SCREEN_WIDTH - 40)/6)];
        pwdLabel.layer.borderColor = [UIColor blackColor].CGColor;
        pwdLabel.enabled = NO;
        pwdLabel.backgroundColor = [UIColor whiteColor];
        pwdLabel.textAlignment = NSTextAlignmentCenter;//居中
        pwdLabel.secureTextEntry = YES;//设置密码模式
        pwdLabel.layer.borderWidth = 1;
        [passWordView addSubview:pwdLabel];
        
        [textMuArray addObject:pwdLabel];
    }
    UIButton * forgotBtn = [Unity buttonAddsuperview_superView:passWordView _subViewFrame:CGRectMake((SCREEN_WIDTH-100)/2, [Unity countcoordinatesH:100], 100, [Unity countcoordinatesH:30]) _tag:self _action:@selector(forgotClick) _string:@"忘记密码?" _imageName:@""];
    [forgotBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
    forgotBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
}
- (void)forgotClick{
    [self hiddenPass];
    [self hiddenKeyboard];
    [self passWordInput:@""];
    AuthenticationViewController * avc = [[AuthenticationViewController alloc]init];
    [self.navigationController pushViewController:avc animated:YES];
}
- (void)cancelClick{
    [self hiddenPass];
    [self passWordInput:@""];
}
- (void)showPass{
    self.maskView.hidden = NO;
    isPass = YES;
}
- (void)hiddenPass{
    self.maskView.hidden = YES;
    [self hiddenKeyboard];
    isPass = NO;
}
- (void)passWordInput:(NSString *)num{
    if ([num isEqualToString:@""]) {
        password = @"";
        for (int i=0; i<6; i++) {
            UITextField *pwdtx = [textMuArray objectAtIndex:i];
            pwdtx.text = @"";
        }
        return;
    }else if ([num isEqualToString:@"-"]){
        if ([password isEqualToString:@""]) {
            return;
        }else{
            NSInteger len = password.length;
            UITextField *pwdtx = [textMuArray objectAtIndex:len-1];
            pwdtx.text = @"";
            password = [password substringToIndex:len-1];
        }
        NSLog(@"mima  %@",password);
    }else{
        password = [password stringByAppendingString:num];
    }
    
    for (int i = 0; i < textMuArray.count; i++)
    {
        UITextField *pwdtx = [textMuArray objectAtIndex:i];
        if (i < password.length)
        {
            NSString * pwd = [password substringWithRange:NSMakeRange(i, 1)];
            pwdtx.text = pwd;
        }
    }
    
    if (password.length == 6)
    {
//        NSLog(@"密码输入完成");
        [self hiddenPass];
        [self hiddenKeyboard];
            [Unity showanimate];
            NSDictionary * user = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
            NSDictionary * dic = @{@"customer":user[@"member_id"],@"way":tkType,@"num":self.textField.text,@"price":self.placeText.text,@"reason":tkWay,@"mytoken":@"120123477moken008myday099",@"old_password":password,@"name":user[@"w_mobile"]};
        NSLog(@"%@",dic);
        [self passWordInput:@""];
            [GZMrequest postWithURLString:[GZMUrl get_cash_url] parameters:dic success:^(NSDictionary *data) {
                [Unity hiddenanimate];
                if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
                    //更新余额
                    NSMutableDictionary * dict = [NSMutableDictionary new];
                    dict = [user mutableCopy];
                    float balan = [self.balance floatValue]-[self.placeText.text floatValue];
                    [dict setObject:[NSString stringWithFormat:@"%.2f",balan] forKey:@"w_yk_tw"];
                    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"userInfo"];
                    
                    self.sView.amountL.text = self.placeText.text;
                    [self.sView showCashSuccess];
                }else{
                    self.fView.amountL.text = self.placeText.text;
                    self.fView.msgL.text = data[@"msg"];
                    [self.fView showCashFailuer];
                }
            } failure:^(NSError *error) {
                [Unity hiddenanimate];
                [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            }];
    }
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
