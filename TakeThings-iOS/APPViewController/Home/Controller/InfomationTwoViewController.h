//
//  InfomationTwoViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/7/19.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  InfoTwoDelegate <NSObject>

-(void)cellSelect:(NSDictionary *)dict;

@end
NS_ASSUME_NONNULL_BEGIN

@interface InfomationTwoViewController : UIViewController
@property (nonatomic, strong) id<InfoTwoDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
