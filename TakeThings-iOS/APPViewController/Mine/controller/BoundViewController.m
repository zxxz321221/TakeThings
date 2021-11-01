//
//  BoundViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/29.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "BoundViewController.h"
#import "BdMobileViewController.h"
#import "EmailViewController.h"
#import "UIViewController+YINNav.h"
#import <WXApi.h>
@interface BoundViewController ()
{
    NSString * mobile;
    BOOL isWechatBind;//是否绑定微信 默认nO
}
@property (nonatomic , strong) UILabel * mobileL;
@property (nonatomic , strong) UIButton * mobileB;
@property (nonatomic, strong) UILabel * phoneNum;

@property (nonatomic , strong) UILabel * otherL;
@property (nonatomic , strong) UIButton * wechatB;
@property (nonatomic , strong) UIButton * emailB;

@property (nonatomic , strong) UILabel * wechatL;
@property (nonatomic , strong) UILabel * wechatName;
@property (nonatomic , strong) UILabel * wechatBid;
@property (nonatomic , strong) UILabel * wechatUn;
@property (nonatomic , strong) UIImageView * wechatGo;

@property (nonatomic , strong) UILabel * emailL;
@property (nonatomic , strong) UILabel * emailName;
@property (nonatomic , strong) UILabel * emailBid;
@property (nonatomic , strong) UILabel * emailUn;
@property (nonatomic , strong) UIImageView * emailGo;

@end

