//
//  NewHaitaoCell2.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/13.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "NewHaitaoCell2.h"
@interface NewHaitaoCell2()
@property (nonatomic , strong) UILabel * line0;
@property (nonatomic , strong) UILabel * block1;//标题前红快
@property (nonatomic , strong) UILabel * titleL;
@end
@implementation NewHaitaoCell2
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.line0];
        [self.contentView addSubview:self.block1];
        [self.contentView addSubview:self.titleL];
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
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(_block1.right+[Unity countcoordinatesW:10], _line0.bottom+[Unity countcoordinatesH:10], 200, [Unity countcoordinatesH:20])];
        _titleL.text = @"商品列表";
        _titleL.font = [UIFont systemFontOfSize:FontSize(17)];
        _titleL.textColor = LabelColor3;
    }
    return _titleL;
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
