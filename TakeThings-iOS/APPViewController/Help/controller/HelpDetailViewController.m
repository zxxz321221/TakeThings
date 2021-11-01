

//
//  HelpDetailViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/7/2.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "HelpDetailViewController.h"
#import <WebKit/WebKit.h>
@interface HelpDetailViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic , strong) WKWebView * webView;
@end

@implementation HelpDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.webView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = self.navTitle;
}
- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight)];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        if (self.type == 99) {
            [_webView loadHTMLString:self.htmlStr baseURL:nil];
        }else{
            if ([self.flow isEqualToString:@"0"]) {
                NSString * string;
                string=[self.htmlStr stringByReplacingOccurrencesOfString:@"src=\""withString:@"src=\"http://shaogood.com"];
                [_webView loadHTMLString:string baseURL:nil];
            }else{
                NSString * str = [self editString:self.htmlStr];
                NSString * string = @"";
                string = [NSString stringWithFormat:@"<div align=\"center\">\r\n\t%@<br />\r\n</div>",str];
                [_webView loadHTMLString:string baseURL:nil];
            }
        }
        
    }
    return _webView;
}
- (NSString *)editString:(NSString *)str{
    NSString * str1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"];
    NSArray *array = [str componentsSeparatedByString:@";"];
    NSString * str2 = @"";
    for (int i=0; i<array.count; i++) {
        NSString * string = @"";
        if ([array[i] rangeOfString:@"||"].location == NSNotFound) {
            NSArray *array1 = [array[i] componentsSeparatedByString:@"|"];
            string = [NSString stringWithFormat:@"<h1>%@</h1><h3>%@</h3><img src=\"%@%@\" alt=\"\" />",array1[0],array1[1],str1,array1[2]];
            str2 = [str2 stringByAppendingFormat:@"%@",string];
        } else {
            NSArray *array1 = [array[i] componentsSeparatedByString:@"||"];
            string = [NSString stringWithFormat:@"<h1>%@</h1><h3></h3><img src=\"%@%@\" alt=\"\" />",array1[0],str1,array1[1]];
            str2 = [str2 stringByAppendingFormat:@"%@",string];
        }
    }
    return str2;
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    //修改字体大小 300%
//    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'" completionHandler:nil];
    
    //修改字体颜色  #9098b8
//    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#0078f0'" completionHandler:nil];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
