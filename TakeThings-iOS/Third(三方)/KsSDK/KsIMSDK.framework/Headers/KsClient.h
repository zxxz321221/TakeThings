//
//  KsClient.h
//  KsIMSDK
//
//  Created by chenshengji on 16/9/24.
//  Copyright © 2016年 chenshengji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KsEcv.h"
#import "KsEcg.h"
#import "KsResponse.h"
typedef void(^KsCallback)(KsResponse *response);
@interface KsClient : NSObject

+ (instancetype)sharedInstance;

-(void)setInSite;
-(void)setOutSite;
-(NSInteger)getHostType;
-(void)getAppKeysWithCompId:(NSString *)compId response:(KsCallback)response;
- (void)initSdk:(NSString *)appKey compId:(NSString *)compId response:(KsCallback)response;
- (void)openSessionWithAppKey:(NSString *)appKey;
- (void)openConversation;
- (void)closeSession;
- (BOOL)isOpen;
- (void)bindVip:(KsEcv *)ecv response:(KsCallback)response;
- (void)goodsTrack:(KsEcv *)ecv ksEcg:(KsEcg *)ecg response:(KsCallback)response;
- (void)goodsConsult:(KsEcv *)ecv ksEcg:(KsEcg *)ecg response:(KsCallback)response;

- (void)pushChatViewOnViewController:(UIViewController *)viewController;
- (void)popChatViewController;
@end
