//
//  NotiCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/13.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "NotiCell.h"
#import "NotiModel.h"
@interface NotiCell()
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UIButton * readBtn;
@property (nonatomic , strong) UILabel * numberL;//投标编号
@property (nonatomic , strong) UILabel * line0;//
@property (nonatomic , strong) UIImageView * icon;//商品图片
@property (nonatomic , strong) UILabel * goodsTitle;//商品标题
@property (nonatomic , strong) UILabel * goodsNum;//竞拍商品数量
@property (nonatomic , strong) UILabel * line1;
@property (nonatomic , strong) UILabel * regionL;// 所在地区 仓库
@property (nonatomic , strong) UILabel * region;
@property (nonatomic , strong) UILabel * weightL;// 重量
@property (nonatomic , strong) UILabel * weight;
@property (nonatomic , strong) UILabel * timeOfArrivalL;// 到货时间
@property (nonatomic , strong) UILabel * timeOfArrival;
@property (nonatomic , strong) UILabel * biddingPriceL;// 得标价
@property (nonatomic , strong) UILabel * biddingPrice;
@property (nonatomic , strong) UILabel * line2;
@property (nonatomic , strong) UILabel * sumL;//现况总价
@property (nonatomic , strong) UILabel * sum;
@property (nonatomic , strong) UIButton * oriPage;//原始页面
@property (nonatomic , strong) UIButton * detail;//明细
@property (nonatomic , strong) UIButton * goodsBtn;
@end
@implementation NotiCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [self NotiView];
    }
    return self;
}
- (void)NotiView{
    [self.contentView addSubview:self.backView];
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:335])];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 10;
        
        [_backView addSubview:self.readBtn];
        [_backView addSubview:self.numberL];
        [_backView addSubview:self.line0];
        [_backView addSubview:self.goodsBtn];
