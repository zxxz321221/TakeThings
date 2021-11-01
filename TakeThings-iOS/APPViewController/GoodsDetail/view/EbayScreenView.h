//
//  EbayScreenView.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/7/18.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//@protocol  EbayScreenViewDelegate <NSObject>
//
//- (void)screenBtnIndex:(NSInteger)btnIndex WithMin:(NSString *)placemin WithMax:(NSString *)placemax WithIndex:(NSInteger )index;
//@end
@interface EbayScreenView : UIView
//@property (nonatomic, strong) id<EbayScreenViewDelegate>delegate;
+(instancetype)setEbayScreenView:(UIView *)view;
- (void)maskAction;
- (void)showScreenView;
@end

NS_ASSUME_NONNULL_END
