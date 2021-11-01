//
//  KsViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/10/25.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "KsViewController.h"
#import <KsIMSDK/KsIMSDK.h>
@interface KsViewController ()
@property(nonatomic, weak) NSString *appKey;
@property(nonatomic,weak) NSString *compId;
@end

@implementation KsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSdk];

    
    
}
-(void)initSdk
{
    //    [self setAppKey];
    _appKey = @"8OWC0dWkDrQ76wHEwIUbWSempcdwjV12";
    _compId =@"851095";
    //客服sdk初始化
    [[KsClient sharedInstance]initSdk:_appKey compId:_compId response:^(KsResponse *response) {
        NSString *status = response.status;
        if([@"success" isEqualToString:status]){
            NSLog(@"成功111");
            [[KsClient sharedInstance] openConversation];
            
            [[KsClient sharedInstance] pushChatViewOnViewController:self];
        }else{
            NSLog(@"失败222");
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
