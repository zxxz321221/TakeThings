//
//  ceshiViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/8/7.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "ceshiViewController.h"
#import <WebKit/WebKit.h>
@interface ceshiViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation ceshiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.wkWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight)];
    self.wkWebView.UIDelegate = self;
    self.wkWebView.navigationDelegate = self;
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/shaogood/login.php?L3NoYW9nb29kL21lbWJlci9jaGluYXBucl9pbmRleC5waHA=",[[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"]]]]];
    
    [self.view addSubview:self.wkWebView];
    
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
    self.progressView.progressTintColor = [UIColor greenColor];
    [self.view addSubview:self.progressView];
    
    // 给webview添加监听
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    // Do any additional setup after loading the view, typically from a nib.
    
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
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSDictionary * dic = @{@"mydayuser":@"dayed.hell@gmail.com",@"mydaypass":@"123456",@"act":@"pass_submit",@"url":@"L3NoYW9nb29kL21lbWJlci9jaGluYXBucl9pbmRleC5waHA=",@"isAppPost":@"1"};

    [self post:[NSString stringWithFormat:@"%@/shaogood/login.php?L3NoYW9nb29kL21lbWJlci9jaGluYXBucl9pbmRleC5waHA=",[[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"]] andData:dic andCallback:^(id JSON) {
        NSLog(@"%@",JSON);
    }];
    
}
-(void)post:(NSString *)url andData:(NSDictionary *)params andCallback:(void (^)(id JSON))callback{
    __block  AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",nil];
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (callback) {
            callback(responseObject);
            NSLog(@"请求成功");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(error.code == -1009) {
            if (callback) {
                callback(nil);
                NSLog(@"1009");
            }
        } else if(error.code == -1001) {
            //网络超时
            if (callback) {
                callback(nil);
                NSLog(@"1001");
            }
            
        } else {
            if (callback) {
                callback(nil);
            }
            NSLog(@"Error: %@", error);
        }
        
    }];
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
