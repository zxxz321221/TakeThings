//
//  HaitaoSendScreenViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/3/9.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "HaitaoSendScreenViewController.h"

@interface HaitaoSendScreenViewController ()
{
    UIButton * _seleteBtn;
}
@property (nonatomic , strong) UIView * navView;
@property (nonatomic , strong) UIButton * leftBtn;
@property (nonatomic , strong) UIButton * rightBtn;
@property (nonatomic , strong) UILabel * navL;
@property (nonatomic , strong) UILabel * lineL;
@property (nonatomic , strong) UILabel * titleL;

@property (nonatomic , strong) UILabel * overTimeL;//结标时间
@property (nonatomic , strong) UILabel * createTimeL;//委托时间

@property (nonatomic , strong) UIButton * confirmBtn;
@end

@implementation HaitaoSendScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}
- (void)createUI{
    [self.view addSubview:self.navView];
    [self.view addSubview:self.titleL];
    [self.view addSubview:self.overTimeL];
    
    [self createButton];
    
    
    
    [self.view addSubview:self.confirmBtn];
    
}
- (UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight)];
        _navView.backgroundColor = [UIColor whiteColor];
        
        [_navView addSubview:self.leftBtn];
        [_navView addSubview:self.rightBtn];
        [_navView addSubview:self.navL];
        [_navView addSubview:self.lineL];
    }
    return _navView;
}
- (UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(12, NavBarHeight-44+7.5, 28.5, 28.5)];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"screenX"] forState:UIControlStateNormal];
        _leftBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_leftBtn addTarget:self action:@selector(exitClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _leftBtn;
}
- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-62, NavBarHeight-44+7.5, 50, 28.5)];
        [_rightBtn addTarget:self action:@selector(resetClick) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn setTitle:@"重置" forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        _rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightBtn;
}
- (UILabel *)navL{
    if (!_navL) {
        _navL = [[UILabel alloc]initWithFrame:CGRectMake(50, StatusBarHeight, SCREEN_WIDTH-100, 44)];
        _navL.text = @"筛选条件";
        _navL.textColor = LabelColor3;
        _navL.font = [UIFont systemFontOfSize:17];
        _navL.textAlignment = NSTextAlignmentCenter;
    }
    return _navL;
}
- (UILabel *)lineL{
    if (!_lineL) {
        _lineL = [[UILabel alloc]initWithFrame:CGRectMake(0, NavBarHeight-1, SCREEN_WIDTH, 1)];
        _lineL.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _lineL;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], NavBarHeight+[Unity countcoordinatesH:25], 100, [Unity countcoordinatesH:20])];
        _titleL.text = @"时间排序";
        _titleL.font = [UIFont systemFontOfSize:FontSize(16)];
        _titleL.textColor = LabelColor3;
    }
    return _titleL;
}
- (UILabel *)overTimeL{
    if (!_overTimeL) {
        _overTimeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], _titleL.bottom+[Unity countcoordinatesW:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _overTimeL.text = @"按委托生成时间";
        _overTimeL.textColor = LabelColor3;
        _overTimeL.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _overTimeL;
}
- (void)createButton{

    NSArray * arr = @[@"顺序",@"倒叙"];
    for (int i=0; i<2; i++) {
        UIButton * btn = [[UIButton  alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:130]+(i%2*[Unity countcoordinatesW:55]), _overTimeL.top+(i/2*[Unity countcoordinatesH:35]), [Unity countcoordinatesW:45], [Unity countcoordinatesH:20])];
        btn.tag = 1000+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[Unity getColor:@"494949"] forState:UIControlStateNormal];
        [btn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateSelected];
        btn.backgroundColor = [Unity getColor:@"f0f0f0"];
        btn.layer.cornerRadius = btn.height/2;
        btn.titleLabel.font = [UIFont systemFontOfSize:FontSize(13)];
        
        [self.view addSubview:btn];
        if (i==self.order) {
            btn.selected = YES;
            btn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
            btn.layer.borderWidth = 1;
            btn.backgroundColor = [UIColor whiteColor];
            _seleteBtn = btn;
        }
    }
}
- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], SCREEN_HEIGHT-StatusBarHeight-[Unity countcoordinatesH:60], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        [_confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
        _confirmBtn.layer.cornerRadius = _confirmBtn.height/2;
        _confirmBtn.backgroundColor = [Unity getColor:@"aa112d"];
    }
    return _confirmBtn;
}
/**
 关闭弹出框
 */
- (void)exitClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 重置
 */
- (void)resetClick{
    if (self.order != 1) {
        _seleteBtn.selected = NO;
        _seleteBtn.layer.borderColor = [Unity getColor:@"f0f0f0"].CGColor;
        _seleteBtn.layer.borderWidth = 1;
        _seleteBtn.backgroundColor = [Unity getColor:@"f0f0f0"];
        
        UIButton * btn = (UIButton *)[self.view viewWithTag:1001];
        btn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        btn.layer.borderWidth = 1;
        btn.backgroundColor = [UIColor whiteColor];
        btn.selected = YES;
        _seleteBtn = btn;
        self.order = 1;
    }
}
/**
 确定
 */
- (void)confirmClick{
    [self.delegate haitaoSendScreen:self.order];
    [self exitClick];
}
/**
 时间排序
 */
- (void)btnClick:(UIButton *)btn{
    self.order = btn.tag-1000;
    if (btn != _seleteBtn) {
        _seleteBtn.selected = NO;
        _seleteBtn.layer.borderColor = [Unity getColor:@"f0f0f0"].CGColor;
        _seleteBtn.layer.borderWidth = 1;
        _seleteBtn.backgroundColor = [Unity getColor:@"f0f0f0"];
        
        btn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        btn.layer.borderWidth = 1;
        btn.backgroundColor = [UIColor whiteColor];
        btn.selected = YES;
        _seleteBtn = btn;
        
    }
}
@end
