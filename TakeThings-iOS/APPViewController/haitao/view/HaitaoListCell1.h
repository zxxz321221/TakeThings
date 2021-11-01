//
//  HaitaoListCell1.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/17.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HaitaoListCell1;
NS_ASSUME_NONNULL_BEGIN
@protocol  HaitaoListCell1lDelegate <NSObject>
- (void)cancel:(HaitaoListCell1 *)cell;
- (void)onlineService;
- (void)payment:(HaitaoListCell1 *)cell;
@end
@interface HaitaoListCell1 : UITableViewCell
@property (nonatomic, strong) id<HaitaoListCell1lDelegate>delegate;
- (void)configWithData:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
