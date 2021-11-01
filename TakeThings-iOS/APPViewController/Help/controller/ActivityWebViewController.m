//
//  ActivityWebViewController.m
//  GlobalBuyer
//
//  Created by 薛铭 on 2017/11/14.
//  Copyright © 2017年 赵阳. All rights reserved.
//

#import "ActivityWebViewController.h"
#import <WebKit/WebKit.h>
@interface ActivityWebViewController ()

@property (nonatomic , strong) WKWebView * webView;

@end

@implementation ActivityWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self deleteWebCache];
    self.title = @"在线客服";
    [self createUI];
    [self loadHref];
}
- (void)deleteWebCache {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        NSSet *websiteDataTypes =[NSSet setWithArray:@[
                              
                                                       WKWebsiteDataTypeDiskCache,
                                                       //WKWebsiteDataTypeOfflineWebApplicationCache,
                                                       WKWebsiteDataTypeMemoryCache,
                                                       //WKWebsiteDataTypeLocalStorage,
                                                       //WKWebsiteDataTypeCookies,
                                                       //WKWebsiteDataTypeSessionStorage,
                                                       //WKWebsiteDataTypeIndexedDBDatabases,
                                                       //WKWebsiteDataTypeWebSQLDatabases
                                                       ]];
        //// All kinds of data
        //NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        //// Date from
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        //// Execute
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            NSLog(@"缓存清理成功");
        }];
    } else {
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
        NSLog(@"%@,%@",cookiesFolderPath,errors);
    }
}
- (void)createUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight)];
    [self.view addSubview:self.webView];
    
}

- (void)loadHref
{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.href]];
    NSLog(@"%@",request);
    [self.webView loadRequest:request];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
