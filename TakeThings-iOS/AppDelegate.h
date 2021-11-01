//
//  AppDelegate.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/9.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/** 设置全局变量的属性. */
@property (strong, nonatomic)NSString * japan;
@property (strong, nonatomic)NSString * usa;
@property (strong, nonatomic)NSString * japan1;
@property (strong, nonatomic)NSString * usa1;
@property (assign, nonatomic)NSInteger pageTrue;//yes 显示分类中品牌 no默认日本雅虎

@end

