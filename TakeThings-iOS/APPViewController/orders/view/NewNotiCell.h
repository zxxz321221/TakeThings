//
//  NewNotiCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/9.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class NewNotiModel;
@class NewNotiCell;
@protocol  NewNotiCellDelegate <NSObject>
/**
 *  cell关于选中的代理方法
 *
 *  @param cell     cell
 *  @param selectBt cell左边选中按钮
 */
- (void)shoppingCellDelegate:(NewNotiCell *)cell WithSelectButton:(UIButton *)selectBt;
- (void)sendF:(NewNotiCell *)cell;
- (void)goods_detail:(NewNotiCell *)cell;
@end
@interface NewNotiCell : UITableViewCell
@property (nonatomic, strong) id<NewNotiCellDelegate>delegate;
@property (nonatomic,strong) NewNotiModel * model;
@end

NS_ASSUME_NONNULL_END
