//
//  EntrustFooterCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/28.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  EntrustFooterCellDelegate <NSObject>

- (void)sdxxieyi;
- (void)weituohetong;
- (void)editAddress;
- (void)agreementClick:(BOOL)isContract;
- (void)transportType:(NSInteger )type WithPlatform:(NSString *)platform;
@end
NS_ASSUME_NONNULL_BEGIN

@interface EntrustFooterCell : UITableViewCell
@property (nonatomic, strong) id<EntrustFooterCellDelegate>delegate;
- (void)configWithArr:(NSArray *)arr WithAddress:(NSDictionary *)addressDic WithString:(NSString *)str;
- (void)configWithTrType:(NSString *)trType;
- (void)entrustSeleted;
@end

NS_ASSUME_NONNULL_END
