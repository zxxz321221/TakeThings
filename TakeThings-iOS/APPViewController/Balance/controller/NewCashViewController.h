//
//  NewCashViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/8/2.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  NewCashDelegate <NSObject>

- (void)reloadBalance;

@end
@interface NewCashViewController : UIViewController
@property (nonatomic, strong) id<NewCashDelegate>delegate;
@property (nonatomic , strong) NSString * balance;
@end

NS_ASSUME_NONNULL_END
