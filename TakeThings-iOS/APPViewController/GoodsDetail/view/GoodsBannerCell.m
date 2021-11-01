//
//  GoodsBannerCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/22.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "GoodsBannerCell.h"
#import "SDCycleScrollView.h"
@interface GoodsBannerCell()<SDCycleScrollViewDelegate>

@property (nonatomic , strong) SDCycleScrollView * cycleScrollView;//轮播图
@property (nonatomic , strong) NSArray * imagesURLStrings;

@end
@implementation GoodsBannerCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.contentView.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [self loadBannerView];
    }
    return self;
}
- (void)loadBannerView{
    // 网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, NavBarHeight-44, SCREEN_WIDTH, [Unity countcoordinatesH:300]- (NavBarHeight-44)-5) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _cycleScrollView.backgroundColor = [UIColor redColor];
    _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    _cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    _cycleScrollView.imageURLStringsGroup = _imagesURLStrings;
    _cycleScrollView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_cycleScrollView];
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
