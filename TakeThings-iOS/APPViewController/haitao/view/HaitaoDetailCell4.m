//
//  HaitaoDetailCell4.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/18.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "HaitaoDetailCell4.h"
@interface HaitaoDetailCell4()
@property (nonatomic , strong) UIView * block;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UILabel * line;
@property (nonatomic , strong) UILabel * subTitle;
@property (nonatomic , strong) UILabel * nameL;
@property (nonatomic , strong) UILabel* mobileL;
@property (nonatomic , strong) UILabel * addressL;
@end
@implementation HaitaoDetailCell4

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.block];
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.subTitle];
        [self.contentView addSubview:self.nameL];
        [self.contentView addSubview:self.mobileL];
        [self.contentView addSubview:self.addressL];
    }
    return self;
}
- (UIView *)block{
    if (!_block) {
        _block = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:15], [Unity countcoordinatesW:3], [Unity countcoordinatesH:10])];
        _block.backgroundColor = [Unity getColor:@"aa112d"];
    }
    return _block;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], 0, 300, [Unity countcoordinatesH:40])];
        _titleL.text = @"寄送信息";
        _titleL.textColor = LabelColor3;
        _titleL.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _titleL;
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(0, _titleL.bottom, SCREEN_WIDTH, 1)];
        _line.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return  _line;
}
- (UILabel *)subTitle{
    if (!_subTitle) {
        _subTitle = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], _titleL.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:40])];
        _subTitle.text = @"收货地址";
        _subTitle.textColor = LabelColor3;
        _subTitle.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _subTitle;
}
- (UILabel *)nameL{
    if (!_nameL) {
        _nameL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], _subTitle.bottom, [Unity countcoordinatesW:140], [Unity countcoordinatesH:20])];
        _nameL.text = @"--";
        _nameL.textColor = LabelColor3;
        _nameL.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _nameL;
}
- (UILabel *)mobileL{
    if (!_mobileL) {
        _mobileL = [[UILabel alloc]initWithFrame:CGRectMake(_nameL.right, _nameL.top, _nameL.width, _nameL.height)];
        _mobileL.text = @"--";
        _mobileL.textColor = LabelColor3;
        _mobileL.font = [UIFont systemFontOfSize:FontSize(17)];
        _mobileL.textAlignment = NSTextAlignmentRight;
    }
    return _mobileL;
}
- (UILabel *)addressL{
    if (!_addressL) {
        _addressL = [[UILabel alloc]initWithFrame:CGRectMake(_nameL.left, _nameL.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:280], [Unity countcoordinatesH:40])];
        _addressL.textColor = LabelColor6;
        _addressL.font = [UIFont systemFontOfSize:FontSize(14)];
        _addressL.numberOfLines = 0;
    }
    return _addressL;
}
- (void)configWithData:(NSDictionary *)dic{
    self.nameL.text = dic[@"name"];
    self.mobileL.text = dic[@"mobile"];
    self.addressL.text = dic[@"address"];
}
@end
