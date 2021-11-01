//
//  RechargeViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/10.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  RechargeDelegate <NSObject>

- (void)rechargeSuccReload;

@end
@interface RechargeViewController : UIViewController
@property (nonatomic, strong) id<RechargeDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
