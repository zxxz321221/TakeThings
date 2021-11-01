//
//  PrecelAddressCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/27.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "PrecelAddressCell.h"
@interface PrecelAddressCell()
@property (nonatomic , strong) UIView * blockV;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UIButton * updataBtn;
@property (nonatomic , strong) UILabel * nameL;
@property (nonatomic , strong) UILabel* mobileL;
@property (nonatomic , strong) UILabel * addressL;
@end
@implementation PrecelAddressCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.blockV];
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.updataBtn];
        [self.contentView addSubview:self.nameL];
        [self.contentView addSubview:self.mobileL];
        [self.contentView addSubview:self.addressL];
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
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(_blockV.right+[Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:100], [Unity countcoordinatesH:40])];
        _titleL.text = @"收货地址";
        _titleL.textColor = LabelColor3;
        _titleL.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _titleL;
}
- (UIButton *)updataBtn{
    if (!_updataBtn) {
        _updataBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:110], 0, [Unity countcoordinatesW:100], [Unity countcoordinatesH:40])];
        [_updataBtn addTarget:self action:@selector(addressClick) forControlEvents:UIControlEventTouchUpInside];
        [_updataBtn setTitle:@"修改收货地址" forState:UIControlStateNormal];
        [_updataBtn setTitleColor:[Unity getColor:@"4a90e2"] forState:UIControlStateNormal];
        _updataBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _updataBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _updataBtn;
}
- (UILabel *)nameL{
    if (!_nameL) {
        _nameL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], _titleL.bottom, [Unity countcoordinatesW:140], [Unity countcoordinatesH:20])];
        _nameL.text = @"姓名";
        _nameL.textColor = LabelColor3;
        _nameL.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _nameL;
}
- (UILabel *)mobileL{
    if (!_mobileL) {
        _mobileL = [[UILabel alloc]initWithFrame:CGRectMake(_nameL.right, _nameL.top, _nameL.width, _nameL.height)];
        _mobileL.text = @"12312312312";
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
- (void)configName:(NSString *)name WithMobile:(NSString *)mobile WithAddress:(NSString *)address WithMark:(NSString *)mark WithStatus:(NSInteger)status{
    self.nameL.text = name;
    self.mobileL.text = mobile;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",address,mark]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10; // 调整行间距
    NSRange range = NSMakeRange(0, [[NSString stringWithFormat:@"%@ %@",address,mark] length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    _addressL.attributedText = attributedString;
    if (status != 140 && status != 150 && status != 160) {
        _updataBtn.hidden = YES;
    }
}
- (void)addressClick{
    [self.delegate seleteAddress];
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
