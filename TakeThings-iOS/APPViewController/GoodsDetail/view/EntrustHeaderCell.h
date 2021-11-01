//
//  EntrustHeaderCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/27.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  EntrustHeaderCellDelegate <NSObject>

- (void)incrementBtn;
- (void)placeText:(NSString *)place;
- (void)descriText:(NSString *)descriText;
@end
NS_ASSUME_NONNULL_BEGIN

@interface EntrustHeaderCell : UITableViewCell
@property (nonatomic, strong) id<EntrustHeaderCellDelegate>delegate;
- (void)configWithGoodsName:(NSString *)goodsName WithPrice:(NSString *)price WithEndTime:(NSString *)endTime WithImageUrl:(NSString *)imageUrl WithIncrement:(NSString *)inc WithPlatform:(NSString *)platform WithBidorbuy:(NSString *)bidorbuy;
@end

NS_ASSUME_NONNULL_END
