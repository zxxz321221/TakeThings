//
//  GoodsTimeCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/23.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "GoodsTimeCell.h"
@interface GoodsTimeCell()

@property (nonatomic , strong) UILabel * line;
@property (nonatomic , strong) UILabel * currentTime;
@property (nonatomic , strong) UILabel * stopTime;
@property (nonatomic , strong) UILabel * amount;

@end
@implementation GoodsTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self GoodsTimeView];
    }
    return self;
}
- (void)GoodsTimeView{
    [self addSubview:self.line];
    
    UILabel * amountL = [Unity lableViewAddsuperview_superView:self _subViewFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:20], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15]) _string:@"最小出价单位:" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentLeft];
    self.amount = [Unity lableViewAddsuperview_superView:self _subViewFrame:CGRectMake(amountL.right, amountL.top, [Unity countcoordinatesW:200], [Unity countcoordinatesH:15]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
    
    UILabel * stopTimeL = [Unity lableViewAddsuperview_superView:self _subViewFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:55], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15]) _string:@"截止时间:" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentLeft];
    self.stopTime = [Unity lableViewAddsuperview_superView:self _subViewFrame:CGRectMake(stopTimeL.right, stopTimeL.top, [Unity countcoordinatesW:200], [Unity countcoordinatesH:15]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
    
//    UILabel * currentTimeL = [Unity lableViewAddsuperview_superView:self _subViewFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:90], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15]) _string:@"现在时间:" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentLeft];
//    self.currentTime = [Unity lableViewAddsuperview_superView:self _subViewFrame:CGRectMake(currentTimeL.right, currentTimeL.top, [Unity countcoordinatesW:200], [Unity countcoordinatesH:15]) _string:@"2018/11/266 22:11:24 (东京)" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
    
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        _line.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return  _line;
}
- (void)configWithEndTime:(NSString *)endTime WithPlatform:(NSString *)platform WithPrice:(NSString *)price WithBidCount:(NSString *)count{
    if ([platform isEqualToString:@"0"]) {
        self.stopTime.text = [NSString stringWithFormat:@"%@（东京）",endTime];
        self.amount.text = [NSString stringWithFormat:@"%@円",price];
    }else{
        self.stopTime.text = [NSString stringWithFormat:@"%@（中国）",endTime];
        self.amount.text = [NSString stringWithFormat:@"%@美元",price];
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
