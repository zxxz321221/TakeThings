//
//  DrainIntoView.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/30.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  DrainIntoViewDelegate <NSObject>

- (void)queue;

@end
NS_ASSUME_NONNULL_BEGIN

@interface DrainIntoView : UIView
@property (nonatomic ,strong) id<DrainIntoViewDelegate>delegate;
+(instancetype)setDrainIntoView:(UIView *)view;
- (void)showDrainIntoView;
@end

NS_ASSUME_NONNULL_END
