//
//  BabyModel.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/28.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BabyModel : NSObject
@property(nonatomic,assign)BOOL isSelect;
@property (nonatomic , strong) NSString * w_object;
@property (nonatomic , strong) NSString * w_overtime;
@property (nonatomic , strong) NSString * w_imgsrc;
@property (nonatomic , strong) NSString * w_cc;
@property (nonatomic , strong) NSString * w_link;
@property (nonatomic , strong) NSString * numId;
@property (nonatomic , strong) NSString * w_jpnid;
@end

NS_ASSUME_NONNULL_END
