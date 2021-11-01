//
//  CashViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/10.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "CashViewController.h"
#import "CashSuccess.h"
#import "CashFailure.h"
#import "PayPassWordView.h"
@interface CashViewController ()<UITextFieldDelegate,PayPassWordViewDelegate>
{
    UIView * KeyView;
    BOOL isPass;
    NSString *password;
    UIView * passWordView;
    NSMutableArray * textMuArray;
}

@property (nonatomic,strong) UIView * backView;
@property (nonatomic , strong) UILabel * cashTL;
@property (nonatomic , strong) UITextField * placeText;
@property (nonatomic , strong) UIButton * allBtn;
@property (nonatomic , strong) UILabel * rmbL;
@property (nonatomic , strong) UIView * line;

@property (nonatomic , strong) UIButton * cashBtn;
@property (nonatomic,strong) UIView * maskView;
@property (nonatomic , strong) CashSuccess * sView;
@property (nonatomic , strong) CashFailure *fView;
@end

@implementation CashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    password = @"";
    isPass=NO;
    [self createUI];
    [self createKeyboard];
    [self inputPassWord];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"退款";
    self.view.backgroundColor = [Unity getColor:@"#f0f0f0"];
}
- (void)createUI{
    [self.view addSubview:self.backView];
    [self.view addSubview:self.cashBtn];
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
- (UIButton *)cashBtn{
    if (!_cashBtn) {
        _cashBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _backView.bottom+[Unity countcoordinatesH:35], SCREEN_WIDTH- [Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
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
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    NSLog(@"123123");
    [self showKeyboard];
    return NO;
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
            NSString * str = [NSString stringWithFormat:@"%d",btn.tag -665];
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
        NSLog(@"密码输入完成");
//        [self cashPlace:self.placeText.text Pwd:password];
        
        
        //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"输入的密码是" message:password delegate:nil cancelButtonTitle:@"完成" otherButtonTitles:nil, nil];
        //        [alert show];
    }
}





- (void)allClick{
//    self.sView.amountL.text = @"5000.00";
//    [self.sView showCashSuccess];
    
//    self.fView.amountL.text = @"5000.00";
//    self.fView.msgL.text = @"余额不足";
//    [self.fView showCashFailuer];
//    if ([self.balance floatValue] >0) {
        self.placeText.text = self.balance;
//    }
    
    
}
- (void)cashClick{
//    if ([_textField.text intValue]>[self.balance intValue]) {
//        [self cashFailureMessage:@"余额不足" Place:[NSString stringWithFormat:@"%.2f",[self.textField.text floatValue]]];
//        [self.altView showAlertView];
//        return;
//    }
    if ([self.placeText.text isEqualToString:@""]) {
        return;
    }
    [self showKeyboard];
    [self showPass];
}
- (CashSuccess *)sView{
    if (!_sView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _sView = [CashSuccess setCashSuccess:window];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
