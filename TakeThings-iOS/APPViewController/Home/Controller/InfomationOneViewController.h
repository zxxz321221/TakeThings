//
//  InfomationOneViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/7/19.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@protocol  InfoOneDelegate <NSObject>

-(void)cellSelect:(NSDictionary *)dict;

@end


@interface InfomationOneViewController : UIViewController
@property (nonatomic, strong) id<InfoOneDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
