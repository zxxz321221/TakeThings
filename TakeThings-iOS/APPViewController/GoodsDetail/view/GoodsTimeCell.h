//
//  GoodsTimeCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/23.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsTimeCell : UITableViewCell
- (void)configWithEndTime:(NSString *)endTime WithPlatform:(NSString *)platform WithPrice:(NSString *)price WithBidCount:(NSString *)count;
@end

NS_ASSUME_NONNULL_END
