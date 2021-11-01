//
//  ProgressCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/27.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "ProgressCell.h"
@interface ProgressCell()
{
    NSArray * list;
}
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UIImageView * imgView;
@end
@implementation ProgressCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:15])];
        _titleL.text = @"包裹进度";
        _titleL.textColor = LabelColor6;
        _titleL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _titleL;
}
- (void)configProgressArr:(NSArray *)arr{
//    if (list == nil || list != arr) {
        for (UIView * view in self.contentView.subviews) {
            [view removeFromSuperview];
        }
        [self.contentView addSubview:self.titleL];
//        list = arr;
        for (int i=0; i<arr.count; i++) {
            //进度线
            UIView * topLine = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:113], [Unity countcoordinatesH:10]+i*[Unity countcoordinatesH:25], [Unity countcoordinatesW:1], [Unity countcoordinatesH:9])];
            topLine.backgroundColor = LabelColor9;
            [self.contentView addSubview:topLine];
            UIView * qiu = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:110], topLine.bottom, [Unity countcoordinatesW:7], [Unity countcoordinatesH:7])];
            qiu.backgroundColor = LabelColor9;
            qiu.layer.cornerRadius = qiu.height/2;
            [self.contentView addSubview:qiu];
            UIView * bottomLine = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:113], qiu.bottom, [Unity countcoordinatesW:1], [Unity countcoordinatesH:9])];
            bottomLine.backgroundColor = LabelColor9;
            [self.contentView addSubview:bottomLine];
            //进度文字
            UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:125], [Unity countcoordinatesH:10]+i*[Unity countcoordinatesH:25], [Unity countcoordinatesW:80], [Unity countcoordinatesH:25])];
            title.text = arr[i][@"title"];
            title.textColor = LabelColor9;
            title.font = [UIFont systemFontOfSize:FontSize(14)];
            title.textAlignment = NSTextAlignmentLeft;
            [self.contentView addSubview:title];
            if ([arr[i][@"title"] isEqualToString:@"竞价中"]) {
                self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(title.left+[Unity countcoordinatesW:40], title.top+[Unity countcoordinatesH:7], [Unity countcoordinatesW:13], [Unity countcoordinatesH:11])];
                self.imgView.image = [UIImage imageNamed:@"jinggao"];
                [self.contentView addSubview:self.imgView];
                if (self.tanhao) {
                    self.imgView.hidden = NO;
                }else{
                    self.imgView.hidden = YES;
                }
            }
            //时间
            UILabel * time = [[UILabel alloc]initWithFrame:CGRectMake(title.right+[Unity countcoordinatesW:5], title.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
            NSArray *array = [[Unity nullDicToDic:arr[i]][@"time"] componentsSeparatedByString:@" "];
            time.text = array[0];
            time.textColor = LabelColor6;
            time.font = [UIFont systemFontOfSize:FontSize(14)];
            time.textAlignment = NSTextAlignmentRight;
            [self.contentView addSubview:time];
            //对应的时间不为空 状态已通过颜色 aa112d
            if (![[Unity nullDicToDic:arr[i]][@"time"] isEqualToString:@""]) {
                topLine.backgroundColor = [Unity getColor:@"aa112d"];
                qiu.backgroundColor = [Unity getColor:@"aa112d"];
                bottomLine.backgroundColor = [Unity getColor:@"aa112d"];
                title.textColor = [Unity getColor:@"aa112d"];
            }
            
            if (i ==0) {//第一个的画  最上线那条线是透明的
                topLine.backgroundColor = [UIColor clearColor];
            }
            if (i == arr.count-1) {//最后一个   最下面的线透明
                bottomLine.backgroundColor = [UIColor clearColor];
            }
        }
//    }
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
