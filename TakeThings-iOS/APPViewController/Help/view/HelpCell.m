//
//  HelpCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/29.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "HelpCell.h"
@interface HelpCell()

@property (nonatomic , strong) UIImageView * icon;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UIImageView * backImg;

@end
@implementation HelpCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setup];
    }
    return self;
}
- (void)setup{
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.titleL];
    [self.contentView addSubview:self.backImg];
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:49], SCREEN_WIDTH, 1)];
    line.backgroundColor = [Unity getColor:@"#f0f0f0"];
    [self.contentView addSubview:line];
}
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:18], [Unity countcoordinatesW:14], [Unity countcoordinatesW:14])];
    }
    return _icon;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(_icon.right+[Unity countcoordinatesW:13], [Unity countcoordinatesH:15], [Unity countcoordinatesW:150], [Unity countcoordinatesH:20])];
        _titleL.font = [UIFont systemFontOfSize:FontSize(14)];
        _titleL.textColor = LabelColor3;
        _titleL.textAlignment = NSTextAlignmentLeft;
    }
    return _titleL;
}
- (UIImageView *)backImg{
    if (!_backImg) {
        _backImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:15], [Unity countcoordinatesH:20], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10])];
        _backImg.image = [UIImage imageNamed:@"go"];
    }
    return _backImg;
}

- (void)configWithIcon:(NSString *)icon WithTitle:(NSString  *)title{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",icon]] placeholderImage:[UIImage imageNamed:@"Loading"]];
    self.titleL.text = title;
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
