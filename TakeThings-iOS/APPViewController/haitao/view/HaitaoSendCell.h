//
//  HaitaoSendCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/3/6.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HaitaoSendModel;
@class HaitaoSendCell;
NS_ASSUME_NONNULL_BEGIN
@protocol  HaitaoSendCellDelegate <NSObject>
/**
 *  cell关于选中的代理方法
 *
 *  @param cell     cell
 *  @param selectBt cell左边选中按钮
 */
- (void)seleteCellDelegate:(HaitaoSendCell *)cell WithSelectButton:(UIButton *)selectBt;
- (void)haitaoSend:(HaitaoSendCell *)cell;
- (void)haitaoOldPage:(HaitaoSendCell *)cell;
@end
@interface HaitaoSendCell : UITableViewCell
@property (nonatomic, strong) id<HaitaoSendCellDelegate>delegate;
@property (nonatomic,strong) HaitaoSendModel * model;
@end

NS_ASSUME_NONNULL_END
