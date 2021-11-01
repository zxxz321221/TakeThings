//
//  HaitaoDetailCell3.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/18.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "HaitaoDetailCell3.h"
@interface HaitaoDetailCell3()
@property (nonatomic , strong) UIView * block;
@property (nonatomic , strong) UILabel * titleL;

@property (nonatomic , strong) UILabel * sxf;//银行汇款手续费
@property (nonatomic , strong) UILabel * sxfL;
@property (nonatomic , strong) UILabel * clf;//海外处理费
@property (nonatomic , strong) UILabel * clfL;
@property (nonatomic , strong) UILabel * zplp;//诈骗理赔
@property (nonatomic , strong) UILabel * zplpL;
@property (nonatomic , strong) UILabel * oem;//代工费
@property (nonatomic , strong) UILabel * oemL;
@property (nonatomic , strong) UILabel * yhj;//优惠券
@property (nonatomic , strong) UILabel * yhjL;
@property (nonatomic , strong) UILabel * line;//
@property (nonatomic , strong) UILabel * xj;//小计
@property (nonatomic , strong) UILabel * xjL;
@end
@implementation HaitaoDetailCell3

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.block];
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.sxf];
        [self.contentView addSubview:self.sxfL];
        [self.contentView addSubview:self.clf];
        [self.contentView addSubview:self.clfL];
        [self.contentView addSubview:self.zplp];
        [self.contentView addSubview:self.zplpL];
        [self.contentView addSubview:self.oem];
        [self.contentView addSubview:self.oemL];
//        [self.contentView addSubview:self.yhj];
//        [self.contentView addSubview:self.yhjL];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.xj];
        [self.contentView addSubview:self.xjL];
    }
    return self;
}
- (UIView *)block{
    if (!_block) {
        _block = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:15], [Unity countcoordinatesW:3], [Unity countcoordinatesH:10])];
        _block.backgroundColor = [Unity getColor:@"aa112d"];
    }
    return _block;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], 0, 300, [Unity countcoordinatesH:40])];
//        _titleL.text = @"日本代拍费用（）";
        _titleL.textColor = LabelColor3;
        _titleL.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _titleL;
}
- (UILabel *)sxf{
    if (!_sxf) {
        _sxf = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], _titleL.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _sxf.text = @"银行汇款手续费";
        _sxf.textColor = LabelColor6;
        _sxf.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _sxf;
}
- (UILabel *)sxfL{
    if (!_sxfL) {
        _sxfL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:165], _sxf.top, [Unity countcoordinatesW:150], [Unity countcoordinatesH:25])];
        _sxfL.textColor = LabelColor6;
        _sxfL.font = [UIFont systemFontOfSize:FontSize(14)];
        _sxfL.textAlignment = NSTextAlignmentRight;
    }
    return _sxfL;
}
- (UILabel *)clf{
    if (!_clf) {
        _clf = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], _sxf.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _clf.text = @"海外处理费";
        _clf.textColor = LabelColor6;
        _clf.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _clf;
}
- (UILabel *)clfL{
    if (!_clfL) {
        _clfL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:165], _clf.top, [Unity countcoordinatesW:150], [Unity countcoordinatesH:25])];
        _clfL.textColor = LabelColor6;
        _clfL.font = [UIFont systemFontOfSize:FontSize(14)];
        _clfL.textAlignment = NSTextAlignmentRight;
    }
    return _clfL;
}
- (UILabel *)zplp{
    if (!_zplp) {
        _zplp = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], _clf.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _zplp.text = @"诈骗理赔";
        _zplp.textColor = LabelColor6;
        _zplp.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _zplp;
}
- (UILabel *)zplpL{
    if (!_zplpL) {
        _zplpL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:165], _zplp.top, [Unity countcoordinatesW:150], [Unity countcoordinatesH:25])];
        _zplpL.textColor = LabelColor6;
        _zplpL.font = [UIFont systemFontOfSize:FontSize(14)];
        _zplpL.textAlignment = NSTextAlignmentRight;
    }
    return _zplpL;
}
- (UILabel *)oem{
    if (!_oem) {
        _oem = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], _zplp.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _oem.text = @"代工费";
        _oem.textColor = LabelColor6;
        _oem.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _oem;
}
- (UILabel *)oemL{
    if (!_oemL) {
        _oemL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:165], _oem.top, [Unity countcoordinatesW:150], [Unity countcoordinatesH:25])];
        _oemL.textColor = LabelColor6;
        _oemL.font = [UIFont systemFontOfSize:FontSize(14)];
        _oemL.textAlignment = NSTextAlignmentRight;
    }
    return _oemL;
}
- (UILabel *)yhj{
    if (!_yhj) {
        _yhj = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], _oem.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _yhj.text = @"优惠券";
        _yhj.textColor = LabelColor6;
        _yhj.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _yhj;
}
- (UILabel *)yhjL{
    if (!_yhjL) {
        _yhjL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:165], _yhj.top, [Unity countcoordinatesW:150], [Unity countcoordinatesH:25])];
        _yhjL.textColor = LabelColor6;
        _yhjL.font = [UIFont systemFontOfSize:FontSize(14)];
        _yhjL.textAlignment = NSTextAlignmentRight;
    }
    return _yhjL;
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(0, _oemL.bottom, SCREEN_WIDTH, 1)];
        _line.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return  _line;
}
- (UILabel *)xj{
    if (!_xj) {
        _xj = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], _oem.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:35])];
        _xj.text = @"小计";
        _xj.textColor = LabelColor6;
        _xj.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _xj;
}
- (UILabel *)xjL{
    if (!_xjL) {
        _xjL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:165], _xj.top, [Unity countcoordinatesW:150], [Unity countcoordinatesH:35])];
        _xjL.textColor = [Unity getColor:@"aa112d"];
        _xjL.font = [UIFont systemFontOfSize:FontSize(14)];
        _xjL.textAlignment = NSTextAlignmentRight;
    }
    return _xjL;
}
- (void)configWithData:(NSDictionary *)dic{
    if ([dic[@"currency"] isEqualToString:@"円"]) {
        self.titleL.text = [NSString stringWithFormat:@"日本代拍费用（%@）",dic[@"exchange_rate"]];
    }else{
        self.titleL.text = [NSString stringWithFormat:@"美国代拍费用（%@）",dic[@"exchange_rate"]];
    }
    self.sxfL.text = [NSString stringWithFormat:@"%@%@",dic[@"cost_bank_remitt"],dic[@"currency"]];
    self.clfL.text = [NSString stringWithFormat:@"%@%@",dic[@"cost_process"],dic[@"currency"]];
    self.zplpL.text = [NSString stringWithFormat:@"%@%@",dic[@"cost_fraud_safe"],dic[@"currency"]];
    self.oemL.text = [NSString stringWithFormat:@"%@RMB",dic[@"cost_foundry"]];
    self.yhjL.text = @"-0.00RMB";
    self.xjL.text = [NSString stringWithFormat:@"%@RMB",dic[@"price_true"]];
}
@end
