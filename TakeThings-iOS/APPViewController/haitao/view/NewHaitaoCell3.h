//
//  NewHaitaoCell3.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/13.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  NewHaitaoCell3Delegate <NSObject>

- (void)get_fraud_safe:(NSString *)ins;
- (void)get_safe_traffic:(NSString *)traffic;

@end
@interface NewHaitaoCell3 : UITableViewCell
@property (nonatomic, strong) id<NewHaitaoCell3Delegate>delegate;
- (void)configWithSource:(NSString *)source;
@end

NS_ASSUME_NONNULL_END
