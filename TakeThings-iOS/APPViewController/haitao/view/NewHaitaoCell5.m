//
//  NewHaitaoCell5.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/13.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "NewHaitaoCell5.h"
@interface NewHaitaoCell5()
//@property (nonatomic , strong) UILabel * line;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UILabel * numl;
@end
@implementation NewHaitaoCell5
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.numl];
    }
    return self;
}
//- (UILabel *)line{
//    if (!_line) {
//        _line = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, SCREEN_WIDTH-[Unity countcoordinatesW:20], 1)];
//        _line.backgroundColor = [Unity getColor:@"f0f0f0"];
//    }
//    return _line;
//}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], 0, 100, [Unity countcoordinatesH:25])];
        _titleL.text = @"共计";
        _titleL.textColor = LabelColor3;
        _titleL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _titleL;
}
- (UILabel *)numl{
    if (!_numl) {
        _numl = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:50], 0, [Unity countcoordinatesW:40], [Unity countcoordinatesH:25])];
//        _numl.text = @"1";
        _numl.textColor = LabelColor6;
        _numl.font = [UIFont systemFontOfSize:FontSize(14)];
        _numl.textAlignment = NSTextAlignmentRight;
    }
    return _numl;
}
- (void)configWithIsAdd:(BOOL)isAdd WithNum:(NSInteger )num{
    if (isAdd) {
//        self.line.hidden = NO;
        self.titleL.hidden= NO;
        self.numl.hidden = NO;
        self.numl.text = [NSString stringWithFormat:@"%ld件",(long)num];
    }else{
//        self.line.hidden = YES;
        self.titleL.hidden= YES;
        self.numl.hidden = YES;
    }
    
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
