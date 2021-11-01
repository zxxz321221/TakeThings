//
//  TIDCardCaptureViewController.h
//  FBYIDCardRecognition-iOS
//
//  Created by 范保莹 on 2018/1/5.
//  Copyright © 2018年 FBYIDCardRecognition-iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IDInfo;
@protocol  TIDCardDelegate <NSObject>

- (void)backIDInfo:(IDInfo *)idInfo WithImg:(UIImage *)img;

@end
@interface TIDCardCaptureViewController : UIViewController
@property (nonatomic, strong) id<TIDCardDelegate>delegate;
@end
