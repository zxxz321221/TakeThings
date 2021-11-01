//
//  CashWay.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/8/2.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  CashWayDelegate <NSObject>

- (void)confirm:(NSString *)way;

@end
@interface CashWay : UIView
@property (nonatomic, strong) id<CashWayDelegate>delegate;
+(instancetype)setCashWay:(UIView *)view;
- (void)showCashWay;
- (void)hiddenCashWay;
@end

NS_ASSUME_NONNULL_END
