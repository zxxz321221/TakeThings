//
//  KsResponse.h
//  KsIMSDK
//
//  Created by kst on 2019/8/29.
//  Copyright © 2019 wanglingxin. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface KsResponse : NSObject

@property(nonatomic,assign) NSInteger code;
@property(nonatomic, copy) NSString *status;
@property(nonatomic, copy) NSString *msg;
@property(nonatomic, copy) NSString *result;
@property(nonatomic, copy) NSArray *resultList;
@property(nonatomic, copy) NSError *error;
@end
