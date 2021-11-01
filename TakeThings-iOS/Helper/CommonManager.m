//
//  CommonManager.m
//  TakeThings-iOS
//
//  Created by 赵祥 on 2021/9/1.
//  Copyright © 2021 GUIZM. All rights reserved.
//

#import "CommonManager.h"

@implementation CommonManager

+ (UIViewController *)getCurrentViewController {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    if (@available(iOS 13.0, *)) {
            window = [UIApplication sharedApplication].windows[0];
    } else {
            window = [UIApplication sharedApplication].delegate.window;
    }
    
     UIViewController *rootViewController = window.rootViewController;
      if ([rootViewController isKindOfClass:[UITabBarController class]]) {
          UITabBarController *tabBarController = (UITabBarController *)rootViewController;
          UINavigationController *navController = tabBarController.selectedViewController;
          UIViewController *topViewController = navController.topViewController;
          return topViewController;
      }
      return rootViewController;
}

+ (CGFloat)getStatusBarHight {
    float statusBarHeight = 0;
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        statusBarHeight = statusBarManager.statusBarFrame.size.height;
    }
    else {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    return statusBarHeight;
}

@end
