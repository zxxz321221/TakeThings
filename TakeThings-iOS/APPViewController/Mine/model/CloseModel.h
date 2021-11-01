//
//  CloseModel.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/26.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CloseModel : NSObject
@property(nonatomic,assign)BOOL isSelect;
@property (nonatomic , strong) NSString * w_lsh;
@property (nonatomic , strong) NSString * w_imgsrc;
@property (nonatomic , strong) NSString * w_object;
@property (nonatomic , strong) NSString * w_maxpay_jp;
@property (nonatomic , strong) NSString * w_total_tw;
@property (nonatomic , strong) NSString * w_ordertime;
@property (nonatomic , strong) NSString * w_tbsl;
@property (nonatomic , strong) NSString * w_overtime;
@property (nonatomic , strong) NSString * w_cc;
@property (nonatomic , strong) NSString * numId;
@end

NS_ASSUME_NONNULL_END
