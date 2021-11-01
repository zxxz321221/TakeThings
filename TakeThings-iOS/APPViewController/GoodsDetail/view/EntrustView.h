//
//  EntrustView.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/29.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  EntrustViewDelegate <NSObject>

- (void)know;
- (void)update;
@end
NS_ASSUME_NONNULL_BEGIN

@interface EntrustView : UIView
@property (nonatomic, strong) id<EntrustViewDelegate>delegate;
+(instancetype)setEntrustView:(UIView *)view;
- (void)showEntrustView;
@end

NS_ASSUME_NONNULL_END
