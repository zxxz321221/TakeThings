//
//  HaitaoDetailCell5.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/18.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "HaitaoDetailCell5.h"
@interface HaitaoDetailCell5()
@property (nonatomic , strong) UILabel * gjyfT;//国际运输方式
@property (nonatomic , strong) UILabel * gjyfL;
@property (nonatomic , strong) UILabel * zlT;//重量
@property (nonatomic , strong) UILabel * zlL;
@property (nonatomic , strong) UILabel * kddhT;//快递单号
@property (nonatomic , strong) UILabel * kddhL;
@property (nonatomic , strong) UILabel * kddtT;//快递动态
@property (nonatomic , strong) UIButton * kddtBtn;

@property (nonatomic , strong) NSDictionary * bgDic;
@end
@implementation HaitaoDetailCell5

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.gjyfT];
        [self.contentView addSubview:self.gjyfL];
        [self.contentView addSubview:self.zlT];
        [self.contentView addSubview:self.zlL];
        [self.contentView addSubview:self.kddhT];
        [self.contentView addSubview:self.kddhL];
        [self.contentView addSubview:self.kddtT];
        [self.contentView addSubview:self.kddtBtn];
    }
    return self;
}
- (UILabel *)gjyfT{
    if (!_gjyfT) {
        _gjyfT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], 0, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _gjyfT.text = @"国际运输方式";
        _gjyfT.textColor = LabelColor6;
        _gjyfT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _gjyfT;
}
- (UILabel *)gjyfL{
    if (!_gjyfL) {
        _gjyfL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:115], _gjyfT.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _gjyfL.textColor = LabelColor6;
        _gjyfL.font = [UIFont systemFontOfSize:FontSize(14)];
        _gjyfL.textAlignment = NSTextAlignmentRight;
    }
    return _gjyfL;
}
- (UILabel *)zlT{
    if (!_zlT) {
        _zlT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], _gjyfT.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _zlT.text = @"重量";
        _zlT.textColor = LabelColor6;
        _zlT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _zlT;
}
- (UILabel *)zlL{
    if (!_zlL) {
        _zlL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:115], _zlT.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _zlL.textColor = LabelColor6;
        _zlL.font = [UIFont systemFontOfSize:FontSize(14)];
        _zlL.textAlignment = NSTextAlignmentRight;
    }
    return _zlL;
}
- (UILabel *)kddhT{
    if (!_kddhT) {
        _kddhT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], _zlT.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _kddhT.text = @"快递单号";
        _kddhT.textColor = LabelColor6;
        _kddhT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _kddhT;
}
- (UILabel *)kddhL{
    if (!_kddhL) {
        _kddhL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:115], _kddhT.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _kddhL.text = @"工作人员处理中";
        _kddhL.textColor = LabelColor9;
        _kddhL.font = [UIFont systemFontOfSize:FontSize(14)];
        _kddhL.textAlignment = NSTextAlignmentRight;
    }
    return _kddhL;
}
- (UILabel *)kddtT{
    if (!_kddtT) {
        _kddtT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], _kddhT.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _kddtT.text = @"快递动态";
        _kddtT.textColor = LabelColor6;
        _kddtT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _kddtT;
}
- (UIButton *)kddtBtn{
    if (!_kddtBtn) {
        _kddtBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:115], _kddtT.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        [_kddtBtn addTarget:self action:@selector(kddtClick) forControlEvents:UIControlEventTouchUpInside];
        [_kddtBtn setTitle:@"暂无信息请等待" forState:UIControlStateNormal];
        [_kddtBtn setTitle:@"查看动态" forState:UIControlStateSelected];
        [_kddtBtn setTitleColor:LabelColor9 forState:UIControlStateNormal];
        [_kddtBtn setTitleColor:[Unity getColor:@"4a90e2"] forState:UIControlStateSelected];
        _kddtBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _kddtBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _kddtBtn.userInteractionEnabled = NO;
    }
    return _kddtBtn;
}
- (void)configWithData:(NSDictionary *)dic{
    NSLog(@"%@",dic);
    self.bgDic = dic;
    self.gjyfL.text = [self getTraffic_type:dic[@"traffic_type"]];
    self.zlL.text = [NSString stringWithFormat:@"%@KG",dic[@"weight_count"]];
    
    if (dic[@"traffic_num"] == nil || [dic[@"traffic_num"] isEqualToString:@""]) {
        self.kddtBtn.selected = NO;
        self.kddtBtn.userInteractionEnabled = NO;
    }else{
        self.kddhL.text = dic[@"traffic_num"];
        self.kddtBtn.selected = YES;
        self.kddtBtn.userInteractionEnabled = YES;
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
- (void)kddtClick{
    [self.delegate expressDynamic:self.bgDic];
}
- (NSDictionary *)bgDic{
    if (!_bgDic) {
        _bgDic = [NSDictionary new];
    }
    return _bgDic;
}
@end
