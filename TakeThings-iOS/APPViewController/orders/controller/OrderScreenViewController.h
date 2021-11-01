//
//  OrderScreenViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/5.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  OrderScreenDelegate <NSObject>
- (void)screenTime:(NSInteger)time WithListIndex:(NSInteger)listIndex WithStatusIndex:(NSInteger)statusIndex WithType:(NSInteger)type;
@end
@interface OrderScreenViewController : UIViewController
@property (nonatomic, strong) id<OrderScreenDelegate>delegate;
@property (nonatomic , assign) NSInteger tap;
@property (nonatomic , assign) NSInteger timeP;//时间排序
@property (nonatomic , assign) NSInteger typeP;//出价方式
@property (nonatomic , assign) NSInteger statusP;
@end

NS_ASSUME_NONNULL_END
