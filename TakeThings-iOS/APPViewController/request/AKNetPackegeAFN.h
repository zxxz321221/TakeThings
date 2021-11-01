//
//  AKNetPackegeAFN.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/9/29.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HttpSuccess)(id json);
typedef void (^HttpErro)(NSError* error);


@interface AKNetPackegeAFN : NSObject

+(instancetype)shareHttpManager;
- (void)netWorkType:(NSInteger)netWorkType Signature:(NSString *)signature API:(NSString *)api Parameters:(NSDictionary *)parameters Success:(HttpSuccess)sucess Fail:(HttpErro)fail;

@end


