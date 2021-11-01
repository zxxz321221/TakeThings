//
//  SendCostCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/27.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "SendCostCell.h"
@interface SendCostCell()
{
    NSArray * list;
}
@property (nonatomic , strong) UIView * blockV;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UILabel * line;
@property (nonatomic , strong) UILabel * xjT;//小计
@property (nonatomic , strong) UILabel * xjL;
@end
@implementation SendCostCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.blockV];
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.xjT];
        [self.contentView addSubview:self.xjL];
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
//        _titleL.text = @"日本代拍补充费用";
        _titleL.textColor = LabelColor3;
        _titleL.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _titleL;
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:220], SCREEN_WIDTH, 1)];
        _line.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return _line;
}
- (UILabel *)xjT{
    if (!_xjT) {
        _xjT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:13], _line.bottom, [Unity countcoordinatesW:100], [Unity countcoordinatesH:34])];
        _xjT.text = @"小计";
        _xjT.textColor = LabelColor6;
        _xjT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _xjT;
}
- (UILabel *)xjL{
    if (!_xjL) {
        _xjL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:113], _xjT.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:34])];
        _xjL.text = @"xxxx";
        _xjL.textColor = LabelColor6;
        _xjL.font = [UIFont systemFontOfSize:FontSize(14)];
        _xjL.textAlignment = NSTextAlignmentRight;
    }
    return _xjL;
}
- (void)configArr:(NSArray *)arr WithPrice:(NSString *)price WithRate:(NSString *)rate{
    if (list == nil) {//防止重复创建
        list = arr;
        for (int i=0; i<arr.count; i++) {
            UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:13], [Unity countcoordinatesH:40]+i*[Unity countcoordinatesH:30], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
            title.text = arr[i][@"title"];
            title.textColor = LabelColor6;
            title.font = [UIFont systemFontOfSize:FontSize(14)];
            [self.contentView addSubview:title];
            UILabel * content = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:113], title.top,[Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
            content.text = arr[i][@"content"];
            content.textColor = LabelColor6;
            content.font = [UIFont systemFontOfSize:FontSize(14)];
            content.textAlignment = NSTextAlignmentRight;
            [self.contentView addSubview:content];
        }
    }
    self.titleL.text = [NSString stringWithFormat:@"国际运输费用(汇率：%@)",rate];
    self.xjL.text = [NSString stringWithFormat:@"%@RMB",price];
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
