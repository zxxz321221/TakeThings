//
//  DetailViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/24.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
@property (nonatomic , strong) NSString * item;//商品id
@property (nonatomic , strong) NSString * platform;//商品来源 （易贝 雅虎等）
@end

NS_ASSUME_NONNULL_END
