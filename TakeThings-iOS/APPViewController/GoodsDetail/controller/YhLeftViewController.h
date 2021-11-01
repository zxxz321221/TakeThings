//
//  YhLeftViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/9/5.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  YhLeftViewDelegate <NSObject>

- (void)configYhLeftRadio:(NSString *)radio WithMinPlace:(NSString *)minPlace WithMaxPlace:(NSString *)maxPlace WithSellerId:(NSString *)sellerId WithClassId:(NSString *)classId WithIndex:(NSInteger)index WithKeyWord:(NSString *)keyWord WithClassName:(NSString *)className WithLanguage:(NSString *)language;
@end
@interface YhLeftViewController : UIViewController
@property (nonatomic, strong) id<YhLeftViewDelegate>delegate;
@property (nonatomic , strong) NSArray * tjArr;
@property (nonatomic , strong) NSString * platForm;
@property (nonatomic , strong) NSString * sellerStr;
@property (nonatomic , strong) NSString * wordStr;
@property (nonatomic , strong) NSString * categoryStr;
@property (nonatomic , strong) NSString * categoryID;
@property (nonatomic , strong) NSString * minStr;
@property (nonatomic , strong) NSString * maxStr;

@property (nonatomic , strong) NSString * sellerA;
@property (nonatomic , strong) NSString * wordA;
@property (nonatomic , strong) NSString * categoryA;
@property (nonatomic , strong) NSString * categoryB;

@property (nonatomic , strong) NSString * local;
@property (nonatomic , strong) NSString * localA;
@end

NS_ASSUME_NONNULL_END
