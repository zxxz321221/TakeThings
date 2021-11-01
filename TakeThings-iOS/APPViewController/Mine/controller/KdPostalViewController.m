//
//  KdPostalViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/5.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "KdPostalViewController.h"
#import <WebKit/WebKit.h>
@interface KdPostalViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic , strong) WKWebView * wkWebView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation KdPostalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"快递动态";
    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.progressView];
}

- (WKWebView *)wkWebView{
    if (!_wkWebView) {
        
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight)];
        
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
        [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://yjcx.ems.com.cn/qps/yjcx"]]];
                                 
        // 给webview添加监听
        [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    }
    return _wkWebView;
}
- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
        _progressView.progressTintColor = [UIColor greenColor];
    }
    return _progressView;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqual:@"estimatedProgress"] && object == self.wkWebView) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:YES];
        if (self.wkWebView.estimatedProgress  >= 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:YES];
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)dealloc{
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.wkWebView setNavigationDelegate:nil];
    [self.wkWebView setUIDelegate:nil];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    self.kd_id = @"FT800600681TW";
    NSString *js = [NSString stringWithFormat:@"document.getElementById('textInfo').value = \"%@\";\n"
    "document.getElementById('buttonSub').click();",self.kd_id];
    [webView evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
    }];
}


@end
