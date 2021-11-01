//
//  FootHeaderView.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/9/16.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FootHearModel;
@class FootHeaderView;
NS_ASSUME_NONNULL_BEGIN
@protocol  FootHeaderDelegate<NSObject>

- (void)shoppingCarHeaderViewDelegat:(UIButton *)bt WithHeadView:(FootHeaderView *)view;

@end

@interface FootHeaderView : UICollectionReusableView
@property (nonatomic,strong) FootHearModel *model;
@property (nonatomic,strong) UILabel * label;
@property (nonatomic , strong) UIButton * readBtn;
@property(nonatomic,assign)id<FootHeaderDelegate>delegate;
- (void)configWithIsEdit:(BOOL)isEdit Section:(NSInteger)section;
@end

NS_ASSUME_NONNULL_END
