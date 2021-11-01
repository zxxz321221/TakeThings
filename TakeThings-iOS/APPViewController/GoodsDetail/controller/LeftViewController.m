//
//  LeftViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/7/25.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()
{
    NSInteger btnIndex;
}
@property (nonatomic , strong) UILabel * options;
@property (nonatomic, strong) UIButton * seletedBtn;
@property (nonatomic , strong) UILabel * priceRange;
@property (nonatomic , strong) UITextField * min;
@property (nonatomic , strong) UILabel * line;
@property (nonatomic , strong) UITextField * max;
@property (nonatomic , strong) UIButton * screenBtn;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}
- (void)createUI{
    [self.view addSubview:self.options];
    NSArray * arr = @[@"默认",@"竞标",@"全新",@"免当地运费",@"一口价",@"二手"];
    for (int i=0; i<6; i++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake((i/3+1)*[Unity countcoordinatesW:10]+(i/3)*((SCREEN_WIDTH/4*3-[Unity countcoordinatesW:30])/2),self.options.bottom+[Unity countcoordinatesH:10]+(i%3+1)*[Unity countcoordinatesH:10]+(i%3)*[Unity countcoordinatesH:40], (SCREEN_WIDTH/4*3-[Unity countcoordinatesW:30])/2, [Unity countcoordinatesH:40])];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i+1000;
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [btn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"scr_gray"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"scr_red"] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        if (i==0) {
            btn.selected = YES;
            btnIndex = 0;
            self.seletedBtn = btn;
        }
        [self.view addSubview:btn];
    }
    [self.view addSubview:self.priceRange];
    [self.view addSubview:self.min];
    [self.view addSubview:self.line];
    [self.view addSubview:self.max];
    [self.view addSubview:self.screenBtn];
}
- (UILabel *)options{
    if (!_options) {
        _options = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:20], 100, [Unity countcoordinatesH:20])];
        _options.text = @"选项";
        _options.textColor = LabelColor3;
        _options.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _options;
}
- (UILabel *)priceRange{
    if (!_priceRange) {
        _priceRange = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _options.bottom+[Unity countcoordinatesH:205], 100, [Unity countcoordinatesH:20])];
        _priceRange.text = @"价格区间";
        _priceRange.textColor = LabelColor3;
        _priceRange.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _priceRange;
}
- (UITextField *)min{
    if (!_min) {
        _min = [[UITextField alloc]initWithFrame:CGRectMake(_priceRange.left, _priceRange.bottom+[Unity countcoordinatesH:20], (SCREEN_WIDTH/4*3-[Unity countcoordinatesW:40])/2, [Unity countcoordinatesH:30])];
        _min.layer.cornerRadius = _min.height/2;
        _min.layer.borderColor = [Unity getColor:@"#e0e0e0"].CGColor;
        _min.layer.borderWidth =1;
        _min.font = [UIFont systemFontOfSize:FontSize(14)];
        _min.placeholder = @"最低价";
        _min.textAlignment = NSTextAlignmentCenter;
        _min.keyboardType = UIKeyboardTypeDecimalPad;
    }
    return _min;
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(_min.right+[Unity countcoordinatesW:5], _min.top+[Unity countcoordinatesH:15], [Unity countcoordinatesW:10], 1)];
        _line.backgroundColor = LabelColor3;
    }
    return _line;
}
- (UITextField *)max{
    if (!_max) {
        _max = [[UITextField alloc]initWithFrame:CGRectMake(_line.right+[Unity countcoordinatesW:5], _priceRange.bottom+[Unity countcoordinatesH:20], (SCREEN_WIDTH/4*3-[Unity countcoordinatesW:40])/2, [Unity countcoordinatesH:30])];
        _max.layer.cornerRadius = _max.height/2;
        _max.layer.borderColor = [Unity getColor:@"#e0e0e0"].CGColor;
        _max.layer.borderWidth =1;
        _max.font = [UIFont systemFontOfSize:FontSize(14)];
        _max.placeholder = @"最高价";
        _max.textAlignment = NSTextAlignmentCenter;
        _max.keyboardType = UIKeyboardTypeDecimalPad;
    }
    return _max;
}
- (UIButton *)screenBtn{
    if (!_screenBtn) {
        _screenBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], SCREEN_HEIGHT-[Unity countcoordinatesH:50], SCREEN_WIDTH/4*3-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        [_screenBtn addTarget:self action:@selector(screenClick) forControlEvents:UIControlEventTouchUpInside];
        _screenBtn.backgroundColor = [Unity getColor:@"#aa112d"];
        [_screenBtn setTitle:@"筛选" forState:UIControlStateNormal];
        [_screenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _screenBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
        _screenBtn.layer.cornerRadius = _screenBtn.height/2;
    }
    return _screenBtn;
}
- (void)btnClick:(UIButton *)btn{
    btnIndex = btn.tag-1000;
    if (self.seletedBtn != btn) {
        btn.selected = YES;
        self.seletedBtn.selected = NO;
        self.seletedBtn = btn;
    }
}
- (void)screenClick{
    if (([self.min.text isEqualToString:@""] && [self.max.text isEqualToString:@""])||(![self.min.text isEqualToString:@""] && ![self.max.text isEqualToString:@""])) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    [self.delegate screenBtnIndex:btnIndex WithMin:self.min.text WithMax:self.max.text WithIndex:btnIndex];
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
