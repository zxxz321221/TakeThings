//
//  MsgLoginViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/16.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "MsgLoginViewController.h"
#import "ThirdView.h"
#import "alertView.h"
#import "UIViewController+YINNav.h"
#import <JPUSHService.h>
@interface MsgLoginViewController ()<ThirdViewDelegate>
@property (nonatomic , strong) UIImageView * loginImg;
@property (nonatomic , strong) UITextField * login_name;
@property (nonatomic , strong) UITextField * login_pass;
@property (nonatomic , strong) UILabel * line0;//用户名下方线
@property (nonatomic , strong) UILabel * line1;//密码下方线
@property (nonatomic , strong) UIButton * loginBtn;

@property (nonatomic , strong) ThirdView * tView;
@property (nonatomic , strong) UIButton * codeBtn;//获取验证码
@property (nonatomic , strong) alertView * altView;
@property (nonatomic , strong) AroundAnimation * aAnimation;
@end

@implementation MsgLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.y_navLineHidden = YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.tView showThirdView];
//    self.tView.delegate = self;
    [self.view addSubview:self.loginImg];
    [self.view addSubview:self.login_name];
    [self.view addSubview:self.line0];
    [self.view addSubview:self.login_pass];
    [self.view addSubview:self.codeBtn];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.loginBtn];
}
- (ThirdView *)tView{
    if (_tView == nil) {
        _tView = [ThirdView setThirdView:self.view];
    }
    return _tView;
}
- (UIImageView *)loginImg{
    if (_loginImg == nil) {
        _loginImg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-[Unity countcoordinatesW:100])/2, [Unity countcoordinatesH:20], [Unity countcoordinatesW:100], [Unity countcoordinatesH:50])];
        _loginImg.image = [UIImage imageNamed:@"login_icon"];
    }
    return _loginImg;
}
- (UITextField *)login_name{
    if (_login_name == nil) {
        _login_name = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _loginImg.bottom+[Unity countcoordinatesH:50], [Unity countcoordinatesW:200], [Unity countcoordinatesH:30])];
        _login_name.placeholder = @"请输入手机号";
        _login_name.keyboardType = UIKeyboardTypeNumberPad;
        [_login_name addTarget:self action:@selector(jiaoyanText:) forControlEvents:UIControlEventEditingChanged];
    }
    return _login_name;
}
- (UILabel *)line0{
    if (_line0 == nil) {
        _line0 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], self.login_name.bottom+[Unity countcoordinatesH:3], SCREEN_WIDTH-[Unity countcoordinatesW:20], 1)];
        _line0.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line0;
}
- (UITextField *)login_pass{
    if (_login_pass == nil) {
        _login_pass = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line0.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:150], [Unity countcoordinatesH:30])];
        _login_pass.placeholder = @"请输入验证码";
        _login_pass.keyboardType = UIKeyboardTypeNumberPad;
        [_login_pass addTarget:self action:@selector(jiaoyanText:) forControlEvents:UIControlEventEditingChanged];
    }
    return _login_pass;
}
- (UIButton *)codeBtn{
    if (_codeBtn == nil) {
        _codeBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:110], _login_pass.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:30])];
        _codeBtn.layer.cornerRadius = 17;
        _codeBtn.backgroundColor = [Unity getColor:@"#f0f0f0"];
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeBtn setTitleColor:LabelColor9 forState:UIControlStateNormal];
        [_codeBtn addTarget:self action:@selector(codeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeBtn;
}
- (UILabel *)line1{
    if (_line1 == nil) {
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], self.login_pass.bottom+[Unity countcoordinatesH:3], SCREEN_WIDTH-[Unity countcoordinatesW:20], 1)];
        _line1.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line1;
}
- (UIButton *)loginBtn{
    if (_loginBtn == nil) {
        _loginBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line1.bottom+[Unity countcoordinatesH:40], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        [_loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.layer.cornerRadius = 25;
        _loginBtn.backgroundColor = [Unity getColor:@"#cb6d7f"];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(18)];
        [_loginBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
        _loginBtn.userInteractionEnabled = NO;
    }
    return _loginBtn;
}
- (void)codeBtnClick{
    self.codeBtn.userInteractionEnabled = NO;
    [self requestCode];
}
- (void)requestCode{
    if (self.login_name.text.length != 11) {
        [self.altView showAlertView];
        self.altView.msgL.text = @"请输入正确的手机号";
        self.codeBtn.userInteractionEnabled = YES;
        return;
    }
    [self.aAnimation startAround];
    NSDictionary *params = @{@"mobileNum":self.login_name.text,@"type":@"1"};
    [GZMrequest postWithURLString:[GZMUrl get_code_url]parameters:params success:^(NSDictionary *data) {
        [self.aAnimation stopAround];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            [self startTime];
        }else{
            self.codeBtn.userInteractionEnabled = YES;
            [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        self.codeBtn.userInteractionEnabled = YES;
        [self.aAnimation stopAround];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
#pragma mark --ThirdView 第三方登录   隐私政策--
- (void)thirdLoginIndex:(NSInteger)index{
    switch (index) {
        case 0://微信
        {}
            break;
        case 1://脸书
        {}
            break;
        case 2://谷歌
        {}
            break;
            
        default:
            break;
    }
}
- (void)privacyPolicylClick{
    
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
- (alertView *)altView{
    if (_altView == nil) {
        _altView = [alertView setAlertView:self.view];
    }
    return _altView;
}
- (void)loginClick{
    if (self.login_name.text.length != 11) {
        [self.altView showAlertView];
        self.altView.msgL.text = @"请输入正确的手机号";
        return;
    }
    if (self.login_pass.text.length == 0) {
        [self.altView showAlertView];
        self.altView.msgL.text = @"验证码不能为空";
        return;
    }
    [self.aAnimation startAround];
    NSDictionary *params = @{@"check":self.login_pass.text,@"mobile":self.login_name.text,@"type":@"checkcode",@"tag":[Unity getLanguage],@"registration_id":[JPUSHService registrationID]};
    NSLog(@"%@",params);
    [GZMrequest postWithURLString:[GZMUrl get_login_url] parameters:params success:^(NSDictionary *data) {
        [self.aAnimation stopAround];
        NSLog(@"短信登录 %@",data);
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            NSMutableDictionary * dict = [NSMutableDictionary new];
            [dict setObject:data[@"data"][@"id"] forKey:@"member_id"];
            [dict setObject:data[@"data"][@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"login"];
            NSMutableDictionary * muDic = [Unity editLoginData:data[@"data"]];
            
            [[NSUserDefaults standardUserDefaults]setObject:muDic forKey:@"userInfo"];
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfo" object:nil];
            [self uploadFoot:data[@"data"][@"w_email"]];
            NSInteger index = (NSInteger)[[self.navigationController viewControllers] indexOfObject:self];
            
            if (index > 2) {
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index-2)] animated:YES];
            }else{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            if (self.status == 999) {
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
            }
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
    if (self.login_name.text.length == 0 || self.login_pass.text.length == 0) {
        self.loginBtn.backgroundColor = [Unity getColor:@"#cb6d7f"];
        self.loginBtn.userInteractionEnabled = NO;
    }else{
        self.loginBtn.backgroundColor = [Unity getColor:@"#aa112d"];
        self.loginBtn.userInteractionEnabled = YES;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
