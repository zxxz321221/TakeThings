//
//  ResetPasswordViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/28.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "UIViewController+YINNav.h"
@interface ResetPasswordViewController ()
@property (nonatomic , strong) UITextField * passWord;
@property (nonatomic , strong) UITextField * nPassWord;
@property (nonatomic , strong) UILabel * line1;
@property (nonatomic , strong) UILabel * line2;
@property (nonatomic , strong) UILabel * line3;
@property (nonatomic , strong) UILabel * markL;
@property (nonatomic , strong) UIButton * nextBtn;

@property (nonatomic , strong) alertView * altView;
@property (nonatomic , strong) AroundAnimation * aAnimation;
@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.y_navLineHidden = YES;
    [self.navigationItem setTitle:@"修改登录密码"];
    [self creareUI];
}
- (void)creareUI{
    [self.view addSubview:self.line1];
    [self.view addSubview:self.passWord];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.nPassWord];
    [self.view addSubview:self.line3];
    [self.view addSubview:self.markL];
    [self.view addSubview:self.nextBtn];
    
}
- (UILabel *)line1{
    if (!_line1) {
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        _line1.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line1;
}
- (UITextField *)passWord{
    if (!_passWord) {
        _passWord = [[UITextField alloc]initWithFrame:CGRectMake(0, _line1.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        _passWord.secureTextEntry = YES;
        _passWord.placeholder = @"请输入当前密码";
        _passWord.keyboardType = UIKeyboardTypeASCIICapable;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [Unity countcoordinatesW:10], 0)];
        leftView.backgroundColor = [UIColor clearColor];
        // 保证点击缩进的view，也可以调出光标
        leftView.userInteractionEnabled = NO;
        _passWord.leftView = leftView;
        _passWord.leftViewMode = UITextFieldViewModeAlways;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)name:@"UITextFieldTextDidChangeNotification"object:_passWord];

    }
    return _passWord;
}
- (UILabel *)line2{
    if (!_line2) {
        _line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, _passWord.bottom, SCREEN_WIDTH, 1)];
        _line2.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line2;
}
- (UITextField *)nPassWord{
    if (!_nPassWord) {
        _nPassWord = [[UITextField alloc]initWithFrame:CGRectMake(0, _line2.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        _nPassWord.secureTextEntry = YES;
        _nPassWord.placeholder = @"请输入新密码";
        _nPassWord.keyboardType = UIKeyboardTypeASCIICapable;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [Unity countcoordinatesW:10], 0)];
        leftView.backgroundColor = [UIColor clearColor];
        // 保证点击缩进的view，也可以调出光标
        leftView.userInteractionEnabled = NO;
        _nPassWord.leftView = leftView;
        _nPassWord.leftViewMode = UITextFieldViewModeAlways;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged1:)name:@"UITextFieldTextDidChangeNotification"object:_nPassWord];
    }
    return _nPassWord;
}
- (UILabel *)line3{
    if (!_line3) {
        _line3 = [[UILabel alloc]initWithFrame:CGRectMake(0, _nPassWord.bottom, SCREEN_WIDTH, 1)];
        _line3.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line3;
}
- (UILabel *)markL{
    if (!_markL) {
        _markL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line3.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _markL.text = @"8-16个字符,请使用字母加数字或者符号的组合密码";
        _markL.textColor = LabelColor6;
        _markL.textAlignment = NSTextAlignmentLeft;
        _markL.font = [UIFont systemFontOfSize:13];
    }
    return _markL;
}
- (UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _markL.bottom+[Unity countcoordinatesH:30], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextBtn.backgroundColor = [Unity getColor:@"#cb6d7f"];
        _nextBtn.layer.cornerRadius = [Unity countcoordinatesH:20];
        [_nextBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.userInteractionEnabled = NO;
    }
    return _nextBtn;
}
- (void)nextClick{
    if (![Unity isSafePassword:self.nPassWord.text]) {
        [WHToast showMessage:@"格式不正确" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        return;
    }
    [self changeLoginPassword];
}
-(void)textFiledEditChanged:(NSNotification*)notification{
    [self loadStatus];
    UITextField*textField = notification.object;
    
    NSString*str = textField.text;
    
    for (int i = 0; i<str.length; i++)
        
    {
        NSString*string = [str substringFromIndex:i];
        NSString *regex = @"[\u4e00-\u9fa5]{0,}$"; // 中文
        // 2、拼接谓词
        NSPredicate *predicateRe1 = [NSPredicate predicateWithFormat:@"self matches %@", regex];
        // 3、匹配字符串
        BOOL resualt = [predicateRe1 evaluateWithObject:string];
        if (resualt){
            //是中文替换为空字符串
            str =  [str stringByReplacingOccurrencesOfString:[str substringFromIndex:i] withString:@""];
        }
    }
    textField.text = str;
    NSLog(@"%@",str);
}
-(void)textFiledEditChanged1:(NSNotification*)notification{
    [self loadStatus];
    UITextField*textField = notification.object;
    
    NSString*str = textField.text;
    
    for (int i = 0; i<str.length; i++)
        
    {
        NSString*string = [str substringFromIndex:i];
        NSString *regex = @"[\u4e00-\u9fa5]{0,}$"; // 中文
        // 2、拼接谓词
        NSPredicate *predicateRe1 = [NSPredicate predicateWithFormat:@"self matches %@", regex];
        // 3、匹配字符串
        BOOL resualt = [predicateRe1 evaluateWithObject:string];
        if (resualt){
            //是中文替换为空字符串
            str =  [str stringByReplacingOccurrencesOfString:[str substringFromIndex:i] withString:@""];
        }
    }
    textField.text = str;
    NSLog(@"%@",str);
}
//判断字符串中是否包含数字和字母
- (BOOL)isStringContainNumberWith:(NSString *)str {
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"A-Za-z0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger count = [numberRegular numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    //count是str中包含[A-Za-z0-9]数字的个数，只要count>0，说明str中包含数字
    if (count > 0) {
        return YES;
        
    }return NO;
    
}
- (void)loadStatus{
    if (self.passWord.text.length !=0 && self.nPassWord.text.length !=0) {
        self.nextBtn.userInteractionEnabled = YES;
        self.nextBtn.backgroundColor = [Unity getColor:@"aa112d"];
    }else{
        self.nextBtn.userInteractionEnabled = NO;
        self.nextBtn.backgroundColor = [Unity getColor:@"cb6d7f"];
    }
}
- (void)changeLoginPassword{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSLog(@"%@",[userInfo objectForKey:@"member_id"]);
    NSDictionary * dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"old":self.passWord.text,@"new":self.nPassWord.text};
    [self.aAnimation startAround];
    [GZMrequest postWithURLString:[GZMUrl get_loginPass_url] parameters:dic success:^(NSDictionary *data) {
        [self.aAnimation stopAround];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
//            NSMutableDictionary * dic = [NSMutableDictionary new];
//            [dic setObject:self.nPassWord.text forKey:@"loginPass"];
//            [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"userInfo"];
            [WHToast showMessage:@"登录密码修改成功" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
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
- (alertView *)altView{
    if (_altView == nil) {
        _altView = [alertView setAlertView:self.view];
    }
    return _altView;
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
