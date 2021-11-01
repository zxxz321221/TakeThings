//
//  NotBidCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/5.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "NotBidCell.h"
#import "NotBidModel.h"
@interface NotBidCell()
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UILabel * numberL;//投标编号
@property (nonatomic , strong) UILabel * statusL;//竞拍状态
@property (nonatomic , strong) UILabel * line0;//
@property (nonatomic , strong) UIImageView * icon;//商品图片
@property (nonatomic , strong) UILabel * goodsTitle;//商品标题
@property (nonatomic , strong) UILabel * goodsNum;//竞拍商品数量
@property (nonatomic , strong) UILabel * offerL;//出价竞标
@property (nonatomic , strong) UILabel * goodsAmount;//价格
@property (nonatomic , strong) UILabel * line1;
@property (nonatomic , strong) UILabel * accountL;//出价账号文字
@property (nonatomic , strong) UILabel * account;//出价账号
@property (nonatomic , strong) UILabel * endOfTimeL;//结标时间
@property (nonatomic , strong) UILabel * endOfTime;
@property (nonatomic , strong) UILabel * line2;
@property (nonatomic , strong) UILabel * highestBidL;//最高出价
@property (nonatomic , strong) UILabel * highestBid;
@property (nonatomic , strong) UIButton * readBtn;//编辑
@property (nonatomic , strong) UIButton * goodsBtn;
@end
@implementation NotBidCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [self notBidCellView];
    }
    return self;
}
- (void)notBidCellView{
    [self.contentView addSubview:self.backView];
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:243])];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 10;
        
        [_backView addSubview:self.readBtn];
        [_backView addSubview:self.numberL];
        [_backView addSubview:self.statusL];
        [_backView addSubview:self.line0];
        [_backView addSubview:self.goodsBtn];
