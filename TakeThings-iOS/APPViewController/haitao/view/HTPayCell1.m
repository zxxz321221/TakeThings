//
//  HTPayCell1.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/3/3.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "HTPayCell1.h"
@interface HTPayCell1()
@property (nonatomic , strong) UILabel * goodsTitle;//商品标题
@property (nonatomic , strong) UILabel * goodsNum;//竞拍商品数量
@property (nonatomic , strong) UILabel * placeLabel;//商品价格
@property (nonatomic , strong) UILabel * line0;

@property (nonatomic , strong) UILabel * goods_price;
@property (nonatomic , strong) UILabel * goods_priceL;
@property (nonatomic , strong) UILabel * cost_bank;
@property (nonatomic , strong) UILabel * cost_bankL;
@property (nonatomic , strong) UILabel * cost_process;
@property (nonatomic , strong) UILabel * cost_processL;
@property (nonatomic , strong) UILabel * zplp;
@property (nonatomic , strong) UILabel * zplpL;
@property (nonatomic , strong) UILabel * oem;
@property (nonatomic , strong) UILabel * oemL;
@property (nonatomic , strong) UILabel * line1;
@property (nonatomic , strong) UILabel * hj;
@property (nonatomic , strong) UILabel * hjL;
@property (nonatomic , strong) UILabel * line2;

@property (nonatomic , strong) UIView * blockV;
@property (nonatomic , strong) UILabel * payT;
@property (nonatomic , strong) UIButton * payType;
@property (nonatomic , strong) UILabel * payTypeT;
@property (nonatomic , strong) UIButton * payType1;
@property (nonatomic , strong) UILabel * payTypeT1;
@end
@implementation HTPayCell1

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.goodsTitle];
        [self.contentView addSubview:self.goodsNum];
        [self.contentView addSubview:self.placeLabel];
        [self.contentView addSubview:self.line0];
        [self.contentView addSubview:self.goods_price];
        [self.contentView addSubview:self.goods_priceL];
        [self.contentView addSubview:self.cost_bank];
        [self.contentView addSubview:self.cost_bankL];
        [self.contentView addSubview:self.cost_process];
        [self.contentView addSubview:self.cost_processL];
        [self.contentView addSubview:self.zplp];
        [self.contentView addSubview:self.zplpL];
        [self.contentView addSubview:self.oem];
        [self.contentView addSubview:self.oemL];
        [self.contentView addSubview:self.line1];
        [self.contentView addSubview:self.hj];
        [self.contentView addSubview:self.hjL];
        [self.contentView addSubview:self.line2];
        
        [self.contentView addSubview:self.blockV];
        [self.contentView addSubview:self.payT];
        [self.contentView addSubview:self.payType];
        [self.contentView addSubview:self.payTypeT];
        [self.contentView addSubview:self.payType1];
        [self.contentView addSubview:self.payTypeT1];
    }
    return self;
}

- (UILabel *)goodsTitle{
    if (!_goodsTitle) {
        _goodsTitle = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line0.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:200], [Unity countcoordinatesH:30])];
//        _goodsTitle.text = @"加快速度将开放啦解放啦氨基酸的反馈了甲方看到了家里快递费家扫地机房";
        _goodsTitle.numberOfLines = 0;
        _goodsTitle.textColor = LabelColor6;
        _goodsTitle.font = [UIFont systemFontOfSize:FontSize(14)];
        _goodsTitle.textAlignment = NSTextAlignmentLeft;
    }
    return _goodsTitle;
}
- (UILabel *)goodsNum{
    if (!_goodsNum) {
        _goodsNum = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:30], _goodsTitle.top, [Unity countcoordinatesW:20], [Unity countcoordinatesH:15])];
