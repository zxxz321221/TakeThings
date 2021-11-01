//
//  CollectionViewHeaderView.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/22.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  CollectionViewHeaderDelegate <NSObject>

- (void)moreClick:(NSString *_Nullable)title;

@end
NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewHeaderView : UICollectionReusableView

@property (nonatomic, strong) id<CollectionViewHeaderDelegate>delegate;
@property (nonatomic,strong) UILabel * label;
@end

NS_ASSUME_NONNULL_END
