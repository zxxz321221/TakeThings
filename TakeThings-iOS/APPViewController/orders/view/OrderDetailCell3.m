//
//  OrderDetailCell3.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/14.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "OrderDetailCell3.h"
@interface OrderDetailCell3()
@property (nonatomic , strong) UIView * blockV;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UILabel * ddyfL;
@property (nonatomic , strong) UILabel * ddyf;
@property (nonatomic , strong) UILabel * ddFeeL;
@property (nonatomic , strong) UILabel * ddFee;
@property (nonatomic , strong) UILabel * line;
@property (nonatomic , strong) UILabel * xjL;
@property (nonatomic , strong) UILabel * xj;
@end
@implementation OrderDetailCell3
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.blockV];
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.ddyfL];
        [self.contentView addSubview:self.ddyf];
        [self.contentView addSubview:self.ddFeeL];
        [self.contentView addSubview:self.ddFee];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.xjL];
        [self.contentView addSubview:self.xj];
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
        _titleL.textColor = LabelColor3;
        _titleL.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _titleL;
}
- (UILabel *)ddyfL{
    if (!_ddyfL) {
        _ddyfL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:13], _titleL.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _ddyfL.text = @"当地运费";
        _ddyfL.textColor = LabelColor6;
        _ddyfL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _ddyfL;
}
- (UILabel *)ddyf{
    if (!_ddyf) {
        _ddyf = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:113], _ddyfL.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _ddyf.textColor = LabelColor6;
        _ddyf.font = [UIFont systemFontOfSize:FontSize(14)];
        _ddyf.textAlignment = NSTextAlignmentRight;
    }
    return _ddyf;
}
- (UILabel *)ddFeeL{
    if (!_ddFeeL) {
        _ddFeeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:13], _ddyfL.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _ddFeeL.text = @"当地消费税";
        _ddFeeL.textColor = LabelColor6;
        _ddFeeL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _ddFeeL;
}
- (UILabel *)ddFee{
    if (!_ddFee) {
        _ddFee = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:113], _ddFeeL.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _ddFee.textColor = LabelColor6;
        _ddFee.font = [UIFont systemFontOfSize:FontSize(14)];
        _ddFee.textAlignment = NSTextAlignmentRight;
    }
    return _ddFee;
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(0, _ddFeeL.bottom, SCREEN_WIDTH, 1)];
        _line.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line;
}
- (UILabel *)xjL{
    if (!_xjL) {
        _xjL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:13], _line.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:34])];
        _xjL.text = @"小计";
        _xjL.textColor = LabelColor6;
        _xjL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _xjL;
}
- (UILabel *)xj{
    if (!_xj) {
        _xj = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:113], _xjL.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:34])];
        _xj.textColor = LabelColor6;
        _xj.font = [UIFont systemFontOfSize:FontSize(14)];
        _xj.textAlignment = NSTextAlignmentRight;
    }
    return _xj;
}
- (void)configWithData:(NSDictionary *)dic{
    if ([dic[@"currency"] isEqualToString:@"円"]) {
        self.titleL.text = [NSString stringWithFormat:@"日本代拍补充费用（汇率：%@）",dic[@"exchange_rate"]];
    }else{
        self.titleL.text = [NSString stringWithFormat:@"美国代拍补充费用（汇率：%@）",dic[@"exchange_rate"]];
    }
    self.ddyf.text = [NSString stringWithFormat:@"%@%@",dic[@"cost_local_freight"],dic[@"currency"]];
    self.ddFee.text = [NSString stringWithFormat:@"%@%@",dic[@"cost_excise"],dic[@"currency"]];
    
    float sum = ([dic[@"cost_local_freight"] floatValue] + [dic[@"cost_excise"] floatValue])*[dic[@"exchange_rate"] floatValue];
    self.xj.text = [NSString stringWithFormat:@"%.2fRMB",sum];
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
