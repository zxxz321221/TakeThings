//
//  SendScreenViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/9.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  SendScreenDelegate <NSObject>
- (void)screenTime:(NSInteger)time;
@end
@interface SendScreenViewController : UIViewController
@property (nonatomic, strong) id<SendScreenDelegate>delegate;
@property (nonatomic , assign) NSInteger order_id;
@end

NS_ASSUME_NONNULL_END
