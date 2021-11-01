//
//  OrderDetailCell6.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/15.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "OrderDetailCell6.h"
@interface OrderDetailCell6()
@property (nonatomic , strong) UILabel * bgNumL;
@property (nonatomic , strong) UIButton * bgNumBtn;
@property (nonatomic , strong) UILabel * sendTypeL;
@property (nonatomic , strong) UILabel * sendType;
@property (nonatomic , strong) UILabel * weightL;
@property (nonatomic , strong) UILabel * weight;
@property (nonatomic , strong) UILabel * kdNumL;
@property (nonatomic , strong) UILabel * kdNum;
@property (nonatomic , strong) UILabel * kdTrendL;
@property (nonatomic , strong) UIButton * kdTrendBtn;

@property (nonatomic , strong) NSDictionary * bgDic;
@end
@implementation OrderDetailCell6
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.bgNumL];
        [self.contentView addSubview:self.bgNumBtn];
        [self.contentView addSubview:self.sendTypeL];
        [self.contentView addSubview:self.sendType];
        [self.contentView addSubview:self.weightL];
        [self.contentView addSubview:self.weight];
        [self.contentView addSubview:self.kdNumL];
        [self.contentView addSubview:self.kdNum];
        [self.contentView addSubview:self.kdTrendL];
        [self.contentView addSubview:self.kdTrendBtn];
    }
    return self;
}
- (UILabel *)bgNumL{
    if (!_bgNumL) {
        _bgNumL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _bgNumL.text = @"包裹编号";
        _bgNumL.textColor = LabelColor6;
        _bgNumL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _bgNumL;
}
- (UIButton *)bgNumBtn{
    if (!_bgNumBtn) {
        _bgNumBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:110], _bgNumL.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        [_bgNumBtn addTarget:self action:@selector(bgNumClick) forControlEvents:UIControlEventTouchUpInside];
        [_bgNumBtn setTitle:@"包裹编号xx" forState:UIControlStateNormal];
        [_bgNumBtn setTitleColor:[Unity getColor:@"4a90e2"] forState:UIControlStateNormal];
        _bgNumBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _bgNumBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _bgNumBtn;
}
- (UILabel *)sendTypeL{
    if (!_sendTypeL) {
        _sendTypeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _bgNumL.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _sendTypeL.text = @"国际运输方式";
        _sendTypeL.textColor = LabelColor6;
        _sendTypeL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _sendTypeL;
}
- (UILabel *)sendType{
    if (!_sendType) {
        _sendType = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:110], _sendTypeL.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _sendType.textColor = LabelColor6;
        _sendType.font = [UIFont systemFontOfSize:FontSize(14)];
        _sendType.textAlignment = NSTextAlignmentRight;
    }
    return _sendType;
}
- (UILabel *)weightL{
    if (!_weightL) {
        _weightL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _sendType.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _weightL.text = @"重量";
        _weightL.textColor = LabelColor6;
        _weightL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _weightL;
}
- (UILabel *)weight{
    if (!_weight) {
        _weight = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:110], _weightL.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _weight.textColor = LabelColor6;
        _weight.font = [UIFont systemFontOfSize:FontSize(14)];
        _weight.textAlignment = NSTextAlignmentRight;
    }
    return _weight;
}
- (UILabel *)kdNumL{
    if (!_kdNumL) {
        _kdNumL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _weight.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _kdNumL.text = @"快递单号";
        _kdNumL.textColor = LabelColor6;
        _kdNumL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _kdNumL;
}
- (UILabel *)kdNum{
    if (!_kdNum) {
        _kdNum = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:110], _kdNumL.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _kdNum.textColor = LabelColor6;
        _kdNum.font = [UIFont systemFontOfSize:FontSize(14)];
        _kdNum.textAlignment = NSTextAlignmentRight;
    }
    return _kdNum;
}
- (UILabel *)kdTrendL{
    if (!_kdTrendL) {
        _kdTrendL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _kdNum.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _kdTrendL.text = @"快递动态";
        _kdTrendL.textColor = LabelColor6;
        _kdTrendL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _kdTrendL;
}
- (UIButton *)kdTrendBtn{
    if (!_kdTrendBtn) {
        _kdTrendBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:110], _kdTrendL.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        [_kdTrendBtn addTarget:self action:@selector(kdTrendClick) forControlEvents:UIControlEventTouchUpInside];
        [_kdTrendBtn setTitle:@"查看详细" forState:UIControlStateNormal];
        [_kdTrendBtn setTitle:@"暂无快递动态" forState:UIControlStateSelected];
        [_kdTrendBtn setTitleColor:[Unity getColor:@"4a90e2"] forState:UIControlStateNormal];
        [_kdTrendBtn setTitleColor:LabelColor9 forState:UIControlStateSelected];
        _kdTrendBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _kdTrendBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _kdTrendBtn;
}
//点击详细
- (void)kdTrendClick{
    [self.delegate expressDynamic:self.bgDic];
}
//包裹编号
- (void)bgNumClick{
//    NSLog(@"%@",self.bgDic);
    [self.delegate bgDetail:self.bgDic[@"id"]];
}
- (void)configWithData:(NSDictionary *)dic{
    NSLog(@"%@",dic);
    self.bgDic = dic;
    [self.bgNumBtn setTitle:dic[@"order_code"] forState:UIControlStateNormal];
    self.sendType.text = [self getTraffic_type:dic[@"traffic_type"]];
    self.weight.text = [NSString stringWithFormat:@"%@KG",dic[@"weight_count"]];
    self.kdNum.text = dic[@"traffic_num"];
    if (dic[@"traffic_num"] == nil || [dic[@"traffic_num"] isEqualToString:@""]) {
        self.kdTrendBtn.selected = YES;
        self.kdTrendBtn.userInteractionEnabled = NO;
    }
}
- (NSString *)getTraffic_type:(NSString *)type{
    switch ([type intValue]) {
        case 1:
            return @"EMS";
            break;
        case 2:
            return @"SAL";
            break;
        case 3:
            return @"海运";
            break;
        case 4:
            return @"UCS";
            break;
            
        default:
            return @"空港快线";
            break;
    }
}
- (NSDictionary *)bgDic{
    if (!_bgDic) {
        _bgDic = [NSDictionary new];
    }
    return _bgDic;
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
