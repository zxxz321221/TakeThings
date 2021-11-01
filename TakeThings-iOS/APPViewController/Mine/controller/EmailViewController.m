//
//  EmailViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/30.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "EmailViewController.h"
#import "UIViewController+YINNav.h"
@interface EmailViewController ()
@property (nonatomic , strong) UILabel * navLine;
@property (nonatomic , strong) UILabel * emailL;
@property (nonatomic , strong) UILabel *validationL;
@property (nonatomic , strong) UITextField * codeText;
@property (nonatomic , strong) UIButton * codeBtn;
@property (nonatomic , strong) UILabel * line;
@property (nonatomic , strong) UIButton * boundBtn;
@end

@implementation EmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.y_navLineHidden = YES;
    [self.navigationItem setTitle:@"邮箱绑定"];
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
        _emailL.text = @"邮箱绑定：12345678@qq.com";
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
        _codeText.placeholder = @"请输入邮箱验证码";
        _codeText.keyboardType = UIKeyboardTypeNumberPad;
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
    }
    return _boundBtn;
}

- (void)codeBtnClick{
    [self startTime];
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
