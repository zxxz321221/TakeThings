//
//  RefundViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/7/8.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "RefundViewController.h"

@interface RefundViewController ()
{
    NSMutableArray * textMuArray;
    NSString *password;
}
@property (nonatomic , strong) UIView * topView;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UILabel * placeL;

@property (nonatomic , strong) UIButton * refundBtn;

@property (nonatomic , strong) UIView * maskView;
@property (nonatomic , strong) UIView * bottomView;

@property (nonatomic , strong) UIView * passWordView;
@property (nonatomic , strong) UIView * keybordView;
@end

@implementation RefundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    password = @"";
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.title = @"确认退款";
    self.view.backgroundColor = [Unity getColor:@"f0f0f0"];
}
- (void)createUI{
    [self.view addSubview:self.topView];
    [self.view addSubview:self.refundBtn];
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskView];
}
- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:150])];
        _topView.backgroundColor = [UIColor whiteColor];
        
        [_topView addSubview:self.titleL];
        [_topView addSubview:self.placeL];
    }
    return _topView;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:20], 200, [Unity countcoordinatesH:15])];
        _titleL.text = @"退款金额(RMB)";
        _titleL.textColor = LabelColor3;
        _titleL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _titleL;
}
- (UILabel *)placeL{
    if (!_placeL) {
        _placeL = [[UILabel alloc]initWithFrame:CGRectMake(0, _titleL.bottom+[Unity countcoordinatesH:20], SCREEN_WIDTH, [Unity countcoordinatesH:55])];
        _placeL.text = [NSString stringWithFormat:@"%ld",(long)self.place];
        _placeL.textColor = LabelColor3;
        _placeL.textAlignment = NSTextAlignmentCenter;
        _placeL.font = [UIFont systemFontOfSize:FontSize(55)];
    }
    return _placeL;
}

- (UIButton *)refundBtn{
    if (!_refundBtn) {
        _refundBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _topView.bottom+[Unity countcoordinatesH:35], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        [_refundBtn addTarget:self action:@selector(refundClick) forControlEvents:UIControlEventTouchUpInside];
        [_refundBtn setTitle:@"申请退款" forState:UIControlStateNormal];
        [_refundBtn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
        _refundBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        _refundBtn.layer.borderWidth = 1;
        _refundBtn.layer.cornerRadius = _refundBtn.height/2;
        _refundBtn.layer.masksToBounds =YES;
    }
    return _refundBtn;
}
- (void)refundClick{
    
    self.maskView.hidden= NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomView.frame = CGRectMake(0, SCREEN_HEIGHT-[Unity countcoordinatesH:350], SCREEN_WIDTH, [Unity countcoordinatesH:350]);
    }];
}

- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        _maskView.userInteractionEnabled = YES;
        _maskView.hidden=YES;
        
        [_maskView addSubview:self.bottomView];
        
    }
    return _maskView;
}
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, [Unity countcoordinatesH:350])];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        [_bottomView addSubview:self.passWordView];
        [_bottomView addSubview:self.keybordView];
    }
    return _bottomView;
}
- (UIView *)passWordView{
    if (!_passWordView) {
        _passWordView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:150])];
        _passWordView.backgroundColor = [Unity getColor:@"#f0f0f0"];
        
        UIButton * cancel = [Unity buttonAddsuperview_superView:_passWordView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:12], [Unity countcoordinatesW:16], [Unity countcoordinatesH:16]) _tag:self _action:@selector(cancelClick) _string:@"" _imageName:@"X"];
        cancel.backgroundColor = [UIColor clearColor];
        UILabel * tishi = [Unity lableViewAddsuperview_superView:_passWordView _subViewFrame:CGRectMake(80, [Unity countcoordinatesH:10], SCREEN_WIDTH-160, [Unity countcoordinatesH:20]) _string:@"请输入支付密码" _lableFont:[UIFont systemFontOfSize:FontSize(17)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentCenter];
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
            [_passWordView addSubview:pwdLabel];
            
            [textMuArray addObject:pwdLabel];
        }
        UIButton * forgotBtn = [Unity buttonAddsuperview_superView:_passWordView _subViewFrame:CGRectMake((SCREEN_WIDTH-100)/2, [Unity countcoordinatesH:100], 100, [Unity countcoordinatesH:30]) _tag:self _action:@selector(forgotClick) _string:@"忘记密码?" _imageName:@""];
        [forgotBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        forgotBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _passWordView;
}
- (UIView *)keybordView{
    if (!_keybordView) {
        _keybordView = [[UIView alloc]initWithFrame:CGRectMake(0, _passWordView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:200])];
        NSArray * keylist = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"X",@"0",@"."];
        for (int i=0; i<keylist.count; i++) {
            UIButton * btn = [Unity buttonAddsuperview_superView:_keybordView _subViewFrame:CGRectMake((i%3)*(SCREEN_WIDTH/4), (i/3)*[Unity countcoordinatesH:50], SCREEN_WIDTH/4, [Unity countcoordinatesH:50]) _tag:self _action:@selector(keyBoardClick:) _string:@"" _imageName:@""];
            [btn setTitle:keylist[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:24];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.tag = 666+i;
        }
        NSArray * arr = @[@"key_s",@"key_d"];
        for (int j=0; j<arr.count; j++) {
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4*3, j*[Unity countcoordinatesH:100], SCREEN_WIDTH/4, [Unity countcoordinatesH:100])];
            [_keybordView addSubview:btn];
            [btn addTarget:self action:@selector(keyBoardClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundImage:[UIImage imageNamed:arr[j]] forState:UIControlStateNormal];
            btn.adjustsImageWhenHighlighted = NO;
            btn.tag = 678+j;
        }
    }
    return _keybordView;
}
- (void)keyBoardClick:(UIButton *)btn{
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
- (void)cancelClick{
    self.maskView.hidden=YES;
    self.bottomView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, [Unity countcoordinatesH:350]);
    [self passWordInput:@""];
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
