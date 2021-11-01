//
//  NewOrderDetailViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/13.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  NewOrderDetailDelegate <NSObject>
- (void)successCut:(NSString *)order_id;
- (void)successAddPlace;
- (void)successJiesuan;//委托单结算
@end
@interface NewOrderDetailViewController : UIViewController
@property (nonatomic, strong) id<NewOrderDetailDelegate>delegate;
@property (nonatomic , strong) NSDictionary * dataDic;
@property (nonatomic , strong) NSString * orderId;//委托单ID
@property (nonatomic , assign) NSInteger page;
@property (nonatomic , strong) NSString * oldUrl;
@end

NS_ASSUME_NONNULL_END
