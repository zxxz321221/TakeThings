//
//  SellerModel.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/28.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SellerModel : NSObject
@property(nonatomic,assign)BOOL isSelect;
@property (nonatomic , strong) NSString * numId;
@property (nonatomic , strong) NSString * w_saler;
@property (nonatomic , strong) NSString * w_cc;
@end

NS_ASSUME_NONNULL_END
