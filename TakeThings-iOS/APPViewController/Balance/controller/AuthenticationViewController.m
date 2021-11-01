//
//  AuthenticationViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/11.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "AuthenticationViewController.h"
#import "SetPayPasswordViewController.h"
#import "UIViewController+YINNav.h"
@interface AuthenticationViewController ()
{
    NSString * mobile;
}
@property (nonatomic , strong) UILabel * navLine;
@property (nonatomic , strong) UILabel * emailL;
@property (nonatomic , strong) UILabel *validationL;
@property (nonatomic , strong) UITextField * codeText;
@property (nonatomic , strong) UIButton * codeBtn;
@property (nonatomic , strong) UILabel * line;
@property (nonatomic , strong) UIButton * boundBtn;
@end

@implementation AuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    mobile = userInfo[@"w_mobile"];
    self.y_navLineHidden = YES;
    [self.navigationItem setTitle:@"设置支付密码验证"];
    [self creareUI];
    
}
- (void)creareUI{
    [self.view addSubview:self.navLine];
    [self.view addSubview:self.emailL];
    [self.view addSubview:self.validationL];
    [self.view addSubview:self.codeText];
    [self.view addSubview:self.codeBtn];
    [self.view addSubview:self.line];
    [self.view addSubview:self.boundBtn];
    
}
- (UILabel *)navLine{
    if (!_navLine) {
        _navLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        _navLine.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _navLine;
}
- (UILabel *)emailL{
    if (!_emailL) {
        _emailL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _emailL.text = [NSString stringWithFormat:@"验证码已发送至 %@",[Unity editMobile:mobile]];
        _emailL.textColor = LabelColor3;
        _emailL.font = [UIFont systemFontOfSize:15];
    }
    return _emailL;
}
- (UILabel * )validationL{
    if (!_validationL) {
        _validationL = [[UILabel alloc]initWithFrame:CGRectMake(_emailL.left, _emailL.bottom+[Unity countcoordinatesH:15], 100, [Unity countcoordinatesH:20])];
        _validationL.text = @"请验证";
        _validationL.textColor = LabelColor3;
        _validationL.font = [UIFont systemFontOfSize:15];
    }
    return _validationL;
}
- (UITextField *)codeText{
    if (!_codeText) {
        _codeText = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _validationL.bottom+[Unity countcoordinatesH:30], [Unity countcoordinatesW:150], [Unity countcoordinatesH:20])];
        _codeText.placeholder = @"请输入短信验证码";
        _codeText.keyboardType = UIKeyboardTypeNumberPad;
        [_codeText addTarget:self action:@selector(codeText:) forControlEvents:UIControlEventEditingChanged];
    }
    return _codeText;
}
- (UIButton *)codeBtn{
    if (!_codeBtn) {
        _codeBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:110], _validationL.bottom+[Unity countcoordinatesH:25], [Unity countcoordinatesW:100], [Unity countcoordinatesH:30])];
        _codeBtn.layer.cornerRadius = 17;
        _codeBtn.backgroundColor = [Unity getColor:@"#f0f0f0"];
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_codeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_codeBtn setTitleColor:LabelColor9 forState:UIControlStateNormal];
        [_codeBtn addTarget:self action:@selector(codeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeBtn;
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(0, _codeText.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH, 1)];
        _line.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line;
}
- (UIButton *)boundBtn{
    if (_boundBtn == nil) {
        _boundBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line.bottom+[Unity countcoordinatesH:20], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        _boundBtn.layer.cornerRadius = [Unity countcoordinatesH:20];
        [_boundBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
        _boundBtn.backgroundColor = [Unity getColor:@"#cb6d7f"];
        [_boundBtn setTitle:@"确定" forState:UIControlStateNormal];
        _boundBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_boundBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
        _boundBtn.userInteractionEnabled = NO;
    }
    return _boundBtn;
}

- (void)codeBtnClick{
    [Unity showanimate];
    NSDictionary *params = @{@"mobileNum":mobile,@"type":@"1"};
    [GZMrequest postWithURLString:[GZMUrl get_code_url]parameters:params success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            [self startTime];
        }else{
            self.codeBtn.userInteractionEnabled = YES;
            [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        self.codeBtn.userInteractionEnabled = YES;
        [Unity hiddenanimate];
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
- (void)nextClick{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    [Unity hiddenanimate];
    NSDictionary *params = @{@"customer":userInfo[@"member_id"],@"code":self.codeText.text};
    [GZMrequest postWithURLString:[GZMUrl get_userAuthen_url] parameters:params success:^(NSDictionary *data) {
//        NSLog(@"验证用户%@",data);
        [Unity hiddenanimate];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            SetPayPasswordViewController * svc = [[SetPayPasswordViewController alloc]init];
            svc.token = data[@"data"];
            [self.navigationController pushViewController:svc animated:YES];
        }else{
            [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}

- (void)codeText:(UITextField *)textField{
    if (textField.text.length == 0) {
        self.boundBtn.backgroundColor = [Unity getColor:@"#cb6d7f"];
        self.boundBtn.userInteractionEnabled = NO;
    }else{
        self.boundBtn.backgroundColor = [Unity getColor:@"#aa112d"];
        self.boundBtn.userInteractionEnabled = YES;
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
