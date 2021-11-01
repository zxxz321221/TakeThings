//
//  SendView.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/14.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  SendViewDelegate <NSObject>

- (void)popHome;
- (void)popOrderPage;
@end
@interface SendView : UIView
@property (nonatomic, strong) id<SendViewDelegate>delegate;
+(instancetype)setSendView:(UIView *)view;
- (void)showSendView;
@end

NS_ASSUME_NONNULL_END
