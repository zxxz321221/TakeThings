//
//  ForgotViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/17.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "ForgotViewController.h"
#import "alertView.h"
#import "UIViewController+YINNav.h"
#import "ServiceViewController.h"
@interface ForgotViewController ()
@property (nonatomic , strong)UITextField * mobileText;//手机号
@property (nonatomic , strong)UILabel * line0;//手机号下方横线
@property (nonatomic , strong)UITextField * codeText;//验证码
@property (nonatomic , strong)UIButton * codeBtn;//获取验证码
@property (nonatomic , strong)UILabel * line1;//验证码下方横线
@property (nonatomic , strong)UITextField * passWordText;//密码
@property (nonatomic , strong)UIButton * eyesBtn;//掩码
@property (nonatomic , strong)UILabel * line2;//密码下放横线
@property (nonatomic , strong) UILabel * passMark;
@property (nonatomic , strong)UIButton * comfimBtn;//确认
@property (nonatomic , strong)UILabel * labelL;//遇到问题L
@property (nonatomic , strong)UILabel * serviceL;//客服L
@property (nonatomic , strong) alertView * altView;
@property (nonatomic , strong) AroundAnimation * aAnimation;
@end

@implementation ForgotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.y_navLineHidden = YES;
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title=@"忘记密码";
}
- (void)createUI{
    [self.view addSubview:self.mobileText];
    [self.view addSubview:self.line0];
    [self.view addSubview:self.codeText];
    [self.view addSubview:self.codeBtn];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.passWordText];
    [self.view addSubview:self.eyesBtn];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.passMark];
    [self.view addSubview:self.comfimBtn];
    [self.view addSubview:self.labelL];
    [self.view addSubview:self.serviceL];
}
- (UITextField *)mobileText{
    if (_mobileText == nil) {
        _mobileText = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:150], [Unity countcoordinatesH:30])];
        _mobileText.placeholder = @"请输入手机号";
        _mobileText.font = [UIFont systemFontOfSize:FontSize(14)];
        _mobileText.keyboardType = UIKeyboardTypeNumberPad;
        [_mobileText addTarget:self action:@selector(jiaoyanText:) forControlEvents:UIControlEventEditingChanged];
    }
    return _mobileText;
}
- (UILabel *)line0{
    if (_line0 == nil) {
        _line0 = [[UILabel alloc]initWithFrame:CGRectMake(_mobileText.left, _mobileText.bottom+[Unity countcoordinatesH:3], SCREEN_WIDTH-[Unity countcoordinatesW:20], 1)];
        _line0.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line0;
}
- (UITextField *)codeText{
    if (_codeText == nil) {
        _codeText = [[UITextField alloc]initWithFrame:CGRectMake(_line0.left, _line0.bottom+[Unity countcoordinatesH:15], _mobileText.width, _mobileText.height)];
        _codeText.placeholder = @"请输入验证码";
        _codeText.font = [UIFont systemFontOfSize:FontSize(14)];
        _codeText.keyboardType = UIKeyboardTypeNumberPad;
        [_codeText addTarget:self action:@selector(jiaoyanText:) forControlEvents:UIControlEventEditingChanged];
    }
    return _codeText;
}
- (UIButton *)codeBtn{
    if (_codeBtn == nil) {
        _codeBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:110], _codeText.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:30])];
        _codeBtn.layer.cornerRadius = 17;
        _codeBtn.backgroundColor = [Unity getColor:@"#f0f0f0"];
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeBtn setTitleColor:LabelColor9 forState:UIControlStateNormal];
        [_codeBtn addTarget:self action:@selector(codeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeBtn;
}
- (UILabel *)line1{
    if (_line1 == nil) {
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake(_codeText.left, _codeText.bottom+[Unity countcoordinatesH:3], _line0.width, 1)];
        _line1.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return  _line1;
}
- (UITextField *)passWordText{
    if (_passWordText == nil) {
        _passWordText = [[UITextField alloc]initWithFrame:CGRectMake(_codeText.left, _line1.bottom+[Unity countcoordinatesH:15], _codeText.width, _codeText.height)];
        _passWordText.placeholder = @"设置密码";
        _passWordText.secureTextEntry = YES;
        _passWordText.font = [UIFont systemFontOfSize:FontSize(14)];
        [_passWordText addTarget:self action:@selector(jiaoyanText:) forControlEvents:UIControlEventEditingChanged];
    }
    return _passWordText;
}
- (UIButton *)eyesBtn{
    if (_eyesBtn == nil) {
        _eyesBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:25], _passWordText.top+[Unity countcoordinatesH:8.5], [Unity countcoordinatesW:15], [Unity countcoordinatesH:13])];
        [_eyesBtn setBackgroundImage:[UIImage imageNamed:@"bi"] forState:UIControlStateNormal];
        [_eyesBtn setBackgroundImage:[UIImage imageNamed:@"zheng"] forState:UIControlStateSelected];
        [_eyesBtn addTarget:self action:@selector(eyesClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _eyesBtn;
}
- (UILabel *)line2{
    if (_line2 == nil) {
        _line2 = [[UILabel alloc]initWithFrame:CGRectMake(_line1.left, _passWordText.bottom+[Unity countcoordinatesH:3], _line1.width, 1)];
        _line2.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line2;
}
- (UILabel *)passMark{
    if (!_passMark) {
        _passMark = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line2.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:15])];
        _passMark.text = @"8-16个字符，请使用字母加数字或则符号的组合密码";
        _passMark.textColor = LabelColor6;
        _passMark.font = [UIFont systemFontOfSize:FontSize(12)];
        _passMark.textAlignment = NSTextAlignmentLeft;
    }
    return _passMark;
}
- (UIButton *)comfimBtn{
    if (_comfimBtn == nil) {
        _comfimBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _passMark.bottom+[Unity countcoordinatesH:40], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        [_comfimBtn addTarget:self action:@selector(comfimClick) forControlEvents:UIControlEventTouchUpInside];
        _comfimBtn.layer.cornerRadius = 25;
        _comfimBtn.backgroundColor = [Unity getColor:@"#cb6d7f"];
        [_comfimBtn setTitle:@"确认" forState:UIControlStateNormal];
        _comfimBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
        [_comfimBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
        _comfimBtn.userInteractionEnabled = NO;
    }
    return _comfimBtn;
}
- (UILabel *)labelL{
    if (_labelL == nil) {
        CGFloat W = [Unity widthOfString:@"遇到问题？" OfFontSize:14 OfHeight:20];
        _labelL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _comfimBtn.bottom+[Unity countcoordinatesH:10], W, [Unity countcoordinatesH:20])];
        _labelL.font = [UIFont systemFontOfSize:14];
        _labelL.text = @"遇到问题？";
        _labelL.textColor = LabelColor9;
    }
    return _labelL;
}
- (UILabel *)serviceL{
    if (_serviceL == nil) {
        CGFloat W = [Unity widthOfString:@"联系客服" OfFontSize:14 OfHeight:20];
        _serviceL = [[UILabel alloc]initWithFrame:CGRectMake(_labelL.right, _comfimBtn.bottom+[Unity countcoordinatesH:10], W, [Unity countcoordinatesH:20])];
        _serviceL.font = [UIFont systemFontOfSize:14];
        _serviceL.text = @"联系客服";
        _serviceL.textColor = [Unity getColor:@"4a90e2"];
       
        UITapGestureRecognizer *singleTap =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelpPAction)];
        singleTap.numberOfTapsRequired = 1; //点击次数
        singleTap.numberOfTouchesRequired = 1; //点击手指数
        [_serviceL addGestureRecognizer:singleTap];
        _serviceL.userInteractionEnabled = YES;
    }
    return _serviceL;
}
- (void)eyesClick{
    if (self.eyesBtn.selected) {
        self.eyesBtn.selected = NO;
        self.passWordText.secureTextEntry = YES;
    }else{
        self.eyesBtn.selected = YES;
        self.passWordText.secureTextEntry = NO;
    }
}
- (void)codeBtnClick{
    self.codeBtn.userInteractionEnabled = NO;
    [self requestCode];
}
- (void)requestCode{
    if (self.mobileText.text.length != 11) {
        [self.altView showAlertView];
        self.altView.msgL.text = @"请输入正确的手机号";
        self.codeBtn.userInteractionEnabled = YES;
        return;
    }
    [self.aAnimation startAround];
    NSDictionary *params = @{@"mobileNum":self.mobileText.text,@"type":@"1"};
    [GZMrequest postWithURLString:[GZMUrl get_code_url]parameters:params success:^(NSDictionary *data) {
        [self.aAnimation stopAround];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            [self startTime];
        }else{
            self.codeBtn.userInteractionEnabled = YES;
            [self.altView showAlertView];
            self.altView.msgL.text = [data objectForKey:@"msg"];
        }
    } failure:^(NSError *error) {
        self.codeBtn.userInteractionEnabled = YES;
        [self.aAnimation stopAround];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
/***
 短信验证码倒计时
 ***/
-(void)startTime{
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置（倒计时结束后调用）
                [self.codeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                //设置不可点击
                self.codeBtn.userInteractionEnabled = YES;
                
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.codeBtn setTitle:[NSString stringWithFormat:@"重新发送(%@s)",strTime] forState:UIControlStateNormal];
                //设置可点击
                self.codeBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    
    dispatch_resume(_timer);
}
- (void)labelpPAction{
    ServiceViewController * svc = [[ServiceViewController alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
}
//判断内容是否为空
- (void)WithOfContent{
    if (self.mobileText.text.length == 0 || self.codeText.text.length == 0 || self.passWordText.text.length == 0) {
        self.comfimBtn.backgroundColor = [Unity getColor:@"#cb6d7f"];
        self.comfimBtn.userInteractionEnabled = NO;
    }else{
        self.comfimBtn.backgroundColor = [Unity getColor:@"#aa112d"];
        self.comfimBtn.userInteractionEnabled = YES;
    }
}
- (void)jiaoyanText:(UITextField *)textField{
    [self WithOfContent];
}
- (alertView *)altView{
    if (_altView == nil) {
        _altView = [alertView setAlertView:self.view];
    }
    return _altView;
}
- (void)comfimClick{
    if (self.mobileText.text.length != 11) {
        [self.altView showAlertView];
        self.altView.msgL.text = @"请输入正确的手机号";
        return;
    }
    if (![Unity isSafePassword:self.passWordText.text]) {
        [self.altView showAlertView];
        self.altView.msgL.text = @"密码格式不正确";
        return;
    }
    [self.aAnimation startAround];
    NSDictionary *params = @{@"passwd":self.passWordText.text,@"check":self.codeText.text,@"mobile":self.mobileText.text};
    [GZMrequest postWithURLString:[GZMUrl get_resetpassword_url]parameters:params success:^(NSDictionary *data) {
        [self.aAnimation stopAround];
        NSLog(@"%@",data);
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self.altView showAlertView];
            self.altView.msgL.text = [data objectForKey:@"msg"];
        }
    } failure:^(NSError *error) {
        [self.aAnimation stopAround];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (AroundAnimation *)aAnimation{
    if (!_aAnimation) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _aAnimation = [AroundAnimation AroundAnimationViewSetView:window];
    }
    return _aAnimation;
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
