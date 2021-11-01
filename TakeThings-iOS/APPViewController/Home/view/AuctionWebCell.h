//
//  AuctionWebCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/15.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  AuctionWebCellDelegate <NSObject>

- (void)auctionIndex:(NSInteger)index;

@end
NS_ASSUME_NONNULL_BEGIN

@interface AuctionWebCell : UITableViewCell
@property (nonatomic, strong) id<AuctionWebCellDelegate>delegate;

- (void)configWithSubject:(NSArray *)arr;
@end

NS_ASSUME_NONNULL_END
