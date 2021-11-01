//
//  NewTwoCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/23.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewTwoCell;
NS_ASSUME_NONNULL_BEGIN
@protocol  NewTwoCellDelegate <NSObject>
- (void)TwoLogisticClick:(NewTwoCell *)cell WithTag:(NSInteger)tag;
- (void)TwoUniversalClick:(NewTwoCell *)cell WithTag:(NSInteger)tag;
- (void)TwoSeleteLogistics:(NSString *)num  WithCell:(NewTwoCell *)cell;
@end
@interface NewTwoCell : UITableViewCell
@property (nonatomic, strong) id<NewTwoCellDelegate>delegate;
- (void)configWithData:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
