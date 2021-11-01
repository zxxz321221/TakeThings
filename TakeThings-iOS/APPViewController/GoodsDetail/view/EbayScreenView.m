//
//  EbayScreenView.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/7/18.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "EbayScreenView.h"
@interface EbayScreenView()
{
    NSInteger btnIndex;
}
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UILabel * options;
@property (nonatomic, strong) UIButton * seletedBtn;
@property (nonatomic , strong) UILabel * priceRange;
@property (nonatomic , strong) UITextField * min;
@property (nonatomic , strong) UILabel * line;
@property (nonatomic , strong) UITextField * max;
@property (nonatomic , strong) UIButton * screenBtn;
@end
@implementation EbayScreenView
+(instancetype)setEbayScreenView:(UIView *)view{
    EbayScreenView * sView = [[EbayScreenView alloc]initWithFrame:view.frame];
    [[UIApplication sharedApplication].keyWindow addSubview:sView];
    return sView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.hidden = YES;
        UITapGestureRecognizer *singleTap =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskAction)];
        singleTap.numberOfTapsRequired = 1; //点击次数
        singleTap.numberOfTouchesRequired = 1; //点击手指数
        [self addGestureRecognizer:singleTap];
        [self addSubview:self.backView];
    }
    return self;
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, [Unity countcoordinatesW:220], SCREEN_HEIGHT)];
        _backView.backgroundColor = [UIColor whiteColor];
        [_backView addSubview:self.options];
        NSArray * arr = @[@"默认",@"直购",@"免当地运费",@"新品"];
        for (int i=0; i<4; i++) {
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake((i/2+1)*[Unity countcoordinatesW:10]+(i/2)*((_backView.width-[Unity countcoordinatesW:30])/2),self.options.bottom+[Unity countcoordinatesH:10]+(i%2+1)*[Unity countcoordinatesH:10]+(i%2)*[Unity countcoordinatesH:40], (_backView.width-[Unity countcoordinatesW:30])/2, [Unity countcoordinatesH:40])];
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
            [_backView addSubview:btn];
        }
        [_backView addSubview:self.priceRange];
        [_backView addSubview:self.min];
        [_backView addSubview:self.line];
        [_backView addSubview:self.max];
        [_backView addSubview:self.screenBtn];
    }
    return _backView;
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
        _priceRange = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _options.bottom+[Unity countcoordinatesH:155], 100, [Unity countcoordinatesH:20])];
        _priceRange.text = @"价格区间";
        _priceRange.textColor = LabelColor3;
        _priceRange.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _priceRange;
}
- (UITextField *)min{
    if (!_min) {
        _min = [[UITextField alloc]initWithFrame:CGRectMake(_priceRange.left, _priceRange.bottom+[Unity countcoordinatesH:20], (_backView.width-[Unity countcoordinatesW:40])/2, [Unity countcoordinatesH:30])];
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
        _max = [[UITextField alloc]initWithFrame:CGRectMake(_line.right+[Unity countcoordinatesW:5], _priceRange.bottom+[Unity countcoordinatesH:20], (_backView.width-[Unity countcoordinatesW:40])/2, [Unity countcoordinatesH:30])];
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
        _screenBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], SCREEN_HEIGHT-[Unity countcoordinatesH:50], _backView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        [_screenBtn addTarget:self action:@selector(screenClick) forControlEvents:UIControlEventTouchUpInside];
        _screenBtn.backgroundColor = [Unity getColor:@"#aa112d"];
        [_screenBtn setTitle:@"筛选" forState:UIControlStateNormal];
        [_screenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _screenBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
        _screenBtn.layer.cornerRadius = _screenBtn.height/2;
    }
    return _screenBtn;
}


- (void)showScreenView{
    self.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        [self.backView setFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:220], 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }completion:nil];
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
//    [self.delegate screenBtnIndex:btnIndex WithMin:self.min.text WithMax:self.max.text WithIndex:btnIndex];
}
- (void)maskAction{
    self.hidden = YES;
    self.backView.frame = CGRectMake(SCREEN_WIDTH, 0, [Unity countcoordinatesW:220], SCREEN_HEIGHT);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
