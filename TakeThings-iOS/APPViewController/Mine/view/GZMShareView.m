//
//  GZMShareView.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/8/28.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "GZMShareView.h"
@interface GZMShareView()
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UIButton * weixinShar;
@property (nonatomic , strong) UIButton * weixinFrind;
@end
@implementation GZMShareView

+(instancetype)setGZMShareView:(UIView *)view{
    GZMShareView * gView = [[GZMShareView alloc]initWithFrame:view.frame];
    [[UIApplication sharedApplication].keyWindow addSubview:gView];
    return gView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        self.hidden = YES;
        [self addSubview:self.backView];
    }
    return self;
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, bottomH+[Unity countcoordinatesH:60])];
        _backView.backgroundColor = [UIColor whiteColor];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:20])];
        label.text = @"分享APP";
        label.textColor = LabelColor6;
        label.font = [UIFont systemFontOfSize:FontSize(14)];
        label.textAlignment = NSTextAlignmentCenter;
        [_backView addSubview:label];
        [_backView addSubview:self.weixinShar];
        [_backView addSubview:self.weixinFrind];
    }
    return _backView;
}
- (UIButton *)weixinShar{
    if (!_weixinShar) {
        _weixinShar = [[UIButton alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:25], SCREEN_WIDTH/4, [Unity countcoordinatesH:70])];
        [_weixinShar addTarget:self action:@selector(weixinSharClick) forControlEvents:UIControlEventTouchUpInside];
//        _weixinShar.backgroundColor = [UIColor redColor];
        UIImageView * imageView = [Unity imageviewAddsuperview_superView:_weixinShar _subViewFrame:CGRectMake((_weixinShar.width-[Unity countcoordinatesW:50])/2, 0, [Unity countcoordinatesW:50], [Unity countcoordinatesH:50]) _imageName:@"weixinShar" _backgroundColor:nil];
        imageView.backgroundColor = [UIColor clearColor];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:55], _weixinShar.width, [Unity countcoordinatesH:15])];
        label.text = @"微信好友";
        label.textColor = LabelColor3;
        label.font = [UIFont systemFontOfSize:FontSize(14)];
        label.textAlignment = NSTextAlignmentCenter;
        [_weixinShar addSubview:label];
    }
    return _weixinShar;
}
- (UIButton *)weixinFrind{
    if (!_weixinFrind) {
        _weixinFrind = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, [Unity countcoordinatesH:25], SCREEN_WIDTH/4, [Unity countcoordinatesH:70])];
        [_weixinFrind addTarget:self action:@selector(weixinFrindClick) forControlEvents:UIControlEventTouchUpInside];
//        _weixinFrind.backgroundColor = [UIColor yellowColor];
        UIImageView * imageView = [Unity imageviewAddsuperview_superView:_weixinFrind _subViewFrame:CGRectMake((_weixinShar.width-[Unity countcoordinatesW:50])/2, 0, [Unity countcoordinatesW:50], [Unity countcoordinatesH:50]) _imageName:@"weixinFrindShar" _backgroundColor:nil];
        imageView.backgroundColor = [UIColor clearColor];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:55], _weixinShar.width, [Unity countcoordinatesH:15])];
        label.text = @"微信朋友圈";
        label.textColor = LabelColor3;
        label.font = [UIFont systemFontOfSize:FontSize(14)];
        label.textAlignment = NSTextAlignmentCenter;
        [_weixinFrind addSubview:label];
    }
    return _weixinFrind;
}
- (void)showShareView{
    self.hidden=NO;
    [UIView animateWithDuration:0.5 animations:^{
        [self.backView setFrame:CGRectMake(0, SCREEN_HEIGHT-self.backView.height, SCREEN_WIDTH, bottomH+[Unity countcoordinatesH:60])];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }completion:nil];
}
- (void)cancelClick{
    [UIView animateWithDuration:0.5 animations:^{
        [self.backView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, bottomH+[Unity countcoordinatesH:60])];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    }completion:nil];
    [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:0.5];
}
- (void)delayMethod{
    self.hidden = YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancelClick];
}
- (void)weixinSharClick{
    [self cancelClick];
    [self.delegate weixinshareClick];
}
- (void)weixinFrindClick{
    [self cancelClick];
    [self.delegate weixinfrindClick];
}
@end
