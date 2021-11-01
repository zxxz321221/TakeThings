//
//  ProgressCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/27.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProgressCell : UITableViewCell
@property (nonatomic , assign) BOOL tanhao;
- (void)configProgressArr:(NSArray *)arr;
@end

NS_ASSUME_NONNULL_END
