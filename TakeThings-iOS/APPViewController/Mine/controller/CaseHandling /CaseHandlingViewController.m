//
//  CaseHandlingViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/13.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "CaseHandlingViewController.h"
#import "BidprocViewController.h"
#import "GoodsprocViewController.h"
#import "NotiViewController.h"
#import "ShippedViewController.h"
#import "CloseViewController.h"
@interface CaseHandlingViewController ()<UIScrollViewDelegate>
{
    NSInteger currentPage;//当前显示的page
}
@property (nonatomic , strong) UIScrollView * topScrollView;
@property (nonatomic , strong) UIScrollView * scrollView;
@property (nonatomic , strong) UIButton * rightbBarButton;

//顶部topscro控件
@property (nonatomic , strong) UIButton * bidProcBtn;//得标处理中
@property (nonatomic , strong) UILabel * bidProcLine;
@property (nonatomic , strong) UIButton * goodsProcBtn;//发货处理中
@property (nonatomic , strong) UILabel * goodsProLine;
@property (nonatomic , strong) UIButton * notiBtn;//通知发货
@property (nonatomic , strong) UILabel * notiLine;
@property (nonatomic , strong) UIButton * shippedBtn;//待拍已发货
@property (nonatomic , strong) UILabel * shippedLine;
@property (nonatomic , strong) UIButton * closeBtn;//代拍结案
@property (nonatomic , strong) UILabel * closeLine;
@end

@implementation CaseHandlingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"案件处理"];
    self.view.backgroundColor = [Unity getColor:@"#e0e0e0"];
    [self creareUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [self addRightBarButtonItemWithTitle:@"管理" action:@selector(adminClick)];
    if (self.tap == 4) {
        self.rightbBarButton.hidden = NO;
    }else{
        self.rightbBarButton.hidden = YES;
    }
    if (self.tap >=3) {
        [self.topScrollView setContentOffset:CGPointMake(SCREEN_WIDTH/4, 0) animated:YES];
    }
}
- (void)creareUI{
    [self.view addSubview:self.topScrollView];
    [self.view addSubview:self.scrollView];
    
    [self setupChildViewController];

    for (int i=0; i<5; i++) {
        [self showVc:i];
    }
    [self topTitleColor:self.tap];
    CGFloat offsetX = self.tap * SCREEN_WIDTH;
    self.scrollView.contentOffset = CGPointMake(offsetX, 0);
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
}
- (UIScrollView *)topScrollView{
    if (!_topScrollView) {
        _topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:40])];
        _topScrollView.backgroundColor = [UIColor whiteColor];
