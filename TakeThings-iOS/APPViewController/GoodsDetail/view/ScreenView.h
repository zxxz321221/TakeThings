//
//  ScreenView.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/13.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//@protocol  ScreenViewwDelegate <NSObject>
//
//- (void)screenBtnIndex:(NSInteger)btnIndex WithMin:(NSString *)placemin WithMax:(NSString *)placemax WithIndex:(NSInteger)index;
//@end
@interface ScreenView : UIView
//@property (nonatomic, strong) id<ScreenViewwDelegate>delegate;
+(instancetype)setScreenView:(UIView *)view;
- (void)maskAction;
- (void)showScreenView;
@end

NS_ASSUME_NONNULL_END
