//
//  PrecelPayDetailViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/24.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  PrecelPayDelegate <NSObject>
- (void)loadList;
@end

@interface PrecelPayDetailViewController : UIViewController
@property (nonatomic, strong) id<PrecelPayDelegate>delegate;
@property (nonatomic , strong) NSDictionary * dataDic;
@end

NS_ASSUME_NONNULL_END
