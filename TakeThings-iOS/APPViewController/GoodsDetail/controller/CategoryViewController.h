//
//  CategoryViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/9/9.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  CategoryDelegate <NSObject>

- (void)categoryDic:(NSDictionary *)dic;
@end
@interface CategoryViewController : UIViewController
@property (nonatomic, strong) id<CategoryDelegate>delegate;
@property (nonatomic , strong) NSString * platform;
@end

NS_ASSUME_NONNULL_END
