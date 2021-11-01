//
//  RegisterViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/16.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "RegisterViewController.h"
#import "alertView.h"
#import "Agreenment.h"
#import "InterestViewController.h"
#import "UIViewController+YINNav.h"
#import <JPUSHService.h>
@interface RegisterViewController ()<AgreenmentDelegate>
{
    BOOL isAgreed;//yes勾选隐私政策 默认no
    NSString * string;
    BOOL isSuccess;//判断协议是否请求成功 默认no
}
@property (nonatomic , strong)UITextField * mobileText;;//手机
@property (nonatomic , strong)UILabel *line0;//手机下方横线
@property (nonatomic , strong) UILabel * mobileMark;
@property (nonatomic , strong)UITextField * codeText;//验证码
@property (nonatomic , strong)UIButton * codeBtn;//获取验证码
@property (nonatomic , strong)UILabel * line1;//验证码下方横线
@property (nonatomic , strong)UITextField * passWordText;//密码
@property (nonatomic , strong)UIButton * eyesBtn;//掩码
@property (nonatomic , strong)UILabel * line2;//密码下方横线
@property (nonatomic , strong) UILabel * passMark;
@property (nonatomic , strong)UITextField * nameText;//用户名
@property (nonatomic , strong)UILabel * line3;//用户名下方横线
@property (nonatomic , strong)UITextField * emailText;//邮箱
@property (nonatomic , strong)UILabel * line4;//邮箱下方横线
@property (nonatomic , strong)UILabel * emailMark;
@property (nonatomic , strong)UIButton * registerBtn;//注册
@property (nonatomic , strong)UIButton * readBtn;
@property (nonatomic , strong)UILabel * labelL;//我已阅读并同意
@property (nonatomic , strong)UILabel * labelP;//《捎东西隐私政策》

@property (nonatomic , strong) alertView * altView;
@property (nonatomic , strong) AroundAnimation * aAnimation;
@property (nonatomic , strong) Agreenment * aView;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.y_navLineHidden = YES;
    isAgreed = NO;
    isSuccess= NO;
    [self creareUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"新用户注册";
}
- (void)creareUI{
    [self.view addSubview:self.mobileText];
    [self.view addSubview:self.line0];
    [self.view addSubview:self.mobileMark];
    [self.view addSubview:self.codeText];
    [self.view addSubview:self.codeBtn];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.passWordText];
    [self.view addSubview:self.eyesBtn];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.passMark];
