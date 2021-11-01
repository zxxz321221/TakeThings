//
//  PrecelDetailCell1.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/26.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "PrecelDetailCell1.h"
@interface PrecelDetailCell1()
@property (nonatomic , strong) UILabel * orderId;//订单id
@property (nonatomic , strong) UILabel * ysfsL;//运输方式
@property (nonatomic , strong) UIImageView * icon;
@property (nonatomic , strong) UILabel * goodsTitle;
@property (nonatomic , strong) UILabel * goodsNum;
@property (nonatomic , strong) UILabel * subTitle;
@property (nonatomic , strong) UILabel * priceL;
@property (nonatomic , strong) UILabel * line;
@end
@implementation PrecelDetailCell1
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.orderId];
        [self.contentView addSubview:self.ysfsL];
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.goodsTitle];
        [self.contentView addSubview:self.goodsNum];
        [self.contentView addSubview:self.subTitle];
        [self.contentView addSubview:self.priceL];
        [self.contentView addSubview:self.line];
        
    }
    return self;
}
- (UILabel *)orderId{
    if (!_orderId) {
        _orderId = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], 0, [Unity countcoordinatesW:205], [Unity countcoordinatesH:40])];
        _orderId.text = @"订单ID xxxx";
        _orderId.textColor = LabelColor3;
        _orderId.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _orderId;
}
- (UILabel *)ysfsL{
    if (!_ysfsL) {
        _ysfsL = [[UILabel alloc]initWithFrame:CGRectMake(_orderId.right, 0, [Unity countcoordinatesW:85], [Unity countcoordinatesH:40])];
        _ysfsL.text = @"EMS";
        _ysfsL.textColor = [Unity getColor:@"aa112d"];
        _ysfsL.font = [UIFont systemFontOfSize:FontSize(14)];
        _ysfsL.textAlignment = NSTextAlignmentRight;
    }
    return _ysfsL;
}
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], [Unity countcoordinatesH:40], [Unity countcoordinatesW:60], [Unity countcoordinatesH:60])];
        _icon.layer.borderColor = [Unity getColor:@"f0f0f0"].CGColor;
        _icon.layer.borderWidth = 1;
//        _icon.backgroundColor = [UIColor redColor];
        _icon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _icon;
}
- (UILabel *)goodsTitle{
    if (!_goodsTitle) {
        _goodsTitle = [[UILabel alloc]initWithFrame:CGRectMake(_icon.right+[Unity countcoordinatesW:5], _icon.top+[Unity countcoordinatesH:5], [Unity countcoordinatesW:200], [Unity countcoordinatesH:30])];
        _goodsTitle.textColor = LabelColor3;
        _goodsTitle.font = [UIFont systemFontOfSize:FontSize(14)];
        _goodsTitle.numberOfLines = 0;
    }
    return _goodsTitle;
}
- (UILabel *)goodsNum{
    if (!_goodsNum) {
        _goodsNum = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitle.right, _goodsTitle.top, [Unity countcoordinatesW:25], [Unity countcoordinatesH:14])];
        _goodsNum.text = @"x1";
        _goodsNum.textColor = LabelColor3;
        _goodsNum.font = [UIFont systemFontOfSize:FontSize(12)];
        _goodsNum.textAlignment = NSTextAlignmentRight;
    }
    return _goodsNum;
}
- (UILabel *)subTitle{
    if (!_subTitle) {
        _subTitle = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitle.left, _goodsTitle.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:140], [Unity countcoordinatesH:15])];
        _subTitle.textColor = LabelColor9;
        _subTitle.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _subTitle;
}
- (UILabel *)priceL{
    if (!_priceL) {
        _priceL = [[UILabel alloc]initWithFrame:CGRectMake(_subTitle.right, _subTitle.top, [Unity countcoordinatesW:85], [Unity countcoordinatesH:15])];
        _priceL.text = @"1234567円";
        _priceL.textColor = LabelColor3;
        _priceL.font = [UIFont systemFontOfSize:FontSize(14)];
        _priceL.textAlignment = NSTextAlignmentRight;
    }
    return _priceL;
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:111]-1, SCREEN_WIDTH, 1)];
        _line.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return _line;
}
- (void)configData:(NSDictionary *)dic WithKd:(NSInteger)kd{
    self.orderId.text = [NSString stringWithFormat:@"订单ID %@",dic[@"order_code"]];
    if (kd == 1) {
         self.ysfsL.text = @"EMS";
    }else if (kd == 2){
         self.ysfsL.text = @"SAL";
    }else if (kd == 3){
         self.ysfsL.text = @"海运";
    }else if (kd == 4){
         self.ysfsL.text = @"UCS";
    }else{
         self.ysfsL.text = @"空港快线";
    }
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"new_sdxurl"],dic[@"goods_img_local"]]] placeholderImage:[UIImage imageNamed:@"Loading"]];
    self.goodsTitle.text = dic[@"goods_name"];
    self.goodsNum.text = [NSString stringWithFormat:@"x%@",dic[@"goods_num"]];
    self.subTitle.text = dic[@"describe_chinese"];
    self.priceL.text = [NSString stringWithFormat:@"%@%@",dic[@"over_price"],dic[@"currency"]];
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
