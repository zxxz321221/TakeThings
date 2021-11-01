//
//  BaseViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/9.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController<UINavigationControllerDelegate>
//导航左侧按钮
- (void)addLeftBarButtonWithImage:(UIImage *)image action:(SEL)action;
//右侧一个图片按钮的情况
- (void)addRightBarButtonWithFirstImage:(UIImage *)firstImage action:(SEL)action;
//右侧为文字item的情况
- (void)addRightBarButtonItemWithTitle:(NSString *)itemTitle action:(SEL)action;
//左侧为文字item的情况
- (void)addLeftBarButtonItemWithTitle:(NSString *)itemTitle action:(SEL)action;
//右侧两个图片item的情况
- (void)addRightTwoBarButtonsWithFirstImage:(UIImage *)firstImage firstAction:(SEL)firstAction secondImage:(UIImage *)secondImage secondAction:(SEL)secondAction;
//右侧三个图片item的情况
- (void)addRightThreeBarButtonsWithFirstImage:(UIImage *)firstImage firstAction:(SEL)firstAction secondImage:(UIImage *)secondImage secondAction:(SEL)secondAction thirdImage:(UIImage *)thirdImage thirdAction:(SEL)thirdAction;
@end

NS_ASSUME_NONNULL_END
