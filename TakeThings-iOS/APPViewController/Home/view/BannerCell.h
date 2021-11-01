//
//  BannerCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/12.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  BannerCellDelegate <NSObject>

- (void)homeBtn:(NSInteger)tag;
- (void)bannerImg:(NSDictionary *)dic;
- (void)about;
@end
NS_ASSUME_NONNULL_BEGIN

@interface BannerCell : UITableViewCell

@property (nonatomic, strong) id<BannerCellDelegate>delegate;

- (void)configWithBannerArray:(NSMutableArray *)arr;
@end

NS_ASSUME_NONNULL_END
