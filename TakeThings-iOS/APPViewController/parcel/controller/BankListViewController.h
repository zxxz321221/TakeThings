//
//  BankListViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/25.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  bankNameDelegate <NSObject>
- (void)bankNameClick:(NSDictionary *)dic WithType:(NSInteger)type;
@end
@interface BankListViewController : UIViewController
@property (nonatomic, strong) id<bankNameDelegate>delegate;
@property (nonatomic , assign) NSInteger type;//0借记卡 1信用卡
@end

NS_ASSUME_NONNULL_END
