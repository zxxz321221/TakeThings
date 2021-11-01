//
//  HaitaoDetailViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/18.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  HaitaoDetailDelegate <NSObject>

- (void)updataList;
@end
@interface HaitaoDetailViewController : UIViewController
@property (nonatomic, strong) id<HaitaoDetailDelegate>delegate;
@property (nonatomic , strong) NSString * haitaoId;
@end

NS_ASSUME_NONNULL_END
