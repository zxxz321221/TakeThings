//
//  PrecelSendInfoCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/27.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  PrecelSendInfoCellDelegate <NSObject>
- (void)expressQuery;
@end
@interface PrecelSendInfoCell : UITableViewCell

@property (nonatomic, strong) id<PrecelSendInfoCellDelegate>delegate;
- (void)configData:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
