//
//  MsgModel.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/11/11.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MsgModel : NSObject
@property (nonatomic, copy) NSString * title;
@property (nonatomic, assign) NSInteger app_jump_type;
@property (nonatomic, copy) NSString * app_jump_url;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, assign) NSInteger msg_id;
@property (nonatomic, copy) NSString * image;
@property (nonatomic, assign) NSInteger image_type;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, copy) NSString * timing;
@property (nonatomic, copy) NSString * web_jump_url;
@property (nonatomic, assign) NSInteger web_jump_type;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger trigger_type;
@property (nonatomic, copy) NSString * summary;
@end

NS_ASSUME_NONNULL_END
