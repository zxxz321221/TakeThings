//
//  HaitaoListCell3.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/17.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "HaitaoListCell3.h"
@interface HaitaoListCell3()
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UILabel * numberL;
@property (nonatomic , strong) UILabel * statusL;
@property (nonatomic , strong) UILabel * line0;
@property (nonatomic , strong) UILabel * goodsTitle;//商品标题
@property (nonatomic , strong) UILabel * goodsNum;//竞拍商品数量
@property (nonatomic , strong) UILabel * placeLabel;//商品价格
@property (nonatomic , strong) UILabel * line1;

@property (nonatomic , strong) UILabel * amount;//预付款
@property (nonatomic , strong) UILabel * amountL;
@property (nonatomic , strong) UILabel * sumPrice;//总价
@property (nonatomic , strong) UILabel * sumPriceL;
@property (nonatomic , strong) UILabel * time;//委托时间
@property (nonatomic , strong) UILabel * timeL;
@property (nonatomic , strong) UILabel * line2;

@property (nonatomic , strong) UIButton * oldBtn;//原始页面
@property (nonatomic , strong) UIButton * deleteBtn;//删除
@end
@implementation HaitaoListCell3

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [Unity getColor:@"f0f0f0"];
        [self.contentView addSubview:self.backView];
    }
    return self;
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:247])];
        _backView.layer.cornerRadius = 5;
        _backView.backgroundColor = [UIColor whiteColor];
        [_backView addSubview:self.numberL];
        [_backView addSubview:self.statusL];
        [_backView addSubview:self.line0];
        [_backView addSubview:self.goodsTitle];
        [_backView addSubview:self.goodsNum];
        [_backView addSubview:self.placeLabel];
        [_backView addSubview:self.line1];
        [_backView addSubview:self.amount];
        [_backView addSubview:self.amountL];
        [_backView addSubview:self.sumPrice];
        [_backView addSubview:self.sumPriceL];
        [_backView addSubview:self.time];
        [_backView addSubview:self.timeL];
        [_backView addSubview:self.line2];
        [_backView addSubview:self.deleteBtn];
        [_backView addSubview:self.oldBtn];
    }
    return _backView;
}
- (UILabel *)numberL{
    if (!_numberL) {
        _numberL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:170], [Unity countcoordinatesH:40])];
        _numberL.text = @"CD XXXX";
        _numberL.textColor = LabelColor3;
        _numberL.font = [UIFont systemFontOfSize:FontSize(14)];
        _numberL.textAlignment = NSTextAlignmentLeft;
    }
    return _numberL;
}
- (UILabel *)statusL{
    if (!_statusL) {
        _statusL = [[UILabel alloc]initWithFrame:CGRectMake(_numberL.right, _numberL.top, [Unity countcoordinatesW:110], _numberL.height)];
        _statusL.text = @"XXX";
        _statusL.textColor = [Unity getColor:@"aa112d"];
        _statusL.font = [UIFont systemFontOfSize:FontSize(14)];
        _statusL.textAlignment = NSTextAlignmentRight;
    }
    return _statusL;
}
- (UILabel *)line0{
    if (!_line0) {
        _line0 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:40], _backView.width-[Unity countcoordinatesW:10], 1)];
        _line0.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line0;
}
- (UILabel *)goodsTitle{
    if (!_goodsTitle) {
        _goodsTitle = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line0.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:200], [Unity countcoordinatesH:30])];
        _goodsTitle.text = @"加快速度将开放啦解放啦氨基酸的反馈了甲方看到了家里快递费家扫地机房";
        _goodsTitle.numberOfLines = 0;
        _goodsTitle.textColor = LabelColor6;
        _goodsTitle.font = [UIFont systemFontOfSize:FontSize(14)];
        _goodsTitle.textAlignment = NSTextAlignmentLeft;
    }
    return _goodsTitle;
}
- (UILabel *)goodsNum{
    if (!_goodsNum) {
        _goodsNum = [[UILabel alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:30], _goodsTitle.top, [Unity countcoordinatesW:20], [Unity countcoordinatesH:15])];
        _goodsNum.text = @"x1";
        _goodsNum.textColor = LabelColor6;
        _goodsNum.font = [UIFont systemFontOfSize:FontSize(12)];
        _goodsNum.textAlignment = NSTextAlignmentRight;
    }
    return _goodsNum;
}
- (UILabel *)placeLabel{
    if (!_placeLabel) {
        _placeLabel = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _goodsTitle.bottom, _backView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        _placeLabel.text = @"xxx円";
        _placeLabel.textColor = [Unity getColor:@"aa112d"];
        _placeLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _placeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _placeLabel;
}
- (UILabel *)line1{
    if (!_line1) {
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _placeLabel.bottom, _backView.width-[Unity countcoordinatesW:10], 1)];
        _line1.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line1;
}
- (UILabel *)amount{
    if (!_amount) {
        _amount = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line1.bottom, [Unity countcoordinatesW:80], [Unity countcoordinatesH:25])];
        _amount.textColor = LabelColor3;
        _amount.text = @"预付款";
        _amount.textAlignment = NSTextAlignmentLeft;
        _amount.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _amount;
}
- (UILabel *)amountL{
    if (!_amountL) {
        _amountL = [[UILabel alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:160], _amount.top, [Unity countcoordinatesW:150], [Unity countcoordinatesH:25])];
        _amountL.textColor = LabelColor6;
        _amountL.textAlignment = NSTextAlignmentRight;
        _amountL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _amountL;
}
- (UILabel *)sumPrice{
    if (!_sumPrice) {
        _sumPrice = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _amount.bottom, [Unity countcoordinatesW:80], [Unity countcoordinatesH:25])];
        _sumPrice.textColor = LabelColor3;
        _sumPrice.text = @"总价(估)";
        _sumPrice.textAlignment = NSTextAlignmentLeft;
        _sumPrice.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _sumPrice;
}
- (UILabel *)sumPriceL{
    if (!_sumPriceL) {
        _sumPriceL = [[UILabel alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:160], _sumPrice.top, [Unity countcoordinatesW:150], [Unity countcoordinatesH:25])];
        _sumPriceL.text = @"尚未报价";
        _sumPriceL.textColor = LabelColor6;
        _sumPriceL.textAlignment = NSTextAlignmentRight;
        _sumPriceL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _sumPriceL;
}
- (UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _sumPrice.bottom, [Unity countcoordinatesW:80], [Unity countcoordinatesH:25])];
        _time.textColor = LabelColor3;
        _time.text = @"委托时间";
        _time.textAlignment = NSTextAlignmentLeft;
        _time.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _time;
}
- (UILabel *)timeL{
    if (!_timeL) {
        _timeL = [[UILabel alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:160], _time.top, [Unity countcoordinatesW:150], [Unity countcoordinatesH:25])];
        _timeL.textColor = LabelColor6;
        _timeL.textAlignment = NSTextAlignmentRight;
        _timeL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _timeL;
}
- (UILabel *)line2{
    if (!_line2) {
        _line2 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _time.bottom, _backView.width-[Unity countcoordinatesW:10], 1)];
        _line2.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line2;
}
- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:90], _line2.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:30])];
        [_deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [_deleteBtn setTitle:@"删除委托单" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
        _deleteBtn.layer.cornerRadius = _deleteBtn.height/2;
        _deleteBtn.layer.borderWidth =1;
        _deleteBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _deleteBtn;
}
- (UIButton *)oldBtn{
    if (!_oldBtn) {
        _oldBtn = [[UIButton alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:170], _line2.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_oldBtn addTarget:self action:@selector(oldClick) forControlEvents:UIControlEventTouchUpInside];
        [_oldBtn setTitle:@"原始页面" forState:UIControlStateNormal];
        [_oldBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        _oldBtn.layer.cornerRadius = _oldBtn.height/2;
        _oldBtn.layer.borderWidth =1;
        _oldBtn.layer.borderColor = LabelColor9.CGColor;
        _oldBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _oldBtn;
}
- (void)deleteClick{
    [self.delegate deleteOrder:self];
}
- (void)oldClick{
    [self.delegate oldPage1:self];
}
- (void)configWithData:(NSDictionary *)dic{
    self.numberL.text = dic[@"order_code"];
//    if ([dic[@"order_bid_status_id"] intValue] == 4) {
//        self.statusL.text = [Unity get_HaitaoStatusId:@"430"];
//    }else if ([dic[@"is_invalid"] intValue] == 1){
//        self.statusL.text = [Unity get_HaitaoStatusId:@"420"];
//    }else if ([dic[@"is_cancel"] intValue] == 1){
//        self.statusL.text = [Unity get_HaitaoStatusId:@"410"];
//    }else{
    self.statusL.text = [Unity get_HaitaoStatusId:dic[@"order_bid_status_id"]];
//    }
    self.goodsTitle.text = dic[@"goods_name"];
    self.goodsNum.text = [NSString stringWithFormat:@"x%@",dic[@"goods_num"]];
    self.placeLabel.text = [NSString stringWithFormat:@"%@%@",dic[@"goods_price"],dic[@"currency"]];
    float sum = [dic[@"price_true"] floatValue]/[dic[@"exchange_rate"] floatValue];
    self.amountL.text = [NSString stringWithFormat:@"%.2f%@",sum,dic[@"currency"]];
    self.sumPriceL.text = [NSString stringWithFormat:@"%.2f%@",sum,dic[@"currency"]];
    self.timeL.text = dic[@"create_time"];
}
@end