//        [_backView addSubview:self.goodsTitle];
//        [_backView addSubview:self.goodsNum];
//        [_backView addSubview:self.offerL];
//        [_backView addSubview:self.goodsAmount];
        [_backView addSubview:self.line1];
        [_backView addSubview:self.accountL];
        [_backView addSubview:self.account];
        [_backView addSubview:self.endOfTimeL];
        [_backView addSubview:self.endOfTime];
        [_backView addSubview:self.line2];
        [_backView addSubview:self.highestBidL];
        [_backView addSubview:self.highestBid];
        
    }
    return _backView;
}
- (UIButton *)readBtn{
    if (!_readBtn) {
        _readBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:12], [Unity countcoordinatesW:16], [Unity countcoordinatesH:16])];
        [_readBtn setBackgroundImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [_readBtn setBackgroundImage:[UIImage imageNamed:@"read"] forState:UIControlStateSelected];
        [_readBtn addTarget:self action:@selector(raadClick:) forControlEvents:UIControlEventTouchUpInside];
        _readBtn.hidden = YES;
    }
    return _readBtn;
}
- (UILabel *)numberL{
    if (!_numberL) {
        _numberL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:200], [Unity countcoordinatesH:40])];
        _numberL.text = @"";
        _numberL.textColor = LabelColor3;
        _numberL.font = [UIFont systemFontOfSize:14];
        _numberL.textAlignment = NSTextAlignmentLeft;
    }
    return _numberL;
}
- (UILabel *)statusL{
    if (!_statusL) {
        _statusL = [[UILabel alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:80], _numberL.top, [Unity countcoordinatesW:70], _numberL.height)];
//        _statusL.text = @"购买失败";
        _statusL.textColor = [Unity getColor:@"560010"];
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
- (UIButton *)goodsBtn{
    if (!_goodsBtn) {
        _goodsBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _line0.bottom, _backView.width, [Unity countcoordinatesH:90])];
        [_goodsBtn addTarget:self action:@selector(goodBtn) forControlEvents:UIControlEventTouchUpInside];
        [_goodsBtn addSubview:self.icon];
        [_goodsBtn addSubview:self.goodsTitle];
        [_goodsBtn addSubview:self.goodsNum];
        [_goodsBtn addSubview:self.offerL];
        [_goodsBtn addSubview:self.goodsAmount];
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
        _goodsTitle.font = [UIFont systemFontOfSize:14];
        _goodsTitle.textAlignment = NSTextAlignmentLeft;
    }
    return _goodsTitle;
}
- (UILabel *)goodsNum{
    if (!_goodsNum) {
        _goodsNum = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitle.right+[Unity countcoordinatesW:10], _goodsTitle.top+[Unity countcoordinatesH:5], [Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _goodsNum.text = @"";
        _goodsNum.textColor = LabelColor6;
        _goodsNum.font = [UIFont systemFontOfSize:12];
        _goodsNum.textAlignment = NSTextAlignmentRight;
    }
    return _goodsNum;
}
- (UILabel *)offerL{
    if (!_offerL) {
        _offerL = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitle.left, _goodsTitle.bottom+[Unity countcoordinatesH:7], [Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _offerL.backgroundColor = [Unity getColor:@"#f6e7ea"];
        _offerL.textColor = [Unity getColor:@"#aa112d"];
        _offerL.textAlignment = NSTextAlignmentCenter;
        _offerL.font = [UIFont systemFontOfSize:14];
    }
    return _offerL;
}
- (UILabel *)goodsAmount{
    if (!_goodsAmount) {
        _goodsAmount = [[UILabel alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:150], _offerL.top, [Unity countcoordinatesW:140], _offerL.height)];
        _goodsAmount.textColor = LabelColor3;
        _goodsAmount.text = @"";
        _goodsAmount.textAlignment = NSTextAlignmentRight;
        _goodsAmount.font = [UIFont systemFontOfSize:14];
    }
    return _goodsAmount;
}
- (UILabel *)line1{
    if (!_line1) {
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _goodsBtn.bottom, _backView.width-[Unity countcoordinatesW:10], 1)];
        _line1.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line1;
}
- (UILabel *)accountL{
    if (!_accountL) {
        _accountL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line1.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
        _accountL.textColor = LabelColor3;
        _accountL.text = @"出价账号";
        _accountL.textAlignment = NSTextAlignmentLeft;
        _accountL.font = [UIFont systemFontOfSize:14];
    }
    return _accountL;
}
- (UILabel *)account{
    if (!_account) {
        _account = [[UILabel alloc]initWithFrame:CGRectMake(_accountL.right, _accountL.top, _backView.width-[Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _account.textColor = LabelColor6;
        _account.text = @"";
        _account.textAlignment = NSTextAlignmentRight;
        _account.font = [UIFont systemFontOfSize:14];
    }
    return _account;
}
- (UILabel *)endOfTimeL{
    if (!_endOfTimeL) {
        _endOfTimeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _accountL.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
        _endOfTimeL.textColor = LabelColor3;
        _endOfTimeL.text = @"结束时间";
        _endOfTimeL.textAlignment = NSTextAlignmentLeft;
        _endOfTimeL.font = [UIFont systemFontOfSize:14];
    }
    return _endOfTimeL;
}
- (UILabel *)endOfTime{
    if (!_endOfTime) {
        _endOfTime = [[UILabel alloc]initWithFrame:CGRectMake(_endOfTimeL.right, _endOfTimeL.top, _backView.width-[Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _endOfTime.textColor = LabelColor6;
        _endOfTime.text = @"";
        _endOfTime.textAlignment = NSTextAlignmentRight;
        _endOfTime.font = [UIFont systemFontOfSize:14];
    }
    return _endOfTime;
}
- (UILabel *)line2{
    if (!_line2) {
        _line2 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _endOfTime.bottom+[Unity countcoordinatesH:10], _backView.width-[Unity countcoordinatesW:10], 1)];
        _line2.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line2;
}
- (UILabel *)highestBidL{
    if (!_highestBidL) {
        _highestBidL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line2.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:120], [Unity countcoordinatesH:20])];
        _highestBidL.textColor = LabelColor3;
        _highestBidL.text = @"最高出价";
        _highestBidL.textAlignment = NSTextAlignmentLeft;
        _highestBidL.font = [UIFont systemFontOfSize:14];
    }
    return _highestBidL;
}
- (UILabel *)highestBid{
    if (!_highestBid) {
        _highestBid = [[UILabel alloc]initWithFrame:CGRectMake(_highestBidL.right, _highestBidL.top, _backView.width-[Unity countcoordinatesW:140], [Unity countcoordinatesH:20])];
        _highestBid.textColor = [Unity getColor:@"#aa112d"];
        _highestBid.text = @"";
        _highestBid.textAlignment = NSTextAlignmentRight;
        _highestBid.font = [UIFont systemFontOfSize:14];
    }
    return _highestBid;
}

- (void)configIsAction:(BOOL)isAction{
    if (isAction) {
        self.readBtn.hidden = NO;
        self.numberL.frame = CGRectMake(self.readBtn.right +[Unity countcoordinatesW:5], 0, [Unity countcoordinatesW:200], [Unity countcoordinatesH:40]);
    }else{
        self.readBtn.hidden = YES;
        self.numberL.frame = CGRectMake([Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:200], [Unity countcoordinatesH:40]);
    }
}
/**
 *  模型赋值
 */
- (void)setModel:(NotBidModel *)model{
    self.readBtn.selected = model.isSelect;
    NSString * sta = @"";
    if ([model.w_ykj isEqualToString:@"2"]) {
        sta = @"立即购买";
    }else{
        sta = @"结束前购买";
    }
    self.statusL.text = [Unity getState:[model.w_state intValue] WithPage:3];
    self.offerL.frame = CGRectMake(_goodsTitle.left, _goodsTitle.bottom+[Unity countcoordinatesH:7], 20+[Unity widthOfString:sta OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:20]], [Unity countcoordinatesH:20]);
    self.offerL.layer.cornerRadius = [Unity countcoordinatesH:10];
    self.offerL.layer.masksToBounds = YES;
    self.offerL.text = sta;
    
    self.numberL.text = [NSString stringWithFormat:@"订单编号  %@/%@",model.numId,model.w_jpnid];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.w_imgsrc] placeholderImage:[UIImage imageNamed:@"Loading"]];
    self.goodsTitle.text = model.w_object;
    //加这个判断是因为 A区不一定有这个字段 所以默认1件
    if (model.w_tbsl == nil) {
        self.goodsNum.text = @"x1";
    }else{
        self.goodsNum.text = [NSString stringWithFormat:@"x%@",model.w_tbsl];
    }
    
    self.endOfTime.text = model.w_overtime;
    
    
    if ([model.w_cc isEqualToString:@"0"]) {
        if ([self.area isEqualToString:@"b"]) {
            if ([model.w_biduser isEqualToString:@""]) {
                self.account.text = @"";
            }else{
                self.account.text = [NSString stringWithFormat:@"%@/雅虎显示%@",model.w_biduser,model.w_signal];
            }
        }else{
            self.account.text = model.w_biduser;
        }
        self.goodsAmount.text = [NSString stringWithFormat:@"%@円",model.w_maxpay_jp];
        self.highestBid.text = [NSString stringWithFormat:@"%@円",model.w_maxpay_jp];
    }else{
        self.account.text = model.w_biduser;
        self.goodsAmount.text = [NSString stringWithFormat:@"%@美元",model.w_maxpay_jp];
        self.highestBid.text = [NSString stringWithFormat:@"%@美元",model.w_maxpay_jp];
    }
    
}
- (void)raadClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(acloseCellDelegate:WithSelectButton:)])
    {
        [self.delegate acloseCellDelegate:self WithSelectButton:sender];
    }
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
