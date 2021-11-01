//
//  IDCardCaptureViewController.h
//  FBYIDCardRecognition-iOS
//
//  Created by 范保莹 on 2017/12/29.
//  Copyright © 2017年 FBYIDCardRecognition-iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IDInfo;
@protocol  IDCardCaptureDelegate <NSObject>

- (void)backIDCardInfo:(IDInfo *)idInfo WithImg:(UIImage *)img;

@end
@interface IDCardCaptureViewController : UIViewController
@property (nonatomic, strong) id<IDCardCaptureDelegate>delegate;
@end
