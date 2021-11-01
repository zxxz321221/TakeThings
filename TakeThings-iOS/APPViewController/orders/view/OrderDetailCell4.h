//
//  OrderDetailCell4.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/14.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  OrderDetailCell4Delegate <NSObject>
- (void)seleteAddress;
@end
@interface OrderDetailCell4 : UITableViewCell
@property (nonatomic, strong) id<OrderDetailCell4Delegate>delegate;
- (void)configName:(NSString *)name WithMobile:(NSString *)mobile WithAddress:(NSString *)address WithMark:(NSString *)mark WithStatus:(NSInteger)status;
@end

NS_ASSUME_NONNULL_END