//    [self.view addSubview:self.nameText];
//    [self.view addSubview:self.line3];
    [self.view addSubview:self.emailText];
    [self.view addSubview:self.line4];
    [self.view addSubview:self.emailMark];
    [self.view addSubview:self.registerBtn];
    [self.view addSubview:self.readBtn];
    [self.view addSubview:self.labelL];
    [self.view addSubview:self.labelP];
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
- (UILabel *)mobileMark{
    if (!_mobileMark) {
        _mobileMark = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line0.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:15])];
        _mobileMark.text = @"如有问题客服可以在第一时间通知您";
        _mobileMark.textColor = LabelColor6;
        _mobileMark.font = [UIFont systemFontOfSize:FontSize(12)];
        _mobileMark.textAlignment = NSTextAlignmentLeft;
    }
    return _mobileMark;
}
- (UITextField *)codeText{
    if (_codeText == nil) {
        _codeText = [[UITextField alloc]initWithFrame:CGRectMake(_mobileMark.left, _mobileMark.bottom+[Unity countcoordinatesH:15], _mobileText.width, _mobileText.height)];
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
        _codeBtn.layer.cornerRadius = _codeBtn.height/2;
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
        _passWordText.font = [UIFont systemFontOfSize:FontSize(14)];
        _passWordText.secureTextEntry = YES;
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
- (UITextField *)nameText{
    if (_nameText == nil) {
        _nameText = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _passMark.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:150], [Unity countcoordinatesH:30])];
        _nameText.placeholder = @"请输入用户名";
        _nameText.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _nameText;
}
- (UILabel *)line3{
    if (_line3 == nil) {
        _line3 = [[UILabel alloc]initWithFrame:CGRectMake(_nameText.left, _nameText.bottom+[Unity countcoordinatesH:3], SCREEN_WIDTH-[Unity countcoordinatesW:20], 1)];
        _line3.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line3;
}
- (UITextField *)emailText{
    if (_emailText == nil) {
        _emailText = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10],_passMark.bottom+ [Unity countcoordinatesH:15], [Unity countcoordinatesW:150], [Unity countcoordinatesH:30])];
        _emailText.placeholder = @"请输入邮箱";
        _emailText.font = [UIFont systemFontOfSize:FontSize(14)];
        [_emailText addTarget:self action:@selector(jiaoyanText:) forControlEvents:UIControlEventEditingChanged];
    }
    return _emailText;
}
- (UILabel *)line4{
    if (_line4 == nil) {
        _line4 = [[UILabel alloc]initWithFrame:CGRectMake(_emailText.left, _emailText.bottom+[Unity countcoordinatesH:3], SCREEN_WIDTH-[Unity countcoordinatesW:20], 1)];
        _line4.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line4;
}
- (UILabel *)emailMark{
    if (!_emailMark) {
        _emailMark = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line4.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:15])];
        _emailMark.text = @"请您使用email作为账号 如1234@qq.com,建议QQ,163邮箱";
        _emailMark.textColor = LabelColor6;
        _emailMark.font = [UIFont systemFontOfSize:FontSize(12)];
        _emailMark.textAlignment = NSTextAlignmentLeft;
    }
    return _emailMark;
}
- (UIButton *)registerBtn{
    if (_registerBtn == nil) {
        _registerBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _emailMark.bottom+[Unity countcoordinatesH:40], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        [_registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
        _registerBtn.layer.cornerRadius = [Unity countcoordinatesH:20];
        _registerBtn.backgroundColor = [Unity getColor:@"#cb6d7f"];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(18)];
        [_registerBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
        _registerBtn.userInteractionEnabled = NO;
    }
    return _registerBtn;
}
- (UIButton *)readBtn{
    if (_readBtn == nil) {
        _readBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _registerBtn.bottom+[Unity countcoordinatesH:12], [Unity countcoordinatesW:16], [Unity countcoordinatesH:16])];
        [_readBtn setBackgroundImage:[UIImage imageNamed:@"unread"] forState:UIControlStateNormal];
        [_readBtn setBackgroundImage:[UIImage imageNamed:@"read"] forState:UIControlStateSelected];
        [_readBtn addTarget:self action:@selector(readClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _readBtn;
}
- (UILabel *)labelL{
    if (_labelL == nil) {
        CGFloat W = [Unity widthOfString:@"我已阅读并同意" OfFontSize:14 OfHeight:20];
        _labelL = [[UILabel alloc]initWithFrame:CGRectMake(_readBtn.right+[Unity countcoordinatesW:5], _registerBtn.bottom+[Unity countcoordinatesH:10], W, [Unity countcoordinatesH:20])];
        _labelL.font = [UIFont systemFontOfSize:14];
        _labelL.text = @"我已阅读并同意";
        _labelL.textColor = LabelColor9;
    }
    return _labelL;
}
- (UILabel *)labelP{
    if (_labelP == nil) {
        CGFloat W = [Unity widthOfString:@"《捎东西隐私政策》" OfFontSize:14 OfHeight:20];
        _labelP = [[UILabel alloc]initWithFrame:CGRectMake(_labelL.right, _registerBtn.bottom+[Unity countcoordinatesH:10], W, [Unity countcoordinatesH:20])];
        _labelP.font = [UIFont systemFontOfSize:14];
        _labelP.text = @"《捎东西隐私政策》";
        _labelP.textColor = [Unity getColor:@"4a90e2"];
        // 下划线
        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"《捎东西隐私政策》" attributes:attribtDic];
        
        //赋值
        _labelP.attributedText = attribtStr;
        UITapGestureRecognizer *singleTap =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelpPAction)];
        singleTap.numberOfTapsRequired = 1; //点击次数
        singleTap.numberOfTouchesRequired = 1; //点击手指数
        [_labelP addGestureRecognizer:singleTap];
        _labelP.userInteractionEnabled = YES;
    }
    return _labelP;
}

