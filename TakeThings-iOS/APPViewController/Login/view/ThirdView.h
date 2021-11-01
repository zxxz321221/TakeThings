//
//  ThirdView.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/16.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  ThirdViewDelegate <NSObject>

- (void)thirdLoginIndex:(NSInteger)index;
- (void)privacyPolicylClick;

@end
NS_ASSUME_NONNULL_BEGIN

@interface ThirdView : UIView
@property (nonatomic , strong) id<ThirdViewDelegate>delegate;
+(instancetype)setThirdView:(UIView *)view;
- (void)showThirdView;
@end

NS_ASSUME_NONNULL_END
