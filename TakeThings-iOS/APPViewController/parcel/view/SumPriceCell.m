//
//  SumPriceCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/27.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "SumPriceCell.h"
@interface SumPriceCell()
@property (nonatomic , strong) UIView * blockV;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UILabel * xjT;//小计
@property (nonatomic , strong) UILabel * xjL;
@end
@implementation SumPriceCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.blockV];
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.xjT];
        [self.contentView addSubview:self.xjL];
    }
    return self;
}
- (UIView *)blockV{
    if (!_blockV) {
        _blockV = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:15], [Unity countcoordinatesW:3], [Unity countcoordinatesH:10])];
        _blockV.backgroundColor = [Unity getColor:@"aa112d"];
    }
    return _blockV;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(_blockV.right+[Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:297], [Unity countcoordinatesH:40])];
        _titleL.text = @"总金额";
        _titleL.textColor = LabelColor3;
        _titleL.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _titleL;
}
- (UILabel *)xjT{
    if (!_xjT) {
        _xjT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:13], _titleL.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _xjT.text = @"合计";
        _xjT.textColor = LabelColor6;
        _xjT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _xjT;
}
- (UILabel *)xjL{
    if (!_xjL) {
        _xjL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:113], _xjT.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _xjL.text = @"xxxx";
        _xjL.textColor = [Unity getColor:@"aa112d"];
        _xjL.font = [UIFont systemFontOfSize:FontSize(14)];
        _xjL.textAlignment = NSTextAlignmentRight;
    }
    return _xjL;
}
- (void)configPrice:(NSDictionary *)dic{
    float sum = [dic[@"cost_local_freight"] floatValue]*[dic[@"exchange_rate"] floatValue] + [dic[@"cost_excise"] floatValue]*[dic[@"exchange_rate"] floatValue]+[dic[@"price_true"] floatValue];
    _xjL.text = [NSString stringWithFormat:@"%.2fRMB",sum];
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
