//
//  LoginViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/16.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "LoginViewController.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "ThirdView.h"
#import "MsgLoginViewController.h"
#import "RegisterViewController.h"
#import "ForgotViewController.h"
#import "WebTwoViewController.h"
#import "UIViewController+YINNav.h"
#import <JPUSHService.h>
#import <WXApi.h>
#import "ToastView.h"
@interface LoginViewController ()<ThirdViewDelegate,ToastViewDelegate>
{
    NSString * openId;
    NSString * unionId;
}
@property (nonatomic , strong) UIImageView * loginImg;
@property (nonatomic , strong) UITextField * login_name;
@property (nonatomic , strong) UITextField * login_pass;
@property (nonatomic , strong) UILabel * line0;//用户名下方线
@property (nonatomic , strong) UILabel * line1;//密码下方线
@property (nonatomic , strong) UIButton * showPassBtn;//密码眼
@property (nonatomic , strong) UIButton * forgotBtn;//忘记密码
@property (nonatomic , strong) UIButton * loginBtn;
@property (nonatomic , strong) UIButton * msgCodeBtn;//短信验证码
@property (nonatomic , strong) UIButton * registerBtn;//注册

@property (nonatomic , strong) alertView * altView;
@property (nonatomic , strong) ThirdView * tView;
@property (nonatomic , strong) AroundAnimation * aAnimation;
@property (nonatomic , strong) ToastView * toastView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatLogin:) name:@"wechatLogin" object:nil];
    self.y_navLineHidden = YES;
    [self creareUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addLeftBarButtonWithImage:[UIImage imageNamed:@"X"] action:@selector(backBtn)];
}
#pragma mark --UI创建--
- (void)creareUI{
    //如果没有安装微信  隐藏第三方登录按钮
    if ([WXApi isWXAppInstalled]) {
        [self.tView showThirdView];
        self.tView.delegate = self;
    }
    [self.view addSubview:self.loginImg];
    [self.view addSubview:self.login_name];
    [self.view addSubview:self.line0];
    [self.view addSubview:self.login_pass];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.showPassBtn];
    [self.view addSubview:self.forgotBtn];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.msgCodeBtn];
    [self.view addSubview:self.registerBtn];
    
}
- (ThirdView *)tView{
    if (_tView == nil) {
        _tView = [ThirdView setThirdView:self.view];
    }
    return _tView;
}
- (void)backBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addLeftBarButtonWithImage:(UIImage *)image action:(SEL)action
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    view.backgroundColor = [UIColor clearColor];
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.frame = CGRectMake(0, 0, 44, 44);
    [firstButton setImage:image forState:UIControlStateNormal];
    [firstButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    firstButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0, 5 * SCREEN_WIDTH / 375.0, 0, 0)];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:firstButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
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
        _login_name.placeholder = @"用户名/邮箱/手机号";
