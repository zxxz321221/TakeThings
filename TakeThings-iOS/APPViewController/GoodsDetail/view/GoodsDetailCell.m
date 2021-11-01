//
//  GoodsDetailCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/23.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "GoodsDetailCell.h"
@interface GoodsDetailCell()

@property (nonatomic,strong) UILabel * line;
@property (nonatomic,strong) UIButton * parameterBtn;

@end
@implementation GoodsDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self GoodsDetailView];
    }
    return self;
}
- (void)GoodsDetailView{
    [self addSubview:self.line];
    [self addSubview:self.parameterBtn];
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        _line.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return _line;
}
- (UIButton *)parameterBtn{
    if (!_parameterBtn) {
        _parameterBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _line.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        [_parameterBtn addTarget:self action:@selector(parClick) forControlEvents:UIControlEventTouchUpInside];
        UILabel * parameterL = [Unity lableViewAddsuperview_superView:_parameterBtn _subViewFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20]) _string:@"牌品参数:" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentLeft];
        UILabel * label = [Unity lableViewAddsuperview_superView:_parameterBtn _subViewFrame:CGRectMake(parameterL.right, [Unity countcoordinatesH:15], [Unity countcoordinatesW:200], [Unity countcoordinatesH:20]) _string:@"商品情况 商品ID..." _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
    }
    return _parameterBtn;
}
- (void)parClick{
    [self.delegate goodsDetail];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
