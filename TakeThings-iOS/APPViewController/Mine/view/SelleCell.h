//
//  SelleCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/12.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SellerModel;
@class SelleCell;
NS_ASSUME_NONNULL_BEGIN
@protocol  SelleCellDelegate <NSObject>
/**
 *  cell关于选中的代理方法
 *
 *  @param cell     cell
 *  @param selectBt cell左边选中按钮
 */
- (void)sellerCellDelegate:(SelleCell *)cell WithSelectButton:(UIButton *)selectBt;
@end
@interface SelleCell : UITableViewCell
@property (nonatomic, strong) id<SelleCellDelegate>delegate;
@property (nonatomic,strong) SellerModel * model;
- (void)config:(BOOL)edit;
@end

NS_ASSUME_NONNULL_END