//        [_backView addSubview:self.goodsTitle];
//        [_backView addSubview:self.goodsNum];
        [_backView addSubview:self.line1];
        [_backView addSubview:self.regionL];
        [_backView addSubview:self.region];
        [_backView addSubview:self.weightL];
        [_backView addSubview:self.weight];
        [_backView addSubview:self.timeOfArrivalL];
        [_backView addSubview:self.timeOfArrival];
        [_backView addSubview:self.biddingPriceL];
        [_backView addSubview:self.biddingPrice];
        [_backView addSubview:self.line2];
        [_backView addSubview:self.sumL];
        [_backView addSubview:self.sum];
        [_backView addSubview:self.oriPage];
        [_backView addSubview:self.detail];
    }
    return _backView;
}
- (UIButton *)readBtn{
    if (!_readBtn) {
        _readBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:13], [Unity countcoordinatesW:14], [Unity countcoordinatesW:14])];
        [_readBtn addTarget:self action:@selector(readClick:) forControlEvents:UIControlEventTouchUpInside];
        [_readBtn setBackgroundImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [_readBtn setBackgroundImage:[UIImage imageNamed:@"read"] forState:UIControlStateSelected];
    }
    return _readBtn;
}
- (UILabel *)numberL{
    if (!_numberL) {
        _numberL = [[UILabel alloc]initWithFrame:CGRectMake(_readBtn.right+[Unity countcoordinatesW:10], 0, _backView.width-[Unity countcoordinatesW:46], [Unity countcoordinatesH:40])];
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
- (UILabel *)line1{
    if (!_line1) {
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _goodsBtn.bottom, _backView.width-[Unity countcoordinatesW:10], 1)];
        _line1.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line1;
}
- (UILabel *)regionL{
    if (!_regionL) {
        _regionL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _goodsBtn.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
        _regionL.textColor = LabelColor3;
        _regionL.text = @"所在仓库";
        _regionL.textAlignment = NSTextAlignmentLeft;
        _regionL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _regionL;
}
- (UILabel *)region{
    if (!_region) {
        _region = [[UILabel alloc]initWithFrame:CGRectMake(_regionL.right, _regionL.top, _backView.width-[Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _region.textColor = LabelColor3;
        _region.text = @"";
        _region.textAlignment = NSTextAlignmentRight;
        _region.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _region;
}
- (UILabel *)weightL{
    if (!_weightL) {
        _weightL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _regionL.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:120], [Unity countcoordinatesH:20])];
        _weightL.textColor = LabelColor3;
        _weightL.text = @"重量";
        _weightL.textAlignment = NSTextAlignmentLeft;
        _weightL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _weightL;
}
- (UILabel *)weight{
    if (!_weight) {
        _weight = [[UILabel alloc]initWithFrame:CGRectMake(_weightL.right, _weightL.top, _backView.width-[Unity countcoordinatesW:140], [Unity countcoordinatesH:20])];
        _weight.textColor = LabelColor6;
        _weight.textAlignment = NSTextAlignmentRight;
        _weight.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _weight;
}
- (UILabel *)timeOfArrivalL{
    if (!_timeOfArrivalL) {
        _timeOfArrivalL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _weightL.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:120], [Unity countcoordinatesH:20])];
        _timeOfArrivalL.textColor = LabelColor3;
        _timeOfArrivalL.text = @"到货时间";
        _timeOfArrivalL.textAlignment = NSTextAlignmentLeft;
        _timeOfArrivalL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _timeOfArrivalL;
}
- (UILabel *)timeOfArrival{
    if (!_timeOfArrival) {
        _timeOfArrival = [[UILabel alloc]initWithFrame:CGRectMake(_timeOfArrivalL.right, _timeOfArrivalL.top, _backView.width-[Unity countcoordinatesW:140], [Unity countcoordinatesH:20])];
        _timeOfArrival.textColor = LabelColor6;
        _timeOfArrival.textAlignment = NSTextAlignmentRight;
        _timeOfArrival.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _timeOfArrival;
}
- (UILabel *)biddingPriceL{
    if (!_biddingPriceL) {
        _biddingPriceL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _timeOfArrivalL.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:120], [Unity countcoordinatesH:20])];
        _biddingPriceL.textColor = LabelColor3;
        _biddingPriceL.text = @"购得价";
        _biddingPriceL.textAlignment = NSTextAlignmentLeft;
        _biddingPriceL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _biddingPriceL;
}
- (UILabel *)biddingPrice{
    if (!_biddingPrice) {
        _biddingPrice = [[UILabel alloc]initWithFrame:CGRectMake(_biddingPriceL.right, _biddingPriceL.top, _backView.width-[Unity countcoordinatesW:140], [Unity countcoordinatesH:20])];
        _biddingPrice.textColor = LabelColor3;
        _biddingPrice.textAlignment = NSTextAlignmentRight;
        _biddingPrice.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _biddingPrice;
}
- (UILabel *)line2{
    if (!_line2) {
        _line2 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _biddingPrice.bottom+[Unity countcoordinatesH:10], _backView.width-[Unity countcoordinatesW:10], 1)];
        _line2.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line2;
}
- (UILabel *)sumL{
    if (!_sumL) {
        _sumL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _biddingPriceL.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:120], [Unity countcoordinatesH:20])];
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
        _sum.textAlignment = NSTextAlignmentRight;
        _sum.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _sum;
}
- (UIButton *)oriPage{
    if (!_oriPage) {
        _oriPage = [[UIButton alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:160], _sum.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_oriPage addTarget:self action:@selector(oriPageClick) forControlEvents:UIControlEventTouchUpInside];
        //设置边框颜色
        _oriPage.layer.borderColor = [LabelColor9 CGColor];
        //设置边框宽度
        _oriPage.layer.borderWidth = 1.0f;
        [_oriPage setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_oriPage setTitle:@"原始页面" forState:UIControlStateNormal];
        _oriPage.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _oriPage.layer.cornerRadius = [Unity countcoordinatesH:15];
        _oriPage.layer.masksToBounds = YES;
    }
    return _oriPage;
}
- (UIButton *)detail{
    if (!_detail) {
        _detail = [[UIButton alloc]initWithFrame:CGRectMake(_oriPage.right+[Unity countcoordinatesW:10], _sum.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
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
- (void)oriPageClick{
    [self.delegate oriPage:self];
}
- (void)detailClick{
    [self.delegate detail:self];
}



- (void)readClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(shoppingCellDelegate:WithSelectButton:)])
    {
        [self.delegate shoppingCellDelegate:self WithSelectButton:sender];
    }
}

/**
 *  模型赋值
 */
- (void)setModel:(NotiModel *)model{
    self.readBtn.selected = model.isSelect;
    
    self.numberL.text = [NSString stringWithFormat:@"订单编号 %@/%@",model.w_lsh,model.w_jpnid];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.w_imgsrc] placeholderImage:[UIImage imageNamed:@"Loading"]];
    self.goodsTitle.text = model.w_object;
    self.goodsNum.text = [NSString stringWithFormat:@"x%@",model.w_tbsl];
    self.timeOfArrival.text = model.dhsj;
    self.weight.text = [NSString stringWithFormat:@"%@KG",model.w_kgs];
    if ([model.w_cc isEqualToString:@"0"]) {
        if ([model.w_receive_place intValue] ==0) {
            self.region.text = @"福冈";
        }else{
            self.region.text = @"千叶";
        }
        self.biddingPrice.text = [NSString stringWithFormat:@"%@円",model.w_jbj_jp];
    }else{
        self.region.text = @"California";
        self.biddingPrice.text = [NSString stringWithFormat:@"%@美元",model.w_jbj_jp];
    }
    self.sum.text = [NSString stringWithFormat:@"%@RMB",model.w_total_tw];
    
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
