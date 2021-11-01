//
//  OrderDetailCell6.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/15.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  OrderDetailCell6Delegate <NSObject>

- (void)bgDetail:(NSString *)bg_id;
- (void)expressDynamic:(NSDictionary *)dic;
@end
@interface OrderDetailCell6 : UITableViewCell
@property (nonatomic, strong) id<OrderDetailCell6Delegate>delegate;
- (void)configWithData:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
