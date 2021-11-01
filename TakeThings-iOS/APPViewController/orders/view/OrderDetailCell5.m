//
//  OrderDetailCell5.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/14.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "OrderDetailCell5.h"
@interface OrderDetailCell5()
@property (nonatomic , strong) UIView * blockV;
@property (nonatomic , strong) UILabel * titleL;

@end
@implementation OrderDetailCell5
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.blockV];
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.placeL];
        
    }
    return self;
}
- (UIView *)blockV{
    if (!_blockV) {
        _blockV = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:15], [Unity countcoordinatesW:3], [Unity countcoordinatesH:10])];
        _blockV.backgroundColor = [Unity getColor:@"aa112d"];
    }
    return _blockV;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(_blockV.right+[Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:297], [Unity countcoordinatesH:40])];
        _titleL.text = @"总支付金额";
        _titleL.textColor = LabelColor3;
        _titleL.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _titleL;
}
- (UILabel *)placeL{
    if (!_placeL) {
        _placeL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:110], _titleL.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:40])];
        _placeL.textColor = [Unity getColor:@"aa112d"];
        _placeL.font = [UIFont systemFontOfSize:FontSize(17)];
        _placeL.textAlignment = NSTextAlignmentRight;
    }
    return _placeL;
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
