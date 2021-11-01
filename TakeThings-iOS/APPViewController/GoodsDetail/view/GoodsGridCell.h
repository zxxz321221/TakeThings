//
//  GoodsGridCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/12.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsGridCell : UICollectionViewCell
- (void)config:(NSDictionary *)dic WithPlatform:(NSString *)platform;
@property (nonatomic,assign) NSTimeInterval time;
@property (nonatomic , strong) NSString * imageUrl;
@property (nonatomic , strong) NSString * goodTitle;
@property (nonatomic , strong) NSString * currPlace;
@property (nonatomic , strong) NSString * countNum;
@property (nonatomic , strong) NSString * w_cc;

//@property (nonatomic , strong) UIImageView * icon;
@end

NS_ASSUME_NONNULL_END
