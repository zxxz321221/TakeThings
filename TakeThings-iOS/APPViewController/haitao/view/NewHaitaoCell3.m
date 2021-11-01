//
//  NewHaitaoCell3.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/13.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "NewHaitaoCell3.h"
#import "UILabel+YBAttributeTextTapAction.h"
@interface NewHaitaoCell3()
@property (nonatomic , strong) UILabel * line0;
@property (nonatomic , strong) UILabel * block1;//标题前红快
@property (nonatomic , strong) UILabel * haitaoCost;
@property (nonatomic , strong) UILabel * oemL;//代工费文字
@property (nonatomic , strong) UILabel * oemMark;
@property (nonatomic , strong) UILabel * line1;
@property (nonatomic , strong) UILabel * insL;
@property (nonatomic , strong) UIButton * insBtn;
@property (nonatomic , strong) UILabel * insText;//理赔保险富文本
@property (nonatomic , strong) UILabel * transportL;
@property (nonatomic , strong) UIButton * transportBtn;
@property (nonatomic , strong) UILabel * transportText;//理赔保险富文本
@end
@implementation NewHaitaoCell3

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.line0];
        [self.contentView addSubview:self.block1];
        [self.contentView addSubview:self.haitaoCost];
        [self.contentView addSubview:self.oemL];
        [self.contentView addSubview:self.oemMark];
        [self.contentView addSubview:self.line1];
        [self.contentView addSubview:self.insL];
        [self.contentView addSubview:self.insBtn];
        [self.contentView addSubview:self.insText];
        [self.contentView addSubview:self.transportL];
        [self.contentView addSubview:self.transportBtn];
        [self.contentView addSubview:self.transportText];
    }
    return self;
}
- (UILabel *)line0{
    if (!_line0) {
        _line0 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        _line0.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return _line0;
}
- (UILabel *)block1{
    if (!_block1) {
        _block1 = [[UILabel alloc]initWithFrame:CGRectMake(0, _line0.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:3], [Unity countcoordinatesH:10])];
        _block1.backgroundColor = [Unity getColor:@"aa112d"];
    }
    return _block1;
}
- (UILabel *)haitaoCost{
    if (!_haitaoCost) {
        _haitaoCost = [[UILabel alloc]initWithFrame:CGRectMake(_block1.right+[Unity countcoordinatesW:10], _line0.bottom+[Unity countcoordinatesH:10], 200, [Unity countcoordinatesH:20])];
        _haitaoCost.text = @"海淘费用";
        _haitaoCost.font = [UIFont systemFontOfSize:FontSize(17)];
        _haitaoCost.textColor = LabelColor3;
    }
    return _haitaoCost;
}
- (UILabel *)oemL{
    if (!_oemL) {
        _oemL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], _haitaoCost.bottom, [Unity countcoordinatesW:60], [Unity countcoordinatesH:25])];
        _oemL.text = @"代工费:";
        _oemL.textColor = LabelColor3;
        _oemL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _oemL;
}
- (UILabel *)oemMark{
    if (!_oemMark) {
        _oemMark = [[UILabel alloc]initWithFrame:CGRectMake(_oemL.right, _oemL.top, [Unity countcoordinatesW:230], [Unity countcoordinatesH:25])];
        _oemMark.text = @"1万日币以上(含):98元,1万日币以下:58元";
        _oemMark.textColor = LabelColor9;
        _oemMark.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _oemMark;
}
- (UILabel *)line1{
    if (!_line1) {
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _oemMark.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:20], 1)];
        _line1.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return _line1;
}
- (UILabel *)insL{
    if (!_insL) {
        _insL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], _line1.bottom, [Unity countcoordinatesW:60], [Unity countcoordinatesH:25])];
        _insL.text = @"购物保障:";
        _insL.textColor = LabelColor3;
        _insL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _insL;
}
- (UIButton *)insBtn{
    if (!_insBtn) {
        _insBtn = [[UIButton alloc] initWithFrame:CGRectMake(_oemMark.left, _insL.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        [_insBtn addTarget:self action:@selector(insClick:) forControlEvents:UIControlEventTouchUpInside];
        [_insBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_insBtn setTitle:@"  购物理赔保险" forState:UIControlStateNormal];
        _insBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _insBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_insBtn setImage:[UIImage imageNamed:@"kuang_no"] forState:UIControlStateNormal];
        [_insBtn setImage:[UIImage imageNamed:@"kuang_yes"] forState:UIControlStateSelected];
    }
    return _insBtn;
}
- (UILabel *)insText{
    if (!_insText) {
        NSString *label_text2 = @"诈骗理赔保险按您商品购买的2%收取,遇到卖家欺骗行为由捎东西理赔详细";
        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0, label_text2.length-2)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"4a90e2"] range:NSMakeRange(label_text2.length-2, 2)];
        _insText = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:90], _insBtn.bottom, [Unity countcoordinatesW:220], [Unity countcoordinatesH:30])];
        _insText.attributedText = attributedString2;
        _insText.numberOfLines = 0;
        _insText.font = [UIFont systemFontOfSize:FontSize(12)];
        [_insText yb_addAttributeTapActionWithStrings:@[@"详细"] tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {
            NSLog(@"点击了");
        }];
    }
    return _insText;
}
- (UILabel *)transportL{
    if (!_transportL) {
        _transportL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], _insText.bottom, [Unity countcoordinatesW:60], [Unity countcoordinatesH:25])];
        _transportL.text = @"运输保障:";
        _transportL.textColor = LabelColor3;
        _transportL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _transportL;
}
- (UIButton *)transportBtn{
    if (!_transportBtn) {
        _transportBtn = [[UIButton alloc] initWithFrame:CGRectMake(_oemMark.left, _transportL.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        [_transportBtn addTarget:self action:@selector(tranClick:) forControlEvents:UIControlEventTouchUpInside];
        [_transportBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_transportBtn setTitle:@"  丢失理赔保险" forState:UIControlStateNormal];
        _transportBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _transportBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_transportBtn setImage:[UIImage imageNamed:@"kuang_no"] forState:UIControlStateNormal];
        [_transportBtn setImage:[UIImage imageNamed:@"kuang_yes"] forState:UIControlStateSelected];
    }
    return _transportBtn;
}
- (UILabel *)transportText{
    if (!_transportText) {
        NSString *label_text2 = @"※商品购买价的1%收取,运送丢失由运输公司赔偿商品价格;？详情";
        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0, label_text2.length-3)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"aa112d"] range:NSMakeRange(label_text2.length-3, 3)];
        _transportText = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:90], _transportBtn.bottom, [Unity countcoordinatesW:220], [Unity countcoordinatesH:30])];
        _transportText.attributedText = attributedString2;
        _transportText.numberOfLines = 0;
        _transportText.font = [UIFont systemFontOfSize:FontSize(12)];
        [_transportText yb_addAttributeTapActionWithStrings:@[@"？详细"] tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {
            NSLog(@"点击了");
        }];
    }
    return _transportText;
}


- (void)configWithSource:(NSString *)source{
    if ([source isEqualToString:@"yahoo"]) {
        self.oemMark.text = @"1万日币以上(含):98元,1万日币以下:58元";
        self.transportL.hidden = YES;
        self.transportBtn.hidden = YES;
        self.transportText.hidden = YES;
    }else{
        self.oemMark.text = @"100美元以上(含):98元,100美元以下:58元";
    }
}
- (void)insClick:(UIButton *)btn{
    if (btn.selected) {
        self.insBtn.selected = NO;
        [self.delegate get_fraud_safe:@"0"];
    }else{
        self.insBtn.selected = YES;
        [self.delegate get_fraud_safe:@"1"];
    }
}
- (void)tranClick:(UIButton *)btn{
    if (btn.selected) {
        self.transportBtn.selected = NO;
        [self.delegate get_safe_traffic:@"0"];
    }else{
        self.transportBtn.selected = YES;
        [self.delegate get_safe_traffic:@"1"];
    }
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
