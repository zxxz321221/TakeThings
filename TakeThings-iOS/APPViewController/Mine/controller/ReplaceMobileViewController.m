//
//  ReplaceMobileViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/30.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "ReplaceMobileViewController.h"
#import "UIViewController+YINNav.h"
@interface ReplaceMobileViewController ()
@property (nonatomic , strong) UILabel * navLine;
@property (nonatomic , strong) UILabel * markL;
@property (nonatomic , strong) UITextField * mobileText;
@property (nonatomic , strong) UILabel * line0;
@property (nonatomic , strong) UITextField * codeText;
@property (nonatomic , strong) UIButton * codeBtn;
@property (nonatomic , strong) UILabel * line1;

@property (nonatomic , strong) UIButton * confirmBtn;

@property (nonatomic , strong) AroundAnimation * aAnimation;

@end

@implementation ReplaceMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.y_navLineHidden = YES;
    [self.navigationItem setTitle:@"更换手机号"];
    [self creareUI];
}
- (void)creareUI{
    [self.view addSubview:self.navLine];
    [self.view addSubview:self.markL];
    [self.view addSubview:self.mobileText];
    [self.view addSubview:self.line0];
    [self.view addSubview:self.codeText];
    [self.view addSubview:self.codeBtn];
    [self.view addSubview:self.line1];
    
    [self.view addSubview:self.confirmBtn];
}
- (UILabel *)navLine{
    if (!_navLine) {
        _navLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        _navLine.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _navLine;
}
- (UILabel *)markL{
    if (!_markL) {
        _markL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _navLine.bottom, SCREEN_HEIGHT-[Unity countcoordinatesW:20], [Unity countcoordinatesH:50])];
        _markL.text = @"请输入您要更换的新手机号，并进行验证";
        _markL.textColor = LabelColor3;
        _markL.font = [UIFont systemFontOfSize:15];
    }
    return _markL;
}
- (UITextField *)mobileText{
    if (!_mobileText) {
        _mobileText = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _markL.bottom+[Unity countcoordinatesH:30], [Unity countcoordinatesW:150], [Unity countcoordinatesH:20])];
        _mobileText.placeholder = @"请输入手机号";
        _mobileText.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _mobileText;
}
- (UILabel *)line0{
    if (!_line0) {
        _line0 = [[UILabel alloc]initWithFrame:CGRectMake(0, _mobileText.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH, 1)];
        _line0.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line0;
}
- (UITextField *)codeText{
    if (!_codeText) {
        _codeText = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line0.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:150], [Unity countcoordinatesH:20])];
        _codeText.placeholder = @"请输入短信验证码";
        _codeText.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _codeText;
}
- (UIButton *)codeBtn{
    if (!_codeBtn) {
        _codeBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:110], _line0.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:30])];
        _codeBtn.layer.cornerRadius = 17;
        _codeBtn.backgroundColor = [Unity getColor:@"#f0f0f0"];
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_codeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_codeBtn setTitleColor:LabelColor9 forState:UIControlStateNormal];
        [_codeBtn addTarget:self action:@selector(codeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeBtn;
}
- (UILabel *)line1{
    if (!_line1) {
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, _codeText.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH, 1)];
        _line1.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line1;
}
- (UIButton *)confirmBtn{
    if (_confirmBtn == nil) {
        _confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line1.bottom+[Unity countcoordinatesH:20], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        _confirmBtn.layer.cornerRadius = [Unity countcoordinatesH:20];
        [_confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.backgroundColor = [Unity getColor:@"#cb6d7f"];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_confirmBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
    }
    return _confirmBtn;
}

- (void)codeBtnClick{
    if (self.mobileText.text.length != 11) {
        [WHToast showMessage:@"请输入正确的手机号" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        return;
    }
    [self.aAnimation startAround];
    NSDictionary *params = @{@"mobileNum":self.mobileText.text,@"type":@"3"};
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
- (void)confirmClick{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    [self.aAnimation startAround];
    NSDictionary *params = @{@"customer":userInfo[@"member_id"],@"code":self.codeText.text,@"new":self.mobileText.text,@"token":self.token};
    [GZMrequest postWithURLString:[GZMUrl get_updateMobile_url] parameters:params success:^(NSDictionary *data) {
        NSLog(@"修改绑定手机——原始手机验证%@",data);
        [self.aAnimation stopAround];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            NSMutableDictionary * dic = [NSMutableDictionary new];
            dic = [userInfo mutableCopy];
            [dic setObject:self.mobileText.text forKey:@"w_mobile"];
            
            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"userInfo"];
            NSInteger index = (NSInteger)[[self.navigationController viewControllers] indexOfObject:self];
            if (index > 2) {
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index-2)] animated:YES];
            }else{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
        }else{
            [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
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