//        _topScrollView.scrollEnabled = NO;
        _topScrollView.userInteractionEnabled = YES;
        _topScrollView.contentSize =  CGSizeMake(SCREEN_WIDTH/4*5, 0);
        // 没有弹簧效果
        //        _topScrollView.bounces = NO;
        // 隐藏水平滚动条
        _topScrollView.showsHorizontalScrollIndicator = NO;
        
        [_topScrollView addSubview:self.bidProcBtn];
        [_topScrollView addSubview:self.goodsProcBtn];
        [_topScrollView addSubview:self.notiBtn];
        [_topScrollView addSubview:self.shippedBtn];
        [_topScrollView addSubview:self.closeBtn];
    }
    return _topScrollView;
}
- (UIButton *)bidProcBtn{
    if (!_bidProcBtn) {
        _bidProcBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/4, [Unity countcoordinatesH:40])];
        [_bidProcBtn setTitle:@"得标处理中" forState:UIControlStateNormal];
        _bidProcBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        [_bidProcBtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_bidProcBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateSelected];
        _bidProcBtn.selected = YES;
        [_bidProcBtn addTarget:self action:@selector(bidProcClick) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat w = [Unity widthOfString:@"得标处理中" OfFontSize:15 OfHeight:2];
        _bidProcLine = [Unity lableViewAddsuperview_superView:_bidProcBtn _subViewFrame:CGRectMake((_bidProcBtn.width-w)/2, _bidProcBtn.height-2, w, 2) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentCenter];
        _bidProcLine.backgroundColor = [Unity getColor:@"#aa112d"];
        
    }
    return _bidProcBtn;
}
- (UIButton *)goodsProcBtn{
    if (!_goodsProcBtn) {
        _goodsProcBtn = [[UIButton alloc]initWithFrame:CGRectMake(_bidProcBtn.right, 0, SCREEN_WIDTH/4, [Unity countcoordinatesH:40])];
        [_goodsProcBtn setTitle:@"发货处理中" forState:UIControlStateNormal];
        _goodsProcBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        [_goodsProcBtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_goodsProcBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateSelected];
        [_goodsProcBtn addTarget:self action:@selector(goodsProcClick) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat w = [Unity widthOfString:@"发货处理中" OfFontSize:15 OfHeight:2];
        _goodsProLine = [Unity lableViewAddsuperview_superView:_goodsProcBtn _subViewFrame:CGRectMake((_goodsProcBtn.width-w)/2, _goodsProcBtn.height-2, w, 2) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentCenter];
        _goodsProLine.backgroundColor = [Unity getColor:@"#aa112d"];
        _goodsProLine.hidden = YES;
    }
    return _goodsProcBtn;
}
- (UIButton *)notiBtn{
    if (!_notiBtn) {
        _notiBtn = [[UIButton alloc]initWithFrame:CGRectMake(_goodsProcBtn.right, 0, SCREEN_WIDTH/4, [Unity countcoordinatesH:40])];
        [_notiBtn setTitle:@"通知发货" forState:UIControlStateNormal];
        _notiBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        [_notiBtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_notiBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateSelected];
        [_notiBtn addTarget:self action:@selector(notiClick) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat w = [Unity widthOfString:@"通知发货" OfFontSize:15 OfHeight:2];
        _notiLine = [Unity lableViewAddsuperview_superView:_notiBtn _subViewFrame:CGRectMake((_notiBtn.width-w)/2, _notiBtn.height-2, w, 2) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentCenter];
        _notiLine.backgroundColor = [Unity getColor:@"#aa112d"];
        _notiLine.hidden= YES;
    }
    return _notiBtn;
}
- (UIButton *)shippedBtn{
    if (!_shippedBtn) {
        _shippedBtn = [[UIButton alloc]initWithFrame:CGRectMake(_notiBtn.right, 0, SCREEN_WIDTH/4, [Unity countcoordinatesH:40])];
        [_shippedBtn setTitle:@"代拍已发货" forState:UIControlStateNormal];
        _shippedBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        [_shippedBtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_shippedBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateSelected];
        [_shippedBtn addTarget:self action:@selector(shippedClick) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat w = [Unity widthOfString:@"代拍已发货" OfFontSize:15 OfHeight:2];
        _shippedLine = [Unity lableViewAddsuperview_superView:_shippedBtn _subViewFrame:CGRectMake((_shippedBtn.width-w)/2, _shippedBtn.height-2, w, 2) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentCenter];
        _shippedLine.backgroundColor = [Unity getColor:@"#aa112d"];
        _shippedLine.hidden = YES;
    }
    return _shippedBtn;
}
- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(_shippedBtn.right, 0, SCREEN_WIDTH/4, [Unity countcoordinatesH:40])];
        [_closeBtn setTitle:@"代拍结案" forState:UIControlStateNormal];
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        [_closeBtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_closeBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateSelected];
        [_closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat w = [Unity widthOfString:@"代拍结案" OfFontSize:15 OfHeight:2];
        _closeLine = [Unity lableViewAddsuperview_superView:_closeBtn _subViewFrame:CGRectMake((_closeBtn.width-w)/2, _closeBtn.height-2, w, 2) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentCenter];
        _closeLine.backgroundColor = [Unity getColor:@"#aa112d"];
        _closeLine.hidden = YES;
    }
    return _closeBtn;
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _topScrollView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-[Unity countcoordinatesH:40])];
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 5, 0);
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
// 添加所有子控制器
- (void)setupChildViewController {
    
    BidprocViewController *oneVC = [[BidprocViewController alloc] init];
    [self addChildViewController:oneVC];
    
    GoodsprocViewController *twoVC = [[GoodsprocViewController alloc] init];
    [self addChildViewController:twoVC];
    
    NotiViewController * sVC = [[NotiViewController alloc]init];
    [self addChildViewController:sVC];
    
    ShippedViewController * fourVC = [[ShippedViewController alloc]init];
    [self addChildViewController:fourVC];
    
    CloseViewController * fVC = [[CloseViewController alloc]init];
    [self addChildViewController:fVC];
    
}
//右侧为文字item的情况
- (void)addRightBarButtonItemWithTitle:(NSString *)itemTitle action:(SEL)action
{
    
    self.rightbBarButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 88, 44)];
    [self.rightbBarButton setTitle:itemTitle forState:(UIControlStateNormal)];
    [self.rightbBarButton setTitle:@"取消" forState:(UIControlStateSelected)];
    [self.rightbBarButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.rightbBarButton.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    [self.rightbBarButton addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    self.rightbBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.rightbBarButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5 * SCREEN_WIDTH/375.0)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightbBarButton];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == SCREEN_WIDTH*3) {
        [self.topScrollView setContentOffset:CGPointMake(SCREEN_WIDTH/4, 0) animated:YES];
    }
    if (scrollView.contentOffset.x == SCREEN_WIDTH) {
        [self.topScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    [self topTitleColor:index];
    
}

#pragma topscro 事件
- (void)bidProcClick{
    [self topScrollView:0];
    [self topTitleColor:0];
}
- (void)goodsProcClick{
    [self topScrollView:1];
    [self topTitleColor:1];
    [self.topScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (void)notiClick{
    [self topScrollView:2];
    [self topTitleColor:2];
}
- (void)shippedClick{
    [self topScrollView:3];
    [self topTitleColor:3];
    [self.topScrollView setContentOffset:CGPointMake(SCREEN_WIDTH/4, 0) animated:YES];
}
- (void)closeClick{
    [self topScrollView:4];
    [self topTitleColor:4];
}
- (void)topTitleColor:(NSInteger)index{
    if (index == 0) {
        self.rightbBarButton.hidden= YES;
        self.bidProcBtn.selected = YES;
        self.bidProcLine.hidden = NO;
        self.goodsProcBtn.selected = NO;
        self.goodsProLine.hidden = YES;
        self.notiBtn.selected = NO;
        self.notiLine.hidden = YES;
        self.shippedBtn.selected = NO;
        self.shippedLine.hidden = YES;
        self.closeBtn.selected = NO;
        self.closeLine.hidden = YES;
    }else if (index == 1){
        self.rightbBarButton.hidden= YES;
        self.bidProcBtn.selected = NO;
        self.bidProcLine.hidden = YES;
        self.goodsProcBtn.selected = YES;
        self.goodsProLine.hidden = NO;
        self.notiBtn.selected = NO;
        self.notiLine.hidden = YES;
        self.shippedBtn.selected = NO;
        self.shippedLine.hidden = YES;
        self.closeBtn.selected = NO;
        self.closeLine.hidden = YES;
    }else if (index == 2){
        self.rightbBarButton.hidden= YES;
        self.bidProcBtn.selected = NO;
        self.bidProcLine.hidden = YES;
        self.goodsProcBtn.selected = NO;
        self.goodsProLine.hidden = YES;
        self.notiBtn.selected = YES;
        self.notiLine.hidden = NO;
        self.shippedBtn.selected = NO;
        self.shippedLine.hidden = YES;
        self.closeBtn.selected = NO;
        self.closeLine.hidden = YES;
    }else if (index == 3) {
        self.rightbBarButton.hidden= YES;
        self.bidProcBtn.selected = NO;
        self.bidProcLine.hidden = YES;
        self.goodsProcBtn.selected = NO;
        self.goodsProLine.hidden = YES;
        self.notiBtn.selected = NO;
        self.notiLine.hidden = YES;
        self.shippedBtn.selected = YES;
        self.shippedLine.hidden = NO;
        self.closeBtn.selected = NO;
        self.closeLine.hidden = YES;
    }else{
        self.rightbBarButton.hidden= NO;
        self.bidProcBtn.selected = NO;
        self.bidProcLine.hidden = YES;
        self.goodsProcBtn.selected = NO;
        self.goodsProLine.hidden = YES;
        self.notiBtn.selected = NO;
        self.notiLine.hidden = YES;
        self.shippedBtn.selected = NO;
        self.shippedLine.hidden = YES;
        self.closeBtn.selected = YES;
        self.closeLine.hidden = NO;
    }
}
- (void)adminClick{
    //1 管理 0取消
    if (self.rightbBarButton.selected) {
        self.rightbBarButton.selected  = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"admin" object:@"0"];
        
    }else{
        self.rightbBarButton.selected= YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"admin" object:@"1"];
    }
}
@end
