//
//  SendCostCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/27.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SendCostCell : UITableViewCell
- (void)configArr:(NSArray *)arr WithPrice:(NSString *)price WithRate:(NSString *)rate;
@end

NS_ASSUME_NONNULL_END
