//
//  GZMrequest.m
//  Chenglife
//
//  Created by 桂在明 on 2018/8/13.
//  Copyright © 2018年 桂在明. All rights reserved.
//

#import "GZMrequest.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "AFSecurityPolicy.h"
@implementation GZMrequest


+ (void)getWithURLString:(NSString *)urlString
              parameters:(id)parameters
                 success:(SuccessBlock)successBlock
                 failure:(FailureBlock)failureBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /**
//    [manager setSecurityPolicy:[self customSecurityPolicy]];
    //先导入证书，找到证书的路径
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"sdx" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    //AFSSLPinningModeNone 这个模式表示不做 SSL pinning，只跟浏览器一样在系统的信任机构列表里验证服务端返回的证书。若证书是信任机构签发的就会通过，若是自己服务器生成的证书，这里是不会通过的。
    //AFSSLPinningModeCertificate 这个模式表示用证书绑定方式验证证书，需要客户端保存有服务端的证书拷贝，这里验证分两步，第一步验证证书的域名/有效期等信息，第二步是对比服务端返回的证书跟客户端返回的是否一致。
    //AFSSLPinningModePublicKey 这个模式同样是用证书绑定方式验证，客户端要有服务端的证书拷贝，只是验证时只验证证书里的公钥，不验证证书的有效期等信息。只要公钥是正确的，就能保证通信不会被窃听，因为中间人没有私钥，无法解开通过公钥加密的数据。
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    if (certData) {
        securityPolicy.pinnedCertificates = @[certData];
    }
    **/
    
    
    /**
     *  可以接受的类型
     */
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    /**
     *  请求队列的最大并发数
     */
    //    manager.operationQueue.maxConcurrentOperationCount = 5;
    /**
     *  请求超时的时间
     */
    manager.requestSerializer.timeoutInterval = outline;
    
    NSMutableDictionary *dic = [parameters mutableCopy];
    [dic setObject:@"1" forKey:@"os"];
    [manager GET:urlString parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            successBlock(dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
            NSLog(@"网络异常 - T_T%@", error);
        }
    }];
}

+ (void)postWithURLString:(NSString *)urlString
               parameters:(id)parameters
                  success:(SuccessBlock)successBlock
                  failure:(FailureBlock)failureBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = outline;
    NSMutableDictionary *dic = [parameters mutableCopy];
    [dic setObject:@"1" forKey:@"os"];
    [manager POST:urlString parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            
//            NSDictionary * data = [Unity editDicNull:dic];
//            NSLog(@"afn%@",[Unity editDicNull:dic]);
            successBlock(dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
            NSLog(@"网络异常 - T_T%@", error);
        }
    }];
}

+ (void)postWithURLStr:(NSString *)urlString
               parameters:(id)parameters
                isjson:(BOOL)isJson
                  success:(SuccessBlock)successBlock
                  failure:(FailureBlock)failureBlock
{
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.json = isJson;
//    [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
//
////    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
////    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
////    NSLog(@"token=%@",token);
////    [manager.requestSerializer setValue:token forHTTPHeaderField:@"auth_token"];
//    manager.requestSerializer.timeoutInterval = outline;
//    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (successBlock) {
//            NSLog(@"---------------%@",[responseObject class]);
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//            successBlock(dic);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (failureBlock) {
//            [EasyLoadingView hidenLoading];
//            failureBlock(error);
//            NSLog(@"网络异常 - T_T%@", error);
//        }
//    }];
}
//请求验证码专用
+ (void)postWithURLVerification:(NSString *)urlString
            parameters:(id)parameters
                isjson:(BOOL)isJson
               success:(SuccessBlock)successBlock
               failure:(FailureBlock)failureBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.json = isJson;
    [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    //    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    //    NSLog(@"token=%@",token);
    //    [manager.requestSerializer setValue:token forHTTPHeaderField:@"auth_token"];
    manager.requestSerializer.timeoutInterval = outline;
    NSMutableDictionary *dic = [parameters mutableCopy];
    [dic setObject:@"1" forKey:@"os"];
    [manager POST:urlString parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            NSLog(@"返回类型%@",[responseObject class]);
            NSString * str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSDictionary * dic = [[NSDictionary alloc]init];
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            }else{
                dic = @{@"key":str};
            }
            successBlock(dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
            NSLog(@"网络异常 - T_T%@", error);
        }
    }];
}
+ (AFSecurityPolicy*)customSecurityPolicy{

    //证书校验1:

    //        _securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];

    //证书校验2:

    // /先导入证书

    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"sdx" ofType:@"cer"];//证书的路径

    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    

    // AFSSLPinningModeCertificate 使用证书验证模式

    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:[[NSSet alloc] initWithObjects:certData, nil]];

    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO

    // 如果是需要验证自建证书，需要设置为YES

    securityPolicy.allowInvalidCertificates = YES;

    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。

    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。

    //如置为NO，建议自己添加对应域名的校验逻辑。

    securityPolicy.validatesDomainName = NO;

    return securityPolicy;
    
}
@end
