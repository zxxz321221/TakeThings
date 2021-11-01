//
//  SslCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/9/20.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  sslCellDelegate <NSObject>
- (void)confirm:(NSString *)goodId;
- (void)goodDetail:(NSString *)goodId WithType:(NSString *)type;
@end
NS_ASSUME_NONNULL_BEGIN

@interface SslCell : UITableViewCell
@property (nonatomic, strong) id<sslCellDelegate>delegate;
- (void)configWithGoodId:(NSString *)goodId WithStatus:(NSInteger)status WithImage:(NSString *)image WithGoodName:(NSString *)goodName WithGoodPrice:(NSString *)goodPrice WithGuessPrice:(NSString *)guessPrice WithJifen:(NSString *)jifen WithSource:(NSString *)source WithUser_confirm:(NSInteger)user_confirm WithNeed_confirm:(NSInteger)need_confirm;
@end

NS_ASSUME_NONNULL_END
