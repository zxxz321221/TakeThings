//
//  NewOneCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/11/29.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "NewOneCell.h"
@interface NewOneCell()
{
    NSInteger oneStatus;// 1 立即支付 2 包裹详情 3 确认收货
    NSInteger twoStatus;// 1 修改地址 2 物流查询 3 退运
}
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UILabel * numberL;
@property (nonatomic , strong) UILabel * statusL;
@property (nonatomic , strong) UILabel * line0;
@property (nonatomic , strong) UILabel * orderNuml;//订单ID
@property (nonatomic , strong) UILabel * ysfsLabel;//运输方式
@property (nonatomic , strong) UIImageView * icon;//商品图片
@property (nonatomic , strong) UILabel * goodsTitle;//商品标题
@property (nonatomic , strong) UILabel * goodsNum;//竞拍商品数量
@property (nonatomic , strong) UILabel * placeLabel;//商品价格
@property (nonatomic , strong) UILabel * line1;
@property (nonatomic , strong) UIButton * waybillBtn;
@property (nonatomic , strong) UIButton * logistic;
@property (nonatomic , strong) UIButton * universal;
@property (nonatomic , strong) UIImageView * numImg;//运单编号前面的图片


@end
@implementation NewOneCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [self patCellView];
    }
    return self;
}
- (void)patCellView{
    [self.contentView addSubview:self.backView];
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:222])];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 10;
        
        [_backView addSubview:self.numberL];
        [_backView addSubview:self.statusL];
        [_backView addSubview:self.line0];
        [_backView addSubview:self.orderNuml];
        [_backView addSubview:self.ysfsLabel];
        [_backView addSubview:self.icon];
        [_backView addSubview:self.goodsTitle];
        [_backView addSubview:self.goodsNum];
        [_backView addSubview:self.placeLabel];
        [_backView addSubview:self.line1];
        [_backView addSubview:self.waybillBtn];
        [_backView addSubview:self.numImg];
        [_backView addSubview:self.logistic];
        [_backView addSubview:self.universal];
    }
    return _backView;
}
- (UILabel *)numberL{
    if (!_numberL) {
        _numberL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:170], [Unity countcoordinatesH:40])];
        _numberL.textColor = LabelColor3;
        _numberL.font = [UIFont systemFontOfSize:FontSize(14)];
        _numberL.textAlignment = NSTextAlignmentLeft;
    }
    return _numberL;
}
- (UILabel *)statusL{
    if (!_statusL) {
        _statusL = [[UILabel alloc]initWithFrame:CGRectMake(_numberL.right, _numberL.top, [Unity countcoordinatesW:110], _numberL.height)];
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
- (UILabel *)orderNuml{
    if (!_orderNuml) {
        _orderNuml = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:41], [Unity countcoordinatesW:180], [Unity countcoordinatesH:40])];
        _orderNuml.textColor = LabelColor3;
        _orderNuml.font = [UIFont systemFontOfSize:FontSize(14)];
        _orderNuml.textAlignment = NSTextAlignmentLeft;
    }
    return _orderNuml;
}
- (UILabel *)ysfsLabel{
    if (!_ysfsLabel) {
        _ysfsLabel = [[UILabel alloc]initWithFrame:CGRectMake(_orderNuml.right, [Unity countcoordinatesH:41], [Unity countcoordinatesW:100], [Unity countcoordinatesH:40])];
        _ysfsLabel.textColor = [Unity getColor:@"aa112d"];
        _ysfsLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _ysfsLabel.textAlignment = NSTextAlignmentRight;
    }
    return _ysfsLabel;
}
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _orderNuml.bottom, [Unity countcoordinatesW:70], [Unity countcoordinatesH:70])];
        //添加边框
        CALayer * layer = [_icon layer];
        layer.borderColor = [[Unity getColor:@"#e0e0e0"] CGColor];
        layer.borderWidth = 1.0f;
        _icon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _icon;
}
- (UILabel *)goodsTitle{
    if (!_goodsTitle) {
        _goodsTitle = [[UILabel alloc]initWithFrame:CGRectMake(_icon.right+[Unity countcoordinatesW:5], _icon.top, _backView.width-[Unity countcoordinatesW:125], [Unity countcoordinatesH:40])];
        _goodsTitle.numberOfLines = 0;
        _goodsTitle.textColor = LabelColor3;
        _goodsTitle.font = [UIFont systemFontOfSize:FontSize(14)];
        _goodsTitle.textAlignment = NSTextAlignmentLeft;
    }
    return _goodsTitle;
}
- (UILabel *)goodsNum{
    if (!_goodsNum) {
        _goodsNum = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitle.right+[Unity countcoordinatesW:10], _goodsTitle.top+[Unity countcoordinatesH:5], [Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _goodsNum.textColor = LabelColor6;
        _goodsNum.font = [UIFont systemFontOfSize:FontSize(12)];
        _goodsNum.textAlignment = NSTextAlignmentRight;
    }
    return _goodsNum;
}
- (UILabel *)placeLabel{
    if (!_placeLabel) {
        _placeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitle.left, _goodsTitle.bottom+[Unity countcoordinatesH:10], _backView.width-[Unity countcoordinatesW:95], [Unity countcoordinatesH:20])];
        _placeLabel.textColor = LabelColor6;
        _placeLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _placeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _placeLabel;
}
- (UILabel *)line1{
    if (!_line1) {
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _icon.bottom+[Unity countcoordinatesH:10], _backView.width-[Unity countcoordinatesW:10], 1)];
        _line1.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line1;
}
- (UIButton *)waybillBtn{
    if (!_waybillBtn) {
        _waybillBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line1.bottom, [Unity countcoordinatesW:118], [Unity countcoordinatesH:60])];
        _waybillBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _waybillBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_waybillBtn addTarget:self action:@selector(waybillClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _waybillBtn;
}
- (UIImageView *)numImg{
    if (!_numImg) {
        _numImg = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:133], _line1.bottom+[Unity countcoordinatesH:24], [Unity countcoordinatesW:12], [Unity countcoordinatesH:12])];
        _numImg.image = [UIImage imageNamed:@"bglist"];
    }
    return _numImg;
}
- (UIButton *)logistic{
    if (!_logistic) {
        _logistic = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], _line1.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_logistic addTarget:self action:@selector(logisticClick) forControlEvents:UIControlEventTouchUpInside];
        //设置边框颜色
        _logistic.layer.borderColor = [LabelColor9 CGColor];
        //设置边框宽度
        _logistic.layer.borderWidth = 1.0f;
        [_logistic setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_logistic setTitle:@"物流查询" forState:UIControlStateNormal];
        _logistic.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _logistic.layer.cornerRadius = [Unity countcoordinatesH:15];
        _logistic.layer.masksToBounds = YES;
    }
    return _logistic;
}
- (UIButton *)universal{
    if (!_universal) {
        _universal = [[UIButton alloc]initWithFrame:CGRectMake(_logistic.right+[Unity countcoordinatesW:5], _logistic.top, [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_universal addTarget:self action:@selector(universalClick) forControlEvents:UIControlEventTouchUpInside];
    _universal.backgroundColor = [Unity getColor:@"aa112d"];
    [_universal setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_universal setTitle:@"立即支付" forState:UIControlStateNormal];
    _universal.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    _universal.layer.cornerRadius = [Unity countcoordinatesH:15];
    _universal.layer.masksToBounds = YES;
    }
    return _universal;
}

- (void)configWithData:(NSDictionary *)dic{
    
    _numberL.text = [NSString stringWithFormat:@"包裹编号 %@",dic[@"order_code"]];
    _statusL.text = dic[@"status_name"];
    _orderNuml.text = [NSString stringWithFormat:@"订单ID %@",dic[@"order_list"][0][@"order_code"]];
    if ([dic[@"traffic_type"] intValue] == 1) {
        _ysfsLabel.text = @"EMS";
    }else if ([dic[@"traffic_type"] intValue] == 2){
        _ysfsLabel.text = @"SAL";
    }else if ([dic[@"traffic_type"] intValue] == 3){
        _ysfsLabel.text = @"海运";
    }else if ([dic[@"traffic_type"] intValue] == 4){
        _ysfsLabel.text = @"UCS";
    }else{
        _ysfsLabel.text = @"空港快线";
    }
    [_icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"new_sdxurl"],dic[@"order_list"][0][@"goods_img_local"]]] placeholderImage:[UIImage imageNamed:@"Loading"]];
    _goodsTitle.text = dic[@"order_list"][0][@"goods_name"];
    _goodsNum.text = [NSString stringWithFormat:@"x%@",dic[@"order_list"][0][@"goods_num"]];
    
