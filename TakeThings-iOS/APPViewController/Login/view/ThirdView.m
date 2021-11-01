//
//  ThirdView.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/16.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "ThirdView.h"
#import "UILabel+YBAttributeTextTapAction.h"
@interface ThirdView()
@property (nonatomic , strong) UIView * footerView;//第三方登录

@end
@implementation ThirdView
+(instancetype)setThirdView:(UIView *)view{
    ThirdView * thirdView = [[ThirdView alloc]initWithFrame:view.frame];
    [view addSubview:thirdView];
    return thirdView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self addSubview:self.footerView];
    }
    return self;
}
- (UIView *)footerView{
    if (_footerView == nil) {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NavBarHeight-[Unity countcoordinatesH:120], SCREEN_WIDTH, [Unity countcoordinatesH:120])];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], 1)];
        line.backgroundColor = [Unity getColor:@"#d0d0d0"];
        [_footerView addSubview:line];

        UILabel * thirdL = [Unity lableViewAddsuperview_superView:_footerView _subViewFrame:CGRectMake((SCREEN_WIDTH-[Unity countcoordinatesW:100])/2, 0, [Unity countcoordinatesW:100], [Unity countcoordinatesH:20]) _string:@"其他登录方式" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentCenter];
        thirdL.backgroundColor = [UIColor whiteColor];

        NSArray * arr =@[@"applepay",@"weixin"];//@"facebook",@"goole"
        CGFloat W = (SCREEN_WIDTH-(arr.count*[Unity countcoordinatesW:40]))/(arr.count+1);
        for (int i=0; i<arr.count; i++) {
            UIButton * thirdBtn = [Unity buttonAddsuperview_superView:_footerView _subViewFrame:CGRectMake(W*(i+1)+(i*[Unity countcoordinatesW:40]), thirdL.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:40], [Unity countcoordinatesH:40]) _tag:self _action:@selector(thirdClick:) _string:@"" _imageName:arr[i]];
            thirdBtn.tag = i+1000;
        }
        //写死一个微信登陆 （如果多个  上面的打开就行）
        
        /************** 底部隐私政策*****************/
        NSString *label_text = @"登录即代表您已同意《捎东西隐私政策》";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:label_text];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(12)] range:NSMakeRange(0, label_text.length)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"4a90e2"] range:NSMakeRange(10, 7)];

        UILabel * policyL = [[UILabel alloc] initWithFrame:CGRectMake(0, thirdL.bottom+[Unity countcoordinatesH:70], SCREEN_WIDTH , [Unity countcoordinatesH:20])];
        policyL.textColor = LabelColor9;
        policyL.textAlignment = NSTextAlignmentCenter;
        policyL.attributedText = attributedString;
        [_footerView addSubview:policyL];

//        [policyL yb_addAttributeTapActionWithStrings:@[@"登录即代表您已同意《捎东西隐私政策》"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
//            [self.delegate privacyPolicylClick];
//        }];
        [policyL yb_addAttributeTapActionWithStrings:@[@"登录即代表您已同意《捎东西隐私政策》"] tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {
            [self.delegate privacyPolicylClick];
        }];
        //        //设置是否有点击效果，默认是YES
        policyL.enabledTapEffect = NO;
        
    }
    return _footerView;
}
//第三方登录
- (void)thirdClick:(UIButton *)btn{
    [self.delegate thirdLoginIndex:btn.tag-1000];
}
- (void)showThirdView{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
