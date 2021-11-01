//
//  SendInfoCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/27.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "SendInfoCell.h"
@interface SendInfoCell()
@property (nonatomic , strong) UILabel * timeL;
@property (nonatomic, strong) UILabel * contentL;
@end
@implementation SendInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self shipView];
    }
    return self;
}
- (void)shipView{
    [self.contentView addSubview:self.timeL];
    [self.contentView addSubview:self.contentL];
    
}
- (UILabel *)timeL{
    if (!_timeL) {
        _timeL = [[UILabel alloc]init];
        _timeL.textColor = LabelColor9;
        _timeL.font = [UIFont systemFontOfSize:FontSize(12)];
        _timeL.numberOfLines = 0;
        _timeL.textAlignment = NSTextAlignmentCenter;
    }
    return _timeL;
}
- (UILabel *)contentL{
    if (!_contentL) {
        _contentL = [[UILabel alloc]init];
        _contentL.textColor = LabelColor9;
//        _contentL.backgroundColor = [UIColor yellowColor];
        _contentL.font = [UIFont systemFontOfSize:FontSize(14)];
        _contentL.numberOfLines = 0;
    }
    return _contentL;
}
- (void)configWithData:(NSDictionary *)dic WithIndex:(NSInteger)index{
    self.contentL.frame = CGRectMake([Unity countcoordinatesW:100], [Unity countcoordinatesH:15], SCREEN_WIDTH-[Unity countcoordinatesW:110], [dic[@"cellH"] floatValue]-[Unity countcoordinatesH:30]);
    self.contentL.text = dic[@"context"];
    
    NSString*replacedStr = [dic[@"time"] stringByReplacingOccurrencesOfString:@" "withString:@"\n"];
    self.timeL.frame = CGRectMake([Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:70], [dic[@"cellH"] floatValue]);
    self.timeL.text = replacedStr;
    
    UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:89], 0, 1, ([dic[@"cellH"] floatValue]-[Unity countcoordinatesH:9])/2)];
    line1.backgroundColor = LabelColor9;
    [self.contentView addSubview:line1];
    
    UIView * qiu = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:85], line1.bottom, [Unity countcoordinatesW:9], [Unity countcoordinatesH:9])];
    qiu.layer.cornerRadius = qiu.height/2;
    qiu.layer.masksToBounds=  YES;
    qiu.backgroundColor = LabelColor9;
    [self.contentView addSubview:qiu];
    
    UIView * line2 = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:89], qiu.bottom, 1, ([dic[@"cellH"] floatValue]-[Unity countcoordinatesH:9])/2)];
    line2.backgroundColor = LabelColor9;
    [self.contentView addSubview:line2];
    
    if (index == 1) {
        line1.hidden = YES;
    }else if (index == 2){
        line2.hidden = YES;
    }else if (index == 3){
        line1.hidden = YES;
        line2.hidden = YES;
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
