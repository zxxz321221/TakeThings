//
//  ConfirmCell3.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/14.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "ConfirmCell3.h"
@interface ConfirmCell3()
@property (nonatomic , strong) UILabel * line;
@property (nonatomic , strong) UILabel * block;//标题前红快
@property (nonatomic , strong) UILabel * titleL;

@property (nonatomic , strong) UILabel  * priceL;
@property (nonatomic , strong) UILabel  * rateL;
@property (nonatomic , strong) UILabel  * feeL;
@property (nonatomic , strong) UILabel  * claimL;
@property (nonatomic , strong) UILabel  * oemL;
@property (nonatomic , strong) UILabel * line1;
@property (nonatomic , strong) UILabel  * sum;
@property (nonatomic , strong) UILabel * sumL;

@property (nonatomic , strong) UILabel * markL;
@end
@implementation ConfirmCell3
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.block];
        [self.contentView addSubview:self.titleL];
        [self create];
        [self.contentView addSubview:self.priceL];
        [self.contentView addSubview:self.rateL];
        [self.contentView addSubview:self.feeL];
        [self.contentView addSubview:self.claimL];
        [self.contentView addSubview:self.oemL];
        [self.contentView addSubview:self.line1];
        [self.contentView addSubview:self.sum];
        [self.contentView addSubview:self.sumL];
        [self.contentView addSubview:self.markL];
    }
    return self;
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        _line.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return _line;
}
- (UILabel *)block{
    if (!_block) {
        _block = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:25], [Unity countcoordinatesW:3], [Unity countcoordinatesH:10])];
        _block.backgroundColor = [Unity getColor:@"aa112d"];
    }
    return _block;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(_block.right+[Unity countcoordinatesW:10],[Unity countcoordinatesH:20], 300, [Unity countcoordinatesH:20])];
//        _titleL.text = @"预付款(汇率0.0667)";
        _titleL.font = [UIFont systemFontOfSize:FontSize(17)];
        _titleL.textColor = LabelColor3;
    }
    return _titleL;
}
- (void)create{
    NSArray * arr = @[@"购买价",@"汇费",@"当地处理费",@"诈骗理赔",@"代工费"];
    for (int i=0; i<arr.count; i++) {
        UILabel * title = [Unity lableViewAddsuperview_superView:self.contentView _subViewFrame:CGRectMake([Unity countcoordinatesW:20], [Unity countcoordinatesH:40]+i*[Unity countcoordinatesH:25], [Unity countcoordinatesW:60], [Unity countcoordinatesH:25]) _string:arr[i] _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        title.backgroundColor = [UIColor clearColor];
    }
}
- (UILabel *)priceL{
    if (!_priceL) {
        _priceL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:100], [Unity countcoordinatesH:40], [Unity countcoordinatesW:200], [Unity countcoordinatesH:25])];
        _priceL.text = @"--";
        _priceL.textColor = LabelColor6;
        _priceL.font = [UIFont systemFontOfSize:FontSize(14)];
        _priceL.textAlignment = NSTextAlignmentRight;
    }
    return _priceL;
}
- (UILabel *)rateL{
    if (!_rateL) {
        _rateL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:100], _priceL.bottom, [Unity countcoordinatesW:200], [Unity countcoordinatesH:25])];
        _rateL.text = @"--";
        _rateL.textColor = LabelColor6;
        _rateL.font = [UIFont systemFontOfSize:FontSize(14)];
        _rateL.textAlignment = NSTextAlignmentRight;
    }
    return _rateL;
}
- (UILabel *)feeL{
    if (!_feeL) {
        _feeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:100], _rateL.bottom, [Unity countcoordinatesW:200], [Unity countcoordinatesH:25])];
        _feeL.text = @"--";
        _feeL.textColor = LabelColor6;
        _feeL.font = [UIFont systemFontOfSize:FontSize(14)];
        _feeL.textAlignment = NSTextAlignmentRight;
    }
    return _feeL;
}
- (UILabel *)claimL{
    if (!_claimL) {
        _claimL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:100], _feeL.bottom, [Unity countcoordinatesW:200], [Unity countcoordinatesH:25])];
        _claimL.text = @"--";
        _claimL.textColor = LabelColor6;
        _claimL.font = [UIFont systemFontOfSize:FontSize(14)];
        _claimL.textAlignment = NSTextAlignmentRight;
    }
    return _claimL;
}
- (UILabel *)oemL{
    if (!_oemL) {
        _oemL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:100], _claimL.bottom, [Unity countcoordinatesW:200], [Unity countcoordinatesH:25])];
        _oemL.text = @"--";
        _oemL.textColor = LabelColor6;
        _oemL.font = [UIFont systemFontOfSize:FontSize(14)];
        _oemL.textAlignment = NSTextAlignmentRight;
    }
    return _oemL;
}
- (UILabel *)line1{
    if (!_line1) {
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, _oemL.bottom, SCREEN_WIDTH, 1)];
        _line1.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return _line1;
}
- (UILabel *)sum{
    if (!_sum) {
        _sum = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], _oemL.bottom, [Unity countcoordinatesW:60], [Unity countcoordinatesH:25])];
        _sum.text = @"合计";
        _sum.textColor = LabelColor3;
        _sum.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _sum;
}
- (UILabel *)sumL{
    if (!_sumL) {
        _sumL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:100], _oemL.bottom, [Unity countcoordinatesW:200], [Unity countcoordinatesH:25])];
        _sumL.text = @"--";
        _sumL.textColor = [Unity getColor:@"aa112d"];
        _sumL.font = [UIFont systemFontOfSize:FontSize(14)];
        _sumL.textAlignment = NSTextAlignmentRight;
    }
    return _sumL;
}
- (UILabel *)markL{
    if (!_markL) {
        _markL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], _sumL.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:40], [Unity countcoordinatesH:40])];
        _markL.text = @"(此计算结果是同一个卖家多个商品,作为一个订单,如不同卖家需要单独计算!工作人员会帮您整理。此为“不含”税金,当地运费,国际运费的预付款!全部报价工作人员会在委托单送出后,1~2个工作天内报价给您。)";
        _markL.textColor = LabelColor6;
        _markL.font = [UIFont systemFontOfSize:FontSize(10)];
        _markL.numberOfLines = 0;
        _markL.textAlignment = NSTextAlignmentCenter;
    }
    return _markL;
}
- (void)configWithData:(NSDictionary *)dic{
    self.titleL.text = [NSString stringWithFormat:@"预付款(汇率%@)",dic[@"exchange_rate"]];
    self.priceL.text = [NSString stringWithFormat:@"%@%@",dic[@"goods_price"],dic[@"currency"]];
    self.rateL.text = [NSString stringWithFormat:@"%@%@",dic[@"cost_bank_remitt"],dic[@"currency"]];
    self.feeL.text = [NSString stringWithFormat:@"%@%@",dic[@"cost_process"],dic[@"currency"]];
    self.claimL.text = [NSString stringWithFormat:@"%@%@",dic[@"cost_fraud_safe"],dic[@"currency"]];
    self.oemL.text = [NSString stringWithFormat:@"%@RMB",dic[@"cost_foundry"]];
    self.sumL.text = [NSString stringWithFormat:@"%@RMB",dic[@"price_true"]];
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
