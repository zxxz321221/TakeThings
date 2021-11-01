//
//  GZMrequest.h
//  Chenglife
//
//  Created by 桂在明 on 2018/8/13.
//  Copyright © 2018年 桂在明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

typedef void (^SuccessBlock)(NSDictionary *data);
typedef void (^FailureBlock)(NSError *error);

@interface GZMrequest : NSObject

@property (nonatomic, copy) SuccessBlock successBlock;
@property (nonatomic, copy) FailureBlock failureBlock;

/**
 *  发送get请求
 *
 *  @param urlString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param successBlock    请求成功的回调
 *  @param failureBlock    请求失败的回调
 */
+ (void)getWithURLString:(NSString *)urlString
              parameters:(id)parameters
                 success:(SuccessBlock)successBlock
                 failure:(FailureBlock)failureBlock;

/**
 *  发送post请求
 *
 *  @param urlString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param successBlock    请求成功的回调
 *  @param failureBlock    请求失败的回调
 */
+ (void)postWithURLString:(NSString *)urlString
               parameters:(id)parameters
                  success:(SuccessBlock)successBlock
                  failure:(FailureBlock)failureBlock;

/**
 *  发送post请求
 *
 *  @param urlString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param successBlock    请求成功的回调
 *  @param failureBlock    请求失败的回调
 */
+ (void)postWithURLStr:(NSString *)urlString
            parameters:(id)parameters
                isjson:(BOOL)isJson
               success:(SuccessBlock)successBlock
               failure:(FailureBlock)failureBlock;

//请求验证码专用
+ (void)postWithURLVerification:(NSString *)Verification
                     parameters:(id)parameters
                         isjson:(BOOL)isJson
                        success:(SuccessBlock)successBlock
                        failure:(FailureBlock)failureBlock;
@end
