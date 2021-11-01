//
//  PatCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/30.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PatCell;
@protocol  PatCellDelegate <NSObject>

- (void)premium:(NSDictionary *)dic with:(PatCell *)cell;
- (void)bargain:(NSDictionary *)dic with:(PatCell *)cell;
- (void)oriPage:(NSDictionary *)dic;
- (void)goodsDetail:(NSDictionary *)dic;
@end
NS_ASSUME_NONNULL_BEGIN

@interface PatCell : UITableViewCell
@property (nonatomic, strong) id<PatCellDelegate>delegate;
- (void)configWithData:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
