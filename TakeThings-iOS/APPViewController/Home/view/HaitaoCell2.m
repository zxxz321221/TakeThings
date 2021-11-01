//
//  HaitaoCell2.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/7/29.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "HaitaoCell2.h"
#import "UIView+SDAutoLayout.h"
@implementation HaitaoCell2
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
    _timeLabel.text = @"";
    [self.contentView addSubview:_timeLabel];
    
    _view = [UIView new];
    [self.contentView addSubview:_view];
    _view.layer.cornerRadius = 7;
    _view.backgroundColor = [UIColor whiteColor];
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = LabelColor3;
    _titleLabel.font = [UIFont systemFontOfSize:FontSize(15)];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.text = @"";
    [_view addSubview:_titleLabel];
    
    _imageView = [UIImageView new];
    _imageView.backgroundColor = [UIColor redColor];
    [_view addSubview:_imageView];
    
    _contentLbale = [UILabel new];
    _contentLbale.textAlignment = NSTextAlignmentLeft;
    _contentLbale.font = [UIFont systemFontOfSize:FontSize(14)];
    _contentLbale.textColor = LabelColor3;
    //    _contentLbale.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLbale.numberOfLines = 0;
    //    _contentLbale.preferredMaxLayoutWidth = self.contentView.frame.size.width-111;
    _contentLbale.text = @"";
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
    .heightIs([Unity countcoordinatesH:170]);
    
    _titleLabel.sd_layout
    .leftSpaceToView(_view, [Unity countcoordinatesW:5])
    .topSpaceToView(_view, [Unity countcoordinatesH:10])
    .rightSpaceToView(_view, [Unity countcoordinatesW:5])
    .heightIs([Unity countcoordinatesH:20]);
    
    _imageView.sd_layout
    .leftEqualToView(_titleLabel)
    .topSpaceToView(_titleLabel, [Unity countcoordinatesH:10])
    .widthIs([Unity countcoordinatesW:80])
    .heightIs([Unity countcoordinatesH:80]);
    
    _contentLbale.sd_layout
    .leftSpaceToView(_view, [Unity countcoordinatesW:90])
    .topSpaceToView(_titleLabel,[Unity countcoordinatesH:10])
    .rightSpaceToView(_view, [Unity countcoordinatesW:5])
    .heightIs([Unity countcoordinatesH:60]);
    
    line.sd_layout
    .leftEqualToView(_titleLabel)
    .rightEqualToView(_titleLabel)
    .topSpaceToView(_imageView, [Unity countcoordinatesH:10])
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
- (void)setModel:(HaitaoModel *)model
{
    //    _model = model;
    //
    //    _titleLabel.text = model.title;
    //    _timeLabel.text = model.author;
    //    //    _imageView.image = [UIImage imageNamed:model.imageArr.firstObject];
    //    [_imageView sd_setImageWithURL:model.imageArr.firstObject];
    _titleLabel.text = model.w_title;
    NSArray *array = [model.w_date componentsSeparatedByString:@" "];
    _timeLabel.text = array[0];
    _contentLbale.text = model.w_smalltitle;
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
