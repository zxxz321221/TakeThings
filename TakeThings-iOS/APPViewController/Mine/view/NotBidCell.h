//
//  NotBidCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/5.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NotBidModel;
@class NotBidCell;
NS_ASSUME_NONNULL_BEGIN
@protocol  NotBidCellDelegate <NSObject>
/**
 *  cell关于选中的代理方法
 *
 *  @param cell     cell
 *  @param selectBt cell左边选中按钮
 */
- (void)acloseCellDelegate:(NotBidCell *)cell WithSelectButton:(UIButton *)selectBt;
- (void)goodsDetail:(NotBidCell *)cell;

@end
@interface NotBidCell : UITableViewCell

@property (nonatomic, strong) id<NotBidCellDelegate>delegate;
@property (nonatomic,strong) NotBidModel * model;
- (void)configIsAction:(BOOL)isAction;
@property (nonatomic , strong) NSString * area;
@end

NS_ASSUME_NONNULL_END
