//
//  advertising.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/17.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface advertising : UIView
+(instancetype)setadvertising:(UIView *)view;
- (void)showAdvertising;
@property (nonatomic , strong) UIImageView * imageView;
@end

NS_ASSUME_NONNULL_END
