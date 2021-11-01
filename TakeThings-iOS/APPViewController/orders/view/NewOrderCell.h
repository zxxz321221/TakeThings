//
//  NewOrderCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/7.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewOrderCell;
NS_ASSUME_NONNULL_BEGIN
@protocol  NewOrderCellDelegate <NSObject>

- (void)goodsDetail:(NewOrderCell *)cell;
- (void)goodsCut:(NewOrderCell *)cell WithTag:(NSInteger)tag;
- (void)goodsConfirm:(NewOrderCell *)cell WithTag:(NSInteger)tag;
@end
@interface NewOrderCell : UITableViewCell
@property (nonatomic, strong) id<NewOrderCellDelegate>delegate;
- (void)configWithData:(NSDictionary *)dic;
@property (nonatomic ,assign) NSTimeInterval time;
@end

NS_ASSUME_NONNULL_END
