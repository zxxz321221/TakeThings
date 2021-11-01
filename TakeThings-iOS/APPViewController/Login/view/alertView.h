//
//  alertView.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/16.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface alertView : UIView
+(instancetype)setAlertView:(UIView *)view;
- (void)showAlertView;
@property (nonatomic , strong) UILabel * msgL;
@end

NS_ASSUME_NONNULL_END
