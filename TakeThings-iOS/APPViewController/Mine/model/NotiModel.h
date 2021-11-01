//
//  NotiModel.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/14.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotiModel : NSObject
@property(nonatomic,assign)BOOL isSelect;
@property (nonatomic , strong) NSString * numId;
@property (nonatomic , strong) NSString * w_lsh;
@property (nonatomic , strong) NSString * w_jpnid;
@property (nonatomic , strong) NSString * w_kgs;
@property (nonatomic , strong) NSString * w_imgsrc;
@property (nonatomic , strong) NSString * w_object;
@property (nonatomic , strong) NSString * w_tbsl;
@property (nonatomic , strong) NSString * w_cc;
@property (nonatomic , strong) NSString * dhsj;
@property (nonatomic , strong) NSString * w_total_tw;
@property (nonatomic , strong) NSString * w_jbj_jp;
@property (nonatomic , strong) NSString * w_link;
@property (nonatomic , strong) NSString * w_receive_place;

@end

NS_ASSUME_NONNULL_END
