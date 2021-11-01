//
//  ConfirmCell4.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/14.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "ConfirmCell4.h"
@interface ConfirmCell4()
@property (nonatomic , strong) UILabel * line;
@property (nonatomic , strong) UILabel * block;//标题前红快
@property (nonatomic , strong) UILabel * titleL;

@property (nonatomic , strong) UILabel * subTitle;
@property (nonatomic , strong) UIButton * btn1;
@property (nonatomic , strong) UIButton * btn2;
@property (nonatomic , strong) UIButton * btn3;
@end
@implementation ConfirmCell4
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.block];
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.subTitle];
        [self.contentView addSubview:self.btn1];
        [self.contentView addSubview:self.btn2];
        [self.contentView addSubview:self.btn3];
    }
    return self;
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        _line.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return _line;
}
- (UILabel *)block{
    if (!_block) {
        _block = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:25], [Unity countcoordinatesW:3], [Unity countcoordinatesH:10])];
        _block.backgroundColor = [Unity getColor:@"aa112d"];
    }
    return _block;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(_block.right+[Unity countcoordinatesW:10],[Unity countcoordinatesH:20], 300, [Unity countcoordinatesH:20])];
        _titleL.text = @"部分商品缺货时订单处理方式";
        _titleL.font = [UIFont systemFontOfSize:FontSize(17)];
        _titleL.textColor = LabelColor3;
    }
    return _titleL;
}
- (UILabel *)subTitle{
    if (!_subTitle) {
        _subTitle = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], _titleL.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:60], [Unity countcoordinatesH:20])];
        _subTitle.text = @"请选择:";
        _subTitle.textColor = LabelColor3;
        _subTitle.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _subTitle;
}
- (UIButton *)btn1{
    if (!_btn1) {
        _btn1 = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:90], _titleL.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        [_btn1 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
        [_btn1 setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_btn1 setTitle:@"  续订其他商品" forState:UIControlStateNormal];
        _btn1.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_btn1 setImage:[UIImage imageNamed:@"read_gray"] forState:UIControlStateNormal];
        [_btn1 setImage:[UIImage imageNamed:@"read_red"] forState:UIControlStateSelected];
        _btn1.selected = YES;
    }
    return _btn1;
}
- (UIButton *)btn2{
    if (!_btn2) {
        _btn2 = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:90], _btn1.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        [_btn2 addTarget:self action:@selector(btn2Click:) forControlEvents:UIControlEventTouchUpInside];
        [_btn2 setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_btn2 setTitle:@"  取消全部订单" forState:UIControlStateNormal];
        _btn2.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_btn2 setImage:[UIImage imageNamed:@"read_gray"] forState:UIControlStateNormal];
        [_btn2 setImage:[UIImage imageNamed:@"read_red"] forState:UIControlStateSelected];
    }
    return _btn2;
}
- (UIButton *)btn3{
    if (!_btn3) {
        _btn3 = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:90], _btn2.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        [_btn3 addTarget:self action:@selector(btn3Click:) forControlEvents:UIControlEventTouchUpInside];
        [_btn3 setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_btn3 setTitle:@"  电话通知我" forState:UIControlStateNormal];
        _btn3.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _btn3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_btn3 setImage:[UIImage imageNamed:@"read_gray"] forState:UIControlStateNormal];
        [_btn3 setImage:[UIImage imageNamed:@"read_red"] forState:UIControlStateSelected];
    }
    return _btn3;
}


- (void)btn1Click:(UIButton *)btn{
    if (btn.selected) {
        return;
    }else{
        self.btn1.selected = YES;
        self.btn2.selected = NO;
        self.btn3.selected = NO;
    }
    [self.delegate get_lack_channel:@"1"];
}
- (void)btn2Click:(UIButton *)btn{
    if (btn.selected) {
        return;
    }else{
        self.btn1.selected = NO;
        self.btn2.selected = YES;
        self.btn3.selected = NO;
    }
    [self.delegate get_lack_channel:@"2"];
}
- (void)btn3Click:(UIButton *)btn{
    if (btn.selected) {
        return;
    }else{
        self.btn1.selected = NO;
        self.btn2.selected = NO;
        self.btn3.selected = YES;
    }
    [self.delegate get_lack_channel:@"3"];
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
