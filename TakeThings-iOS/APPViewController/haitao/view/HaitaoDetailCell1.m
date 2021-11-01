//
//  HaitaoDetailCell1.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/18.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "HaitaoDetailCell1.h"
@interface HaitaoDetailCell1()
@property (nonatomic , strong) UILabel * goodsName;
@property (nonatomic , strong) UILabel * goodsNameL;
@property (nonatomic , strong) UILabel * goodsPrice;
@property (nonatomic , strong) UILabel * goodsPriceL;
@property (nonatomic , strong) UILabel * goodsParam;
@property (nonatomic , strong) UILabel * goodsParamL;
@property (nonatomic , strong) UILabel * goodsNum;
@property (nonatomic , strong) UILabel * goodsNumL;
@property (nonatomic , strong) UILabel * line;
@end
@implementation HaitaoDetailCell1
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.goodsName];
        [self.contentView addSubview:self.goodsNameL];
        [self.contentView addSubview:self.goodsPrice];
        [self.contentView addSubview:self.goodsPriceL];
        [self.contentView addSubview:self.goodsParam];
        [self.contentView addSubview:self.goodsParamL];
        [self.contentView addSubview:self.goodsNum];
        [self.contentView addSubview:self.goodsNumL];
        [self.contentView addSubview:self.line];
    }
    return self;
}
- (UILabel *)goodsName{
    if (!_goodsName) {
        _goodsName = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], 0, [Unity countcoordinatesW:70], [Unity countcoordinatesH:25])];
        _goodsName.text = @"商品名称";
        _goodsName.textColor = LabelColor3;
        _goodsName.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _goodsName;
}
- (UILabel *)goodsNameL{
    if (!_goodsNameL) {
        _goodsNameL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:215], 0, [Unity countcoordinatesW:200], [Unity countcoordinatesH:25])];
        _goodsNameL.text = @"--";
        _goodsNameL.textColor = LabelColor6;
        _goodsNameL.font = [UIFont systemFontOfSize:FontSize(14)];
        _goodsNameL.textAlignment = NSTextAlignmentRight;
    }
    return _goodsNameL;
}
- (UILabel *)goodsPrice{
    if (!_goodsPrice) {
        _goodsPrice = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], _goodsName.bottom, [Unity countcoordinatesW:70], [Unity countcoordinatesH:25])];
        _goodsPrice.text = @"商品单价";
        _goodsPrice.textColor = LabelColor3;
        _goodsPrice.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _goodsPrice;
}
- (UILabel *)goodsPriceL{
    if (!_goodsPriceL) {
        _goodsPriceL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:215], _goodsPrice.top, [Unity countcoordinatesW:200], [Unity countcoordinatesH:25])];
        _goodsPriceL.text = @"--";
        _goodsPriceL.textColor = LabelColor6;
        _goodsPriceL.font = [UIFont systemFontOfSize:FontSize(14)];
        _goodsPriceL.textAlignment = NSTextAlignmentRight;
    }
    return _goodsPriceL;
}
- (UILabel *)goodsParam{
    if (!_goodsParam) {
        _goodsParam = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], _goodsPrice.bottom, [Unity countcoordinatesW:70], [Unity countcoordinatesH:25])];
        _goodsParam.text = @"规格";
        _goodsParam.textColor = LabelColor3;
        _goodsParam.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _goodsParam;
}
- (UILabel *)goodsParamL{
    if (!_goodsParamL) {
        _goodsParamL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:215], _goodsParam.top, [Unity countcoordinatesW:200], [Unity countcoordinatesH:25])];
        _goodsParamL.text = @"--";
        _goodsParamL.textColor = LabelColor6;
        _goodsParamL.font = [UIFont systemFontOfSize:FontSize(14)];
        _goodsParamL.textAlignment = NSTextAlignmentRight;
    }
    return _goodsParamL;
}
- (UILabel *)goodsNum{
    if (!_goodsNum) {
        _goodsNum = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], _goodsParam.bottom, [Unity countcoordinatesW:70], [Unity countcoordinatesH:25])];
        _goodsNum.text = @"数量";
        _goodsNum.textColor = LabelColor3;
        _goodsNum.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _goodsNum;
}
- (UILabel *)goodsNumL{
    if (!_goodsNumL) {
        _goodsNumL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:215], _goodsNum.top, [Unity countcoordinatesW:200], [Unity countcoordinatesH:25])];
        _goodsNumL.text = @"--";
        _goodsNumL.textColor = LabelColor6;
        _goodsNumL.font = [UIFont systemFontOfSize:FontSize(14)];
        _goodsNumL.textAlignment = NSTextAlignmentRight;
    }
    return _goodsNumL;
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:100]-1, SCREEN_WIDTH, 1)];
        _line.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return  _line;
}
- (void)configWithData:(NSDictionary *)dic{
    if (dic != nil) {
        self.goodsNameL.text = dic[@"goods_name"];
        self.goodsPriceL.text = [NSString stringWithFormat:@"%@%@",dic[@"goods_price"],dic[@"currency"]];
        self.goodsParamL.text = dic[@"goods_specs"];
        self.goodsNumL.text = [dic[@"goods_num"] stringValue];
    }
    
}
@end
