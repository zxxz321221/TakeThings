//
//  HackView.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/30.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  HackViewDelegate <NSObject>

- (void)cancelCase;

@end
NS_ASSUME_NONNULL_BEGIN

@interface HackView : UIView
@property (nonatomic ,strong) id<HackViewDelegate>delegate;

+(instancetype)setHackView:(UIView *)view withTitle:(NSString *)title;
- (void)showHackView;
@end

NS_ASSUME_NONNULL_END
