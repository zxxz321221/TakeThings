//
//  RechargeSuccess.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/10.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  RechargeSuccessDelegate <NSObject>

- (void)rechargeSuccessConfirm;

@end
@interface RechargeSuccess : UIView
@property (nonatomic, strong) id<RechargeSuccessDelegate>delegate;
+(instancetype)setRechrgeSuccess:(UIView *)view;
@property (nonatomic , strong) UILabel * amountL;
- (void)showRechargeSuccess;
@end

NS_ASSUME_NONNULL_END
