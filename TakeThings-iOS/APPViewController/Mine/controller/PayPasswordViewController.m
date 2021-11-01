//
//  PayPasswordViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/28.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "PayPasswordViewController.h"

#import "VerificationCodeView.h"
#import "ConfirmPayViewController.h"
#import "UIViewController+YINNav.h"
@interface PayPasswordViewController ()
@property (nonatomic , strong) UIView * navView;
@property (nonatomic, strong) VerificationCodeView *codeView;
@property (nonatomic , strong) UILabel * navLine;
@property (nonatomic , strong) UILabel * label;
@property (nonatomic , strong) UILabel * markL;
@property (nonatomic , strong) UIButton * nextBtn;
@property (nonatomic , strong) NSString * passWord;

@property (nonatomic , strong) AroundAnimation * aAnimation;
@end

@implementation PayPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.y_navLineHidden = YES;
    [self.navigationItem setTitle:@"修改支付密码"];
    
    [self creareUI];
    
    
}
- (void)creareUI{
    [self.view addSubview:self.navView];
    [self.view addSubview:self.navLine];
    [self.view addSubview:self.label];
    [self.view addSubview:self.codeView];
    [self.view addSubview:self.markL];
    [self.view addSubview:self.nextBtn];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight)];
        _navView.backgroundColor = [UIColor whiteColor];
        UILabel * title = [Unity lableViewAddsuperview_superView:_navView _subViewFrame:CGRectMake([Unity countcoordinatesW:60], StatusBarHeight, [Unity countcoordinatesW:200], 44) _string:@"修改支付密码" _lableFont:[UIFont systemFontOfSize:17] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentCenter];
        title.backgroundColor = [UIColor clearColor];
        UIButton * back = [Unity buttonAddsuperview_superView:_navView _subViewFrame:CGRectMake(12, StatusBarHeight+11.5, 11, 21) _tag:self _action:@selector(goBack) _string:@"" _imageName:@"back"];
    }
    return _navView;
}
- (UILabel *)navLine{
    if (!_navLine) {
        _navLine = [[UILabel alloc]initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, 1)];
        _navLine.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _navLine;
}
- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, _navLine.bottom+[Unity countcoordinatesH:20], SCREEN_WIDTH, [Unity countcoordinatesH:20])];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = @"请输入原支付密码";
        _label.textColor = LabelColor3;
        _label.font = [UIFont systemFontOfSize:15];
    }
    return _label;
}
//- (UILabel *)navLine{
//    if (!_navLine) {
//        _navLine = [[UILabel alloc]initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, 1)];
//        _navLine.backgroundColor = [Unity getColor:@"#e0e0e0"];
//    }
//    return _navLine;
//}
//- (UILabel *)label{
//    if (!_label) {
//        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, _navLine.bottom+[Unity countcoordinatesH:20], SCREEN_WIDTH, [Unity countcoordinatesH:20])];
//        _label.textAlignment = NSTextAlignmentCenter;
//        _label.text = @"请输入原支付密码";
//        _label.textColor = LabelColor3;
//        _label.font = [UIFont systemFontOfSize:15];
//    }
//    return _label;
//}
- (VerificationCodeView *)codeView{
    if (!_codeView) {
        _codeView = [[VerificationCodeView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:30], _label.bottom+[Unity countcoordinatesH:20], self.view.bounds.size.width-[Unity countcoordinatesW:60], [Unity countcoordinatesH:43])];
        _codeView.isCodeViewStatus = NO;
        _codeView.mineSecureTextEntry = YES;
        _codeView.isSelectStatus = YES;
        _codeView.completeBlock = ^(NSString *completeStr) {
            NSLog(@"---***%@",completeStr);
            if (completeStr.length == 6) {
                self.nextBtn.backgroundColor = [Unity getColor:@"aa112d"];
                self.nextBtn.userInteractionEnabled = YES;
            }
            self->_passWord = completeStr;
        };
        _codeView.deleteBlock = ^(){
            self.nextBtn.backgroundColor = [Unity getColor:@"cb6d7f"];
            self.nextBtn.userInteractionEnabled = NO;
        };
    }
    return _codeView;
}
- (UILabel *)markL{
    if (!_markL) {
        _markL = [[UILabel  alloc]initWithFrame:CGRectMake(0, _codeView.bottom+[Unity countcoordinatesH:20], SCREEN_WIDTH, [Unity countcoordinatesH:20])];
        _markL.textAlignment = NSTextAlignmentCenter;
        _markL.text = @"为确保安全请输入原支付密码，确本人操作";
        _markL.textColor = LabelColor6;
        _markL.font = [UIFont systemFontOfSize:15];
    }
    return _markL;
}
- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _markL.bottom+[Unity countcoordinatesH:40], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
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
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    [self.aAnimation startAround];
    NSDictionary *params = @{@"customer":userInfo[@"member_id"],@"old":self.passWord};
    [GZMrequest postWithURLString:[GZMUrl get_oldPayPass_url] parameters:params success:^(NSDictionary *data) {
        NSLog(@"旧密码验证%@",data);
        [self.aAnimation stopAround];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            ConfirmPayViewController * cvc = [[ConfirmPayViewController alloc]init];
            cvc.hidesBottomBarWhenPushed = YES;
            cvc.token = data[@"data"];
            [self.navigationController pushViewController:cvc animated:YES];
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
- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
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
