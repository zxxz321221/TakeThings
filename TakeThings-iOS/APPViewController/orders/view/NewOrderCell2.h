//
//  NewOrderCell2.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/9.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewOrderModel;
@class NewOrderCell2;
NS_ASSUME_NONNULL_BEGIN
@protocol  NewOrderCell2Delegate <NSObject>
/**
 *  cell关于选中的代理方法
 *
 *  @param cell     cell
 *  @param selectBt cell左边选中按钮
 */
- (void)acloseCellDelegate:(NewOrderCell2 *)cell WithSelectButton:(UIButton *)selectBtn;
//- (void)goodsDetail:(NotBidCell *)cell;
- (void)orderDelete:(NewOrderCell2 *)cell;
- (void)orderOld:(NewOrderCell2 *)cell;
@end
@interface NewOrderCell2 : UITableViewCell
@property (nonatomic, strong) id<NewOrderCell2Delegate>delegate;
@property (nonatomic,strong) NewOrderModel * model;
- (void)configIsAction:(BOOL)isAction;
- (void)configWithData:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
