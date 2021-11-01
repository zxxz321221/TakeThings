//
//  HaitaoDetailCell5.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/18.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  HaitaoDetailCell5lDelegate <NSObject>
- (void)expressDynamic:(NSDictionary *)dic;
@end
@interface HaitaoDetailCell5 : UITableViewCell
@property (nonatomic, strong) id<HaitaoDetailCell5lDelegate>delegate;
- (void)configWithData:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
