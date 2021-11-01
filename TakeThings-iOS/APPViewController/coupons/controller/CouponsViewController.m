//
//  CouponsViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/7/10.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "CouponsViewController.h"
#import "NBLScrollTabController.h"
#import "CouponsOneViewController.h"
#import "CouponsTwoViewController.h"
#import "CouponsThreeViewController.h"
@interface CouponsViewController ()<NBLScrollTabControllerDelegate>
@property (nonatomic, strong) NBLScrollTabController *scrollTabController;
@property (nonatomic, strong) NSArray *viewControllers;

@property (nonatomic , strong) NBLScrollTabItem * pageItem0;
@property (nonatomic , strong) NBLScrollTabItem * pageItem1;
@property (nonatomic , strong) NBLScrollTabItem * pageItem2;
@end

@implementation CouponsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"回馈金"];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.scrollTabController.view];
}
- (NBLScrollTabController *)scrollTabController
{
    if (!_scrollTabController) {
        _scrollTabController = [[NBLScrollTabController alloc] init];
        _scrollTabController.view.frame = self.view.bounds;
        _scrollTabController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scrollTabController.delegate = self;
        _scrollTabController.viewControllers = self.viewControllers;
    }
    
    return _scrollTabController;
}
- (NSArray *)viewControllers
{
    if (!_viewControllers) {
        CouponsOneViewController *page0 = [[CouponsOneViewController alloc] init];
        _pageItem0 = [[NBLScrollTabItem alloc] init];
        _pageItem0.title = @"未使用";
        _pageItem0.hideBadge = YES;//每个title可以做个性化配置
        _pageItem0.textColor = [Unity getColor:@"#999999"]; //每个title可以做个性化配置
        _pageItem0.highlightColor = [Unity getColor:@"#aa112d"];//每个title可以做个性化配置
        page0.tabItem = _pageItem0;
        
        CouponsTwoViewController *page1 = [[CouponsTwoViewController alloc] init];
        _pageItem1 = [[NBLScrollTabItem alloc] init];
        _pageItem1.title = @"已使用";
        _pageItem1.hideBadge = YES;
        _pageItem1.textColor = [Unity getColor:@"#999999"]; //每个title可以做个性化配置
        _pageItem1.highlightColor = [Unity getColor:@"#aa112d"];//每个title可以做个性化配置
        page1.tabItem = _pageItem1;
        
        CouponsThreeViewController *page2 = [[CouponsThreeViewController alloc] init];
        _pageItem2 = [[NBLScrollTabItem alloc] init];
        _pageItem2.title = @"已过期";
        _pageItem2.hideBadge = YES;
        _pageItem2.textColor = [Unity getColor:@"#999999"]; //每个title可以做个性化配置
        _pageItem2.highlightColor = [Unity getColor:@"#aa112d"];//每个title可以做个性化配置
        page2.tabItem = _pageItem2;
        
        
        //        demo3Item.font = [UIFont systemFontOfSize:10];//每个title可以做个性化配置
        _viewControllers = @[page0, page1, page2];
        
    }
    
    return _viewControllers;
}

#pragma mark - NBLScrollTabControllerDelegate

- (void)tabController:(NBLScrollTabController * __nonnull)tabController
didSelectViewController:( UIViewController * __nonnull)viewController
{
    //业务逻辑处理
    //    if ([viewController isKindOfClass:[DemoViewController0 class]]) {
    //        NSLog(@"%@，%@",tabController,viewController);
    //    }
    
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
