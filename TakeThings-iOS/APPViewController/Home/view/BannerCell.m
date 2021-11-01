//
//  BannerCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/12.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "BannerCell.h"
#import "SDCycleScrollView.h"
@interface BannerCell()<SDCycleScrollViewDelegate>
@property (nonatomic , strong) NSMutableArray * imagesURLStrings;
@property (nonatomic , strong) SDCycleScrollView * cycleScrollView;//轮播图
@property (nonatomic , strong) NSArray * array;


@end

@implementation BannerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [self loadBannerView];
    }
    return self;
}
- (void)loadBannerView{
//    NSLog(@"images  %@",self.imagesURLStrings);
    // 网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kWidth(135)) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _cycleScrollView.backgroundColor = [UIColor clearColor];
    _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    _cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    _cycleScrollView.autoScrollTimeInterval = 4;
    _cycleScrollView.imageURLStringsGroup = _imagesURLStrings;
    [self.contentView addSubview:_cycleScrollView];
    UIImageView * imageView = [Unity imageviewAddsuperview_superView:_cycleScrollView _subViewFrame:CGRectMake(0, kWidth(116), SCREEN_WIDTH, kWidth(19)) _imageName:@"bannerG" _backgroundColor:nil];
    
    NSArray * titleArr = @[@"汇率转换",@"支付中心",@"费用计算",@"海淘资讯"];
    for (int i=0; i<4; i++) {
        UIButton * btn = [Unity buttonAddsuperview_superView:self.contentView _subViewFrame:CGRectMake(i*(SCREEN_WIDTH/4), imageView.bottom+kWidth(10), SCREEN_WIDTH/4, kWidth(85)) _tag:self _action:@selector(homeBtnClick:) _string:@"" _imageName:@""];
        UIImageView * btnImg = [Unity imageviewAddsuperview_superView:btn _subViewFrame:CGRectMake((btn.width-kWidth(50))/2, kWidth(5), kWidth(50), kWidth(50)) _imageName:titleArr[i] _backgroundColor:nil];
        UILabel * btnL = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake(0, btnImg.bottom+kWidth(5), btn.width, kWidth(20)) _string:titleArr[i] _lableFont:[UIFont systemFontOfSize:16] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentCenter];
        btnL.backgroundColor = [UIColor clearColor];
        btnL.font = [UIFont systemFontOfSize:FontSize(14)];
        btn.tag=i+1000;
    }
    CGFloat W = [Unity widthOfString:@"了解我们/初次使用Shaogod捎东西" OfFontSize:16 OfHeight:kWidth(20)];
    UILabel * homeL = [Unity lableViewAddsuperview_superView:self.contentView _subViewFrame:CGRectMake((SCREEN_WIDTH-W)/2, imageView.bottom+kWidth(100), W, kWidth(20)) _string:@"了解我们/初次使用Shaogod捎东西" _lableFont:[UIFont systemFontOfSize:16] _lableTxtColor:[Unity getColor:@"#aa112d"] _textAlignment:NSTextAlignmentCenter];
    UITapGestureRecognizer *singleTap =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(marginAction)];
    singleTap.numberOfTapsRequired = 1; //点击次数
    singleTap.numberOfTouchesRequired = 1; //点击手指数
    [homeL addGestureRecognizer:singleTap];
    homeL.userInteractionEnabled = YES;
    UIImageView * homeImg = [Unity imageviewAddsuperview_superView:self.contentView _subViewFrame:CGRectMake(homeL.right, homeL.top, kWidth(20), kWidth(20)) _imageName:@"叹号" _backgroundColor:nil];
    homeImg.backgroundColor = [UIColor clearColor];
}
- (void)homeBtnClick:(UIButton *)btn{
    [self.delegate homeBtn:btn.tag-1000];
}
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击的是第几个banner%ld",(long)index);
    
    [self.delegate bannerImg:self.array[index]];
}
- (void)configWithBannerArray:(NSMutableArray *)arr{
    self.array = arr;
//    NSLog(@"+%@",arr);
    [self.imagesURLStrings removeAllObjects];
    for (int i=0; i<arr.count; i++) {
        NSString * str = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"],arr[i][@"w_pic"]];
        [self.imagesURLStrings addObject:str];
    }
    self.cycleScrollView.imageURLStringsGroup = _imagesURLStrings;
    
}
- (NSMutableArray *)imagesURLStrings{
    if (!_imagesURLStrings) {
        _imagesURLStrings = [NSMutableArray new];
    }
    return _imagesURLStrings;
}
- (NSArray *)array{
    if (!_array) {
        _array = [NSArray new];
    }
    return _array;
}
- (void)marginAction{
    [self.delegate about];
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
