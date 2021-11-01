//
//  ThreeOrderViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/7.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  ThreeOrderViewDelegate <NSObject>
- (void)confirmDelete;
- (void)cancelDelete;
@end
@interface ThreeOrderViewController : UIViewController
@property (nonatomic, strong) id<ThreeOrderViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
