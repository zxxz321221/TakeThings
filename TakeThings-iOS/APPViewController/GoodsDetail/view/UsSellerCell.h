//
//  UsSellerCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/20.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  UsSellerCellDelegate <NSObject>

- (void)originalClick;
- (void)allGoodsClick;
- (void)sellerCollectionClick;
@end
NS_ASSUME_NONNULL_BEGIN

@interface UsSellerCell : UITableViewCell
@property (nonatomic ,strong) id<UsSellerCellDelegate>delegate;
- (void)configWithDict:(NSDictionary *)dict isCollection:(BOOL)isCollec;
@end

NS_ASSUME_NONNULL_END
