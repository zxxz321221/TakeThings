//
//  HaitaoSendModel.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/3/9.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HaitaoSendModel : NSObject
@property(nonatomic,assign)BOOL isSelect;
@property (nonatomic , strong) NSString * order_code;//编号
@property (nonatomic , strong) NSString * order_bid_status_id;//状态
@property (nonatomic , strong) NSString * goods_name;
@property (nonatomic , strong) NSString * goods_num;
@property (nonatomic , strong) NSString * goods_price;//得标价
@property (nonatomic , strong) NSString * exchange_rate;//费率
@property (nonatomic , strong) NSString * currency;
@property (nonatomic , strong) NSString * create_time;
@property (nonatomic , strong) NSString * price_true;
@property (nonatomic , strong) NSString * source_url;
@property (nonatomic , strong) NSString * num_id;

@end

NS_ASSUME_NONNULL_END
