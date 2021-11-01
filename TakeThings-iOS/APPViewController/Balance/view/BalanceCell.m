//
//  BalanceCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/6.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "BalanceCell.h"
@interface BalanceCell()
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UILabel * numberL;
@property (nonatomic , strong) UILabel * timeL;
@property (nonatomic , strong) UILabel * placeL;
@property (nonatomic , strong) UILabel * balanceL;
@property (nonatomic , strong) UIImageView * backImg;
@property (nonatomic , strong) UIView * line;
@end
@implementation BalanceCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setup];
//        self.contentView.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return self;
}
- (void)setup{
    [self.contentView addSubview:self.titleL];
    [self.contentView addSubview:self.numberL];
    [self.contentView addSubview:self.timeL];
    [self.contentView addSubview:self.placeL];
    [self.contentView addSubview:self.balanceL];
    [self.contentView addSubview:self.backImg];
    [self.contentView addSubview:self.line];
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:150], [Unity countcoordinatesH:15])];
        _titleL.textColor = LabelColor3;
        _titleL.textAlignment = NSTextAlignmentLeft;
        _titleL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _titleL;
}
- (UILabel *)numberL{
    if (!_numberL) {
        _numberL = [[UILabel alloc]initWithFrame:CGRectMake(_titleL.left, _titleL.bottom+[Unity countcoordinatesH:5], _titleL.width, _titleL.height)];
        _numberL.textColor = LabelColor9;
        _numberL.textAlignment = NSTextAlignmentLeft;
        _numberL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _numberL;
}
- (UILabel *)timeL{
    if (!_timeL) {
        _timeL = [[UILabel alloc]initWithFrame:CGRectMake(_numberL.left, _numberL.bottom+[Unity countcoordinatesH:5], _numberL.width, _numberL.height)];
        _timeL.textColor = LabelColor9;
        _timeL.textAlignment = NSTextAlignmentLeft;
        _timeL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _timeL;
}
- (UILabel *)placeL{
    if (!_placeL) {
        _placeL = [[UILabel alloc]initWithFrame:CGRectMake(_titleL.right, _titleL.top, [Unity countcoordinatesW:140], _titleL.height)];
        _placeL.textColor = [Unity getColor:@"#009944"];//负数颜色aa112d
        _placeL.textAlignment = NSTextAlignmentRight;
        _placeL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _placeL;
}
- (UILabel *)balanceL{
    if (!_balanceL) {
        _balanceL = [[UILabel alloc]initWithFrame:CGRectMake(_timeL.right, _timeL.top, [Unity countcoordinatesW:140], _timeL.height)];
        _balanceL.textColor = LabelColor9;
        _balanceL.textAlignment = NSTextAlignmentRight;
        _balanceL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _balanceL;
}
- (UIImageView *)backImg{
    if (!_backImg) {
        _backImg = [[UIImageView alloc]initWithFrame:CGRectMake(_balanceL.right+[Unity countcoordinatesW:5], [Unity countcoordinatesH:35], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10])];
        _backImg.image = [UIImage imageNamed:@"go"];
    }
    return _backImg;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:79], SCREEN_WIDTH, [Unity countcoordinatesH:1])];
        _line.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line;
}
- (void)configWithData:(NSDictionary *)dic{
    self.titleL.text  = dic[@"w_cause"];
    self.numberL.text  = [NSString stringWithFormat:@"商品编号:%@",dic[@"w_jpnid"]];
    self.timeL.text  = dic[@"w_time"];
    if ([dic[@"w_sz"]isEqualToString:@"s"] || [dic[@"w_sz"]isEqualToString:@"0"]) {
        self.placeL.text  = [NSString stringWithFormat:@"+%@",dic[@"w_fse"]];
        self.placeL.textColor = [Unity getColor:@"#009944"];
    }else{
        self.placeL.text  = [NSString stringWithFormat:@"-%@",dic[@"w_fse"]];
        self.placeL.textColor = [Unity getColor:@"#aa112d"];
    }
    self.balanceL.text  = [NSString stringWithFormat:@"余额:%@",dic[@"w_yk"]];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
