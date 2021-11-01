
//
//  HaitaoListViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/17.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "HaitaoListViewController.h"
#import "HTOneViewController.h"
#import "HTTwoViewController.h"
#import "HTThreeViewController.h"
#import "UIViewController+YINNav.h"
#import "HaitaoSearchViewController.h"
#import "HaitaoScreenViewController.h"
#import "CWScrollView.h"
#import "CWTableViewInfo.h"
#import "UIViewController+CWLateralSlide.h"
@interface HaitaoListViewController ()<UIScrollViewDelegate,HaitaoScreenDelegate>
{
    NSInteger currentPage;//当前显示的page
    
    NSInteger oneStatus;
    NSInteger twoStatus;
    NSInteger threeStatus;
    
    NSInteger oneIndex;
    NSInteger twoIndex;
    NSInteger threeIndex;
}
@property (nonatomic , strong) UIScrollView * topScrollView;
@property (nonatomic , strong) UILabel * navLine;

@property (nonatomic , strong) UIButton * patBtn;//代拍中
@property (nonatomic , strong) UILabel * patLine;
@property (nonatomic , strong) UILabel * patMsg;

@property (nonatomic , strong) UIButton * bidBtn;//易得标
@property (nonatomic , strong) UILabel * bidLine;
@property (nonatomic , strong) UILabel * bidMsg;

@property (nonatomic , strong) UIButton * notBidBtn;//没得标
@property (nonatomic , strong) UILabel * notBidLine;
@property (nonatomic , strong) UILabel * notBidMsg;

@property (nonatomic , strong) UIScrollView * scrollView;
@end

