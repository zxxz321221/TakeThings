//
//  SecurityViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/28.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "SecurityViewController.h"
#import "PayPasswordViewController.h"
#import "ResetPasswordViewController.h"
#import "PayPassWordView.h"
#import "AuthenticationViewController.h"
#import "UIViewController+YINNav.h"
@interface SecurityViewController ()<PayPassWordViewDelegate>
@property (nonatomic , strong) PayPassWordView * pView;
@end

@implementation SecurityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.y_navLineHidden = YES;
    [self.navigationItem setTitle:@"账号安全"];
    [self creareUI];
}
- (void)creareUI{
    NSArray * arr = @[@"修改登录密码",@"修改支付密码"];
    for (int i=0; i<arr.count; i++) {
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, i*[Unity countcoordinatesH:50]+i*1, SCREEN_WIDTH, 1)];
        line.backgroundColor = [Unity getColor:@"#e0e0e0"];
        [self.view addSubview: line];
        UIButton * btn = [Unity buttonAddsuperview_superView:self.view _subViewFrame:CGRectMake(0, line.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:50]) _tag:self _action:@selector(btnClick:) _string:@"" _imageName:nil];
        btn.tag = i+1000;
        UILabel * label = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20]) _string:arr[i] _lableFont:[UIFont systemFontOfSize:15] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
        UIImageView * goImg = [Unity imageviewAddsuperview_superView:btn _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:15], [Unity countcoordinatesH:20], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10]) _imageName:@"go" _backgroundColor:nil];
        goImg.userInteractionEnabled=YES;
    }
    UILabel * line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:100]+2, SCREEN_WIDTH, 1)];
    line1.backgroundColor = [Unity getColor:@"#e0e0e0"];
    [self.view addSubview:line1];
}
- (void)btnClick:(UIButton *)btn{
    if (btn.tag == 1000) {//修改登录密码
        ResetPasswordViewController * rvc = [[ResetPasswordViewController alloc]init];
        rvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:rvc animated:YES];
    }else{//修改支付密码
        NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
        if ([userInfo[@"pay_password"] isEqualToString:@""]) {
            [self.pView showPayPasswordView];
            return;
        }
        PayPasswordViewController * pvc = [[PayPasswordViewController alloc]init];
        pvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pvc animated:YES];
    }
}
- (PayPassWordView *)pView{
    if (!_pView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _pView = [PayPassWordView setPayPassWordView:window];
        _pView.delegate = self;
    }
    return _pView;
}
- (void)set{
    NSLog(@"去设置");
    AuthenticationViewController * avc = [[AuthenticationViewController alloc]init];
    [self.navigationController pushViewController:avc animated:YES];
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
