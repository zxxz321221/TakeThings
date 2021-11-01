//
//  InfomationThreeViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/7/19.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  InfoThreeDelegate <NSObject>

-(void)cellSelect:(NSDictionary *)dict;

@end
NS_ASSUME_NONNULL_BEGIN

@interface InfomationThreeViewController : UIViewController
@property (nonatomic, strong) id<InfoThreeDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
