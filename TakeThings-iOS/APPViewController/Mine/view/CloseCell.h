//
//  CloseCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/13.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CloseModel;
@class CloseCell;
NS_ASSUME_NONNULL_BEGIN
@protocol  CloseCellDelegate <NSObject>
/**
 *  cell关于选中的代理方法
 *
 *  @param cell     cell
 *  @param selectBt cell左边选中按钮
 */
- (void)closeCellDelegate:(CloseCell *)cell WithSelectButton:(UIButton *)selectBt;
- (void)detail:(CloseCell *)cell;
- (void)goodsDetail:(CloseCell *)cell;
@end
@interface CloseCell : UITableViewCell
@property (nonatomic, strong) id<CloseCellDelegate>delegate;
@property (nonatomic,strong) CloseModel * model;
- (void)configIsAction:(BOOL)isAction;
@end

NS_ASSUME_NONNULL_END
