//
//  ShooseGJViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/11.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "ShooseGJViewController.h"
#import "NewHaitaoViewController.h"
@interface ShooseGJViewController ()
{
    NSString * source;
    
}
@property (nonatomic , strong) UILabel * navLine;
@property (nonatomic , strong) UILabel * titleL;

@property (nonatomic , strong) UIButton * japanBtn;
@property (nonatomic , strong) UIImageView * japanImg;
@property (nonatomic , strong) UIButton * usaBtn;
@property (nonatomic , strong) UIImageView * usaImg;

@property (nonatomic , strong) UIButton * confirmBtn;
@end

@implementation ShooseGJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}
- (void)createUI{
    self.title = @"海淘下单";
    [self.view addSubview:self.navLine];
    [self.view addSubview:self.titleL];
    [self.view addSubview:self.japanBtn];
    [self.view addSubview:self.japanImg];
    [self.view addSubview:self.usaBtn];
    [self.view addSubview:self.usaImg];
    [self.view addSubview:self.confirmBtn];
}
#pragma mark ---UI初始化---
- (UILabel *)navLine{
    if (!_navLine) {
        _navLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        _navLine.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return _navLine;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:30], [Unity countcoordinatesH:17], 200, [Unity countcoordinatesH:20])];
        _titleL.text = @"选择国籍:";
        _titleL.textColor = LabelColor3;
        _titleL.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _titleL;
}

- (UIButton *)japanBtn{
    if (!_japanBtn) {
        _japanBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-[Unity countcoordinatesW:100])/2, _titleL.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        [_japanBtn addTarget:self action:@selector(japanClick:) forControlEvents:UIControlEventTouchUpInside];
        [_japanBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_japanBtn setTitle:@"  日本线代购" forState:UIControlStateNormal];
        _japanBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _japanBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_japanBtn setImage:[UIImage imageNamed:@"read_gray"] forState:UIControlStateNormal];
        [_japanBtn setImage:[UIImage imageNamed:@"read_red"] forState:UIControlStateSelected];
    }
    return _japanBtn;
}
- (UIImageView *)japanImg{
    if (!_japanImg) {
        _japanImg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-[Unity countcoordinatesW:170])/2, _japanBtn.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:170], [Unity countcoordinatesH:96])];
        _japanImg.image = [UIImage imageNamed:@"japan_flag"];
    }
    return _japanImg;
}
- (UIButton *)usaBtn{
    if (!_usaBtn) {
        _usaBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-[Unity countcoordinatesW:100])/2, _japanImg.bottom+[Unity countcoordinatesH:25], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        [_usaBtn addTarget:self action:@selector(usaClick:) forControlEvents:UIControlEventTouchUpInside];
        [_usaBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_usaBtn setTitle:@"  美国线代购" forState:UIControlStateNormal];
        _usaBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _usaBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_usaBtn setImage:[UIImage imageNamed:@"read_gray"] forState:UIControlStateNormal];
        [_usaBtn setImage:[UIImage imageNamed:@"read_red"] forState:UIControlStateSelected];
    }
    return _usaBtn;
}
- (UIImageView *)usaImg{
    if (!_usaImg) {
        _usaImg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-[Unity countcoordinatesW:170])/2, _usaBtn.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:170], [Unity countcoordinatesH:96])];
        _usaImg.image = [UIImage imageNamed:@"usa_flag"];
    }
    return _usaImg;
}
- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], SCREEN_HEIGHT-NavBarHeight-bottomH, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        [_confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
        _confirmBtn.layer.cornerRadius = _confirmBtn.height/2;
        _confirmBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        _confirmBtn.layer.borderWidth =1;
    }
    return _confirmBtn;
}


- (void)japanClick:(UIButton *)btn{
    if (btn.selected) {
        return;
    }else{
        source = @"yahoo";
        btn.selected = YES;
        if (self.usaBtn.selected == YES) {
            self.usaBtn.selected= NO;
        }
    }
}
- (void)usaClick:(UIButton *)btn{
    if (btn.selected) {
        return;
    }else{
        source = @"ebay";
        btn.selected = YES;
        if (self.japanBtn.selected == YES) {
            self.japanBtn.selected= NO;
        }
    }
}
- (void)confirmClick{
    if (source == nil) {
        [WHToast showMessage:@"请选择国家" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
    }else{
        NewHaitaoViewController * nvc = [[NewHaitaoViewController alloc]init];
        nvc.source = source;
        [self.navigationController pushViewController:nvc animated:YES];
    }
}
@end
