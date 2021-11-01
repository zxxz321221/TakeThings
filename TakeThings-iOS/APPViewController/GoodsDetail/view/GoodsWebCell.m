//
//  GoodsWebCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/23.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "GoodsWebCell.h"
#import <WebKit/WebKit.h>

@interface GoodsWebCell()<WKNavigationDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIProgressView *progressView;
@end
static CGFloat staticheight = 0;
@implementation GoodsWebCell

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        UIView *superView = self.contentView;
//
////        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
////        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
////        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
////        [wkUController addUserScript:wkUScript];
////        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
////        wkWebConfig.userContentController = wkUController;
////        WKWebView *webView = [[WKWebView alloc] initWithFrame:superView.bounds configuration:wkWebConfig];
//
//
//        WKWebView *webView = [[WKWebView alloc] initWithFrame:superView.bounds];
//        webView.scrollView.scrollEnabled = NO;//禁用webView滑动
//        webView.scrollView.userInteractionEnabled = NO;
//        //自适应宽高，这句要加
//        webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        // webView.navigationDelegate = self;
//        _newsWebView = webView;
//        [superView addSubview:_newsWebView];
//        //监听webView.scrollView的contentSize属性
////        _wkWebView.allowsBackForwardNavigationGestures = YES;
//        [_newsWebView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
//
//
//    }
//    return self;
//}
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"contentSize"]) {
//        __weak typeof(self) weakSelf = self;
//        //执行js方法"document.body.offsetHeight" ，获取webview内容高度
//        [_newsWebView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//            CGFloat contentHeight = [result floatValue];
//            if (weakSelf.webHeightChangedCallback) {
//                weakSelf.webHeightChangedCallback(contentHeight);
//            }
//        }];
//    }
//}
//- (void)refreshWebView:(NSString *)url{
//    //    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    //    [self.newsWebView loadRequest:request];
//    NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";
//    [self.newsWebView loadHTMLString:[headerString stringByAppendingString:url] baseURL:nil];
//}
//- (void)dealloc
//{
//    [_newsWebView.scrollView removeObserver:self forKeyPath:@"contentSize"];
//}
+(CGFloat)cellHeight
{
    return staticheight;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.wkWebView];
    }
    return self;
}

-(WKWebView *)wkWebView{
    if (!_wkWebView) {
//        _wkWebView = [[WKWebView alloc] init];
//        _wkWebView.scrollView.delegate = self;
//        //以下代码适配大小
//        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
//
//        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
//        [wkUController addUserScript:wkUScript];
//
//        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
//        wkWebConfig.userContentController = wkUController;
//
//        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1) configuration:wkWebConfig];
//        _wkWebView.navigationDelegate = self;
        
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        wkWebConfig.userContentController = wkUController;
        wkWebConfig.userContentController = wkUController;
        wkWebConfig.userContentController = wkUController;
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1) configuration:wkWebConfig];
        _wkWebView.navigationDelegate = self;
        _wkWebView.userInteractionEnabled = YES;
        
        
        self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
        self.progressView.progressTintColor = [UIColor greenColor];
        [self.contentView addSubview:self.progressView];
        
        // 给webview添加监听
        [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    }
    return _wkWebView;
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
-(void)setHtmlString:(NSString *)htmlString{
//    _htmlString = htmlString;
//    NSString *html = [NSString stringWithFormat:@"<!DOCTYPE html> \n"
//                      "<html> \n"
//                      "<head> \n"
//                      "<meta charset=\"UTF-8\"> \n"
//                      "</head> \n"
//                      "<body>%@"
//                      "</body>"
//                      "<script type='text/javascript'>"
//                      "var head = document.head || document.getElementsByTagName('head')[0]; \n"
//                      "var script4 = document.createElement('div'); \n"
//                      "script4.id = \"ytWidget\"; \n"
//                      "script4.style.display = \"none\"; \n"
//                      "document.body.appendChild(script4); \n"
//                      "var script5 = document.createElement('script'); \n"
//                      "script5.src = \"https://translate.yandex.net/website-widget/v1/widget.js?widgetId=ytWidget&pageLang=auto&widgetTheme=light&autoMode=true\"; \n"
//                      "head.appendChild(script5); \n"
//                      "window.onload = function(){\n"
//                      "var $img = document.getElementsByTagName('img');\n"
//                      "for(var p in  $img){\n"
//                      " $img[p].style.width = '100%%';\n"
//                      "$img[p].style.height ='auto'\n"
//                      "}\n"
//                      "}"
//                      "</script>"
//                      "</html>", _htmlString];
    
    [self.wkWebView loadHTMLString:htmlString baseURL:nil];
    NSLog(@"%@",htmlString);
}


-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"加载完成");
     CGFloat contentHeight = webView.scrollView.contentSize.height;
    NSLog(@"高度 %f",contentHeight);
    CGRect webFrame = webView.frame;
    webFrame.size.height = contentHeight;
    webView.frame = webFrame;
    if (staticheight != contentHeight+1) {
        staticheight = contentHeight+1;
        if (staticheight > 0) {
            if (self.reloadBlock) {
                self.reloadBlock();
            }
        }
    }
//    __weak typeof(self)bself = self;
//    [webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id data, NSError * _Nullable error) {
//        CGFloat height = [data floatValue];
//        NSLog(@"%f",height); //ps:js可以是上面所写，也可以是document.body.scrollHeight;在WKWebView中前者offsetHeight获取自己加载的html片段，高度获取是相对准确的，但是若是加载的是原网站内容，用这个获取，会不准确，改用后者之后就可以正常显示，这个情况是我尝试了很多次方法才正常显示的
//        CGRect webFrame = webView.frame;
//        webFrame.size.height = height;
//        webView.frame = webFrame;
//        if (staticheight != height+1) {
//            staticheight = height+1;
//            if (staticheight > 0) {
//                if (bself.reloadBlock) {
//                    bself.reloadBlock();
//                }
//            }
//        }
//    }];
    
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{

        
        return self.wkWebView.scrollView.subviews.firstObject;
        
    
}
- (void)webView:(WKWebView*)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"开始加载");
}
- (void)webView:(WKWebView*)webView didFailProvisionalNavigation:(WKNavigation*)navigation withError:(NSError*)error{
    NSLog(@"内容开始返回");
}
@end
