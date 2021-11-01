//
//  NewDeliveryInfoCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/9.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewDeliveryInfoCell;
NS_ASSUME_NONNULL_BEGIN
@protocol  NewDeliveryInfoCellDelegate <NSObject>
- (void)fillInWillSee;
- (void)placeText:(NSString *)place WithCell:(NewDeliveryInfoCell *)cell;
@end
@interface NewDeliveryInfoCell : UITableViewCell
@property (nonatomic, strong) id<NewDeliveryInfoCellDelegate>delegate;
- (void)configWithData:(NSDictionary *)dic WithIsNew:(BOOL)isNew;
@end

NS_ASSUME_NONNULL_END
