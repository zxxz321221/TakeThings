//
//  NewTwoCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/23.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "NewTwoCell.h"
@interface NewTwoCell()
{
    NSInteger oneStatus;// 1 立即支付 2 包裹详情 3 确认收货
    NSInteger twoStatus;// 1 修改地址 2 物流查询
}
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UILabel * numberL;
@property (nonatomic , strong) UILabel * statusL;
@property (nonatomic , strong) UILabel * line0;
@property (nonatomic , strong) UILabel * ysfsLabel;
@property (nonatomic , strong) UILabel * numL;
@property (nonatomic , strong) UILabel * line;
@property (nonatomic , strong) UIButton * waybillBtn;
@property (nonatomic , strong) UIButton * logistic;
@property (nonatomic , strong) UIButton * universal;
@property (nonatomic , strong) UIImageView * numImg;//运单编号前面的图片
@end

@implementation NewTwoCell
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
    [_backView addSubview:self.numberL];
    [_backView addSubview:self.statusL];
    [_backView addSubview:self.line0];
    [self.backView addSubview:self.ysfsLabel];
    [self.backView addSubview:self.numL];
    [self.backView addSubview:self.line];
    [_backView addSubview:self.waybillBtn];
    [_backView addSubview:self.numImg];
    [_backView addSubview:self.logistic];
    [_backView addSubview:self.universal];
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:212])];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius =10;
    }
    return _backView;
}
- (UILabel *)numberL{
    if (!_numberL) {
        _numberL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:150], [Unity countcoordinatesH:40])];
        _numberL.textColor = LabelColor3;
        _numberL.font = [UIFont systemFontOfSize:FontSize(14)];
        _numberL.textAlignment = NSTextAlignmentLeft;
    }
    return _numberL;
}
- (UILabel *)statusL{
    if (!_statusL) {
        _statusL = [[UILabel alloc]initWithFrame:CGRectMake(_numberL.right, _numberL.top, [Unity countcoordinatesW:130], _numberL.height)];
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
- (UILabel *)ysfsLabel{
    if (!_ysfsLabel) {
        _ysfsLabel = [[UILabel alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:80], [Unity countcoordinatesH:41], [Unity countcoordinatesW:70], [Unity countcoordinatesH:40])];
        _ysfsLabel.text = @"";
        _ysfsLabel.textColor = [Unity getColor:@"aa112d"];
        _ysfsLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _ysfsLabel.textAlignment = NSTextAlignmentRight;
    }
    return _ysfsLabel;
}
- (UILabel *)numL{
    if (!_numL) {
        _numL = [[UILabel alloc]initWithFrame:CGRectMake(_ysfsLabel.left, _ysfsLabel.bottom+[Unity countcoordinatesH:20], _ysfsLabel.width, [Unity countcoordinatesH:20])];
        _numL.text = @"";
        _numL.textColor = LabelColor3;
        _numL.font = [UIFont systemFontOfSize:FontSize(14)];
        _numL.textAlignment = NSTextAlignmentRight;
    }
    return _numL;
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:151], _backView.width-[Unity countcoordinatesW:10], 1)];
        _line.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line;
}
- (UIButton *)waybillBtn{
    if (!_waybillBtn) {
        _waybillBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line.bottom, [Unity countcoordinatesW:118], [Unity countcoordinatesH:60])];
        _waybillBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _waybillBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_waybillBtn addTarget:self action:@selector(waybillClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _waybillBtn;
}
- (UIImageView *)numImg{
    if (!_numImg) {
        _numImg = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:133], _line.bottom+[Unity countcoordinatesH:24], [Unity countcoordinatesW:12], [Unity countcoordinatesH:12])];
        _numImg.image = [UIImage imageNamed:@"bglist"];
    }
    return _numImg;
}
- (UIButton *)logistic{
    if (!_logistic) {
        _logistic = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], _line.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
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
    _numL.text = [NSString stringWithFormat:@"共%@件",dic[@"goods_num"]];
    NSInteger i = 0;
    if ([dic[@"order_count"] intValue] >= 3) {
        i=3;
    }else{
        i = [dic[@"order_count"] intValue];
    }
    for (int j=0; j<[dic[@"order_list"] count]; j++) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5]+j*[Unity countcoordinatesW:70], [Unity countcoordinatesH:41], [Unity countcoordinatesW:70], [Unity countcoordinatesH:40])];
        label.text = dic[@"order_list"][j][@"order_code"];
        label.textColor = LabelColor3;
        label.font = [UIFont systemFontOfSize:FontSize(14)];
        label.textAlignment = NSTextAlignmentCenter;
        [self.backView addSubview:label];
        if ([dic[@"order_category_id"] intValue] == 100) {
            UILabel * tt = [[UILabel alloc]initWithFrame:CGRectMake((j+1)*[Unity countcoordinatesW:10]+j*[Unity countcoordinatesH:60], label.bottom, [Unity countcoordinatesW:60], [Unity countcoordinatesH:60])];
            tt.numberOfLines = 0;
            tt.text = dic[@"order_list"][j][@"goods_name"];
            tt.font = [UIFont systemFontOfSize:FontSize(14)];
            tt.textColor = LabelColor3;
            [self.backView addSubview:tt];
        }else{
            UIImageView * icon = [[UIImageView alloc]initWithFrame:CGRectMake((j+1)*[Unity countcoordinatesW:10]+j*[Unity countcoordinatesH:60], label.bottom, [Unity countcoordinatesW:60], [Unity countcoordinatesH:60])];
            //添加边框
            CALayer * layer = [icon layer];
            layer.borderColor = [[Unity getColor:@"#e0e0e0"] CGColor];
            layer.borderWidth = 1.0f;
            icon.contentMode = UIViewContentModeScaleAspectFit;
            [icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"new_sdxurl"],dic[@"order_list"][j][@"goods_img_local"]]] placeholderImage:[UIImage imageNamed:@"Loading"]];
            [self.backView addSubview:icon];
        }
    }
    
    NSString * str2 = [NSString stringWithFormat:@"运单编号 %@",dic[@"traffic_num"]];
    NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc] initWithString:str2];
    [str3 addAttribute:NSForegroundColorAttributeName value:LabelColor3 range:NSMakeRange(0,5)];
    [str3 addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"aa112d"] range:NSMakeRange(5,str3.length-5)];
    [_waybillBtn setAttributedTitle:str3 forState:UIControlStateNormal];
    
    
    
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
                [_universal setTitle:@"立即支付" forState:UIControlStateNormal];
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
    [self.delegate TwoLogisticClick:self WithTag:twoStatus];
}
- (void)universalClick{
    [self.delegate TwoUniversalClick:self WithTag:oneStatus];
}
- (void)waybillClick:(UIButton *)btn{
    [self.delegate TwoSeleteLogistics:btn.titleLabel.text WithCell:self];
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