//        _login_name.keyboardType = UIKeyboardTypeNumberPad;
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
        _login_pass.placeholder = @"输入密码";
        _login_pass.secureTextEntry = YES;
        [_login_pass addTarget:self action:@selector(jiaoyanText:) forControlEvents:UIControlEventEditingChanged];
    }
    return _login_pass;
}
- (UILabel *)line1{
    if (_line1 == nil) {
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], self.login_pass.bottom+[Unity countcoordinatesH:3], SCREEN_WIDTH-[Unity countcoordinatesW:20], 1)];
        _line1.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line1;
}
- (UIButton *)showPassBtn{
    if (_showPassBtn == nil) {
        _showPassBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:105], _login_pass.top+[Unity countcoordinatesH:8.5], [Unity countcoordinatesW:15], [Unity countcoordinatesH:13])];
        [_showPassBtn setBackgroundImage:[UIImage imageNamed:@"bi"] forState:UIControlStateNormal];
        [_showPassBtn setBackgroundImage:[UIImage imageNamed:@"zheng"] forState:UIControlStateSelected];
        [_showPassBtn addTarget:self action:@selector(eyesClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showPassBtn;
}
- (UIButton *)forgotBtn{
    if (_forgotBtn == nil) {
        _forgotBtn = [[UIButton alloc]initWithFrame:CGRectMake(_showPassBtn.right+[Unity countcoordinatesW:10], _login_pass.top, [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        _forgotBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_forgotBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgotBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        _forgotBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_forgotBtn addTarget:self action:@selector(forgotClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgotBtn;
}
- (UIButton *)loginBtn{
    if (_loginBtn == nil) {
        _loginBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line1.bottom+[Unity countcoordinatesH:40], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        [_loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.layer.cornerRadius = 25;
        _loginBtn.backgroundColor = [Unity getColor:@"#cb6d7f"];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_loginBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
        _loginBtn.userInteractionEnabled = NO;
    }
    return _loginBtn;
}
- (UIButton *)msgCodeBtn{
    if (_msgCodeBtn == nil) {
        _msgCodeBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _loginBtn.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:150], [Unity countcoordinatesH:30])];
        _msgCodeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_msgCodeBtn setTitle:@"短信验证码登录" forState:UIControlStateNormal];
        [_msgCodeBtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        _msgCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_msgCodeBtn addTarget:self action:@selector(msgCodeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _msgCodeBtn;
}
- (UIButton *)registerBtn{
    if (_registerBtn == nil) {
        _registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:110], _loginBtn.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:30])];
        _registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_registerBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}

- (alertView *)altView{
    if (_altView == nil) {
        _altView = [alertView setAlertView:self.view];
    }
    return _altView;
}
#pragma mark --登录页按钮事件--
//忘记密码
- (void)forgotClick{
    ForgotViewController * fvc = [[ForgotViewController alloc]init];
    fvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:fvc animated:YES];
}
//眼睛
- (void)eyesClick{
    if (self.showPassBtn.selected) {
        self.showPassBtn.selected = NO;
        self.login_pass.secureTextEntry = YES;
    }else{
        self.showPassBtn.selected =YES;
        self.login_pass.secureTextEntry = NO;
    }
}
//短信验证码登录
- (void)msgCodeClick{
    MsgLoginViewController * mvc = [[MsgLoginViewController alloc]init];
    mvc.hidesBottomBarWhenPushed = YES;
    mvc.status = self.status;
    [self.navigationController pushViewController:mvc animated:YES];
}

//新用户注册
- (void)registerClick{
    RegisterViewController * rvc = [[RegisterViewController alloc]init];
    rvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:rvc animated:YES];
}
#pragma mark --ThirdView 第三方登录   隐私政策--
- (void)thirdLoginIndex:(NSInteger)index{
    switch (index) {
        case 0://苹果登录
        {
            NSLog(@"苹果登录");
        }
            break;
        case 1://微信
        {
            extern BOOL isLogin;
            isLogin = YES;
            
            if (![WXApi isWXAppInstalled]) {
                [WHToast showMessage:@"微信客户端未安装" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            }else{
                //构造SendAuthReq结构体
                SendAuthReq * req =[[SendAuthReq alloc]init];
                req.scope = @"snsapi_userinfo";
                req.state = @"123";
                //第三方向微信终端发送一个SendAuthReq消息结构
                [WXApi sendReq:req];
            }
        }
            break;
//        case 1://脸书
//        {
//            [self.altView showAlertView];
//            self.altView.msgL.text = @"点击脸书";
//        }
//            break;
//        case 2://谷歌
//        {}
//            break;
            
        default:
            break;
    }
}
- (void)privacyPolicylClick{
//    NSLog(@"登录页点击隐私政策");
    WebTwoViewController * wtc = [[WebTwoViewController alloc]init];
    wtc.num = @"175";
    [self.navigationController pushViewController:wtc animated:YES];
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
//登录
- (void)loginClick{
    [self.aAnimation startAround];
    NSDictionary *params;
    if ([self isPureInt:self.login_name.text]) {
        params = @{@"passwd":self.login_pass.text,@"mobile":self.login_name.text,@"type":@"password",@"tag":[Unity getLanguage],@"registration_id":[JPUSHService registrationID]?[JPUSHService registrationID]:@""};
    }else{
        params = @{@"passwd":self.login_pass.text,@"email":self.login_name.text,@"type":@"password",@"tag":[Unity getLanguage],@"registration_id":[JPUSHService registrationID]?[JPUSHService registrationID]:@""};
    }
    [GZMrequest postWithURLString:[GZMUrl get_login_url] parameters:params success:^(NSDictionary *data) {
        [self.aAnimation stopAround];
        NSLog(@"%@",data);
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            NSMutableDictionary * dict = [NSMutableDictionary new];
            [dict setObject:data[@"data"][@"id"] forKey:@"member_id"];
            [dict setObject:data[@"data"][@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"login"];
            NSMutableDictionary * muDic = [Unity editLoginData:data[@"data"]];
           
            [[NSUserDefaults standardUserDefaults]setObject:muDic forKey:@"userInfo"];
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfo" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
            [self uploadFoot:data[@"data"][@"w_email"]];
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
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
    
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
- (void)wechatLogin:(NSNotification *)notification{
    [self.aAnimation startAround];
    NSDictionary * dic = @{@"openid":notification.object[@"openid"],@"unionid":notification.object[@"unionid"],@"type":@"wechatlogin",@"registration_id":[JPUSHService registrationID],@"tag":[Unity getLanguage]};
    NSLog(@"微信登录请求%@",dic);
    [GZMrequest postWithURLString:[GZMUrl get_login_url] parameters:dic success:^(NSDictionary *data) {
        [self.aAnimation stopAround];
        NSLog(@"%@",data);
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            NSMutableDictionary * dict = [NSMutableDictionary new];
            [dict setObject:data[@"data"][@"id"] forKey:@"member_id"];
            [dict setObject:data[@"data"][@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"login"];
            NSMutableDictionary * muDic = [Unity editLoginData:data[@"data"]];
            
            [[NSUserDefaults standardUserDefaults]setObject:muDic forKey:@"userInfo"];
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfo" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
            [self uploadFoot:data[@"data"][@"w_email"]];
            if (self.status == 999) {
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
            }
            
        }else{
            //未绑定 去注册
            openId = notification.object[@"openid"];
            unionId = notification.object[@"unionid"];
            [self.toastView showHackView];
            
        }
    } failure:^(NSError *error) {
        [self.aAnimation stopAround];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (ToastView *)toastView{
    if (!_toastView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _toastView = [ToastView setToastView:window];
        _toastView.delegate = self;
    }
    return _toastView;
}
- (void)goToRegister{
    RegisterViewController * rvc = [[RegisterViewController alloc]init];
    rvc.openId = openId;
    rvc.unionId = unionId;
    rvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:rvc animated:YES];
}
- (void)goToBinding{
    [WHToast showMessage:@"请登录后绑定" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
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
