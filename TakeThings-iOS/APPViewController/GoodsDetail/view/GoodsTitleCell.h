//
//  GoodsTitleCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/22.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsTitleCell : UITableViewCell
- (void)configWithDict:(NSDictionary *)dict WithPlaform:(NSString *)plaform;
@end

NS_ASSUME_NONNULL_END
