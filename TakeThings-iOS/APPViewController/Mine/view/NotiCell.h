//
//  NotiCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/13.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NotiModel;
@class NotiCell;
NS_ASSUME_NONNULL_BEGIN
@protocol  NotiCellDelegate <NSObject>
/**
 *  cell关于选中的代理方法
 *
 *  @param cell     cell
 *  @param selectBt cell左边选中按钮
 */
- (void)shoppingCellDelegate:(NotiCell *)cell WithSelectButton:(UIButton *)selectBt;
- (void)oriPage:(NotiCell *)cell;
- (void)detail:(NotiCell *)cell;
- (void)goodsDetail:(NotiCell *)cell;
@end
@interface NotiCell : UITableViewCell
@property (nonatomic, strong) id<NotiCellDelegate>delegate;
@property (nonatomic,strong) NotiModel * model;
@end

NS_ASSUME_NONNULL_END
