//
//  AddressCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/31.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "AddressCell.h"
@interface AddressCell()

@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UILabel * nameL;
@property (nonatomic , strong) UILabel * mobileL;
@property (nonatomic , strong) UILabel * addressL;
@property (nonatomic , strong) UIView * line;
@property (nonatomic , strong) UIButton * defaultBtn;
@property (nonatomic , strong) UIButton * editBtn;
@property (nonatomic , strong) UIButton * deleteBtn;
@end
@implementation AddressCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setup];
        self.contentView.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return self;
}
- (void)setup{
    [self.contentView addSubview:self.backView];
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:141])];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 10;
        
        [_backView addSubview:self.nameL];
        [_backView addSubview:self.mobileL];
        [_backView addSubview:self.addressL];
        [_backView addSubview:self.line];
        [_backView addSubview:self.defaultBtn];
        [_backView addSubview:self.editBtn];
        [_backView addSubview:self.deleteBtn];
    }
    return _backView;
}
- (UILabel *)nameL{
    if (!_nameL) {
        _nameL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:140], [Unity countcoordinatesH:20])];
        _nameL.text = @"";
        _nameL.textColor = LabelColor3;
        _nameL.textAlignment = NSTextAlignmentLeft;
        _nameL.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _nameL;
}
- (UILabel *)mobileL{
    if (!_mobileL) {
        _mobileL = [[UILabel alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:150], _nameL.top, _nameL.width, _nameL.height)];
        _mobileL.text = @"";
        _mobileL.textColor = LabelColor3;
        _mobileL.textAlignment = NSTextAlignmentRight;
        _mobileL.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _mobileL;
}
- (UILabel *)addressL{
    if (!_addressL) {
        _addressL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _nameL.bottom+[Unity countcoordinatesH:10], _backView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        _addressL.numberOfLines = 0;
        _addressL.textColor = LabelColor6;
        _addressL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _addressL;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]initWithFrame:CGRectMake(_addressL.left, _addressL.bottom+[Unity countcoordinatesH:15], _addressL.width, [Unity countcoordinatesH:1])];
        _line.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line;
}
- (UIButton *)defaultBtn{
    if (!_defaultBtn) {
        _defaultBtn = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:40])];
        [_defaultBtn addTarget:self action:@selector(defaultClick) forControlEvents:UIControlEventTouchUpInside];
        [_defaultBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_defaultBtn setTitle:@"  默认地址" forState:UIControlStateNormal];
        _defaultBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _defaultBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_defaultBtn setImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [_defaultBtn setImage:[UIImage imageNamed:@"read"] forState:UIControlStateSelected];
    }
    return _defaultBtn;
}
- (UIButton *)editBtn{
    if (!_editBtn) {
        _editBtn = [[UIButton alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:125], _line.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:50], [Unity countcoordinatesH:20])];
        [_editBtn addTarget:self action:@selector(editClick) forControlEvents:UIControlEventTouchUpInside];
        UIImageView * imageV = [Unity imageviewAddsuperview_superView:_editBtn _subViewFrame:CGRectMake(0, [Unity countcoordinatesH:3], [Unity countcoordinatesW:14], [Unity countcoordinatesW:14]) _imageName:@"address_edit" _backgroundColor:[UIColor redColor]];
        UILabel * label = [Unity lableViewAddsuperview_superView:_editBtn _subViewFrame:CGRectMake(imageV.right, 0, [Unity countcoordinatesW:36], [Unity countcoordinatesH:20]) _string:@"编辑" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentRight];
        label.backgroundColor = [UIColor clearColor];
    }
    return _editBtn;
}
- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(_backView.width-[Unity countcoordinatesW:60], _line.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:50], [Unity countcoordinatesH:20])];
        [_deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        UIImageView * imageV = [Unity imageviewAddsuperview_superView:_deleteBtn _subViewFrame:CGRectMake(0, [Unity countcoordinatesH:3], [Unity countcoordinatesW:14], [Unity countcoordinatesW:14]) _imageName:@"address_delete" _backgroundColor:[UIColor redColor]];
        UILabel * label = [Unity lableViewAddsuperview_superView:_deleteBtn _subViewFrame:CGRectMake(imageV.right, 0, [Unity countcoordinatesW:36], [Unity countcoordinatesH:20]) _string:@"删除" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentRight];
        label.backgroundColor = [UIColor clearColor];
    }
    return _deleteBtn;
}
- (void)configWithAddressData:(NSDictionary *)dic{
    self.nameL.text = dic[@"w_name"];
    self.mobileL.text = [Unity editMobile:dic[@"w_mobile"]];
    NSString *str = [NSString stringWithFormat:@"%@ %@ %@",dic[@"w_address"],dic[@"w_address_detail"],dic[@"w_other"]];
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = [Unity countcoordinatesH:10]; // 设置行间距
    paragraphStyle.alignment = NSTextAlignmentJustified; //设置两端对齐显示
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedStr.length)];
    self.addressL.attributedText = attributedStr;
    if ([dic[@"if_default"]isEqualToString:@"1"]) {
        self.defaultBtn.selected = YES;
    }else{
        self.defaultBtn.selected = NO;
    }
}

- (void)defaultClick{
    if (self.defaultBtn.selected == NO) {
        [self.delegate defaultCellDelegate:self];
    }
}
- (void)editClick{
    [self.delegate editCellDelegate:self];
}
- (void)deleteClick{
    [self.delegate deleteCellDelegate:self];
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
