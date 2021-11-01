//
//  CouponsCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/7/10.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "CouponsCell.h"
@interface CouponsCell()
@property (nonatomic , strong) UIImageView * backView;
@property (nonatomic , strong) UILabel * label1;
@property (nonatomic , strong) UILabel * label2;
@property (nonatomic , strong) UILabel * label3;
@end
@implementation CouponsCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup{
    [self.contentView addSubview:self.backView];
}
- (UIImageView *)backView{
    if (!_backView) {
        _backView = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:65])];
        _backView.backgroundColor = [UIColor whiteColor];
        // 左上和右上为圆角
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:_backView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
        cornerRadiusLayer.frame = _backView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        _backView.layer.mask = cornerRadiusLayer;
        
        [_backView addSubview:self.label1];
        [_backView addSubview:self.label2];
        [_backView addSubview:self.label3];
    }
    return _backView;
}
- (UILabel *)label1{
    if (!_label1) {
        _label1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], _backView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:15])];
        _label1.text = @"回馈金为捎东西赠送会员的现金低佣金,单次使用限额20元。";
        _label1.textColor = LabelColor6;
        _label1.font = [UIFont systemFontOfSize:12];
    }
    return _label1;
}
- (UILabel *)label2{
    if (!_label2) {
        _label2 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _label1.bottom, _backView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:15])];
        _label2.text = @"有效期30天,参与商品产生的费用抵扣。";
        _label2.textColor = LabelColor6;
        _label2.font = [UIFont systemFontOfSize:12];
    }
    return _label2;
}
- (UILabel *)label3{
    if (!_label3) {
        _label3 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _label2.bottom, _backView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:15])];
        _label3.text = @"目前只适用于日本雅虎（先投标后付款）。";
        _label3.textColor = LabelColor6;
        _label3.font = [UIFont systemFontOfSize:12];
    }
    return _label3;
}
- (void)configWithisRed:(BOOL)isred WithPlace:(NSString *)palce{
    if (isred) {
        self.backView.image = [UIImage imageNamed:@"redB"];
    }else{
        self.backView.image = [UIImage imageNamed:@"garyB"];
    }
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
