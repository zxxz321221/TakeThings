//
//  HelpPageCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/29.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "HelpPageCell.h"
@interface HelpPageCell()

@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UIImageView * backImg;

@end
@implementation HelpPageCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void)setup{
    [self.contentView addSubview:self.titleL];
    [self.contentView addSubview:self.backImg];
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:49], SCREEN_WIDTH, 1)];
    line.backgroundColor = [Unity getColor:@"#f0f0f0"];
    [self.contentView addSubview:line];
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:290], [Unity countcoordinatesH:20])];
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
- (void)configWithTitle:(NSString  *)title WithKeyword:(NSString *)keyword WithSearch:(BOOL)isSearch{
    if (isSearch) {
        NSRange range;
        range = [title rangeOfString:keyword];
        if(range.location!=NSNotFound) {
            NSLog(@"%lu",(unsigned long)range.location);
            NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:title];
            [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(14)] range:NSMakeRange(0, title.length)];
            [attributedString2 addAttribute:NSForegroundColorAttributeName value:LabelColor3 range:NSMakeRange(0, title.length)];
            [attributedString2 addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"#aa112d"] range:NSMakeRange(range.location, keyword.length)];
            self.titleL.attributedText = attributedString2;
        }else{
            self.titleL.text = title;
        }
    }else{
        self.titleL.text = title;
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
