//
//  PayPassWordView.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/11.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  PayPassWordViewDelegate <NSObject>

- (void)set;

@end
@interface PayPassWordView : UIView
@property (nonatomic, strong) id<PayPassWordViewDelegate>delegate;
+(instancetype)setPayPassWordView:(UIView *)view;
- (void)showPayPasswordView;
@end

NS_ASSUME_NONNULL_END
