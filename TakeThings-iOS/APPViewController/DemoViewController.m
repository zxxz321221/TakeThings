//
//  DemoViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/4.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "DemoViewController.h"
#import <WebKit/WebKit.h>

@interface DemoViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic , strong) WKWebView * wkWebView;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试快递查询";
    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.progressView];
}

- (WKWebView *)wkWebView{
    if (!_wkWebView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        NSString *str = @"var translateDiv = document.createElement('div');\n"
        "translateDiv.id = \"ytWidget\";\n"
        "translateDiv.style = \"display:none;height:auto;\";\n"
        "document.body.appendChild(translateDiv);\n"
        "var translateScript = document.createElement(\"script\");\n"
        "translateScript.src = \"https://translate.yandex.net/website-widget/v1/widget.js?widgetId=ytWidget&pageLang=auto&widgetTheme=light&autoMode=true\";\n"
        "document.body.appendChild(translateScript);\n";
        //注入时机是在webview加载状态WKUserScriptInjectionTimeAtDocumentStart、WKUserScriptInjectionTimeAtDocumentEnd
        WKUserScript *userScript = [[WKUserScript alloc] initWithSource:str injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
           //关键代码，把ZBPlus-iOS.txt读取的内容字符注入到js
        [configuration.userContentController addUserScript:userScript];
           
               
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight) configuration:configuration];
        
        
        
//        _wkWebView= [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight)];
        
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
        self.kd_id = @"CI175276815JP";//测试用id
        [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://trackings.post.japanpost.jp/services/sp/srv/search/direct?reqCodeNo=%@&locale=ja",self.kd_id]]]];
                                 
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
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
//    NSString *js = @"var translateDiv = document.createElement('div');\n"
//                    "translateDiv.id = \"ytWidget\";\n"
//                    "translateDiv.style = \"display:none;height:auto;\";\n"
//                    "document.body.appendChild(translateDiv);\n"
//                    "var translateScript = document.createElement(\"script\");\n"
//                    "translateScript.src = \"https://translate.yandex.net/website-widget/v1/widget.js?widgetId=ytWidget&pageLang=auto&widgetTheme=light&autoMode=true\";\n"
//                    "document.body.appendChild(translateScript);\n";
//    [webView evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
//        NSLog(@"---%@,+++%@",response,error);
//    }];
}
@end
