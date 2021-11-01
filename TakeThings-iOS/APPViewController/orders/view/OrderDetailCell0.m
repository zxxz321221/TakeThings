//
//  OrderDetailCell0.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/14.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "OrderDetailCell0.h"

@implementation OrderDetailCell0

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)configArr:(NSArray *)arr{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    for (int i=0; i<arr.count; i++) {
        UILabel * titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], i*[Unity countcoordinatesH:25], [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        titleL.text = arr[i][@"title"];
        titleL.textColor = LabelColor3;
        titleL.font = [UIFont systemFontOfSize:FontSize(14)];
        titleL.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titleL];
        
        UILabel * placeL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:110], i*[Unity countcoordinatesH:25], [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        placeL.text = [NSString stringWithFormat:@"%@%@",arr[i][@"place"],arr[i][@"currency"]];
        placeL.textColor = [Unity getColor:@"aa112d"];
        placeL.font = [UIFont systemFontOfSize:FontSize(14)];
        placeL.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:placeL];
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
