//
//  SelleCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/12.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "SelleCell.h"
#import "SellerModel.h"
@interface SelleCell()
@property (nonatomic , strong) UIImageView * icon;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UIImageView * goImg;
@property (nonatomic , strong) UIButton * seletdBtn;
@end
@implementation SelleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self sellerView];
    }
    return self;
}
- (void)sellerView{
    [self.contentView addSubview:self.seletdBtn];
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.titleL];
    [self.contentView addSubview:self.goImg];
}
- (UIButton *)seletdBtn{
    if (!_seletdBtn) {
        _seletdBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:22.5], [Unity countcoordinatesW:15], [Unity countcoordinatesW:15])];
        [_seletdBtn addTarget:self action:@selector(readClick:) forControlEvents:UIControlEventTouchUpInside];
        [_seletdBtn setBackgroundImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [_seletdBtn setBackgroundImage:[UIImage imageNamed:@"read"] forState:UIControlStateSelected];
        _seletdBtn.hidden = YES;
    }
    return _seletdBtn;
}
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:40], [Unity countcoordinatesW:40])];
        _icon.backgroundColor = [UIColor redColor];
    }
    return  _icon;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(_icon.right+[Unity countcoordinatesW:10], _icon.top, SCREEN_WIDTH-[Unity countcoordinatesW:80], [Unity countcoordinatesH:40])];
        _titleL.text = @"";
        _titleL.textColor = LabelColor3;
        _titleL.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _titleL;
}
- (UIImageView *)goImg{
    if (!_goImg) {
        _goImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:15], [Unity countcoordinatesH:25], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10])];
        _goImg.image = [UIImage imageNamed:@"go"];
    }
    return _goImg;
}

- (void)config:(BOOL)edit{
    if (edit) {
        self.seletdBtn.hidden = NO;
        self.icon.frame = CGRectMake([Unity countcoordinatesW:30], [Unity countcoordinatesH:10], [Unity countcoordinatesW:40], [Unity countcoordinatesH:40]);
        self.titleL.frame = CGRectMake(self.icon.right+[Unity countcoordinatesW:30], self.icon.top, SCREEN_WIDTH-[Unity countcoordinatesW:80], [Unity countcoordinatesH:40]);
    }else{
        self.seletdBtn.hidden = YES;
        self.icon.frame = CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:40], [Unity countcoordinatesH:40]);
        self.titleL.frame = CGRectMake(self.icon.right+[Unity countcoordinatesW:10], self.icon.top, SCREEN_WIDTH-[Unity countcoordinatesW:80], [Unity countcoordinatesH:40]);
    }
}

- (void)setModel:(SellerModel *)model{
    self.seletdBtn.selected = model.isSelect;
    self.titleL.text = model.w_saler;
    
}
- (void)readClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(sellerCellDelegate:WithSelectButton:)])
    {
        [self.delegate sellerCellDelegate:self WithSelectButton:sender];
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
