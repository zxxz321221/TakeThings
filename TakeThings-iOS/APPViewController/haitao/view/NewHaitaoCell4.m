//
//  NewHaitaoCell4.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/13.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "NewHaitaoCell4.h"
@interface NewHaitaoCell4()
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UILabel * numl;
@end
@implementation NewHaitaoCell4
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.numl];
    }
    return self;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], 0, 100, [Unity countcoordinatesH:25])];
        _titleL.text = @"序号";
        _titleL.textColor = LabelColor3;
        _titleL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _titleL;
}
- (UILabel *)numl{
    if (!_numl) {
        _numl = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:50], 0, [Unity countcoordinatesW:40], [Unity countcoordinatesH:25])];
        _numl.text = @"1";
        _numl.textColor = LabelColor6;
        _numl.font = [UIFont systemFontOfSize:FontSize(14)];
        _numl.textAlignment = NSTextAlignmentRight;
    }
    return _numl;
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
