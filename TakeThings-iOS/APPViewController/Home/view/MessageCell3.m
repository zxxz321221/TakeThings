//
//  MessageCell3.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/27.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "MessageCell3.h"

#import "UIView+SDAutoLayout.h"
@implementation MessageCell3
{
    UILabel *_titleLabel;
    UILabel * _timeLabel;
    UILabel * _contentLbale;
    UIView * _view;
    UIImageView * _imageView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    self.contentView.backgroundColor = [Unity getColor:@"#f0f0f0"];
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:FontSize(12)];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.textColor = LabelColor6;
//    _timeLabel.text = @"一个月前";
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_timeLabel];
    
    _view = [UIView new];
    [self.contentView addSubview:_view];
    _view.layer.cornerRadius = 7;
    _view.backgroundColor = [UIColor whiteColor];
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = LabelColor3;
    _titleLabel.font = [UIFont systemFontOfSize:FontSize(15)];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
//    _titleLabel.text = @"超级竞价日来袭";
    [_view addSubview:_titleLabel];
    
    _imageView = [UIImageView new];
//    _imageView.backgroundColor = [UIColor redColor];
    [_view addSubview:_imageView];
    
    _contentLbale = [UILabel new];
    _contentLbale.font = [UIFont systemFontOfSize:FontSize(14)];
    _contentLbale.textColor = LabelColor3;
//    _contentLbale.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLbale.numberOfLines = 0;
//    _contentLbale.preferredMaxLayoutWidth = self.contentView.frame.size.width-44;
    _contentLbale.textAlignment = NSTextAlignmentLeft;
//    _contentLbale.text = @"爆款2.5折起，全场折上88折，明星同款爱丽丝系列限量抢，还有品牌新客50元门槛，速戳>>";
    [_view addSubview:_contentLbale];
    
    UILabel * line = [UILabel new];
    line.backgroundColor = [Unity getColor:@"#f0f0f0"];
    [_view addSubview:line];
    
    UILabel * lookLabel = [UILabel new];
    lookLabel.font = [UIFont systemFontOfSize:FontSize(12)];
    lookLabel.textAlignment = NSTextAlignmentLeft;
    lookLabel.textColor = LabelColor3;
    lookLabel.text = @"查看详情";
    [_view addSubview:lookLabel];
    
    UIImageView * goImg = [UIImageView new];
    goImg.image = [UIImage imageNamed:@"go"];
    [_view addSubview:goImg];
    
    CGFloat margin = [Unity countcoordinatesW:15];
    UIView *contentView = self.contentView;
    
    _timeLabel.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin)
    .rightSpaceToView(contentView, margin)
    .heightIs([Unity countcoordinatesH:15]);
    
    _view.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(_timeLabel, [Unity countcoordinatesH:10])
    .rightSpaceToView(contentView, margin)
    .heightIs([Unity countcoordinatesH:240]);
    
    _titleLabel.sd_layout
    .leftSpaceToView(_view, [Unity countcoordinatesW:5])
    .topSpaceToView(_view, [Unity countcoordinatesH:10])
    .rightSpaceToView(_view, [Unity countcoordinatesW:5])
    .heightIs([Unity countcoordinatesH:20]);
    
    _imageView.sd_layout
    .leftEqualToView(_titleLabel)
    .rightEqualToView(_titleLabel)
    .topSpaceToView(_titleLabel, [Unity countcoordinatesH:10])
    .heightIs([Unity countcoordinatesH:100]);
    
    _contentLbale.sd_layout
    .leftEqualToView(_imageView)
    .topSpaceToView(_imageView, [Unity countcoordinatesH:10])
    .rightSpaceToView(_view, [Unity countcoordinatesW:5])
    .heightIs([Unity countcoordinatesH:40]);
    
    line.sd_layout
    .leftEqualToView(_contentLbale)
    .rightEqualToView(_contentLbale)
    .topSpaceToView(_contentLbale, [Unity countcoordinatesH:10])
    .heightIs(1);
    
    lookLabel.sd_layout
    .leftEqualToView(line)
    .rightEqualToView(line)
    .topSpaceToView(line, 0)
    .heightIs([Unity countcoordinatesH:40]);
    
    goImg.sd_layout
    .rightSpaceToView(_view, [Unity countcoordinatesW:5])
    .topSpaceToView(line, [Unity countcoordinatesH:14])
    .widthIs([Unity countcoordinatesW:5])
    .heightIs([Unity countcoordinatesH:10]);
    
    // 当你不确定哪个view在自动布局之后会排布在cell最下方的时候可以调用次方法将所有可能在最下方的view都传过去
    [self setupAutoHeightWithBottomViewsArray:@[_timeLabel,_view ] bottomMargin:0];
}
- (void)setModel:(MsgModel *)model
{
    _model = model;
    
    _titleLabel.text = model.title;
    _timeLabel.text = model.timing;
    _contentLbale.text = model.content;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/public%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"new_sdxurl"],model.image]] placeholderImage:nil];
}
/*计算消息时间*/
- (NSString *)compareCurrentTime:(NSString *)str
{
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    timeInterval = timeInterval - 8*60*60;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
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