- (void)eyesClick{
    if (self.eyesBtn.selected) {
        self.eyesBtn.selected = NO;
        self.passWordText.secureTextEntry = YES;
    }else{
        self.eyesBtn.selected =YES;
        self.passWordText.secureTextEntry = NO;
    }
}
- (void)codeBtnClick{
    self.codeBtn.userInteractionEnabled = NO;
    if (self.mobileText.text.length != 11) {
        [self.altView showAlertView];
        self.altView.msgL.text = @"请输入正确的手机号";
        self.codeBtn.userInteractionEnabled = YES;
        return;
    }
    [self requestCode];
    
}

- (void)requestCode{
    [self.aAnimation startAround];
    NSDictionary *params = @{@"mobileNum":self.mobileText.text,@"type":@"0"};
    [GZMrequest postWithURLString:[GZMUrl get_code_url]parameters:params success:^(NSDictionary *data) {
        NSLog(@"%@",data);
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
- (void)readClick{
    if (self.readBtn.selected) {
        self.readBtn.selected = NO;
        isAgreed = NO;
    }else{
        if (isSuccess) {
            [self.aView showAgView];
            self.aView.titleL.text = @"捎东西隐私政策";
            [self.aView.webView loadHTMLString:string baseURL:nil];
        }else{
            [self requestHelp];
        }
    }
    [self WithOfContent];
}
- (void)labelpPAction{
    if (isSuccess) {
        [self.aView showAgView];
        self.aView.titleL.text = @"捎东西隐私政策";
        [self.aView.webView loadHTMLString:string baseURL:nil];
    }else{
        [self requestHelp];
    }
    
}
- (void)requestHelp{
    [self.aAnimation startAround];
    NSDictionary * dic = @{@"help":@"175"};
    [GZMrequest getWithURLString:[GZMUrl get_helpDetail_url] parameters:dic success:^(NSDictionary *data) {
        NSLog(@"%@",data);
        [self.aAnimation stopAround];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            isSuccess = YES;
            string=[data[@"data"][0][@"content"] stringByReplacingOccurrencesOfString:@"src=\""withString:@"src=\"http://shaogood.com"];
            [self.aView showAgView];
            self.aView.titleL.text = @"捎东西隐私政策";
            [self.aView.webView loadHTMLString:string baseURL:nil];

        }else{
            [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [self.aAnimation stopAround];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (NSString *)editString:(NSString *)str{
    NSString * str1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"];
    NSArray *array = [str componentsSeparatedByString:@";"];
    NSString * str2 = @"";
    for (int i=0; i<array.count; i++) {
        NSString * string = @"";
        if ([array[i] rangeOfString:@"||"].location == NSNotFound) {
            NSArray *array1 = [array[i] componentsSeparatedByString:@"|"];
            string = [NSString stringWithFormat:@"<h1>%@</h1><h3>%@</h3><img src=\"%@%@\" alt=\"\" />",array1[0],array1[1],str1,array1[2]];
            str2 = [str2 stringByAppendingFormat:@"%@",string];
            
        } else {
            NSArray *array1 = [array[i] componentsSeparatedByString:@"||"];
            string = [NSString stringWithFormat:@"<h1>%@</h1><h3></h3><img src=\"%@%@\" alt=\"\" />",array1[0],str1,array1[1]];
            str2 = [str2 stringByAppendingFormat:@"%@",string];
        }
    }
    return str2;
}
- (alertView *)altView{
    if (_altView == nil) {
        _altView = [alertView setAlertView:self.view];
    }
    return _altView;
}
//注册
- (void)registerClick{
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
    NSDictionary *params = [NSDictionary new];
    if (self.openId == nil || self.unionId == nil) {//没有绑定微信
        params = @{@"passwd":self.passWordText.text,@"email":self.emailText.text,@"mobile":self.mobileText.text,@"check":self.codeText.text,@"name":self.emailText.text,@"tag":[Unity getLanguage],@"registration_id":[JPUSHService registrationID]};
    }else{
        params = @{@"passwd":self.passWordText.text,@"email":self.emailText.text,@"mobile":self.mobileText.text,@"check":self.codeText.text,@"name":self.emailText.text,@"tag":[Unity getLanguage],@"registration_id":[JPUSHService registrationID],@"openid":self.openId,@"unionid":self.unionId};
    }
    [GZMrequest postWithURLString:[GZMUrl get_register_url]parameters:params success:^(NSDictionary *data) {
        NSLog(@"%@",data);
        [self.aAnimation stopAround];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            NSMutableDictionary * dict = [NSMutableDictionary new];
            [dict setObject:data[@"data"][@"id"] forKey:@"member_id"];
            [dict setObject:data[@"data"][@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"login"];
            NSMutableDictionary * muDic = [Unity editLoginData:data[@"data"]];
            
            [[NSUserDefaults standardUserDefaults]setObject:muDic forKey:@"userInfo"];
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfo" object:nil];
            
            [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            
//            NSInteger index = (NSInteger)[[self.navigationController viewControllers] indexOfObject:self];
//            if (index > 2) {
//                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index-2)] animated:YES];
//            }else{
//                [self.navigationController popToRootViewControllerAnimated:YES];
//            }
            [self uploadFoot:data[@"data"][@"w_email"]];
            InterestViewController * ivc = [[InterestViewController alloc]init];
            ivc.backIndex = 1;
            [self.navigationController pushViewController:ivc animated:YES];
        }else{
            [self.altView showAlertView];
            self.altView.msgL.text = [data objectForKey:@"msg"];
        }
    } failure:^(NSError *error) {
        [self.aAnimation stopAround];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
//判断内容是否为空
- (void)WithOfContent{
    if (self.mobileText.text.length == 0 || self.codeText.text.length == 0 || self.passWordText.text.length == 0 || self.emailText.text.length == 0 ||  self.readBtn.selected == NO) {
        self.registerBtn.backgroundColor = [Unity getColor:@"#cb6d7f"];
        self.registerBtn.userInteractionEnabled = NO;
    }else{
        self.registerBtn.backgroundColor = [Unity getColor:@"#aa112d"];
        self.registerBtn.userInteractionEnabled = YES;
    }
}
- (void)jiaoyanText:(UITextField *)textField{
    [self WithOfContent];
}
- (AroundAnimation *)aAnimation{
    if (!_aAnimation) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _aAnimation = [AroundAnimation AroundAnimationViewSetView:window];
    }
    return _aAnimation;
}
- (Agreenment *)aView{
    if (!_aView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _aView = [Agreenment setAgreenment:window];
        _aView.isRegister = YES;
        _aView.delegate = self;
    }
    return _aView;
}
- (void)confirmAgreenment{
    self.readBtn.selected = YES;
    isAgreed = YES;
    [self WithOfContent];
}
- (void)uploadFoot:(NSString *)user{
    NSArray * arr =  [[NSUserDefaults standardUserDefaults] objectForKey:@"footInfo"];
    if (arr.count>1) {
        NSDictionary * dic = @{@"user":user,@"markdata":[Unity gs_jsonStringCompactFormatForNSArray:arr]};
        [GZMrequest postWithURLString:[GZMUrl get_saveFoot_url] parameters:dic success:^(NSDictionary *data) {
            NSLog(@"保存返回%@",data);
            if ([data[@"status"] intValue] == 1) {
                NSArray * array = [NSArray new];
                [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"footInfo"];
            }
        } failure:^(NSError *error) {
            
        }];
    }
}

@end
