//
//  HelpPageCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/29.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelpPageCell : UITableViewCell
- (void)configWithTitle:(NSString  *)title WithKeyword:(NSString *)keyword WithSearch:(BOOL)isSearch;
@end

NS_ASSUME_NONNULL_END
