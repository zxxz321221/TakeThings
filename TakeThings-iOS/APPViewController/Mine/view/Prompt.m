//
//  Prompt.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/25.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "Prompt.h"
@interface Prompt()
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UIImageView * imageView;
@property (nonatomic, strong) UILabel * title;
@property (nonatomic , strong) UILabel * content;
@end
@implementation Prompt

+(instancetype)setPrompt:(UIView *)view{
    Prompt * dView = [[Prompt alloc]initWithFrame:view.frame];
    [[UIApplication sharedApplication].keyWindow addSubview:dView];
    return dView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        [self addSubview:self.backView];
    }
    return self;
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:50], (SCREEN_HEIGHT-[Unity countcoordinatesH:120])/2, SCREEN_WIDTH-[Unity countcoordinatesW:100], [Unity countcoordinatesH:120])];
        _backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _backView.layer.cornerRadius = 10;
        
        [_backView addSubview:self.imageView];
        [_backView addSubview:self.title];
        [_backView addSubview:self.content];
    }
    return _backView;
}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((_backView.width-[Unity countcoordinatesW:25])/2, [Unity countcoordinatesH:15], [Unity countcoordinatesW:25], [Unity countcoordinatesH:25])];
        _imageView.image = [UIImage imageNamed:@"弹窗叹号"];
    }
    return _imageView;
}
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageView.bottom+[Unity countcoordinatesH:25], _backView.width, [Unity countcoordinatesH:15])];
        _title.text = @"仓库所在地不同";
        _title.textColor = [UIColor whiteColor];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _title;
}
- (UILabel *)content{
    if (!_content) {
        _content = [[UILabel alloc]initWithFrame:CGRectMake(0, _title.bottom+[Unity countcoordinatesH:10], _backView.width, [Unity countcoordinatesH:15])];
        _content.text = @"无法统一选中,请手动选择";
        _content.textColor = [UIColor whiteColor];
        _content.textAlignment = NSTextAlignmentCenter;
        _content.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _content;
}


- (void)showPrompt{
    self.hidden = NO;
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:3.0];
}
- (void)delayMethod{
    self.hidden = YES;
}
@end
