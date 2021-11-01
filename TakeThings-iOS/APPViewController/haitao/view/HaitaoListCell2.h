//
//  HaitaoListCell2.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/17.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HaitaoListCell2;
NS_ASSUME_NONNULL_BEGIN
@protocol  HaitaoListCell2lDelegate <NSObject>
- (void)send:(HaitaoListCell2 *)cell;
- (void)detail:(HaitaoListCell2 *)cell;
- (void)oldPage:(HaitaoListCell2 *)cell;
- (void)bgDetail:(HaitaoListCell2 *)cell;
@end
@interface HaitaoListCell2 : UITableViewCell
@property (nonatomic, strong) id<HaitaoListCell2lDelegate>delegate;
- (void)configWithData:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
