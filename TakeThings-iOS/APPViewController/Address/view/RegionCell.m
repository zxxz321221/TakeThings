//
//  RegionCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/31.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "RegionCell.h"
@interface RegionCell()
@property (nonatomic ,strong) UILabel * letter;
@property (nonatomic , strong) UILabel * name;

@end
@implementation RegionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setup];
    }
    return self;
}
- (void)setup{
    [self.contentView addSubview:self.letter];
    [self.contentView addSubview:self.name];
}
- (UILabel *)letter{
    if (!_letter) {
        _letter = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], 10, 30, 20)];
        _letter.textColor = LabelColor9;
        _letter.textAlignment = NSTextAlignmentLeft;
        _letter.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _letter;
}
- (UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc]initWithFrame:CGRectMake(_letter.right, _letter.top, 200, 20)];
        _name.textColor = LabelColor3;
        _name.textAlignment = NSTextAlignmentLeft;
        _name.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _name;
}
- (void)configWithLetter:(NSString *)letter WithName:(NSString *)name{
    self.letter.text = letter;
    self.name.text = name;
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
