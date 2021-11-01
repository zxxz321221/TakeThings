//
//  NewCouponsCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/10/8.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "NewCouponsCell.h"
@interface NewCouponsCell()
@property (nonatomic , strong) UIView * backV;
@property (nonatomic , strong) UILabel * numL;
@property (nonatomic , strong) UILabel * timeL;
@property (nonatomic , strong) UILabel * placeL;
@property (nonatomic , strong) UIImageView * goImg;

@property (nonatomic , strong) UILabel * line;
@end
@implementation NewCouponsCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setup];
        //        self.contentView.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return self;
}
- (void)setup{
    [self.contentView addSubview:self.backV];
}
- (UIView *)backV{
    if (!_backV) {
        _backV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:55])];
        [_backV addSubview:self.numL];
        [_backV addSubview:self.timeL];
        [_backV addSubview:self.goImg];
        [_backV addSubview:self.placeL];
        [_backV addSubview:self.line];
    }
    return _backV;
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(0, _backV.height-1, SCREEN_WIDTH, 1)];
        _line.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line;
}
- (UILabel *)numL{
    if (!_numL) {
        _numL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:160], [Unity countcoordinatesH:15])];
        _numL.text = @"订单编号:@#￥%……&*（）——";
        _numL.textColor = LabelColor3;
        _numL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _numL;
}
- (UILabel *)timeL{
    if (!_timeL) {
        _timeL = [[UILabel alloc]initWithFrame:CGRectMake(_numL.left, _numL.bottom+[Unity countcoordinatesH:5], _numL.width, _numL.height)];
        _timeL.text = @"2019-09-09 12:12:12";
        _timeL.textColor = LabelColor9;
        _timeL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _timeL;
}
- (UIImageView *)goImg{
    if (!_goImg) {
        _goImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:15], [Unity countcoordinatesH:22.5], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10])];
        _goImg.image = [UIImage imageNamed:@"go"];
    }
    return _goImg;
}
- (UILabel *)placeL{
    if (!_placeL) {
        _placeL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:125], [Unity countcoordinatesH:20], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15])];
        _placeL.text = @"-1000";
        _placeL.font = [UIFont systemFontOfSize:FontSize(14)];
        _placeL.textAlignment = NSTextAlignmentRight;
    }
    return _placeL;
}
- (void)configWithNumId:(NSString *)numId WithTime:(NSString *)time WithPlace:(NSString *)place WithType:(NSString *)type{
    //+ aa112d   - #099443
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
