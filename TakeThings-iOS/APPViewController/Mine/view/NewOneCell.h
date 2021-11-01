//
//  NewOneCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/11/29.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewOneCell;
NS_ASSUME_NONNULL_BEGIN
@protocol  NewOneCellDelegate <NSObject>
- (void)OneLogisticClick:(NewOneCell *)cell WithTag:(NSInteger)tag;
- (void)OneUniversalClick:(NewOneCell *)cell WithTag:(NSInteger)tag;
- (void)OneSeleteLogistics:(NSString *)num WithCell:(NewOneCell *)cell;
@end
@interface NewOneCell : UITableViewCell
@property (nonatomic, strong) id<NewOneCellDelegate>delegate;
- (void)configWithData:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
