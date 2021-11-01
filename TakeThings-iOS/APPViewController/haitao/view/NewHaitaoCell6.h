//
//  NewHaitaoCell6.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/13.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewHaitaoCell6;
NS_ASSUME_NONNULL_BEGIN
@protocol  NewHaitaoCell6Delegate <NSObject>

- (void)goodsDelete:(NSString *)ggg;
- (void)updateWithName:(NSString *)name WithLink:(NSString *)link WithParam:(NSString *)param WithGid:(NSString *)gid WithPrice:(NSString *)price WithNum:(NSString *)num WithGgg:(NSString *)ggg WithCell:(NewHaitaoCell6 *)cell;
@end
@interface NewHaitaoCell6 : UITableViewCell
@property (nonatomic, strong) id<NewHaitaoCell6Delegate>delegate;
- (void)configWithData:(NSDictionary *)dic WithNum:(NSInteger )num WithSumNum:(NSInteger)sumNum;
@end

NS_ASSUME_NONNULL_END
