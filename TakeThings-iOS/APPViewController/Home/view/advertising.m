//
//  advertising.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/17.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "advertising.h"
@interface advertising()



@end
@implementation advertising
+(instancetype)setadvertising:(UIView *)view{
    advertising * pView = [[advertising alloc]initWithFrame:view.frame];
    [[UIApplication sharedApplication].keyWindow addSubview:pView];
    return pView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.hidden = YES;
        [self addSubview:self.imageView];
    }
    return self;
}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, (SCREEN_HEIGHT-200)/2, 200, 200)];
    }
    return _imageView;
}
- (void)showAdvertising{
    self.hidden = NO;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.hidden = YES;
}
@end
