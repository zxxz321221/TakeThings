//
//  PackagingCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/19.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  PackagingCellDelegate <NSObject>
- (void)packBtnRead:(NSMutableArray *)array;
@end
NS_ASSUME_NONNULL_BEGIN
@interface PackagingCell : UITableViewCell
- (void)configWithPackBtnArr:(NSArray *)arr;
@property (nonatomic, strong) id<PackagingCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
