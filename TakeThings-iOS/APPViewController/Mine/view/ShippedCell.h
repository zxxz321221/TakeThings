//
//  ShippedCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/13.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  ShippedCellDelegate <NSObject>
- (void)oriPage:(NSDictionary *)dic;
- (void)handlePlace:(NSString *)place;
- (void)detail:(NSDictionary *)dic;
- (void)goodsDetail:(NSDictionary *)dic;
@end
@interface ShippedCell : UITableViewCell
@property (nonatomic, strong) id<ShippedCellDelegate>delegate;
- (void)configWithData:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
