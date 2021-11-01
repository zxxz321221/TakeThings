//
//  BidCardCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/3.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "BidCardCell.h"
@interface BidCardCell()
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UILabel * name;
@property (nonatomic , strong) UILabel * idCard;
@property (nonatomic , strong) UIView * line;
@property (nonatomic , strong) UILabel * realL;
@end
@implementation BidCardCell

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
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:9], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:106])];
        _backView.layer.cornerRadius = 10;
        _backView.backgroundColor = [UIColor whiteColor];
        [_backView addSubview:self.name];
        [_backView addSubview:self.idCard];
        [_backView addSubview:self.line];
        [_backView addSubview:self.realL];
    }
    return _backView;
}
- (UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], _backView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _name.textColor = LabelColor3;
        _name.font = [UIFont systemFontOfSize:FontSize(17)];
        _name.textAlignment = NSTextAlignmentLeft;
    }
    return _name;
}
- (UILabel *)idCard{
    if (!_idCard) {
        _idCard = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _name.bottom+[Unity countcoordinatesH:10], _backView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:15])];
        _idCard.textColor = LabelColor6;
        _idCard.font = [UIFont systemFontOfSize:FontSize(14)];
        _idCard.textAlignment = NSTextAlignmentLeft;
    }
    return _idCard;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _idCard.bottom+[Unity countcoordinatesH:10], _backView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:1])];
        _line.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line;
}
- (UILabel *)realL{
    if (!_realL) {
        _realL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line.bottom, [Unity countcoordinatesW:200], [Unity countcoordinatesH:40])];
        _realL.text = @"已认证身份证";
        _realL.textColor = LabelColor3;
        _realL.textAlignment = NSTextAlignmentLeft;
        _realL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return  _realL;
}
- (void)configWithName:(NSString *)name WithIdCardNum:(NSString *)idCardNum{
    self.name.text = name;
    self.idCard.text = [NSString stringWithFormat:@"身份证号码:  %@",[Unity editIdCard:idCardNum]];
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
