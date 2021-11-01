//
//  UsTrialViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/21.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UsTrialViewController : UIViewController
@property (nonatomic , strong) NSString * platform;
@property (nonatomic , strong) NSString * price;//当地货币
@property (nonatomic , strong) NSString * goodsTitle;
@property (nonatomic , strong) NSString * imageUrl;
@property (nonatomic , strong) NSString * endTime;
@property (nonatomic , strong) NSString * increment;//出价增额
@property (nonatomic , strong) NSString * goodsID;
@property (nonatomic , strong) NSString * bidorbuy;
@property (nonatomic , strong) NSString * link;
@property (nonatomic , assign) BOOL isDetail;

@property (nonatomic , assign) NSInteger buystatus;
@property (nonatomic , strong) NSString * buy_msg;
@end

NS_ASSUME_NONNULL_END
