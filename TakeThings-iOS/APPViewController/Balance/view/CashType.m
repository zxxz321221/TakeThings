//
//  CashType.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/8/5.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "CashType.h"
@interface CashType()
{
    NSInteger index;
}
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UILabel * typeL;
@property (nonatomic , strong) UIButton * confirmBtn;
@property (nonatomic , strong) UIView * line;

@property (nonatomic , strong) UIButton * readBtn;
@property (nonatomic , strong) UIButton * selectBtn;
@end
@implementation CashType
+(instancetype)setCashType:(UIView *)view{
    CashType * cashType = [[CashType alloc]initWithFrame:view.frame];
    [view addSubview:cashType];
    return cashType;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        index = 100;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        [self addSubview:self.backView];
        self.hidden = YES;
    }
    return self;
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, [Unity countcoordinatesH:140])];
        _backView.backgroundColor = [UIColor whiteColor];
        [_backView addSubview:self.typeL];
        [_backView addSubview:self.confirmBtn];
        [_backView addSubview:self.line];
        NSArray * arr = @[@"aliPay",@"汇付天下"];
        for (int i=0; i<2; i++) {
            UIButton * btn = [Unity buttonAddsuperview_superView:_backView _subViewFrame:CGRectMake(0, [Unity countcoordinatesH:40]+i*[Unity countcoordinatesH:50], SCREEN_WIDTH, [Unity countcoordinatesH:50]) _tag:self _action:@selector(cashType:) _string:@"" _imageName:@""];
            btn.tag = 1000+i;
            UIImageView * img = [Unity imageviewAddsuperview_superView:btn _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20]) _imageName:arr[i] _backgroundColor:nil];
            img.contentMode = UIViewContentModeScaleAspectFit;
            if (i<1) {
                UILabel * line = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake(0, [Unity countcoordinatesH:50]-1, SCREEN_WIDTH, 1) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentRight];
                line.backgroundColor = [Unity getColor:@"e0e0e0"];
            }
            self.readBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:25], [Unity countcoordinatesH:17.5], [Unity countcoordinatesW:15], [Unity countcoordinatesH:15])];
            [self.readBtn setBackgroundImage:[UIImage imageNamed:@"不中"] forState:UIControlStateNormal];
            [self.readBtn setBackgroundImage:[UIImage imageNamed:@"中"] forState:UIControlStateSelected];
            self.readBtn.tag = btn.tag+1000;
            [btn addSubview:self.readBtn];
            
        }
    }
    
    return _backView;
}

- (UILabel *)typeL{
    if (!_typeL) {
        _typeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:150], [Unity countcoordinatesH:20])];
        _typeL.text = @"选择退款方式";
        _typeL.textColor = LabelColor3;
        _typeL.textAlignment = NSTextAlignmentLeft;
        _typeL.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _typeL;
}
- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:60], [Unity countcoordinatesH:10], [Unity countcoordinatesW:50], [Unity countcoordinatesH:20])];
        [_confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
        _confirmBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _confirmBtn;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:39], SCREEN_WIDTH,1)];
        _line.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line;
}


- (void)cashType:(UIButton *)sender{
    index = sender.tag - 1000;
    UIButton *btn = (UIButton *)[sender viewWithTag:sender.tag+1000];
    if (btn.selected == YES) {
        
    }else{
        self.selectBtn.selected = NO;
        btn.selected = YES;
        self.selectBtn = btn;
    }
}
- (void)confirmClick{
    if (index != 100) {
        [self.delegate cashTypeconfirm:index];
    }
    [self hiddenCashType];
}
- (void)showCashType{
    self.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.backView.frame = CGRectMake(0, SCREEN_HEIGHT-[Unity countcoordinatesH:140], SCREEN_WIDTH, [Unity countcoordinatesH:140]);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }];
}
- (void)hiddenCashType{
    [UIView animateWithDuration:0.5 animations:^{
        self.backView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, [Unity countcoordinatesH:140]);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    }];
    [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:0.5];
}
- (void)delayMethod{
    self.hidden = YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hiddenCashType];
}
@end
