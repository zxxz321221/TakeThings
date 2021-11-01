//
//  ConfirmCell1.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/14.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "ConfirmCell1.h"
@interface ConfirmCell1()
@property (nonatomic , strong) UILabel * block;//标题前红快
@property (nonatomic , strong) UILabel * titleL;
@end
@implementation ConfirmCell1
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.block];
        [self.contentView addSubview:self.titleL];
    }
    return self;
}
- (UILabel *)block{
    if (!_block) {
        _block = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:15], [Unity countcoordinatesW:3], [Unity countcoordinatesH:10])];
        _block.backgroundColor = [Unity getColor:@"aa112d"];
    }
    return _block;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(_block.right+[Unity countcoordinatesW:10],[Unity countcoordinatesH:10], 200, [Unity countcoordinatesH:20])];
        _titleL.text = @"确认海淘明细";
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
