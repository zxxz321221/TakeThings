//
//  paymentTpye.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/10.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  paymentTpyeDelegate <NSObject>

- (void)confirm:(NSInteger)index;

@end
NS_ASSUME_NONNULL_BEGIN

@interface paymentTpye : UIView
@property (nonatomic, strong) id<paymentTpyeDelegate>delegate;
+(instancetype)setPaymentType:(UIView *)view;

- (void)showType;
- (void)hiddenType;
@end

NS_ASSUME_NONNULL_END
