//
//  CashFailure.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/10.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CashFailure : UIView
+(instancetype)setCashFailure:(UIView *)view;
@property (nonatomic , strong) UILabel * amountL;
@property (nonatomic , strong) UILabel * msgL;
- (void)showCashFailuer;
@end

NS_ASSUME_NONNULL_END
