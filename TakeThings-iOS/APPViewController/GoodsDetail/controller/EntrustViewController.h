//
//  EntrustViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/27.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EntrustViewController : UIViewController
@property (nonatomic , strong) NSString * platform;
@property (nonatomic , strong) NSString * price;
@property (nonatomic , strong) NSString * goodsTitle;
@property (nonatomic , strong) NSString * endTime;
@property (nonatomic , strong) NSString * imageUrl;
@property (nonatomic , strong) NSString * increment;//出价增额
@property (nonatomic , strong) NSString * goodId;//商品id
@property (nonatomic , strong) NSString * bidorbuy;
@end

NS_ASSUME_NONNULL_END
