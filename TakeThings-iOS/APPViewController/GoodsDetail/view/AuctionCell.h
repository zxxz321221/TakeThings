//
//  AuctionCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/23.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  AuctionCellDelegate <NSObject>

- (void)moreClick;

@end
NS_ASSUME_NONNULL_BEGIN

@interface AuctionCell : UITableViewCell
@property (nonatomic ,strong) id<AuctionCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
