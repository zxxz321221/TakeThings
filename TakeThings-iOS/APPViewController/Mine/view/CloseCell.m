//
//  CloseCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/13.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "CloseCell.h"
#import "CloseModel.h"
@interface CloseCell()
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UIButton * readBtn;
@property (nonatomic , strong) UILabel * numberL;//得标ID
@property (nonatomic , strong) UILabel * line0;//
@property (nonatomic , strong) UIImageView * icon;//商品图片
@property (nonatomic , strong) UILabel * goodsTitle;//商品标题
@property (nonatomic , strong) UILabel * goodsNum;//竞拍商品数量
@property (nonatomic , strong) UILabel * line1;
@property (nonatomic , strong) UILabel * entrustTimeL;//委托时间
@property (nonatomic , strong) UILabel * entrustTime;
@property (nonatomic , strong) UILabel * endTimeL;// 结标时间
@property (nonatomic , strong) UILabel * endTime;
@property (nonatomic , strong) UILabel * highestL;//最高出价
@property (nonatomic , strong) UILabel * highest;
@property (nonatomic , strong) UILabel * line2;
@property (nonatomic , strong) UILabel * sumL;//现况总价
@property (nonatomic , strong) UILabel * sum;
@property (nonatomic , strong) UIButton * detail;//明细
@property (nonatomic , strong) UIButton * goodsBtn;
@end
@implementation CloseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [self shipView];
    }
    return self;
}
- (void)shipView{
    [self.contentView addSubview:self.backView];
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:315])];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 10;
        
        [_backView addSubview:self.readBtn];
        [_backView addSubview:self.numberL];
        [_backView addSubview:self.line0];
        [_backView addSubview:self.goodsBtn];
