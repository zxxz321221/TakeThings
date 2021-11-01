//
//  UsLeftViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/7/26.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  UsLeftViewDelegate <NSObject>

- (void)screenBtnIndex:(NSInteger)btnIndex WithMin:(NSString *)placemin WithMax:(NSString *)placemax WithIndex:(NSInteger )index;
@end
@interface UsLeftViewController : UIViewController
@property (nonatomic, strong) id<UsLeftViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
