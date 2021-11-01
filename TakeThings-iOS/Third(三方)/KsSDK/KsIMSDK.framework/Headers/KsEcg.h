//
//  KsEcg.h
//  KsIMSDK
//
//  Created by kst on 2019/8/29.
//  Copyright © 2019 wanglingxin. All rights reserved.
//
#import <Foundation/Foundation.h>
@class KsEcg;
@protocol KsEcg <NSObject>
@end

@interface KsEcg : NSObject

@property(nonatomic, copy) NSString *_goodsNo;
@property(nonatomic, copy)  NSString *_goodsName;
@property(nonatomic, copy) NSString *_goodsPrice;
@property(nonatomic, copy)  NSString *_goodsPhoto;
@property(nonatomic, copy)  NSString *_goodsLinks;
@property(nonatomic, copy)  NSDictionary *_nsattribute;


-(id)initWithName:(NSString *)goodsNo goodsName:(NSString *)goodsName goodsPrice:(NSString *)goodsPrice goodsPhoto:(NSString *)goodsPhoto goodsLinks:(NSString*)goodsLinks nsattribute:(NSDictionary*)nsattribute;

- (NSString*)goodsNo;

- (NSString*)goodsName;

- (NSString*)goodsPrice;

- (NSString*)goodsPhoto;

- (NSString*)goodsLinks;

- (NSDictionary*)nsattribute;


-(void)setGoodsNo:(NSString*)goodsNo;

-(void)setGoodsName:(NSString*)goodsName;

-(void)setGoodsPrice:(NSString*)goodsPrice;

-(void)setGoodsPhoto:(NSString*)goodsPhoto;

-(void)setGoodsLinks:(NSString*)goodsLinks;

-(void)setNsattribute:(NSDictionary*)attributes;


-(NSString *)getJSONString;

- (id)initWithDict:(NSDictionary *)aDict;


@end
