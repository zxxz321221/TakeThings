//
//  ClassViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/11.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "ClassViewController.h"
#import "ClassPageViewController.h"
#import "EbayPageViewController.h"
#import "WebPageViewController.h"
#import "AppDelegate.h"
#define W  ([Unity widthOfString:@"日本雅虎" OfFontSize:17 OfHeight:44])
@interface ClassViewController ()<UIScrollViewDelegate>

@property (nonatomic , strong)UIView * navV;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *titles;

@property (nonatomic , strong) UIButton * yahooBtn;
@property (nonatomic , strong) UIButton * ebayBtn;
@property (nonatomic , strong) UIButton * webBtn;

@property (nonatomic, strong) UILabel * yahooLine;
@property (nonatomic, strong) UILabel * ebayLine;
@property (nonatomic, strong) UILabel * webLine;
@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@""];
    [self creareUI];
    
    // 1.添加所有子控制器
    [self setupChildViewController];
    
    [self.view addSubview:self.mainScrollView];
//    //默认
    ClassPageViewController *cvc = [[ClassPageViewController alloc] init];
    [self.mainScrollView addSubview:cvc.view];

    /*方式默认子controller首次进入时不执行  加上这个就OK了*/
    [self showVc:0];
    
    
}
- (void)creareUI{
    [self.navigationController.view addSubview:self.navV];
    
    [self.navV addSubview:self.yahooBtn];
    [self.navV addSubview:self.ebayBtn];
    [self.navV addSubview:self.webBtn];
}
- (UIView *)navV{
    if (!_navV) {
        _navV = [[UIView alloc]initWithFrame:CGRectMake(0, NavBarHeight-44, SCREEN_WIDTH, 44)];
    }
    return _navV;
}
- (UIButton *)yahooBtn{
    if (!_yahooBtn) {
        _yahooBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-(W*3+30))/2, 0, W, 44)];
        [_yahooBtn setTitle:@"日本雅虎" forState:UIControlStateNormal];
        [_yahooBtn setTitleColor:[Unity getColor:@"#d58896"] forState:UIControlStateNormal];
        _yahooBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_yahooBtn addTarget:self action:@selector(yahooClick) forControlEvents:UIControlEventTouchUpInside];
        
        _yahooLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, _yahooBtn.width, 1)];
        _yahooLine.backgroundColor = [Unity getColor:@"#d58896"];
        [_yahooBtn addSubview:_yahooLine];
    }
    return _yahooBtn;
}
- (UIButton *)ebayBtn{
    if (!_ebayBtn) {
        _ebayBtn = [[UIButton alloc]initWithFrame:CGRectMake(_yahooBtn.right+15, 0, W, 44)];
        [_ebayBtn setTitle:@"美国易贝" forState:UIControlStateNormal];
        [_ebayBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
        _ebayBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_ebayBtn addTarget:self action:@selector(ebayClick) forControlEvents:UIControlEventTouchUpInside];
        
        _ebayLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, _ebayBtn.width, 1)];
        _ebayLine.backgroundColor = [Unity getColor:@"#d58896"];
        _ebayLine.hidden = YES;
        [_ebayBtn addSubview:_ebayLine];
    }
    return _ebayBtn;
}
- (UIButton *)webBtn{
    if (!_webBtn) {
        _webBtn = [[UIButton alloc]initWithFrame:CGRectMake(_ebayBtn.right+15, 0, W/2, 44)];
        [_webBtn setTitle:@"品牌" forState:UIControlStateNormal];
        [_webBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
        _webBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_webBtn addTarget:self action:@selector(webClick) forControlEvents:UIControlEventTouchUpInside];
        
        _webLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, _webBtn.width, 1)];
        _webLine.backgroundColor = [Unity getColor:@"#d58896"];
        _webLine.hidden = YES;
        [_webBtn addSubview:_webLine];
    }
    return _webBtn;
}
// 添加所有子控制器
- (void)setupChildViewController {
    // 分类
    ClassPageViewController *cvc = [[ClassPageViewController alloc] init];
    [self addChildViewController:cvc];
    
    // ebay
    EbayPageViewController *evc = [[EbayPageViewController alloc] init];
    [self addChildViewController:evc];
    
    //网站
    WebPageViewController *wvc = [[WebPageViewController alloc] init];
    [self addChildViewController:wvc];
}
- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-TabBarHeight);
        _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 0);
        _mainScrollView.backgroundColor = [UIColor clearColor];
        [_mainScrollView setScrollEnabled:NO];
        // 开启分页
        _mainScrollView.pagingEnabled = YES;
        // 没有弹簧效果
        _mainScrollView.bounces = NO;
        // 隐藏水平滚动条
        _mainScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _mainScrollView;
}
// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    CGFloat offsetX = index * SCREEN_WIDTH;
    UIViewController *vc = self.childViewControllers[index];
    NSLog(@"VC = %@",vc);
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-TabBarHeight);
}
- (void)yahooClick{
    [_yahooBtn setTitleColor:[Unity getColor:@"#d58896"] forState:UIControlStateNormal];
    _yahooLine.hidden = NO;
    [_ebayBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
    _ebayLine.hidden = YES;
    [_webBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
    _webLine.hidden = YES;
    self.mainScrollView.contentOffset = CGPointMake(0, 0);
    [self showVc:0];
}
- (void)ebayClick{
    [_yahooBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
    _yahooLine.hidden = YES;
    [_ebayBtn setTitleColor:[Unity getColor:@"#d58896"] forState:UIControlStateNormal];
    _ebayLine.hidden = NO;
    [_webBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
    _webLine.hidden = YES;
    self.mainScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    [self showVc:1];
}
- (void)webClick{
    [_yahooBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
    _yahooLine.hidden = YES;
    [_ebayBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
    _ebayLine.hidden = YES;
    [_webBtn setTitleColor:[Unity getColor:@"#d58896"] forState:UIControlStateNormal];
    _webLine.hidden = NO;
    self.mainScrollView.contentOffset = CGPointMake(SCREEN_WIDTH*2, 0);
    [self showVc:2];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navV.hidden=NO;
    AppDelegate * myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.pageTrue == 3) {
        [self webClick];
        myDelegate.pageTrue = 0;
    }
    if (myDelegate.pageTrue == 1) {
        [self yahooClick];
        myDelegate.pageTrue = 0;
    }
    if (myDelegate.pageTrue == 2) {
        [self ebayClick];
        myDelegate.pageTrue = 0;
    }

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navV.hidden=YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
