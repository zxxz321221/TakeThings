//
//  PrecelAddressCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/27.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  PrecellAddressDelegate <NSObject>
- (void)seleteAddress;
@end
@interface PrecelAddressCell : UITableViewCell
@property (nonatomic, strong) id<PrecellAddressDelegate>delegate;
- (void)configName:(NSString *)name WithMobile:(NSString *)mobile WithAddress:(NSString *)address WithMark:(NSString *)mark WithStatus:(NSInteger)status;
@end

NS_ASSUME_NONNULL_END
