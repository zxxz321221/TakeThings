//
//  AppDelegate+Jpush.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/10/29.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN
#ifdef DEBUG
static BOOL isProduction = NO;
#else
static BOOL isProduction = YES;
#endif

static NSString *appKey = @"";//587311f10a1cd2b04584d973
static NSString *channel = @"";
@interface AppDelegate (Jpush)
- (BOOL)Jpush_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
@end

NS_ASSUME_NONNULL_END
