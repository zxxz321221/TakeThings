//
//  HelpDetailViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/7/2.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelpDetailViewController : UIViewController
@property (nonatomic , strong) NSString * htmlStr;
@property (nonatomic , strong) NSString * flow;
@property (nonatomic , strong) NSString * navTitle;
@property (nonatomic , assign) NSInteger type;
@end

NS_ASSUME_NONNULL_END
