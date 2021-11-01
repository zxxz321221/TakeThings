//
//  HaitaoListCell3.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/17.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HaitaoListCell3;
NS_ASSUME_NONNULL_BEGIN
@protocol  HaitaoListCell3lDelegate <NSObject>
- (void)deleteOrder:(HaitaoListCell3 *)cell;
- (void)oldPage1:(HaitaoListCell3 *)cell;
@end
@interface HaitaoListCell3 : UITableViewCell
@property (nonatomic, strong) id<HaitaoListCell3lDelegate>delegate;
- (void)configWithData:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
