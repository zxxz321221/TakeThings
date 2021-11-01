//
//  PersonViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/28.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  personViewDelegate <NSObject>

- (void)exit;
@end
NS_ASSUME_NONNULL_BEGIN

@interface PersonViewController : UIViewController
@property (nonatomic, strong) id<personViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
