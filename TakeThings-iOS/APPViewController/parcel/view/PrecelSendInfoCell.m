//
//  PrecelSendInfoCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/27.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "PrecelSendInfoCell.h"
@interface PrecelSendInfoCell()
@property (nonatomic , strong) UIView * blockV;
@property (nonatomic , strong) UILabel * titleL;

@property (nonatomic , strong) UILabel * gjyfT;//国际运输方式
@property (nonatomic , strong) UILabel * gjyfL;
@property (nonatomic , strong) UILabel * zlT;//重量
@property (nonatomic , strong) UILabel * zlL;
@property (nonatomic , strong) UILabel * kddhT;//快递单号
@property (nonatomic , strong) UILabel * kddhL;
@property (nonatomic , strong) UILabel * kddtT;//快递动态
@property (nonatomic , strong) UIButton * kddtBtn;
@property (nonatomic , strong) UILabel * line;
@property (nonatomic , strong) UILabel * zdT;//转单已发出
@property (nonatomic , strong) UILabel * zdL;
@end
@implementation PrecelSendInfoCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.blockV];
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.gjyfT];
        [self.contentView addSubview:self.gjyfL];
        [self.contentView addSubview:self.zlT];
        [self.contentView addSubview:self.zlL];
        [self.contentView addSubview:self.kddhT];
        [self.contentView addSubview:self.kddhL];
        [self.contentView addSubview:self.kddtT];
        [self.contentView addSubview:self.kddtBtn];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.zdT];
        [self.contentView addSubview:self.zdL];
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
        _titleL.text = @"寄送信息";
        _titleL.textColor = LabelColor3;
        _titleL.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _titleL;
}
- (UILabel *)gjyfT{
    if (!_gjyfT) {
        _gjyfT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:13], _titleL.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _gjyfT.text = @"国际运输方式";
        _gjyfT.textColor = LabelColor6;
        _gjyfT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _gjyfT;
}
- (UILabel *)gjyfL{
    if (!_gjyfL) {
        _gjyfL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:113], _gjyfT.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _gjyfL.textColor = LabelColor6;
        _gjyfL.font = [UIFont systemFontOfSize:FontSize(14)];
        _gjyfL.textAlignment = NSTextAlignmentRight;
    }
    return _gjyfL;
}
- (UILabel *)zlT{
    if (!_zlT) {
        _zlT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:13], _gjyfT.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _zlT.text = @"重量";
        _zlT.textColor = LabelColor6;
        _zlT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _zlT;
}
- (UILabel *)zlL{
    if (!_zlL) {
        _zlL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:113], _zlT.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _zlL.textColor = LabelColor6;
        _zlL.font = [UIFont systemFontOfSize:FontSize(14)];
        _zlL.textAlignment = NSTextAlignmentRight;
    }
    return _zlL;
}
- (UILabel *)kddhT{
    if (!_kddhT) {
        _kddhT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:13], _zlT.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _kddhT.text = @"快递单号";
        _kddhT.textColor = LabelColor6;
        _kddhT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _kddhT;
}
- (UILabel *)kddhL{
    if (!_kddhL) {
        _kddhL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:113], _kddhT.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _kddhL.text = @"工作人员处理中";
        _kddhL.textColor = LabelColor9;
        _kddhL.font = [UIFont systemFontOfSize:FontSize(14)];
        _kddhL.textAlignment = NSTextAlignmentRight;
    }
    return _kddhL;
}
- (UILabel *)kddtT{
    if (!_kddtT) {
        _kddtT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:13], _kddhT.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _kddtT.text = @"快递动态";
        _kddtT.textColor = LabelColor6;
        _kddtT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _kddtT;
}
- (UIButton *)kddtBtn{
    if (!_kddtBtn) {
        _kddtBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:113], _kddtT.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        [_kddtBtn addTarget:self action:@selector(kddtClick) forControlEvents:UIControlEventTouchUpInside];
        [_kddtBtn setTitle:@"暂无信息请等待" forState:UIControlStateNormal];
        [_kddtBtn setTitle:@"查看动态" forState:UIControlStateSelected];
        [_kddtBtn setTitleColor:LabelColor9 forState:UIControlStateNormal];
        [_kddtBtn setTitleColor:[Unity getColor:@"4a90e2"] forState:UIControlStateSelected];
        _kddtBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _kddtBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _kddtBtn.userInteractionEnabled = NO;
        _kddtBtn.selected = NO;
    }
    return _kddtBtn;
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(0, _kddtT.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, 1)];
        _line.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return _line;
}
- (UILabel *)zdT{
    if (!_zdT) {
        _zdT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:13], _line.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:34])];
        _zdT.text = @"转单已发出";
        _zdT.textColor = LabelColor3;
        _zdT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _zdT;
}
- (UILabel *)zdL{
    if (!_zdL) {
        _zdL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:113], _zdT.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:34])];
//        _zdL.text = @"xxxx";
        _zdL.textColor = [Unity getColor:@"aa112d"];
        _zdL.font = [UIFont systemFontOfSize:FontSize(14)];
        _zdL.textAlignment = NSTextAlignmentRight;
    }
    return _zdL;
}
- (void)configData:(NSDictionary *)dic{
    _zdL.text = [NSString stringWithFormat:@"新单号 %@",dic[@"turn_order_code"]];
    if ([dic[@"traffic_type"] intValue] == 1) {
         self.gjyfL.text = @"EMS";
    }else if ([dic[@"traffic_type"] intValue] == 2){
         self.gjyfL.text = @"SAL";
    }else if ([dic[@"traffic_type"] intValue] == 3){
         self.gjyfL.text = @"海运";
    }else if ([dic[@"traffic_type"] intValue] == 4){
         self.gjyfL.text = @"UCS";
    }else{
         self.gjyfL.text = @"空港快线";
    }
    self.zlL.text = [NSString stringWithFormat:@"%@ KG",dic[@"weight_count"]];
    self.kddhL.text = dic[@"traffic_num"];
    if ([dic[@"order_transport_status_id"] intValue] >= 180) {
        self.kddtBtn.selected = YES;
        self.kddtBtn.userInteractionEnabled = YES;
    }
    if ([dic[@"order_transport_status_id"] intValue] != 212) {
        self.line.hidden = YES;
        self.zdT.hidden = YES;
        self.zdL.hidden= YES;
    }
}
- (void)kddtClick{
    [self.delegate expressQuery];
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
