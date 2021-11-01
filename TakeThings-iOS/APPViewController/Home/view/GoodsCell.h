//
//  GoodsCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/15.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  GoodsCellDelegate <NSObject>

- (void)goodsCellMore:(NSDictionary *)dic;
- (void)goodsCellData:(NSDictionary *_Nullable)dic;

@end
NS_ASSUME_NONNULL_BEGIN

@interface GoodsCell : UITableViewCell
@property (nonatomic , strong) id<GoodsCellDelegate>delegate;
- (void)configWithGoods:(NSDictionary *)arr;
@end

NS_ASSUME_NONNULL_END
