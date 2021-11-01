//
//  ToastView.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/11/4.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  ToastViewDelegate <NSObject>

- (void)goToRegister;
- (void)goToBinding;

@end
NS_ASSUME_NONNULL_BEGIN

@interface ToastView : UIView
@property (nonatomic ,strong) id<ToastViewDelegate>delegate;
+(instancetype)setToastView:(UIView *)view;
- (void)showHackView;
@end

NS_ASSUME_NONNULL_END
