//
//  DifferView.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/14.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  DifferViewDelegate <NSObject>
- (void)recharge;
- (void)confirm;
@end
@interface DifferView : UIView
@property (nonatomic, strong) id<DifferViewDelegate>delegate;
+(instancetype)setDifferView:(UIView *)view;
@property (nonatomic , strong) UILabel * amount;
@property (nonatomic , strong) UILabel * balance;
@property (nonatomic , strong) UILabel * mark;
@property (nonatomic , strong) UIButton * confirm;
- (void)showDifferView;
@end

NS_ASSUME_NONNULL_END
