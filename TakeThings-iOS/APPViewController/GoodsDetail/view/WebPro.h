//
//  WebPro.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/8/13.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebPro : UIView
//进度条颜色
@property (nonatomic,strong) UIColor  *lineColor;

//开始加载
-(void)startLoadingAnimation;

//结束加载
-(void)endLoadingAnimation;
@end

NS_ASSUME_NONNULL_END
