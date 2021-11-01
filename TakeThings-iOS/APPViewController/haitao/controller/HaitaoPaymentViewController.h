//
//  HaitaoPaymentViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/3/3.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  HaitaoPaymentDelegate <NSObject>

- (void)reloadList;
@end
@interface HaitaoPaymentViewController : UIViewController
@property (nonatomic, strong) id<HaitaoPaymentDelegate>delegate;
@property (nonatomic , strong) NSDictionary * dataDic;
@end

NS_ASSUME_NONNULL_END
