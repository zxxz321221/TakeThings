//
//  SupplementCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/27.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "SupplementCell.h"
@interface SupplementCell()
@property (nonatomic , strong) UIView * blockV;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UILabel * yfT;//当地运费
@property (nonatomic , strong) UILabel * yfL;
@property (nonatomic , strong) UILabel * xfsT;//消费税
@property (nonatomic , strong) UILabel * xfsL;
@property (nonatomic , strong) UILabel * line;
@property (nonatomic , strong) UILabel * xjT;//小计
@property (nonatomic , strong) UILabel * xjL;

@end
@implementation SupplementCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.blockV];
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.yfT];
        [self.contentView addSubview:self.yfL];
        [self.contentView addSubview:self.xfsT];
        [self.contentView addSubview:self.xfsL];
        [self.contentView addSubview:self.line];
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
//        _titleL.text = @"日本代拍补充费用";
        _titleL.textColor = LabelColor3;
        _titleL.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _titleL;
}
- (UILabel *)yfT{
    if (!_yfT) {
        _yfT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:13], _titleL.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _yfT.text = @"当地运费";
        _yfT.textColor = LabelColor6;
        _yfT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _yfT;
}
- (UILabel *)yfL{
    if (!_yfL) {
        _yfL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:113], _yfT.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _yfL.textColor = LabelColor6;
        _yfL.font = [UIFont systemFontOfSize:FontSize(14)];
        _yfL.textAlignment = NSTextAlignmentRight;
    }
    return _yfL;
}
- (UILabel *)xfsT{
    if (!_xfsT) {
        _xfsT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:13], _yfT.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _xfsT.text = @"当地消费税";
        _xfsT.textColor = LabelColor6;
        _xfsT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _xfsT;
}
- (UILabel *)xfsL{
    if (!_xfsL) {
        _xfsL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:113], _xfsT.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _xfsL.text = @"xxxx";
        _xfsL.textColor = LabelColor6;
        _xfsL.font = [UIFont systemFontOfSize:FontSize(14)];
        _xfsL.textAlignment = NSTextAlignmentRight;
    }
    return _xfsL;
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(0, _xfsT.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, 1)];
        _line.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return _line;
}
- (UILabel *)xjT{
    if (!_xjT) {
        _xjT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:13], _line.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:34])];
        _xjT.text = @"小计";
        _xjT.textColor = LabelColor6;
        _xjT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _xjT;
}
- (UILabel *)xjL{
    if (!_xjL) {
        _xjL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:113], _xjT.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:34])];
        _xjL.textColor = LabelColor6;
        _xjL.font = [UIFont systemFontOfSize:FontSize(14)];
        _xjL.textAlignment = NSTextAlignmentRight;
    }
    return _xjL;
}
- (void)configData:(NSDictionary *)dic{
    NSString * countries;
    if ([dic[@"currency"] isEqualToString:@"円"]) {//日本
        countries = @"日本";
    }else{
        countries = @"美国";
    }
    _titleL.text = [NSString stringWithFormat:@"%@代拍补充费用(汇率：%@)",countries,dic[@"exchange_rate"]];
    _yfL.text = [NSString stringWithFormat:@"%@%@",dic[@"cost_local_freight"],dic[@"currency"]];
    _xfsL.text = [NSString stringWithFormat:@"%@%@",dic[@"cost_excise"],dic[@"currency"]];
    float sum = [dic[@"cost_local_freight"] floatValue]*[dic[@"exchange_rate"] floatValue] + [dic[@"cost_excise"] floatValue]*[dic[@"exchange_rate"] floatValue];
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
