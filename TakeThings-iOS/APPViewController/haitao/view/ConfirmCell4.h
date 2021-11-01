//
//  ConfirmCell4.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/14.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  ConfirmCell4Delegate <NSObject>

- (void)get_lack_channel:(NSString *)channel;

@end
@interface ConfirmCell4 : UITableViewCell
@property (nonatomic, strong) id<ConfirmCell4Delegate>delegate;
@end

NS_ASSUME_NONNULL_END
