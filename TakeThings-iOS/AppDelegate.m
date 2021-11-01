//
//  AppDelegate.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/9.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "AppDelegate.h"
#import "wellcome(欢迎页)/WellcomeViewController.h"
#import "Third(三方)/allpaysdk/AllPaySDK.h"
#import <WXApi.h>
#import "NewYahooDetailViewController.h"
#import "NewEbayDetailViewController.h"
#import "BaiduMobStat.h"
#import "AppDelegate+Jpush.h"
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

NSString * urll;
BOOL isLogin;//登录还是绑定（微信登录）
//@implementation NSURLRequest(DataController)
//
//+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
//
//{
//    
//    return YES;
//
//}
//
//@end
@interface AppDelegate ()<WXApiDelegate>
@property (nonatomic , strong) WellcomeViewController * wellcome;
@property (nonatomic , assign) NSInteger  messageSum;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //百度统计渠道（上线打包的时候 注释掉）
    #ifdef DEBUG
    [[BaiduMobStat defaultStat] setChannelId:@"test"];
    #else
    #endif
    
    //注册微信
    [WXApi registerApp:@"wxbcd88a8bdc0b72a7"];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];

    [self .window setRootViewController:[[UINavigationController alloc]initWithRootViewController:[[NSClassFromString(@"WellcomeViewController") alloc]init]] ];
    [self.window makeKeyAndVisible];
    
    //配置极光，如果通过消息启动，并进行操作
    [self Jpush_application:application didFinishLaunchingWithOptions:launchOptions];

    return YES;
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    [application registerForRemoteNotifications];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];   //清除角标
    [application cancelAllLocalNotifications];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"杀死app");
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userInfo"];
}
//-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//
//    [AllPaySDK openURL:url]; return YES;
//
//}
//
//-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//
//    [AllPaySDK openURL:url]; return YES;
//
//}
//
//-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
//
//    [AllPaySDK openURL:url]; return YES;
//
//}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary*)options{
    NSString * absoluteUrlStr = [url absoluteString];
    if ([absoluteUrlStr rangeOfString:@"wxbcd88a8bdc0b72a7"].location != NSNotFound) {
        return [WXApi handleOpenURL:url delegate:self];
    }else if ([absoluteUrlStr hasPrefix:@"shaogoodapp"]) {
//        //获取参数
        NSArray *paramerArray = [absoluteUrlStr componentsSeparatedByString:@"?"];
        NSArray *paramerArray1 = [paramerArray[1] componentsSeparatedByString:@"&"];
        NSArray *paramerArray2 = [paramerArray1[0] componentsSeparatedByString:@"="];
        NSArray *paramerArray3 = [paramerArray1[1] componentsSeparatedByString:@"="];
//        NSLog(@"paramerArray- %@",paramerArray);
//        [WHToast showMessage:paramerArray3[1] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        urll = absoluteUrlStr;
        if ([paramerArray3[1] isEqualToString:@"0"]) {
            NewYahooDetailViewController * nvc = [[NewYahooDetailViewController alloc]init];
            nvc.hidesBottomBarWhenPushed = YES;
            nvc.item = paramerArray2[1];
            nvc.platform = paramerArray3[1];
            [[self topViewController].navigationController pushViewController:nvc animated:YES];
        }else{
            NewEbayDetailViewController * nvc = [[NewEbayDetailViewController alloc]init];
            nvc.hidesBottomBarWhenPushed = YES;
            nvc.item = paramerArray2[1];
            nvc.platform = paramerArray3[1];
            [[self topViewController].navigationController pushViewController:nvc animated:YES];
        }
        
    }else{
        [AllPaySDK openURL:url];
    }
    return YES;
}
- (void)onResp:(BaseResp*)resp{
    NSLog(@"-___%@",resp);
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        //分享结果
        if (resp.errCode == WXSuccess) {
            NSLog(@"成功");
        }else{
            NSLog(@"失败");
        }
    }else if ([resp isKindOfClass:[SendAuthResp class]]){
        NSLog(@"第三方登录回调%d",resp.errCode);
        SendAuthResp *temp = (SendAuthResp *)resp;
        if (resp.errCode == 0) {//ERR_OK = 0(用户同意) ERR_AUTH_DENIED = -4（用户拒绝授权） ERR_USER_CANCEL = -2（用户取消）
            NSDictionary * dic = @{@"appid":@"wxbcd88a8bdc0b72a7",@"secret":@"035f893529c7b2b5f4d63fbf6a72c833",@"code":temp.code,@"grant_type":@"authorization_code"};
            [GZMrequest getWithURLString:@"https://api.weixin.qq.com/sns/oauth2/access_token" parameters:dic success:^(NSDictionary *data) {
                NSLog(@"请求成功 %@",data);
                if (isLogin) {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"wechatLogin" object:data];
                }else{
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"wechatBind" object:data];
                }
                
            } failure:^(NSError *error) {
                
            }];
        }
    }
}
//- (void)weChatInfo{
//
//}
//获取Window当前显示的ViewController
- (UIViewController*)currentViewController{
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}
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

@end
