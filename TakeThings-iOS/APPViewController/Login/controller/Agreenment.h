//
//  Agreenment.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/7/29.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN
@protocol  AgreenmentDelegate <NSObject>

- (void)confirmAgreenment;

@end
@interface Agreenment : UIView
@property (nonatomic , strong) id<AgreenmentDelegate>delegate;
+(instancetype)setAgreenment:(UIView *)view;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic , strong) NSString * htmlStr;
@property (nonatomic , strong) UILabel * titleL;

@property (nonatomic , assign) BOOL isRegister;
- (void)showAgView;
@end

NS_ASSUME_NONNULL_END
