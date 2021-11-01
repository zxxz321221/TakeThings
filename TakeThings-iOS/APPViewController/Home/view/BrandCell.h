//
//  BrandCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/15.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  BrandCellDelegate <NSObject>

- (void)brandCellMore;
- (void)brandCellItem:(NSInteger)index;

@end
NS_ASSUME_NONNULL_BEGIN

@interface BrandCell : UITableViewCell
@property (nonatomic, strong) id<BrandCellDelegate>delegate;
- (void)configWithBrandList:(NSArray *)arr;
@end

NS_ASSUME_NONNULL_END
