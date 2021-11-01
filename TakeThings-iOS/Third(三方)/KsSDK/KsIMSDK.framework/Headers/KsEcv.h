//
//  KsEcv.h
//  KsIMSDK
//
//  Created by kst on 2019/8/29.
//  Copyright © 2019 wanglingxin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KsEcv;
@protocol KsEcv <NSObject>
@end

@interface KsEcv : NSObject

@property(nonatomic, copy) NSString *_vipNo;
@property(nonatomic, copy)  NSString *_vipName;
@property(nonatomic, copy) NSString *_regTime;
@property(nonatomic, copy)  NSString *_lastLoginTime;
@property(nonatomic, copy)  NSString *_gender;
@property(nonatomic, copy)  NSString *_birthday;
@property(nonatomic, copy)  NSString *_phone;
@property(nonatomic, copy) NSString *_address;

- (id)initWithName:(NSString *)vipNo vipName:(NSString *)vipName regTime:(NSString *)regTime lastLoginTime:(NSString *)lastLoginTime gender:(NSString *)gender birthday:(NSString *)birthday phone:(NSString *)phone address:(NSString *)address;

- (NSString*)vipNo;

- (NSString*)vipName;

- (NSString*)regTime;

- (NSString*)lastLoginTime;

- (NSString*)gender;

- (NSString*)birthday;

- (NSString*)phone;

- (NSString*)address;

-(void)setVipNo:(NSString*)vipNo;

-(void)setVipName:(NSString*)vipName;

-(void)setRegTime:(NSString*)regTime;

-(void)setLastLoginTime:(NSString*)lastLoginTime;

-(void)setGender:(NSString*)gender;

-(void)setBirthday:(NSString*)birthday;

-(void)setPhone:(NSString*)phone;

-(void)setAddress:(NSString*)address;

-(NSString *)getJSONString;

- (id)initWithDict:(NSDictionary *)aDict;

@end
