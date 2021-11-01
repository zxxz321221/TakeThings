//
//  deliveryInfoCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/19.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class deliveryInfoCell;
NS_ASSUME_NONNULL_BEGIN
@protocol  deliveryInfoCellDelegate <NSObject>
- (void)fillInWillSee;
- (void)placeText:(NSString *)place WithCell:(deliveryInfoCell *)cell;
@end
@interface deliveryInfoCell : UITableViewCell
@property (nonatomic, strong) id<deliveryInfoCellDelegate>delegate;
- (void)configWithData:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
