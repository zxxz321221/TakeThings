//
//  TabBarViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/9.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "TabBarViewController.h"
#import "HomeViewController.h"
#import "NewClassViewController.h"
#import "BiddingViewController.h"
#import "MineViewController.h"
#import "NewMineViewController.h"
#define KCOLORWITHRGBA(r,g,b,a) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]
@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[NSNotificationCenter defaultCenter]
//     addObserver:self selector:@selector(getNotificationAction:) name:@"ThisIsANoticafication" object:nil];
    self.tabBar.tintColor = [Unity getColor:@"aa112d"];
    [self createTabBarController];
}
//- (void)getNotificationAction:(NSNotification *)notification{
//    NSDictionary * infoDic = [notification object];
//    NSArray *paramerArray = [infoDic[@"url"] componentsSeparatedByString:@"?"];
//    NSArray *paramerArray1 = [paramerArray[1] componentsSeparatedByString:@"&"];
//    NSArray *paramerArray2 = [paramerArray1[0] componentsSeparatedByString:@"="];
//    NSArray *paramerArray3 = [paramerArray1[1] componentsSeparatedByString:@"="];
//    NSLog(@"paramerArray- %@",paramerArray);
//
//    NewYahooDetailViewController * nvc = [[NewYahooDetailViewController alloc]init];
//    nvc.hidesBottomBarWhenPushed = YES;
//    nvc.item = paramerArray2[1];
//    nvc.platform = paramerArray3[1];
//    [[self topViewController].navigationController pushViewController:nvc animated:YES];
//
//}
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}
- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
- (void)createTabBarController{
    NSArray * array =@[@"HomeViewController",@"NewClassViewController",@"BiddingViewController",@"MineViewController"];
    NSArray *titleArray = @[@"首页",@"分类",@"委托下单",@"会员中心"];
    
    //标签栏控制器的tabbar的图片名称
    NSArray *imageNameArray = @[@"home_gray", @"class_gary", @"bidding_gray",@"mine_gray"];
    
    //标签栏控制器的tabbar被选择之后的图片名称
    NSArray *imageSelectorArray = @[@"home_red", @"class_red", @"bidding_red",@"mine_red"];
    
    //存放视图控制器对象的可变数组
    NSMutableArray *controllers = [NSMutableArray array];
    for (int i = 0; i < array.count; i++) {
        NSString *className = array[i];
        Class class = NSClassFromString(className);
        UIViewController *parent = [[class alloc] init];
        parent.title = titleArray[i];
        NSString *imageName = imageNameArray[i];
        NSString *selectImageName = imageSelectorArray[i];
        
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:titleArray[i] image:[[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        parent.tabBarItem = item;
        
        // 默认
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        
        // 选中
        NSMutableDictionary *attrSelected = [NSMutableDictionary dictionary];
        attrSelected[NSForegroundColorAttributeName] = [Unity getColor:@"#aa112d"];
        
        [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
        [item setTitleTextAttributes:attrSelected forState:UIControlStateSelected];

        //定义为标签栏控制器
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:parent];
        [controllers addObject:navController];
    }
    //加载到标签栏控制器
    self.viewControllers = controllers;
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