//        _goodsNum.text = @"x1";
        _goodsNum.textColor = LabelColor6;
        _goodsNum.font = [UIFont systemFontOfSize:FontSize(12)];
        _goodsNum.textAlignment = NSTextAlignmentRight;
    }
    return _goodsNum;
}
- (UILabel *)placeLabel{
    if (!_placeLabel) {
        _placeLabel = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _goodsTitle.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
//        _placeLabel.text = @"xxx円";
        _placeLabel.textColor = LabelColor3;
        _placeLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _placeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _placeLabel;
}
- (UILabel *)line0{
    if (!_line0) {
        _line0 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _placeLabel.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:10], 1)];
        _line0.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return _line0;
}
- (UILabel *)goods_price{
    if (!_goods_price) {
        _goods_price = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line0.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _goods_price.textColor = LabelColor6;
        _goods_price.text = @"商品价格";
        _goods_price.textAlignment = NSTextAlignmentLeft;
        _goods_price.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _goods_price;
}
- (UILabel *)goods_priceL{
    if (!_goods_priceL) {
        _goods_priceL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:160], _goods_price.top, [Unity countcoordinatesW:150], [Unity countcoordinatesH:25])];
        _goods_priceL.textColor = LabelColor6;
        _goods_priceL.textAlignment = NSTextAlignmentRight;
        _goods_priceL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _goods_priceL;
}
- (UILabel *)cost_bank{
    if (!_cost_bank) {
        _cost_bank = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _goods_priceL.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _cost_bank.textColor = LabelColor6;
        _cost_bank.text = @"银行汇款手续费";
        _cost_bank.textAlignment = NSTextAlignmentLeft;
        _cost_bank.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _cost_bank;
}
- (UILabel *)cost_bankL{
    if (!_cost_bankL) {
        _cost_bankL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:160], _cost_bank.top, [Unity countcoordinatesW:150], [Unity countcoordinatesH:25])];
        _cost_bankL.textColor = LabelColor6;
        _cost_bankL.textAlignment = NSTextAlignmentRight;
        _cost_bankL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _cost_bankL;
}
- (UILabel *)cost_process{
    if (!_cost_process) {
        _cost_process = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _cost_bankL.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _cost_process.textColor = LabelColor6;
        _cost_process.text = @"海外处理费";
        _cost_process.textAlignment = NSTextAlignmentLeft;
        _cost_process.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _cost_process;
}
- (UILabel *)cost_processL{
    if (!_cost_processL) {
        _cost_processL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:160], _cost_process.top, [Unity countcoordinatesW:150], [Unity countcoordinatesH:25])];
        _cost_processL.textColor = LabelColor6;
        _cost_processL.textAlignment = NSTextAlignmentRight;
        _cost_processL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _cost_processL;
}
- (UILabel *)zplp{
    if (!_zplp) {
        _zplp = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _cost_processL.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _zplp.textColor = LabelColor6;
        _zplp.text = @"诈骗理赔";
        _zplp.textAlignment = NSTextAlignmentLeft;
        _zplp.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _zplp;
}
- (UILabel *)zplpL{
    if (!_zplpL) {
        _zplpL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:160], _zplp.top, [Unity countcoordinatesW:150], [Unity countcoordinatesH:25])];
        _zplpL.textColor = LabelColor6;
        _zplpL.textAlignment = NSTextAlignmentRight;
        _zplpL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _zplpL;
}
- (UILabel *)oem{
    if (!_oem) {
        _oem = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _zplpL.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _oem.textColor = LabelColor6;
        _oem.text = @"代工费";
        _oem.textAlignment = NSTextAlignmentLeft;
        _oem.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _oem;
}
- (UILabel *)oemL{
    if (!_oemL) {
        _oemL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:160], _oem.top, [Unity countcoordinatesW:150], [Unity countcoordinatesH:25])];
        _oemL.textColor = LabelColor6;
        _oemL.textAlignment = NSTextAlignmentRight;
        _oemL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _oemL;
}
- (UILabel *)line1{
    if (!_line1) {
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _oemL.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:10], 1)];
        _line1.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return _line1;
}
- (UILabel *)hj{
    if (!_hj) {
        _hj = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _oemL.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:40])];
        _hj.textColor = LabelColor3;
        _hj.text = @"合计";
        _hj.textAlignment = NSTextAlignmentLeft;
        _hj.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _hj;
}
- (UILabel *)hjL{
    if (!_hjL) {
        _hjL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:160], _hj.top, [Unity countcoordinatesW:150], [Unity countcoordinatesH:40])];
        _hjL.textColor = [Unity getColor:@"aa112d"];
        _hjL.textAlignment = NSTextAlignmentRight;
        _hjL.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _hjL;
}
- (UILabel *)line2{
    if (!_line2) {
        _line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, _hjL.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:8])];
        _line2.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return _line2;
}
- (UIView *)blockV{
    if (!_blockV) {
        _blockV = [[UIView alloc]initWithFrame:CGRectMake(0, _line2.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:3], [Unity countcoordinatesH:10])];
        _blockV.backgroundColor = [Unity getColor:@"aa112d"];
    }
    return _blockV;
}
- (UILabel *)payT{
    if (!_payT) {
        _payT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line2.bottom+[Unity countcoordinatesH:15], 100, [Unity countcoordinatesH:20])];
        _payT.text = @"支付方式";
        _payT.textColor = LabelColor3;
        _payT.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _payT;
}
- (UIButton *)payType{
    if (!_payType) {
        _payType = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:10], _payT.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:93], [Unity countcoordinatesH:20])];
        [_payType addTarget:self action:@selector(payTypeClick:) forControlEvents:UIControlEventTouchUpInside];
        [_payType setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_payType setBackgroundImage:[UIImage imageNamed:@"kj"] forState:UIControlStateNormal];
        _payType.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _payType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_payType setImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [_payType setImage:[UIImage imageNamed:@"zhong"] forState:UIControlStateSelected];
    }
    return _payType;
}
- (UILabel *)payTypeT{
    if (!_payTypeT) {
        _payTypeT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _payType.bottom+[Unity countcoordinatesH:4], [Unity countcoordinatesW:93], [Unity countcoordinatesH:20])];
        _payTypeT.text = @"借记卡快捷支付";
        _payTypeT.textColor = LabelColor3;
        _payTypeT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _payTypeT;
}
- (UIButton *)payType1{
    if (!_payType1) {
        _payType1 = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:113], _payT.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:93], [Unity countcoordinatesH:20])];
        [_payType1 addTarget:self action:@selector(payTypeClick1:) forControlEvents:UIControlEventTouchUpInside];
        [_payType1 setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_payType1 setBackgroundImage:[UIImage imageNamed:@"kj"] forState:UIControlStateNormal];
        _payType1.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _payType1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_payType1 setImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [_payType1 setImage:[UIImage imageNamed:@"zhong"] forState:UIControlStateSelected];
    }
    return _payType1;
}
- (UILabel *)payTypeT1{
    if (!_payTypeT1) {
        _payTypeT1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:113], _payType1.bottom+[Unity countcoordinatesH:4], [Unity countcoordinatesW:93], [Unity countcoordinatesH:20])];
        _payTypeT1.text = @"信用卡快捷支付";
        _payTypeT1.textColor = LabelColor3;
        _payTypeT1.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _payTypeT1;
}
- (void)payTypeClick:(UIButton *)btn{
    if (btn.selected) {
        return;
    }else{
        self.payType.selected = YES;
        self.payType1.selected = NO;
        [self.delegate selectBank:0];
    }
}
- (void)payTypeClick1:(UIButton *)btn{
    if (btn.selected) {
        return;
    }else{
        self.payType1.selected = YES;
        self.payType.selected = NO;
        [self.delegate selectBank:1];
    }
}
- (void)configWithData:(NSDictionary *)dic{
    self.goodsTitle.text = dic[@"goods_name"];
    self.goodsNum.text = [NSString stringWithFormat:@"x%@",dic[@"goods_num"]];
    self.placeLabel.text = [NSString stringWithFormat:@"%@%@",dic[@"goods_price"],dic[@"currency"]];
    float sum = [dic[@"price_true"] floatValue]/[dic[@"exchange_rate"] floatValue];
    self.goods_priceL.text = [NSString stringWithFormat:@"%.2f%@",sum,dic[@"currency"]];
    self.cost_bankL.text = [NSString stringWithFormat:@"%@%@",dic[@"cost_bank_remitt"],dic[@"currency"]];
    self.cost_processL.text = [NSString stringWithFormat:@"%@%@",dic[@"cost_process"],dic[@"currency"]];
    self.zplpL.text = [NSString stringWithFormat:@"%@%@",dic[@"cost_fraud_safe"],dic[@"currency"]];
    self.oemL.text = [NSString stringWithFormat:@"%@RMB",dic[@"cost_foundry"]];
    self.hjL.text = [NSString stringWithFormat:@"%@RMB",dic[@"price_true"]];
}
@end
