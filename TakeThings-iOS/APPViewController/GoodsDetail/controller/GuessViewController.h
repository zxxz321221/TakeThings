//
//  GuessViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/9/20.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GuessViewController : UIViewController
@property (nonatomic , strong) NSString * countdown;//倒计时
@property (nonatomic , strong) NSString * goodsTitle;//商品名称
@property (nonatomic , strong) NSString * currentPrice;//目前出价
@property (nonatomic , strong) NSString * price;//直购价
@property (nonatomic , strong) NSString * platform;//
@property (nonatomic , strong) NSString * imageUrl;
@property (nonatomic , strong) NSString * incrementStr;//出价增额
@property (nonatomic , strong) NSString * goodId;//商品id
@property (nonatomic , strong) NSString * link;//商品地址
@end

NS_ASSUME_NONNULL_END
