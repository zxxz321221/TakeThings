//
//  InterestCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/30.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "InterestCell.h"
@interface InterestCell()
@property (nonatomic , strong)UIImageView * imageView;
@property (nonatomic , strong)UILabel * title;
@end
@implementation InterestCell
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self addSubview:self.title];
    }
    return self;
}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, self.frame.size.width-[Unity countcoordinatesW:20], self.frame.size.width-[Unity countcoordinatesW:20])];
        _imageView.backgroundColor = [UIColor whiteColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_imageView addSubview:self.maskV];
        
    }
    return _imageView;
}
- (UIView *)maskV{
    if (!_maskV) {
        _maskV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _imageView.width, _imageView.height)];
        _maskV.backgroundColor = [UIColor blackColor];
        _maskV.alpha=0.5;
        _maskV.hidden=YES;
        UIImageView * icon = [Unity imageviewAddsuperview_superView:_maskV _subViewFrame:CGRectMake((_maskV.width-[Unity countcoordinatesW:32])/2, (_maskV.height-[Unity countcoordinatesW:20])/2, [Unity countcoordinatesW:32], [Unity countcoordinatesW:20]) _imageName:@"组3" _backgroundColor:nil];
        icon.backgroundColor = [UIColor clearColor];
    }
    return _maskV;
}
- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageView.bottom, self.frame.size.width, [Unity countcoordinatesH:30])];
        _title.textColor = LabelColor3;
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font =[UIFont systemFontOfSize:FontSize(14)];
    }
    return _title;
}
- (void)configInterestDataImage:(NSString *)imageUrl WithTitle:(NSString *)title{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"],imageUrl]] placeholderImage:[UIImage imageNamed:@"Loading"]];
    self.title.text = title;
}
@end
