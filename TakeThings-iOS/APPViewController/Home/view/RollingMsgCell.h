//
//  RollingMsgCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/12.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  RollingMsgCellDelegate <NSObject>

- (void)msgMore;
- (void)noticeBack:(NSDictionary *)dic;
@end
NS_ASSUME_NONNULL_BEGIN

@interface RollingMsgCell : UITableViewCell
- (void)configWithMsgList:(NSMutableArray *)arr;
@property (nonatomic, strong) id<RollingMsgCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
