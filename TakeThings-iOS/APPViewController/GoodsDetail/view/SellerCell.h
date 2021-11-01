//
//  SellerCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/23.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  SellerCellDelegate <NSObject>

- (void)originalClick;
- (void)allGoodsClick;
- (void)sellerCollectionClick;
@end
NS_ASSUME_NONNULL_BEGIN

@interface SellerCell : UITableViewCell
@property (nonatomic ,strong) id<SellerCellDelegate>delegate;
- (void)configWithDict:(NSDictionary *)dict isCollection:(BOOL)isCollec;
@end

NS_ASSUME_NONNULL_END
