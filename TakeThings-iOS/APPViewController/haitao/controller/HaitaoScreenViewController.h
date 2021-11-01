//
//  HaitaoScreenViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/18.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  HaitaoScreenDelegate <NSObject>
- (void)screenTime:(NSInteger)time WithListIndex:(NSInteger)index WithStatusIndex:(NSInteger)status;
@end
@interface HaitaoScreenViewController : UIViewController
@property (nonatomic, strong) id<HaitaoScreenDelegate>delegate;
@property (nonatomic , assign) NSInteger tap;
@property (nonatomic , assign) NSInteger timeP;
@property (nonatomic , assign) NSInteger statusP;
@end

NS_ASSUME_NONNULL_END
