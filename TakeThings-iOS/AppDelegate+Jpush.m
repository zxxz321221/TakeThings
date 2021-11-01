//
//  AppDelegate+Jpush.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/10/29.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "AppDelegate+Jpush.h"

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#import "CollectionViewController.h"
@interface AppDelegate ()<JPUSHRegisterDelegate>
@end
@implementation AppDelegate (Jpush)

- (BOOL)Jpush_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [JPUSHService setLogOFF];//setDebugMode
    //推送配置，及注册服务
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    //获取registrationID 项目服务器发推送需要
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        //upload registrationID to server
    }];
    
    //启动推送服务
    [JPUSHService setupWithOption:launchOptions appKey:appKey channel:channel apsForProduction:isProduction];
    
    //根据APP启动参数，判断是否由推送消息唤醒APP，并对消息进行处理
    if (launchOptions) {
        NSDictionary *remoteNotification = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
        if (remoteNotification) {
            //此处将推送消息保存在通知参数内。可在首页加载完成添加监听，实现跳转等操作。可能有更好的办法
            [self performSelector:@selector(sendNotificationInfoToHomeVC:) withObject:remoteNotification afterDelay:1];
        }
    }
    
    return YES;
}
#pragma mark    ---     注册deviceToken到JPUSHService
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //向JPUSHService 上传deviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    //添加标签
    [JPUSHService addTags:[NSSet setWithObject:[Unity getLanguage]] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSLog(@"=======+++++%ld",(long)iResCode);
    } seq:0];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"推送注册失败");
}

#pragma mark    ---     APP 前台运行/后台运行 收到消息都会先走此方法
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    
}

#pragma mark    ---    程序前台运行中 调用此方法
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
        //对消息进行处理  比如自定义弹框显示在当前window上面
        //        NSLog(@"前台收到推送：%@",[self getCurrentWindow]);

    }
    completionHandler(UNNotificationPresentationOptionAlert);
}

#pragma mark    ---    程序在后台，点击消息 调用此方法
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
            
            //对消息进行处理  比如从当前控制器 push or present
            //        NSLog(@"通过消息APP从后台被唤醒：%@",[self getCurrentViewController]);
            //在这里处理  app运行时点击通知栏事件
            NSLog(@"点击推送消息 %@",userInfo);
            if ([userInfo[@"app_jump_type"] intValue] == 1) {
                CollectionViewController * cvc = [[CollectionViewController alloc]init];
                cvc.hidesBottomBarWhenPushed = YES;
                [[self topViewController].navigationController pushViewController:cvc animated:YES];
            }
        }
    } else {
        // Fallback on earlier versions
    }
    completionHandler();
}

#pragma mark    ---     app events
- (void)sendNotificationInfoToHomeVC:(NSDictionary *)dict {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"SystemMsgCallApp" object:dict];
}
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
