//
//  NewHaitaoCell1.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/12.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  NewHaitaoCell1Delegate <NSObject>

- (void)addGoodsWithName:(NSString *)name WithLink:(NSString *)link WithParam:(NSString *)param WithGid:(NSString *)gid WithPrice:(NSString *)price WithNum:(NSString *)num;

@end
@interface NewHaitaoCell1 : UITableViewCell
@property (nonatomic, strong) id<NewHaitaoCell1Delegate>delegate;
- (void)configWithSource:(NSString *)source WithSum:(NSInteger)sum;
@end

NS_ASSUME_NONNULL_END
