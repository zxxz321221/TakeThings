//
//  NewOrderCell1.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/9.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewOrderCell1;
NS_ASSUME_NONNULL_BEGIN
@protocol  NewOrderCell1Delegate <NSObject>

- (void)goodsDetailT:(NewOrderCell1 *)cell;
- (void)goodsSettlement:(NewOrderCell1 *)cell WithTag:(NSInteger)tag;
@end
@interface NewOrderCell1 : UITableViewCell
@property (nonatomic, strong) id<NewOrderCell1Delegate>delegate;
- (void)configWithData:(NSDictionary *)dic;
@property (nonatomic ,assign) NSTimeInterval time;
@end

NS_ASSUME_NONNULL_END
