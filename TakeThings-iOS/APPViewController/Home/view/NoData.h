//
//  NoData.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/8/12.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  NoDataDelegate <NSObject>

- (void)pushHome;

@end
NS_ASSUME_NONNULL_BEGIN

@interface NoData : UIView
@property (nonatomic , strong) UIImageView * imageView;
@property (nonatomic , strong) UILabel * msgLabel;
@property (nonatomic , strong) UIButton * homeBtn;
@property (nonatomic, strong) id<NoDataDelegate>delegate;
+(instancetype)setNoData:(UIView *)view;
- (void)showNoData;
- (void)hiddenNoData;
@end

NS_ASSUME_NONNULL_END
