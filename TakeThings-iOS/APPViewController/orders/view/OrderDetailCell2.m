//
//  OrderDetailCell2.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/14.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "OrderDetailCell2.h"
@interface OrderDetailCell2()
@property (nonatomic , strong) UIView * blockV;
@property (nonatomic , strong) UILabel * titleL;

@property (nonatomic , strong) UILabel * bankFeeL;
@property (nonatomic , strong) UILabel * bankFee;
@property (nonatomic , strong) UILabel * overseaFeeL;
@property (nonatomic , strong) UILabel * overseaFee;
@property (nonatomic , strong) UILabel * fraudL;
@property (nonatomic , strong) UILabel * fraud;
@property (nonatomic , strong) UILabel * oemL;
@property (nonatomic , strong) UILabel * oem;
@property (nonatomic , strong) UILabel * couponL;
@property (nonatomic , strong) UILabel * coupon;
@property (nonatomic , strong) UILabel * line;
@property (nonatomic , strong) UILabel * xjL;
@property (nonatomic , strong) UILabel * xj;

@end

@implementation OrderDetailCell2

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.blockV];
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.bankFeeL];
        [self.contentView addSubview:self.bankFee];
        [self.contentView addSubview:self.overseaFeeL];
        [self.contentView addSubview:self.overseaFee];
        [self.contentView addSubview:self.fraudL];
        [self.contentView addSubview:self.fraud];
        [self.contentView addSubview:self.oemL];
        [self.contentView addSubview:self.oem];
        [self.contentView addSubview:self.couponL];
        [self.contentView addSubview:self.coupon];
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
- (UILabel *)bankFeeL{
    if (!_bankFeeL) {
        _bankFeeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:13], _titleL.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _bankFeeL.text = @"银行汇款手续费";
        _bankFeeL.textColor = LabelColor6;
        _bankFeeL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _bankFeeL;
}
- (UILabel *)bankFee{
    if (!_bankFee) {
        _bankFee = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:113], _bankFeeL.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _bankFee.textColor = LabelColor6;
        _bankFee.font = [UIFont systemFontOfSize:FontSize(14)];
        _bankFee.textAlignment = NSTextAlignmentRight;
    }
    return _bankFee;
}
- (UILabel *)overseaFeeL{
    if (!_overseaFeeL) {
        _overseaFeeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:13], _bankFeeL.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _overseaFeeL.text = @"海外处理费";
        _overseaFeeL.textColor = LabelColor6;
        _overseaFeeL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _overseaFeeL;
}
- (UILabel *)overseaFee{
    if (!_overseaFee) {
        _overseaFee = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:113], _overseaFeeL.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _overseaFee.textColor = LabelColor6;
        _overseaFee.font = [UIFont systemFontOfSize:FontSize(14)];
        _overseaFee.textAlignment = NSTextAlignmentRight;
    }
    return _overseaFee;
}
- (UILabel *)fraudL{
    if (!_fraudL) {
        _fraudL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:13], _overseaFeeL.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _fraudL.text = @"诈骗理赔";
        _fraudL.textColor = LabelColor6;
        _fraudL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _fraudL;
}
- (UILabel *)fraud{
    if (!_fraud) {
        _fraud = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:113], _fraudL.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _fraud.textColor = LabelColor6;
        _fraud.font = [UIFont systemFontOfSize:FontSize(14)];
        _fraud.textAlignment = NSTextAlignmentRight;
    }
    return _fraud;
}
- (UILabel *)oemL{
    if (!_oemL) {
        _oemL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:13], _fraudL.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _oemL.text = @"代工费";
        _oemL.textColor = LabelColor6;
        _oemL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _oemL;
}
- (UILabel *)oem{
    if (!_oem) {
        _oem = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:113], _oemL.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _oem.textColor = LabelColor6;
        _oem.font = [UIFont systemFontOfSize:FontSize(14)];
        _oem.textAlignment = NSTextAlignmentRight;
    }
    return _oem;
}
- (UILabel *)couponL{
    if (!_couponL) {
        _couponL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:13], _oemL.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _couponL.text = @"优惠券";
        _couponL.textColor = LabelColor6;
        _couponL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _couponL;
}
- (UILabel *)coupon{
    if (!_coupon) {
        _coupon = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:113], _couponL.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _coupon.text = @"-0.00RMB";
        _coupon.textColor = LabelColor6;
        _coupon.font = [UIFont systemFontOfSize:FontSize(14)];
        _coupon.textAlignment = NSTextAlignmentRight;
    }
    return _coupon;
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(0, _couponL.bottom, SCREEN_WIDTH, 1)];
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
        self.titleL.text = [NSString stringWithFormat:@"日本代拍费用（汇率：%@）",dic[@"exchange_rate"]];
    }else{
        self.titleL.text = [NSString stringWithFormat:@"美国代拍费用（汇率：%@）",dic[@"exchange_rate"]];
    }
    self.bankFee.text = [NSString stringWithFormat:@"%@%@",dic[@"cost_bank_remitt"],dic[@"currency"]];
    self.overseaFee.text = [NSString stringWithFormat:@"%@%@",dic[@"cost_process"],dic[@"currency"]];
    self.fraud.text = [NSString stringWithFormat:@"%@%@",dic[@"cost_fraud_safe"],dic[@"currency"]];
    self.oem.text = [NSString stringWithFormat:@"%@RMB",dic[@"cost_foundry"]];
    float sum = ([dic[@"cost_bank_remitt"] floatValue]+[dic[@"cost_process"] floatValue] + [dic[@"cost_fraud_safe"] floatValue]) * [dic[@"exchange_rate"] floatValue] + [dic[@"cost_foundry"] floatValue];
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
