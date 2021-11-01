//
//  CashWay.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/8/2.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "CashWay.h"
@interface CashWay()
{
    NSInteger index;
    NSArray * arr;
}
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UILabel * typeL;
@property (nonatomic , strong) UIButton * confirmBtn;
@property (nonatomic , strong) UIView * line;

@property (nonatomic , strong) UIButton * readBtn;
@property (nonatomic , strong) UIButton * selectBtn;
@end
@implementation CashWay
+(instancetype)setCashWay:(UIView *)view{
    CashWay * cashWay = [[CashWay alloc]initWithFrame:view.frame];
    [view addSubview:cashWay];
    return cashWay;
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
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, [Unity countcoordinatesH:290])];
        _backView.backgroundColor = [UIColor whiteColor];
        [_backView addSubview:self.typeL];
        [_backView addSubview:self.confirmBtn];
        [_backView addSubview:self.line];
        arr = @[@"物品没有买到",@"商品缺货",@"退回竞价费用",@"运费汇费服务等价格不满意",@"服务太差"];
        for (int i=0; i<5; i++) {
            UIButton * btn = [Unity buttonAddsuperview_superView:_backView _subViewFrame:CGRectMake(0, [Unity countcoordinatesH:40]+i*[Unity countcoordinatesH:50], SCREEN_WIDTH, [Unity countcoordinatesH:50]) _tag:self _action:@selector(cashWay:) _string:@"" _imageName:@""];
            btn.tag = 1000+i;
            UILabel * title = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], SCREEN_WIDTH-[Unity countcoordinatesW:45], [Unity countcoordinatesH:20]) _string:arr[i] _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
            title.backgroundColor = [UIColor clearColor];
            if (i<4) {
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
        _typeL.text = @"选择退款原因";
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





- (void)cashWay:(UIButton *)sender{
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
        [self.delegate confirm:arr[index]];
    }
    [self hiddenCashWay];
}
- (void)showCashWay{
    self.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.backView.frame = CGRectMake(0, SCREEN_HEIGHT-[Unity countcoordinatesH:290], SCREEN_WIDTH, [Unity countcoordinatesH:290]);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }];
}
- (void)hiddenCashWay{
    [UIView animateWithDuration:0.5 animations:^{
        self.backView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, [Unity countcoordinatesH:290]);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    }];
    [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:0.5];
}
- (void)delayMethod{
    self.hidden = YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hiddenCashWay];
}
@end