//        [_backView addSubview:self.goodsTitle];
//        [_backView addSubview:self.goodsNum];
        [_backView addSubview:self.line1];
        [_backView addSubview:self.entrustTimeL];
        [_backView addSubview:self.entrustTime];
        [_backView addSubview:self.endTimeL];
        [_backView addSubview:self.endTime];
        [_backView addSubview:self.highestL];
        [_backView addSubview:self.highest];
        [_backView addSubview:self.line2];
        [_backView addSubview:self.sumL];
        [_backView addSubview:self.sum];
        [_backView addSubview:self.detail];
    }
    return _backView;
}
- (UIButton *)readBtn{
    if (!_readBtn) {
        _readBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:13], [Unity countcoordinatesW:14], [Unity countcoordinatesH:14])];
        [_readBtn addTarget:self action:@selector(readClick:) forControlEvents:UIControlEventTouchUpInside];
        [_readBtn setBackgroundImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [_readBtn setBackgroundImage:[UIImage imageNamed:@"read"] forState:UIControlStateSelected];
        _readBtn.hidden = YES;
    }
    return _readBtn;
}
- (UILabel *)numberL{
    if (!_numberL) {
//        _numberL = [[UILabel alloc]initWithFrame:CGRectMake(_readBtn.right+[Unity countcoordinatesW:10], 0, _backView.width-[Unity countcoordinatesW:46], [Unity countcoordinatesH:40])];
        _numberL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, _backView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        _numberL.text = @"";
        _numberL.textColor = LabelColor3;
        _numberL.font = [UIFont systemFontOfSize:FontSize(14)];
        _numberL.textAlignment = NSTextAlignmentLeft;
    }
    return _numberL;
}
- (UILabel *)line0{
    if (!_line0) {
        _line0 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:40], _backView.width-[Unity countcoordinatesW:10], 1)];
        _line0.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line0;
}
- (UIButton *)goodsBtn{
    if (!_goodsBtn) {
        _goodsBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _line0.bottom, _backView.width, [Unity countcoordinatesH:90])];
        [_goodsBtn addTarget:self action:@selector(goodBtn) forControlEvents:UIControlEventTouchUpInside];
        [_goodsBtn addSubview:self.icon];
        [_goodsBtn addSubview:self.goodsTitle];
        [_goodsBtn addSubview:self.goodsNum];
    }
    return _goodsBtn;
}
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:70])];
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
        _goodsTitle.text = @"";
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
        _goodsNum.text = @"";
        _goodsNum.textColor = LabelColor6;
        _goodsNum.font = [UIFont systemFontOfSize:FontSize(12)];
        _goodsNum.textAlignment = NSTextAlignmentRight;
    }
    return _goodsNum;
}
- (UILabel *)line1{
    if (!_line1) {
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _goodsBtn.bottom, _backView.width-[Unity countcoordinatesW:10], 1)];
        _line1.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line1;
}
- (UILabel *)entrustTimeL{
    if (!_entrustTimeL) {
        _entrustTimeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _goodsBtn.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
        _entrustTimeL.textColor = LabelColor3;
        _entrustTimeL.text = @"委托时间";
        _entrustTimeL.textAlignment = NSTextAlignmentLeft;
        _entrustTimeL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _entrustTimeL;
}
- (UILabel *)entrustTime{
    if (!_entrustTime) {
        _entrustTime = [[UILabel alloc]initWithFrame:CGRectMake(_entrustTimeL.right, _entrustTimeL.top, _backView.width-[Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _entrustTime.textColor = LabelColor6;
        _entrustTime.text = @"";
        _entrustTime.textAlignment = NSTextAlignmentRight;
        _entrustTime.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _entrustTime;
}
- (UILabel *)endTimeL{
    if (!_endTimeL) {
        _endTimeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _entrustTimeL.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:120], [Unity countcoordinatesH:20])];
        _endTimeL.textColor = LabelColor3;
        _endTimeL.text = @"结束时间";
        _endTimeL.textAlignment = NSTextAlignmentLeft;
        _endTimeL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _endTimeL;
}
- (UILabel *)endTime{
    if (!_endTime) {
        _endTime = [[UILabel alloc]initWithFrame:CGRectMake(_endTimeL.right, _endTimeL.top, _backView.width-[Unity countcoordinatesW:140], [Unity countcoordinatesH:20])];
        _endTime.textColor = LabelColor6;
        _endTime.text = @"";
        _endTime.textAlignment = NSTextAlignmentRight;
        _endTime.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _endTime;
}
- (UILabel *)highestL{
    if (!_highestL) {
        _highestL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _endTimeL.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:120], [Unity countcoordinatesH:20])];
        _highestL.textColor = LabelColor3;
        _highestL.text = @"我的价格";
        _highestL.textAlignment = NSTextAlignmentLeft;
        _highestL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _highestL;
}
- (UILabel *)highest{
    if (!_highest) {
        _highest = [[UILabel alloc]initWithFrame:CGRectMake(_highestL.right, _highestL.top, _backView.width-[Unity countcoordinatesW:140], [Unity countcoordinatesH:20])];
        _highest.textColor = LabelColor3;
        _highest.text = @"";
        _highest.textAlignment = NSTextAlignmentRight;
        _highest.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _highest;
}
- (UILabel *)line2{
    if (!_line2) {
        _line2 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _highestL.bottom+[Unity countcoordinatesH:10], _backView.width-[Unity countcoordinatesW:10], 1)];
        _line2.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line2;
}
- (UILabel *)sumL{
    if (!_sumL) {
        _sumL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _highestL.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:120], [Unity countcoordinatesH:20])];
        _sumL.textColor = LabelColor3;
        _sumL.text = @"现况总价";
        _sumL.textAlignment = NSTextAlignmentLeft;
        _sumL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _sumL;
}
- (UILabel *)sum{
    if (!_sum) {
        _sum = [[UILabel alloc]initWithFrame:CGRectMake(_sumL.right, _sumL.top, _backView.width-[Unity countcoordinatesW:140], [Unity countcoordinatesH:20])];
        _sum.textColor = [Unity getColor:@"aa112d"];
        _sum.text = @"";
        _sum.textAlignment = NSTextAlignmentRight;
        _sum.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _sum;
}
- (UIButton *)detail{
    if (!_detail) {
        _detail = [[UIButton alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:80], _sumL.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_detail addTarget:self action:@selector(detailClick) forControlEvents:UIControlEventTouchUpInside];
        _detail.backgroundColor = [Unity getColor:@"#aa112d"];
        [_detail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_detail setTitle:@"订单明细" forState:UIControlStateNormal];
        _detail.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _detail.layer.cornerRadius = [Unity countcoordinatesH:15];
        _detail.layer.masksToBounds = YES;
    }
    return _detail;
}

- (void)configIsAction:(BOOL)isAction{
    if (isAction) {
        self.readBtn.hidden = NO;
        self.numberL.frame = CGRectMake(_readBtn.right+[Unity countcoordinatesW:10], 0, _backView.width-[Unity countcoordinatesW:46], [Unity countcoordinatesH:40]);
        
    }else{
        self.readBtn.hidden = YES;
        self.numberL.frame = CGRectMake([Unity countcoordinatesW:10], 0, _backView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40]);
    }
}
/**
 *  模型赋值
 */
- (void)setModel:(CloseModel *)model{
    self.readBtn.selected = model.isSelect;
    self.numberL.text = [NSString stringWithFormat:@"订单ID %@",model.w_lsh];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.w_imgsrc] placeholderImage:[UIImage imageNamed:@"Loading"]];
    self.goodsTitle.text = model.w_object;
    self.goodsNum.text = [NSString stringWithFormat:@"x%@",model.w_tbsl];
    self.entrustTime.text = model.w_ordertime;
    self.endTime.text = model.w_overtime;
    if ([model.w_cc isEqualToString:@"0"]) {
        self.highest.text = [NSString stringWithFormat:@"%@円",model.w_maxpay_jp];
    }else{
        self.highest.text = [NSString stringWithFormat:@"%@美元",model.w_maxpay_jp];
    }
    self.sum.text = [NSString stringWithFormat:@"%@RMB",model.w_total_tw];
}
- (void)readClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(closeCellDelegate:WithSelectButton:)])
    {
        [self.delegate closeCellDelegate:self WithSelectButton:sender];
    }
}
- (void)detailClick{
    [self.delegate detail:self];
}
- (void)goodBtn{
    [self.delegate goodsDetail:self];
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
