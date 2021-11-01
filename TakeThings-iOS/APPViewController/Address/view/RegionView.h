//
//  RegionView.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/31.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  RegionViewDelegate <NSObject>

- (void)areaSelection:(NSString *)area;

@end
NS_ASSUME_NONNULL_BEGIN

@interface RegionView : UIView
@property (nonatomic, strong) id<RegionViewDelegate>delegate;
+(instancetype)setRegionView:(UIView *)view;
- (void)showRegionView;
@end

NS_ASSUME_NONNULL_END
