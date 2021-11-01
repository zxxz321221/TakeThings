//
//  BidCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/5.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BidCell;
@protocol  BidCellDelegate <NSObject>

- (void)drainInto:(BidCell *)cell;
- (void)oriPage:(NSDictionary *)dic;
- (void)goodsDetail:(NSDictionary *)dic;

@end
NS_ASSUME_NONNULL_BEGIN

@interface BidCell : UITableViewCell
@property (nonatomic, strong) id<BidCellDelegate>delegate;
- (void)confitWithData:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
