//
//  EntrustTwoCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/28.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  EntrustTwoCellDelegate <NSObject>

- (void)whBtn;
- (void)goodsButton;
- (void)shipNum:(NSString *)num;
- (void)bidWay:(NSString *)type;
- (void)smsNoti:(NSString *)sms;
- (void)shipIns:(NSString *)ins;
@end
NS_ASSUME_NONNULL_BEGIN

@interface EntrustTwoCell : UITableViewCell
@property (nonatomic, strong) id<EntrustTwoCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
