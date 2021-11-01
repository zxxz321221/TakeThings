//
//  DrainIntoView.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/30.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "DrainIntoView.h"

@interface DrainIntoView()
@property (nonatomic , strong)UIView * backView;

@property (nonatomic , strong) UILabel * title;
@property (nonatomic , strong) UIButton * confim;
@property (nonatomic , strong) UIButton * cancel;
@end
@implementation DrainIntoView

+(instancetype)setDrainIntoView:(UIView *)view{
    DrainIntoView * dView = [[DrainIntoView alloc]initWithFrame:view.frame];
    [[UIApplication sharedApplication].keyWindow addSubview:dView];
    return dView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.hidden = YES;
        [self addSubview:self.backView];
    }
    return self;
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:30], (SCREEN_HEIGHT-[Unity countcoordinatesH:110])/2, SCREEN_WIDTH-[Unity countcoordinatesW:60], [Unity countcoordinatesH:130])];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 10;
        
        [_backView addSubview:self.title];
        [_backView addSubview:self.cancel];
        [_backView addSubview:self.confim];
        
    }
    return _backView;
}
- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:25], _backView.width, [Unity countcoordinatesH:15])];
        _title.text = @"是否排入案件?";
        _title.textColor = LabelColor3;
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _title;
}
- (UIButton *)cancel{
    if (!_cancel) {
        _cancel = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:30], _title.bottom+[Unity countcoordinatesH:30], (_backView.width-[Unity countcoordinatesW:80])/2, [Unity countcoordinatesH:40])];
        [_cancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [_cancel setTitle:@"取消" forState:UIControlStateNormal];
        [_cancel setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        _cancel.layer.borderColor = [Unity getColor:@"#aa112d"].CGColor;
        _cancel.layer.borderWidth =1;
        _cancel.layer.cornerRadius = _cancel.height/2;
        
        
    }
    return _cancel;
}
- (UIButton *)confim{
    if (!_confim) {
        _confim = [[UIButton alloc]initWithFrame:CGRectMake(_cancel.right+[Unity countcoordinatesW:20], _cancel.top, _cancel.width, _cancel.height)];
        [_confim addTarget:self action:@selector(confimClick) forControlEvents:UIControlEventTouchUpInside];
        [_confim setTitle:@"排入" forState:UIControlStateNormal];
        [_confim setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
        _confim.backgroundColor = [Unity getColor:@"#aa112d"];
        _confim.layer.cornerRadius = _confim.height/2;
        
    }
    return _confim;
}


- (void)confimClick{
    [self.delegate queue];
    [self cancelClick];
}
- (void)cancelClick{
    self.hidden = YES;
}
- (void)showDrainIntoView{
    self.hidden = NO;
}


@end
