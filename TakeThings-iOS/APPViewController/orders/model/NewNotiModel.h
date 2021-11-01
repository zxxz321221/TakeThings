//
//  NewNotiModel.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/9.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewNotiModel : NSObject
@property(nonatomic,assign)BOOL isSelect;
@property (nonatomic , strong) NSString * order_code;//id
@property (nonatomic , strong) NSString * bid_num;//数量
@property (nonatomic , strong) NSString * goods_name;
@property (nonatomic , strong) NSString * goods_url;
@property (nonatomic , strong) NSString * over_price;//得标价
@property (nonatomic , strong) NSString * currency;//币种
@property (nonatomic , strong) NSString * source;
@property (nonatomic , strong) NSString * img;
@property (nonatomic , strong) NSString * advance_rate;
@property (nonatomic , strong) NSString * add_amount_all;
@property (nonatomic , strong) NSString * over_time_ch;
@property (nonatomic , strong) NSString * bid_mode;
@property (nonatomic , strong) NSString * bid_account;
@property (nonatomic , strong) NSString * w_signal;
@property (nonatomic , strong) NSString * price_user;
@property (nonatomic , strong) NSString * warehouse_name;
@property (nonatomic , strong) NSString * num_id;
@property (nonatomic , strong) NSString * auction_id;
@end

NS_ASSUME_NONNULL_END
