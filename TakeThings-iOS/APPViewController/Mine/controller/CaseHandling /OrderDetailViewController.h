//
//  OrderDetailViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/18.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailViewController : UIViewController
@property (nonatomic , strong) NSString * order;// 委托单编号
@property (nonatomic , strong) NSString * finish;// 结案标识
@end

NS_ASSUME_NONNULL_END