@implementation BoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatBind:) name:@"wechatBind" object:nil];
    // Do any additional setup after loading the view.
    isWechatBind = NO;
    self.y_navLineHidden = YES;
    [self.navigationItem setTitle:@"账号绑定"];
    
    [self creareUI];
}
- (void)wechatBind:(NSNotification *)notification{
    NSLog(@"微信返回参数%@",notification.object);
//    NSDictionary * info = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    [Unity showanimate];
//    ,@"userid":info[@"member_id"]
    NSDictionary * dic = @{@"openid":notification.object[@"openid"],@"unionid":notification.object[@"unionid"],@"type":@"wechatcheck"};
    [GZMrequest postWithURLString:[GZMUrl get_login_url] parameters:dic success:^(NSDictionary *data) {
        
        NSLog(@"%@",data);
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            [Unity hiddenanimate];
            [WHToast showMessage:@"微信已被绑定" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }else{
            [self bindWeChatUnionid:notification.object[@"unionid"] WithOpenid:notification.object[@"openid"]];
        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)creareUI{
    [self.view addSubview:self.mobileL];
    [self.view addSubview:self.mobileB];
    [self.view addSubview:self.otherL];
    [self.view addSubview:self.wechatB];
//    [self.view addSubview:self.emailB];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    mobile = userInfo[@"w_mobile"];
    self.phoneNum.text = [Unity editMobile:mobile];
    [self wechatCheck];
}
- (UILabel *)mobileL{
    if (!_mobileL) {
        _mobileL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:40])];
        _mobileL.backgroundColor = [Unity getColor:@"#f0f0f0"];
        _mobileL.text = @"   手机号绑定";
        _mobileL.textColor = LabelColor3;
    }
    return _mobileL;
}
- (UIButton *)mobileB{
    if (!_mobileB) {
        _mobileB = [[UIButton alloc]initWithFrame:CGRectMake(0, _mobileL.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        [_mobileB addTarget:self action:@selector(phoneClick) forControlEvents:UIControlEventTouchUpInside];
        UIImageView * phoneIcon = [Unity imageviewAddsuperview_superView:_mobileB _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:20], [Unity countcoordinatesH:20]) _imageName:@"手机" _backgroundColor:nil];
        _phoneNum = [Unity lableViewAddsuperview_superView:_mobileB _subViewFrame:CGRectMake(phoneIcon.right+[Unity countcoordinatesW:10], phoneIcon.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:20]) _string:[Unity editMobile:mobile] _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        UILabel * label = [Unity lableViewAddsuperview_superView:_mobileB _subViewFrame:CGRectMake(_phoneNum.right, _phoneNum.top, [Unity countcoordinatesH:155], [Unity countcoordinatesH:20]) _string:@"更换手机号" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentRight];
        UIImageView * icon = [Unity imageviewAddsuperview_superView:_mobileB _subViewFrame:CGRectMake(label.right+[Unity countcoordinatesW:10], [Unity countcoordinatesH:20], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10]) _imageName:@"go" _backgroundColor:nil];
        icon.backgroundColor = [UIColor clearColor];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:50]-1, SCREEN_WIDTH, 1)];
        line.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [_mobileB addSubview:line];
    }
    return _mobileB;
}
- (UILabel *)otherL{
    if (!_otherL) {
        _otherL = [[UILabel alloc]initWithFrame:CGRectMake(0, _mobileB.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:40])];
        _otherL.backgroundColor = [Unity getColor:@"#f0f0f0"];
        _otherL.text = @"   其他绑定";
        _otherL.textColor = LabelColor3;
    }
    return _otherL;
}
- (UIButton *)wechatB{
    if (!_wechatB) {
        _wechatB = [[UIButton alloc]initWithFrame:CGRectMake(0, _otherL.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        [_wechatB addTarget:self action:@selector(wechatClick) forControlEvents:UIControlEventTouchUpInside];
        UIImageView * wechatIcon = [Unity imageviewAddsuperview_superView:_wechatB _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:20], [Unity countcoordinatesH:20]) _imageName:@"微信" _backgroundColor:nil];
        _wechatL = [Unity lableViewAddsuperview_superView:_wechatB _subViewFrame:CGRectMake(wechatIcon.right+[Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:180], [Unity countcoordinatesH:20]) _string:@"微信" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        _wechatName = [Unity lableViewAddsuperview_superView:_wechatB _subViewFrame:CGRectMake(_wechatL.left, [Unity countcoordinatesH:25], _wechatL.width, [Unity countcoordinatesH:20]) _string:@"尼古拉斯·赵四" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentLeft];
        _wechatName.hidden=YES;
        _wechatBid = [Unity lableViewAddsuperview_superView:_wechatB _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:70], [Unity countcoordinatesH:15], [Unity countcoordinatesW:60], [Unity countcoordinatesH:20]) _string:@"已绑定" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentRight];
        _wechatBid.hidden=YES;
        
        _wechatUn = [Unity lableViewAddsuperview_superView:_wechatB _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:85], [Unity countcoordinatesH:15], [Unity countcoordinatesW:60], [Unity countcoordinatesH:20]) _string:@"未绑定" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentRight];
        
         _wechatGo = [Unity imageviewAddsuperview_superView:_wechatB _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:15], [Unity countcoordinatesH:20], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10]) _imageName:@"go" _backgroundColor:nil];
        
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:50]-1, SCREEN_WIDTH, 1)];
        line.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [_wechatB addSubview:line];
    }
    return _wechatB;
}
- (UIButton *)emailB{
    if (!_emailB) {
        _emailB = [[UIButton alloc]initWithFrame:CGRectMake(0, _wechatB.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        [_emailB addTarget:self action:@selector(emailClick) forControlEvents:UIControlEventTouchUpInside];
        UIImageView * emailIcon = [Unity imageviewAddsuperview_superView:_emailB _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:20], [Unity countcoordinatesH:20]) _imageName:@"邮箱" _backgroundColor:nil];
        _emailL = [Unity lableViewAddsuperview_superView:_emailB _subViewFrame:CGRectMake(emailIcon.right+[Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:180], [Unity countcoordinatesH:20]) _string:@"邮箱" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        _emailName = [Unity lableViewAddsuperview_superView:_emailB _subViewFrame:CGRectMake(_emailL.left, [Unity countcoordinatesH:25], _emailL.width, [Unity countcoordinatesH:20]) _string:@"123456789@qq.com" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentLeft];
        _emailName.hidden=YES;
        _emailBid = [Unity lableViewAddsuperview_superView:_emailB _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:70], [Unity countcoordinatesH:15], [Unity countcoordinatesW:60], [Unity countcoordinatesH:20]) _string:@"已验证" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentRight];
        _emailBid.hidden=YES;
        
        _emailUn = [Unity lableViewAddsuperview_superView:_emailB _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:85], [Unity countcoordinatesH:15], [Unity countcoordinatesW:60], [Unity countcoordinatesH:20]) _string:@"未验证" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentRight];
        
        _emailGo = [Unity imageviewAddsuperview_superView:_emailB _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:15], [Unity countcoordinatesH:20], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10]) _imageName:@"go" _backgroundColor:nil];
        
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:50]-1, SCREEN_WIDTH, 1)];
        line.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [_emailB addSubview:line];
    }
    return _emailB;
}
//更换手机账号
- (void)phoneClick{
    BdMobileViewController * bvc = [[BdMobileViewController alloc]init];
    bvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bvc animated:YES];
}
//绑定微信
- (void)wechatClick{
//    _wechatL.frame = CGRectMake([Unity countcoordinatesW:40], [Unity countcoordinatesH:5], [Unity countcoordinatesW:180], [Unity countcoordinatesH:20]);
//    _wechatName.hidden=NO;
//    _wechatBid.hidden=NO;
//    _wechatUn.hidden = YES;
//    _wechatGo.hidden = YES;
    if (!isWechatBind) {
        //去绑定
        extern BOOL isLogin;
        isLogin = NO;
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
}
//邮箱绑定
- (void)emailClick{
    _emailL.frame = CGRectMake([Unity countcoordinatesW:40], [Unity countcoordinatesH:5], [Unity countcoordinatesW:180], [Unity countcoordinatesH:20]);
    _emailName.hidden=NO;
    _emailBid.hidden=NO;
    _emailUn.hidden = YES;
    _emailGo.hidden = YES;
    
    EmailViewController * evc = [[EmailViewController alloc]init];
    evc.hidesBottomBarWhenPushed= YES;
    [self.navigationController pushViewController:evc animated:YES];
}
- (void)wechatCheck{
    NSDictionary * info = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    if (![info[@"wechat_openid"]isEqualToString:@""]) {
        //已绑定
        isWechatBind = YES;
        _wechatBid.hidden=NO;
        _wechatUn.hidden = YES;
        _wechatGo.hidden = YES;
    }else{
        isWechatBind = NO;
        _wechatBid.hidden=YES;
        _wechatUn.hidden = NO;
        _wechatGo.hidden = NO;
    }
    
}
- (void)bindWeChatUnionid:(NSString *)unionid WithOpenid:(NSString *)openid{
    NSDictionary * info = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    
    NSDictionary * dic = @{@"openid":openid,@"unionid":unionid,@"type":@"wechatbind",@"userid":info[@"member_id"]};
    [GZMrequest postWithURLString:[GZMUrl get_login_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        NSLog(@"%@",data);
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            isWechatBind = YES;
            self.wechatBid.hidden=NO;
            self.wechatUn.hidden = YES;
            self.wechatGo.hidden = YES;
            NSMutableDictionary * dict = [info mutableCopy];
            [dict setObject:openid forKey:@"wechat_openid"];
            [dict setObject:unionid forKey:@"wechat_unionid"];
            [[NSUserDefaults standardUserDefaults]setObject:dict forKey:@"userInfo"];
        }else{
            [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
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
