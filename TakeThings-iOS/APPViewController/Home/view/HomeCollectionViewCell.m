//
//  HomeCollectionViewCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/9/6.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "HomeCollectionViewCell.h"
@interface HomeCollectionViewCell()

@property (nonatomic , strong) UIImageView * iconImg;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UILabel * currentPlace;
@property (nonatomic , strong) UILabel * rmbL;
@end
@implementation HomeCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {

        [self.contentView addSubview:self.iconImg];
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.currentPlace];
        [self.contentView addSubview:self.rmbL];
    }
    return self;
}
- (UIImageView *)iconImg{
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:5], self.contentView.width-[Unity countcoordinatesW:10], [Unity countcoordinatesH:150])];
        _iconImg.layer.cornerRadius = 5;
        _iconImg.contentMode = UIViewContentModeScaleAspectFill;
        _iconImg.layer.masksToBounds = YES;
    }
    return _iconImg;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(_iconImg.left, _iconImg.bottom, _iconImg.width, [Unity countcoordinatesH:30])];
        _titleL.textColor = LabelColor3;
        _titleL.font = [UIFont systemFontOfSize:FontSize(14)];
        _titleL.numberOfLines = 0;
        _titleL.textAlignment = NSTextAlignmentLeft;
    }
    return _titleL;
}
- (UILabel *)currentPlace{
    if (!_currentPlace) {
        _currentPlace = [[UILabel alloc]initWithFrame:CGRectMake(_titleL.left, _titleL.bottom, _titleL.width, [Unity countcoordinatesH:15])];
        _currentPlace.textColor = LabelColor9;
        _currentPlace.font = [UIFont systemFontOfSize:FontSize(12)];
        _currentPlace.textAlignment = NSTextAlignmentLeft;
    }
    return _currentPlace;
}
- (UILabel *)rmbL{
    if (!_rmbL) {
        _rmbL = [[UILabel alloc]initWithFrame:CGRectMake(_currentPlace.left, _currentPlace.bottom, _currentPlace.width, [Unity countcoordinatesH:15])];
        _rmbL.text = @"换算价格";
        _rmbL.textColor = [Unity getColor:@"aa112d"];
        _rmbL.font = [UIFont systemFontOfSize:FontSize(12)];
        _rmbL.textAlignment = NSTextAlignmentLeft;
    }
    return _rmbL;
}
- (void)configCollectionViewCellImage:(NSString *)image WithTitle:(NSString *)title WithCurrentPlace:(NSString *)place{
    self.titleL.text = title;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",image]] placeholderImage:[UIImage imageNamed:@"Loading"]];
    self.currentPlace.text = [NSString stringWithFormat:@"当前价格:%@円",place];
    NSString * str = [NSString stringWithFormat:@"换算价格:%@RMB",[Unity configWithCurrentCurrency:@"jp" WithTargetCurrency:@"cn" WithAmount:place]];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(12)] range:NSMakeRange(0, 5)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0, 5)];
    self.rmbL.attributedText = attributedString;
}
@end
