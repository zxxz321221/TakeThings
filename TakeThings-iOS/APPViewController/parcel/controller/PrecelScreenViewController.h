//
//  PrecelScreenViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/31.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  PrecelScreenDelegate <NSObject>
- (void)screenTime:(NSInteger)time WithListIndex:(NSInteger)listIndex WithStatusIndex:(NSInteger)statusIndex;
@end
@interface PrecelScreenViewController : UIViewController
@property (nonatomic, strong) id<PrecelScreenDelegate>delegate;
@property (nonatomic , assign) NSInteger tap;
@property (nonatomic , assign) NSInteger timeP;
@property (nonatomic , assign) NSInteger statusP;
@end

NS_ASSUME_NONNULL_END
