//
//  ConfirmInfoViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/14.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConfirmInfoViewController : UIViewController
@property (nonatomic , strong) NSString * source;
@property (nonatomic , strong) NSArray * dataList;
@property (nonatomic , strong) NSString * fraud_safe;
@property (nonatomic , strong) NSString * safe_traffic;
@end

NS_ASSUME_NONNULL_END
