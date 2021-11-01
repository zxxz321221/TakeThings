//
//  RecomeCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/9/27.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecomeCell : UICollectionViewCell
@property (nonatomic,assign) NSTimeInterval time;
- (void)configCellWithImage:(NSString *)image WithTitle:(NSString *)title WithPrice:(NSString *)price WithBid:(NSString *)bid WithType:(NSString *)type;
@end

NS_ASSUME_NONNULL_END
