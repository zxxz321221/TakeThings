//
//  GoodsDetailCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/23.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  GoodsDetailCellDelegate <NSObject>

- (void)goodsDetail;

@end
NS_ASSUME_NONNULL_BEGIN

@interface GoodsDetailCell : UITableViewCell
@property (nonatomic ,strong) id<GoodsDetailCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
