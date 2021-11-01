//
//  BabyCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/12.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BabyModel;
@class BabyCell;
NS_ASSUME_NONNULL_BEGIN
@protocol  BabyCellDelegate <NSObject>
/**
 *  cell关于选中的代理方法
 *
 *  @param cell     cell
 *  @param selectBt cell左边选中按钮
 */
- (void)babyCellDelegate:(BabyCell *)cell WithSelectButton:(UIButton *)selectBt;
- (void)oldpageClick:(BabyCell *)cell;
- (void)patClick:(BabyCell *)cell;
@end
@interface BabyCell : UITableViewCell
@property (nonatomic, strong) id<BabyCellDelegate>delegate;
@property (nonatomic,strong) BabyModel * model;
- (void)config:(BOOL)edit;
@end

NS_ASSUME_NONNULL_END
