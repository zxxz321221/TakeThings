//
//  BidprocCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/13.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  BidprocCellDelegate <NSObject>

- (void)oriPage:(NSDictionary *)dic;
- (void)detail:(NSDictionary *)dic;
- (void)goodsDetail:(NSDictionary *)dic;
@end
@interface BidprocCell : UITableViewCell
@property (nonatomic, strong) id<BidprocCellDelegate>delegate;
- (void)configWithData:(NSDictionary *)dic;
- (void)configWithGoodsData:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
