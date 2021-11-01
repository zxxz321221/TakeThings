//
//  HTPayCell1.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/3/3.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  HTPayCell1Delegate <NSObject>
- (void)selectBank:(NSInteger)type;
@end
@interface HTPayCell1 : UITableViewCell
@property (nonatomic, strong) id<HTPayCell1Delegate>delegate;
- (void)configWithData:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
