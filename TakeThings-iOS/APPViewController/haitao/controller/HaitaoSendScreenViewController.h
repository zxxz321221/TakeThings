//
//  HaitaoSendScreenViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/3/9.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  HaitaoSendScreenDelegate <NSObject>
- (void)haitaoSendScreen:(NSInteger)time;
@end
@interface HaitaoSendScreenViewController : UIViewController
@property (nonatomic, strong) id<HaitaoSendScreenDelegate>delegate;
@property (nonatomic , assign) NSInteger order;
@end

NS_ASSUME_NONNULL_END
