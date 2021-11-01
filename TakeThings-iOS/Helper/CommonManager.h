//
//  CommonManager.h
//  TakeThings-iOS
//
//  Created by 赵祥 on 2021/9/1.
//  Copyright © 2021 GUIZM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonManager : NSObject


+ (UIViewController *)getCurrentViewController;

+ (CGFloat)getStatusBarHight;

@end

NS_ASSUME_NONNULL_END