//    _placeLabel.text
    NSString * str = [NSString stringWithFormat:@"购得价 %@%@",dic[@"over_price"],dic[@"currency"]];
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:str];
    [str1 addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"aa112d"] range:NSMakeRange(4,str.length-4)];
    _placeLabel.attributedText = str1;
    
    NSString * str2 = [NSString stringWithFormat:@"运单编号 %@",dic[@"traffic_num"]];
    NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc] initWithString:str2];
    [str3 addAttribute:NSForegroundColorAttributeName value:LabelColor3 range:NSMakeRange(0,5)];
    [str3 addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"aa112d"] range:NSMakeRange(5,str3.length-5)];
    [_waybillBtn setAttributedTitle:str3 forState:UIControlStateNormal];
    
    if ([dic[@"order_category_id"] intValue] == 100) {
        self.icon.hidden = YES;
        self.goodsTitle.frame = CGRectMake([Unity countcoordinatesW:10], _orderNuml.bottom, _backView.width-[Unity countcoordinatesW:200], [Unity countcoordinatesH:40]);
    }
    
    //根据状态判断 底部按钮样式
    switch ([dic[@"order_transport_status_id"]intValue]) {
        case 140:
            {
                oneStatus = 2;
                twoStatus = 1;
                [_logistic setTitle:@"修改地址" forState:UIControlStateNormal];
                [_universal setTitle:@"包裹详情" forState:UIControlStateNormal];
                _waybillBtn.hidden = YES;
                _numImg.hidden = YES;
            }
            break;
        case 150:
            {
                oneStatus = 2;
                twoStatus = 1;
                [_logistic setTitle:@"修改地址" forState:UIControlStateNormal];
                [_universal setTitle:@"包裹详情" forState:UIControlStateNormal];
                _waybillBtn.hidden = YES;
                _numImg.hidden = YES;
            }
            break;
        case 160:
            {
                oneStatus = 1;
                twoStatus = 1;
                [_logistic setTitle:@"修改地址" forState:UIControlStateNormal];
                [_universal setTitle:@"立即支付" forState:UIControlStateNormal];
                _waybillBtn.hidden = YES;
                _numImg.hidden = YES;
            }
            break;
        case 170:
            {
                oneStatus = 2;
                twoStatus = 2;
                [_logistic setTitle:@"物流查询" forState:UIControlStateNormal];
                [_universal setTitle:@"包裹详情" forState:UIControlStateNormal];
            }
            break;
        case 180:
            {
                oneStatus = 3;
                twoStatus = 3;
//                [_logistic setTitle:@"退回通知" forState:UIControlStateNormal];
                if ([dic[@"traffic_type"] intValue] == 5) {
                    _logistic.hidden = YES;
                }
                [_universal setTitle:@"确认收货" forState:UIControlStateNormal];
            }
            break;
        case 190:
            {
                oneStatus = 1;
                twoStatus = 2;
                [_logistic setTitle:@"物流查询" forState:UIControlStateNormal];
                [_universal setTitle:@"立即支付" forState:UIControlStateNormal];
            }
            break;
        case 200:
            {
                oneStatus = 2;
                twoStatus = 2;
                [_logistic setTitle:@"物流查询" forState:UIControlStateNormal];
                [_universal setTitle:@"包裹详情" forState:UIControlStateNormal];
            }
            break;
        case 210:
            {
                oneStatus = 2;
                twoStatus = 2;
                [_logistic setTitle:@"物流查询" forState:UIControlStateNormal];
                [_universal setTitle:@"包裹详情" forState:UIControlStateNormal];
            }
            break;
        case 212:
            {
                oneStatus = 2;
                twoStatus = 2;
                [_logistic setTitle:@"物流查询" forState:UIControlStateNormal];
                [_universal setTitle:@"包裹详情" forState:UIControlStateNormal];
            }
            break;
        case 220:
            {
                oneStatus = 2;
                twoStatus = 2;
                [_logistic setTitle:@"物流查询" forState:UIControlStateNormal];
                [_universal setTitle:@"包裹详情" forState:UIControlStateNormal];
            }
            break;
        default:
            break;
    }
}
- (void)logisticClick{
    [self.delegate OneLogisticClick:self WithTag:twoStatus];
}
- (void)universalClick{
    [self.delegate OneUniversalClick:self WithTag:oneStatus];
}
- (void)waybillClick:(UIButton *)btn{
//    NSLog(@"%@",btn.titleLabel.text);
    [self.delegate OneSeleteLogistics:btn.titleLabel.text WithCell:self];
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
