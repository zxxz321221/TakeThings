//
//  WKWebView+WKview.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/8/22.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (WKview)
-(NSArray *)getImageUrlByJS:(WKWebView *)wkWebView;
-(BOOL)showBigImage:(NSURLRequest *)request;
- (NSArray *)getImgUrlArray;
@end

NS_ASSUME_NONNULL_END