@implementation HaitaoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    oneStatus = 0;
    twoStatus = 0;
    threeStatus = 0;
    
    oneIndex = 1;
    twoIndex = 1;
    threeIndex = 1;
    self.y_navLineHidden = YES;
    [self.navigationItem setTitle:@"海淘委托单"];
    self.view.backgroundColor = [Unity getColor:@"#e0e0e0"];
    [self creareUI];
}
- (void)creareUI{
    [self.view addSubview:self.topScrollView];
    [self.view addSubview:self.scrollView];
    
    [self setupChildViewController];
    
    
    for (int i=0; i<3; i++) {
        [self showVc:i];
    }
    [self topTitleColor:self.tap];
    CGFloat offsetX = self.tap * SCREEN_WIDTH;
    self.scrollView.contentOffset = CGPointMake(offsetX, 0);
}
// 添加所有子控制器
- (void)setupChildViewController {
    
    HTOneViewController *oneVC = [[HTOneViewController alloc] init];
    [self addChildViewController:oneVC];
    
    HTTwoViewController *twoVC = [[HTTwoViewController alloc] init];
    [self addChildViewController:twoVC];
    
    HTThreeViewController * sVC = [[HTThreeViewController alloc]init];
//    sVC.delegate = self;
    [self addChildViewController:sVC];

}
- (UIScrollView *)topScrollView{
    if (!_topScrollView) {
        _topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:40])];
        _topScrollView.backgroundColor = [UIColor whiteColor];
        [_topScrollView addSubview:self.navLine];
        [_topScrollView addSubview:self.patBtn];
        [_topScrollView addSubview:self.bidBtn];
        [_topScrollView addSubview:self.notBidBtn];
    }
    return _topScrollView;
}
- (UILabel *)navLine{
    if (!_navLine) {
        _navLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        _navLine.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _navLine;
}
- (UIButton *)patBtn{
    if (!_patBtn) {
        _patBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, [Unity countcoordinatesH:40])];
        [_patBtn setTitle:@"询价中" forState:UIControlStateNormal];
        _patBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_patBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        [_patBtn addTarget:self action:@selector(patClick) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat w = [Unity widthOfString:@"询价中" OfFontSize:15 OfHeight:2];
        _patLine = [Unity lableViewAddsuperview_superView:_patBtn _subViewFrame:CGRectMake((_patBtn.width-w)/2, _patBtn.height-2, w, 2) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentCenter];
        _patLine.backgroundColor = [Unity getColor:@"#aa112d"];
        
        _patMsg = [Unity lableViewAddsuperview_superView:_patBtn _subViewFrame:CGRectMake(_patLine.right-2, [Unity countcoordinatesH:13], 5, 5) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentCenter];
        _patMsg.backgroundColor = [UIColor redColor];
        _patMsg.layer.cornerRadius = 2.5;
        _patMsg.layer.masksToBounds = YES;
        _patMsg.hidden = YES;
    }
    return _patBtn;
}
- (UIButton *)bidBtn{
    if (!_bidBtn) {
        _bidBtn = [[UIButton alloc]initWithFrame:CGRectMake(_patBtn.right, 0, SCREEN_WIDTH/3, [Unity countcoordinatesH:40])];
        [_bidBtn setTitle:@"已支付" forState:UIControlStateNormal];
        _bidBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_bidBtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_bidBtn addTarget:self action:@selector(bidClick) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat w = [Unity widthOfString:@"已支付" OfFontSize:15 OfHeight:2];
        _bidLine = [Unity lableViewAddsuperview_superView:_bidBtn _subViewFrame:CGRectMake((_bidBtn.width-w)/2, _bidBtn.height-2, w, 2) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentCenter];
        _bidLine.backgroundColor = [Unity getColor:@"#aa112d"];
        _bidLine.hidden = YES;
        
        _bidMsg = [Unity lableViewAddsuperview_superView:_bidBtn _subViewFrame:CGRectMake(_bidLine.right-2, [Unity countcoordinatesH:13], 5, 5) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentCenter];
        _bidMsg.backgroundColor = [UIColor redColor];
        _bidMsg.layer.cornerRadius = 2.5;
        _bidMsg.layer.masksToBounds = YES;
        _bidMsg.hidden = YES;
    }
    return _bidBtn;
}
- (UIButton *)notBidBtn{
    if (!_notBidBtn) {
        _notBidBtn = [[UIButton alloc]initWithFrame:CGRectMake(_bidBtn.right, 0, SCREEN_WIDTH/3, [Unity countcoordinatesH:40])];
        [_notBidBtn setTitle:@"已结束" forState:UIControlStateNormal];
        _notBidBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_notBidBtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_notBidBtn addTarget:self action:@selector(notbidClick) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat w = [Unity widthOfString:@"已结束" OfFontSize:15 OfHeight:2];
        _notBidLine = [Unity lableViewAddsuperview_superView:_notBidBtn _subViewFrame:CGRectMake((_notBidBtn.width-w)/2, _notBidBtn.height-2, w, 2) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentCenter];
        _notBidLine.backgroundColor = [Unity getColor:@"#aa112d"];
        _notBidLine.hidden = YES;
        
        _notBidMsg = [Unity lableViewAddsuperview_superView:_notBidBtn _subViewFrame:CGRectMake(_notBidLine.right-2, [Unity countcoordinatesH:13], 5, 5) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentCenter];
        _notBidMsg.backgroundColor = [UIColor redColor];
        _notBidMsg.layer.cornerRadius = 2.5;
        _notBidMsg.layer.masksToBounds = YES;
        _notBidMsg.hidden = YES;
    }
    return _notBidBtn;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _topScrollView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-[Unity countcoordinatesH:40])];
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 0);
        _scrollView.backgroundColor = [UIColor clearColor];
        // 开启分页
        _scrollView.pagingEnabled = YES;
        // 没有弹簧效果
        _scrollView.bounces = NO;
        // 隐藏水平滚动条
        _scrollView.showsHorizontalScrollIndicator = NO;
        // 设置代理
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (void)patClick{
    
    [self topTitleColor:0];
    [self topScrollView:0];
}
- (void)bidClick{
    
    [self topTitleColor:1];
    [self topScrollView:1];
}
- (void)notbidClick{
    
    [self topTitleColor:2];
    [self topScrollView:2];
}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    currentPage = index;

    CGFloat offsetX = index * SCREEN_WIDTH;
    
    UIViewController *vc = self.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    [self.scrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-[Unity countcoordinatesH:40]);
}
//头部scrollview点击
- (void)topScrollView:(NSInteger)index{
    // 1 计算滚动的位置
    CGFloat offsetX = index * SCREEN_WIDTH;
    self.scrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 2.给对应位置添加对应子控制器
    [self showVc:index];
    
    self.tap = index;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    [self topTitleColor:index];
    
    self.tap = index;
}
- (void)topTitleColor:(NSInteger)index{
    if (index == 0) {
        [self.patBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        self.patLine.hidden = NO;
        [self.bidBtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        self.bidLine.hidden = YES;
        [self.notBidBtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        self.notBidLine.hidden=YES;
    }else if (index == 1){
        [self.patBtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        self.patLine.hidden = YES;
        [self.bidBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        self.bidLine.hidden = NO;
        [self.notBidBtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        self.notBidLine.hidden=YES;
    }else{
        [self.patBtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        self.patLine.hidden = YES;
        [self.bidBtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        self.bidLine.hidden = YES;
        [self.notBidBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        self.notBidLine.hidden=NO;
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [Unity getColor:@"#f0f0f0"];
    currentPage = self.tap;
    
    [self addRightTwoBarButtonsWithFirstImage:[UIImage imageNamed:@"bgsx"] firstAction:@selector(screening) secondImage:[UIImage imageNamed:@"bgss"] secondAction:@selector(searchClick)];
    
}
//右侧两个图片item的情况
- (void)addRightTwoBarButtonsWithFirstImage:(UIImage *)firstImage firstAction:(SEL)firstAction secondImage:(UIImage *)secondImage secondAction:(SEL)secondAction{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.frame = CGRectMake(40, 0, 40, 44);
    [firstButton setImage:firstImage forState:UIControlStateNormal];
    [firstButton addTarget:self action:firstAction forControlEvents:UIControlEventTouchUpInside];
    firstButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, - 8 * SCREEN_WIDTH/375.0)];
    [view addSubview:firstButton];
    
    UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    secondButton.frame = CGRectMake(0, 0, 40, 44);
    [secondButton setImage:secondImage forState:UIControlStateNormal];
    [secondButton addTarget:self action:secondAction forControlEvents:UIControlEventTouchUpInside];
    secondButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [secondButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, - 15 * SCREEN_WIDTH/375.0)];
    [view addSubview:secondButton];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
- (void)screening{
    NSLog(@"%ld",(long)self.tap);
    [self defaultAnimationFromRight:self.tap];
    
}
/**
 搜索
 */
- (void)searchClick{
    HaitaoSearchViewController * pvc = [[HaitaoSearchViewController alloc]init];
    [self.navigationController pushViewController:pvc animated:YES];
}
/**
 筛选
 */
- (void)defaultAnimationFromRight:(NSInteger)tap{
    HaitaoScreenViewController *vc = [[HaitaoScreenViewController alloc] init];
    vc.delegate = self;
    vc.tap = tap;
    if (tap == 0) {
        vc.timeP = oneIndex;
        vc.statusP = oneStatus;
    }else if (tap == 1){
        vc.timeP = twoIndex;
        vc.statusP = twoStatus;
    }else{
        vc.timeP = threeIndex;
        vc.statusP = threeStatus;
    }
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration defaultConfiguration];
    conf.direction = CWDrawerTransitionFromRight;
    conf.showAnimDuration = 1.0f;
    [self cw_showDrawerViewController:vc animationType:CWDrawerAnimationTypeMask configuration:conf];
}
- (void)screenTime:(NSInteger)time WithListIndex:(NSInteger)index WithStatusIndex:(NSInteger)status{
    if (index != self.tap) {
        [self topTitleColor:index];
        [self topScrollView:index];
    }
    if (index == 0) {
        oneIndex = time;
        oneStatus = status;
    }else if (index == 1){
        twoIndex = time;
        twoStatus = status;
    }else{
        threeIndex = time;
        threeStatus = status;
    }
    NSDictionary * dic = @{@"time":[NSString stringWithFormat:@"%ld",(long)time],@"status":[NSString stringWithFormat:@"%ld",(long)status]};
    NSString * str = [NSString stringWithFormat:@"haitaoList%ld",(long)index];
    [[NSNotificationCenter defaultCenter] postNotificationName:str object:dic];
}
@end
