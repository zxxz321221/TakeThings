//
//  DeliveryInfoViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/19.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  sendViewDelegate <NSObject>
- (void)senViewBack:(NSInteger)num;
@end
@interface DeliveryInfoViewController : UIViewController
@property (nonatomic ,strong) id<sendViewDelegate>delegate;
@property (nonatomic , strong) NSArray * listArr;
@property (nonatomic , strong) NSArray * kdArray;
@end

NS_ASSUME_NONNULL_END
