//
//  GoodCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/10.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "GoodCell.h"
@interface GoodCell()
@property (nonatomic , strong) UIView * backV;
@property (nonatomic , strong) UICollectionView * collectionView;
@end
@implementation GoodCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [self.contentView addSubview:self.backV];
    }
    return self;
}
- (UIView *)backV{
    if (_backV == nil) {
        _backV = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], 0, SCREEN_WIDTH-[Unity countcoordinatesW:10], [Unity countcoordinatesH:560])];
        _backV.layer.cornerRadius = 10;
        _backV.backgroundColor = [UIColor whiteColor];
    }
    return _backV;
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
