//
//  Agreenment.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/7/29.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "Agreenment.h"

@interface Agreenment()<UIScrollViewDelegate>
{
    BOOL isRolling;   //默认NO    yes开始滚动
}
@property (nonatomic , strong) UIButton * cancelBtn;
@property (nonatomic , strong) UIButton * confirmBtn;

@property (nonatomic , strong) UIView * backView;

@property (nonatomic , strong) UIView * line;

@property (nonatomic , strong) UIImageView * imageView;
@end
@implementation Agreenment

+(instancetype)setAgreenment:(UIView *)view{
    Agreenment * eView = [[Agreenment alloc]initWithFrame:view.frame];
    [[UIApplication sharedApplication].keyWindow addSubview:eView];
    return eView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        isRolling = NO;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.hidden = YES;
        [self addSubview:self.backView];
        [self addSubview:self.imageView];
//        [self loadView];
    }
    return self;
}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _imageView.hidden = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage)];

        [_imageView addGestureRecognizer:tapGesture];

        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], [Unity countcoordinatesH:15], SCREEN_WIDTH-[Unity countcoordinatesW:30], SCREEN_HEIGHT-[Unity countcoordinatesH:30])];
        _backView.layer.cornerRadius = 5;
        _backView.backgroundColor =[UIColor whiteColor];
        
        [_backView addSubview:self.titleL];
        [_backView addSubview:self.line];
        [_backView addSubview:self.webView];
        [_backView addSubview:self.cancelBtn];
        [_backView addSubview:self.confirmBtn];
    }
    return _backView;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _backView.width, [Unity countcoordinatesH:40])];
        _titleL.text = @"";
        _titleL.textColor = LabelColor3;
        _titleL.font = [UIFont systemFontOfSize:FontSize(17)];
        _titleL.textAlignment = NSTextAlignmentCenter;
    }
    return _titleL;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]initWithFrame:CGRectMake(0, _titleL.bottom, _titleL.width, 1)];
        _line.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line;
}
- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, _line.bottom, _backView.width, _backView.height-[Unity countcoordinatesH:81])];
        _webView.scrollView.delegate = self;
        
    }
    return _webView;
}
#pragma mark  - scrollView协议
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //NSLog(@"====%f=====%f =====%f",scrollView.contentOffset.y , scrollView.contentSize.height,__zHeight);
    //    NSLog(@"%f",scrollView.contentSize.height-scrollView.contentOffset.y);
    //    NSLog(@"%f",SCREEN_HEIGHT-NavBarHeight-bottomH);
    if (isRolling) {
        if (scrollView.contentSize.height - scrollView.contentOffset.y <= _backView.height-[Unity countcoordinatesH:81]) {
            
            self.confirmBtn.backgroundColor = [Unity getColor:@"aa112d"];
            self.confirmBtn.userInteractionEnabled = YES;
        }
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    isRolling = YES;
    
}
- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _backView.height-[Unity countcoordinatesH:40], _backView.width/2, [Unity countcoordinatesH:40])];
        [_cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
        _cancelBtn.layer.borderWidth = 1;
        _cancelBtn.layer.borderColor = [Unity getColor:@"e0e0e0"].CGColor;
        // 左上和右上为圆角
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:_cancelBtn.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(5, 0)];
        CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
        cornerRadiusLayer.frame = _cancelBtn.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        _cancelBtn.layer.mask = cornerRadiusLayer;
        
    }
    return _cancelBtn;
}
- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(_cancelBtn.right, _cancelBtn.top, _cancelBtn.width, _cancelBtn.height)];
        [_confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBtn setTitle:@"同意" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
        _confirmBtn.backgroundColor = LabelColor9;
        
        // 左上和右上为圆角
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:_confirmBtn.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 0)];
        CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
        cornerRadiusLayer.frame = _confirmBtn.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        _confirmBtn.layer.mask = cornerRadiusLayer;
        _confirmBtn.userInteractionEnabled = NO;
    }
    return _confirmBtn;
}
- (void)cancelClick{
    self.hidden = YES;
}
- (void)confirmClick{
    self.hidden = YES;
    [self.delegate confirmAgreenment];
}
- (void)showAgView{
    self.hidden = NO;
    
    if (self.isRegister) {//注册
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"registerimg"] == nil) {
            self.imageView.image = [UIImage imageNamed:@"组6"];
            self.imageView.hidden = NO;
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"registerimg"];
        }
    }else{
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"htimg"] == nil) {
            self.imageView.image = [UIImage imageNamed:@"组7"];
            self.imageView.hidden = NO;
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"htimg"];
        }
    }
    
}
- (void)clickImage{
    self.imageView.hidden = YES;
}
@end
