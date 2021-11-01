//
//  GZMShareView.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/8/28.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  GZMShareViewDelegate <NSObject>

- (void)weixinshareClick;
- (void)weixinfrindClick;
@end
NS_ASSUME_NONNULL_BEGIN

@interface GZMShareView : UIView
@property (nonatomic, strong) id<GZMShareViewDelegate>delegate;
+(instancetype)setGZMShareView:(UIView *)view;
- (void)showShareView;
- (void)cancelClick;
@end

NS_ASSUME_NONNULL_END
