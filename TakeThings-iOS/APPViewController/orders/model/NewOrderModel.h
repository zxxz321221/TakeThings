//
//  NewOrderModel.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/9.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewOrderModel : NSObject
@property(nonatomic,assign)BOOL isSelect;
@property (nonatomic , strong) NSString * advance_rate;
@property (nonatomic , strong) NSString * add_amount_all;
@property (nonatomic , strong) NSString * order_code;
@property (nonatomic , strong) NSString * status_name;
@property (nonatomic , strong) NSString * status_id;
@property (nonatomic , strong) NSString * goods_name;
@property (nonatomic , strong) NSString * goods_img;
@property (nonatomic , strong) NSString * bid_num;
@property (nonatomic , strong) NSString * over_price;
@property (nonatomic , strong) NSString * currency;
@property (nonatomic , strong) NSString * over_time_ch;
@property (nonatomic , strong) NSString * create_time;
@property (nonatomic , strong) NSString * bid_mode;
@property (nonatomic , strong) NSString * orderID;
@property (nonatomic , strong) NSString * bid_account;
@property (nonatomic , strong) NSString * w_signal;
@property (nonatomic , strong) NSString * price_user;
@property (nonatomic , strong) NSString * goods_url;
@end

NS_ASSUME_NONNULL_END
