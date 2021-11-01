//
//  CashType.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/8/5.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  CashTypeDelegate <NSObject>

- (void)cashTypeconfirm:(NSInteger)index;

@end
@interface CashType : UIView
@property (nonatomic, strong) id<CashTypeDelegate>delegate;
+(instancetype)setCashType:(UIView *)view;
- (void)showCashType;
- (void)hiddenCashType;
@end

NS_ASSUME_NONNULL_END
