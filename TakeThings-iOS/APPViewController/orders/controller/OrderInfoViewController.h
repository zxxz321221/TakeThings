//
//  OrderInfoViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/13.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  OrderInfoDelegate <NSObject>

- (void)loadTwoPage;
@end
@interface OrderInfoViewController : UIViewController
@property (nonatomic, strong) id<OrderInfoDelegate>delegate;
@property (nonatomic , strong) NSDictionary * dataDic;
@end

NS_ASSUME_NONNULL_END
