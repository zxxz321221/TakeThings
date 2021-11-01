//
//  PersonViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/28.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "PersonViewController.h"
#import "InfoViewController.h"
#import "SecurityViewController.h"
#import "AboutViewController.h"
#import "GZMShareView.h"
#import "WXApi.h"
#import "UIViewController+YINNav.h"
@interface PersonViewController ()<UIAlertViewDelegate,GZMShareViewDelegate>
{
    UILabel * dianL;
    NSString * off;  //0关闭 1开启
    NSString * message;
    UILabel * newVersion;
    BOOL isUpdate;
    NSString * app_Version;//当前版本
}
@property (nonatomic , strong) UIButton * exitBtn;
@property (nonatomic , strong) AroundAnimation * aAnimation;
@property (nonatomic , strong) GZMShareView * gView;
@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // app版本
    NSDictionary * infoDictionary = [[NSBundle mainBundle] infoDictionary];
    app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    NSLog(@"当前版本 ==%@",app_Version);
    isUpdate = NO;
    self.y_navLineHidden = YES;
    [self.navigationItem setTitle:@"个人中心"];
    [self creareUI];
    [self.view addSubview:self.exitBtn];
//    [self versionThan];
    //版本请求
    [self requestVersion];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [Unity getColor:@"#f0f0f0"];
}
- (void)creareUI{
    NSArray * arr = @[@"个人信息",@"账号安全",@"短信提醒",@"分享APP",@"版本信息"];//,@"分享APP"
    for (int i=0; i<arr.count; i++) {
        UIButton * btn = [Unity buttonAddsuperview_superView:self.view _subViewFrame:CGRectMake(0, ((i+1)*1)+(i)*[Unity countcoordinatesH:50], SCREEN_WIDTH, [Unity countcoordinatesH:50]) _tag:self _action:@selector(btnClick:) _string:@"" _imageName:nil];
        btn.tag = i+1000;
        btn.backgroundColor = [UIColor whiteColor];
        UILabel * label = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20]) _string:arr[i] _lableFont:[UIFont systemFontOfSize:15] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
        if (i != 2) {
            UIImageView * goImg = [Unity imageviewAddsuperview_superView:btn _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:15], [Unity countcoordinatesH:20], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10]) _imageName:@"go" _backgroundColor:nil];
            goImg.userInteractionEnabled=YES;
        }else{
            UISwitch * swi = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:50], [Unity countcoordinatesH:15], [Unity countcoordinatesW:40], [Unity countcoordinatesH:20])];
            [swi addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventValueChanged];
            [btn addSubview:swi];
//            swi.on = YES;
            NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
            if ([userInfo[@"w_message"] isEqualToString:@"1"]) {
                swi.on=YES;
            }
        }
        if (i == 4) {
            newVersion = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake(SCREEN_WIDTH-5-[Unity countcoordinatesW:125], [Unity countcoordinatesH:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20]) _string:@"发现新版本，如不更新可能部分功能无法正常使用。" _lableFont:[UIFont systemFontOfSize:15] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentRight];
            newVersion.hidden = YES;
            dianL = [[UILabel alloc]initWithFrame:CGRectMake(newVersion.right+2, [Unity countcoordinatesH:20], 5, 5)];
            dianL.backgroundColor = [UIColor redColor];
            dianL.layer.cornerRadius =2.5;
            dianL.layer.masksToBounds = YES;
            dianL.layer.hidden = YES;
            [btn addSubview:dianL];
        }
    }
}
- (UIButton *)exitBtn{
    if (!_exitBtn) {
        _exitBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:260]+5, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        _exitBtn.backgroundColor = [UIColor whiteColor];
        [_exitBtn setTitle:@"退出当前登录" forState:UIControlStateNormal];
        [_exitBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        [_exitBtn addTarget:self action:@selector(exitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitBtn;
}
-(void)changeColor:(UISwitch *)swi{
    if(swi.isOn){//开 （默认关）
        off = @"1";
//        NSLog(@"kai");
    }else{
        off = @"0";
//        NSLog(@"guan");
    }
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"customer":userInfo[@"member_id"],@"message":off};
    [self.aAnimation startAround];
    [GZMrequest postWithURLString:[GZMUrl get_message_url] parameters:dic success:^(NSDictionary *data) {
        [self.aAnimation stopAround];
//        NSLog(@"%@",data);
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            NSMutableDictionary * muDic = [NSMutableDictionary new];
            muDic = [userInfo mutableCopy];
            [muDic setObject:off forKey:@"w_message"];
            [[NSUserDefaults standardUserDefaults]setObject:muDic forKey:@"userInfo"];
        }else{
            if (swi.isOn) {
                swi.on = NO;
            }else{
                swi.on = YES;
            }
            [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [self.aAnimation stopAround];
        if (swi.isOn) {
            swi.on = NO;
        }else{
            swi.on = YES;
        }
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)btnClick:(UIButton *)btn{
    if (btn.tag == 1000) {//个人信息
        InfoViewController * ivc = [[InfoViewController alloc]init];
        ivc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ivc animated:YES];
    }else if (btn.tag==1001){//账号安全
        SecurityViewController * svc = [[SecurityViewController alloc]init];
        svc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:svc animated:YES];
    }else if (btn.tag == 1003){//分享aAPP
        [self.gView showShareView];
    }
    else if (btn.tag == 1004){//版本信息
        if (isUpdate) {
            [self showAlertTitle:@"发现新版本，如不更新可能部分功能无法正常使用。" Message:message];
        }else{
            AboutViewController * avc = [[AboutViewController alloc]init];
            avc.app_version = app_Version;
            [self.navigationController pushViewController:avc animated:YES];
        }
    }
}
- (void)exitClick{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    [self.aAnimation startAround];
    NSDictionary *params = @{@"customer":userInfo[@"member_id"]};
    [GZMrequest postWithURLString:[GZMUrl get_userCancel_url]parameters:params success:^(NSDictionary *data) {
        [self.aAnimation stopAround];
        NSLog(@"会员注销%@",data);
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userInfo"];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"login"];
            [self.delegate exit];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [self.aAnimation stopAround];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (AroundAnimation *)aAnimation{
    if (!_aAnimation) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _aAnimation = [AroundAnimation AroundAnimationViewSetView:window];
    }
    return _aAnimation;
}
- (void)requestVersion{
    NSLog(@"%@",IOS_APPID);
    NSString *url = [[NSString alloc]initWithFormat:@"https://itunes.apple.com/cn/lookup?id=%@",IOS_APPID];//后数字修改成自己项目的APPID
    [self Postpath:url];
}
//获取App Store上应用版本
-(void)Postpath:(NSString *)path{
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];
    
    NSOperationQueue *queue = [NSOperationQueue new];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        
        NSMutableDictionary *receiveStatusDic=[[NSMutableDictionary alloc]init];
        
        if (data) {
            NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            //            NSLog(@"%@",receiveDic);
            if ([[receiveDic valueForKey:@"resultCount"]intValue]>0) {
                
                [receiveStatusDic setValue:@"1"forKey:@"status"];
                
                [receiveStatusDic setValue:[[[receiveDic valueForKey:@"results"]objectAtIndex:0]valueForKey:@"version"] forKey:@"version"];
                [receiveStatusDic setValue:[[[receiveDic valueForKey:@"results"]objectAtIndex:0]valueForKey:@"releaseNotes"] forKey:@"releaseNotes"];
            }else{
                
                [receiveStatusDic setValue:@"-1"forKey:@"status"];
                
            }
            
        }else{
            
            [receiveStatusDic setValue:@"-1"forKey:@"status"];
            
        }
        [self performSelectorOnMainThread:@selector(receiveData:)withObject:receiveStatusDic waitUntilDone:NO];
        
    }];
}
-(void)receiveData:(id)sender{
    NSLog(@"%@",[sender objectForKey:@"version"]);
    NSLog(@"%@",[sender objectForKey:@"releaseNotes"]);
    NSLog(@"%@",[sender objectForKey:@"status"]);
    if ([[sender objectForKey:@"status"] isEqualToString:@"1"]) {
        
        
        if (sender[@"version"] != nil) {
            NSArray * lineArray = [sender[@"version"] componentsSeparatedByString:@"."];
            NSArray * array = [app_Version componentsSeparatedByString:@"."];
            if ([lineArray[0] intValue]>[array[0] intValue]) {
                //有新版本
//                [self showAlertTitle:@"发现新版本" Message:sender[@"releaseNotes"]];
                isUpdate = YES;
                return;
            }else if ([lineArray[0] intValue]==[array[0] intValue]){
                if ([lineArray[1] intValue]>[array[1] intValue]) {
                    //有新版本
//                    [self showAlertTitle:@"发现新版本" Message:sender[@"releaseNotes"]];
                    isUpdate = YES;
                    return;
                }else if ([lineArray[1] intValue]==[array[1] intValue]){
                    if ([lineArray[2] intValue]>[array[2] intValue]) {
                        //有新版本
//                        [self showAlertTitle:@"发现新版本" Message:sender[@"releaseNotes"]];
                        isUpdate = YES;
                    }else{
                        isUpdate = NO;
                    }
                }
            }
        }
    }
    if (isUpdate) {
        message = sender[@"releaseNotes"];
        dianL.hidden = NO;
        newVersion.hidden = NO;
    }
}

- (void)showAlertTitle:(NSString *)title Message:(NSString *)message{
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"下次在说" otherButtonTitles:@"立即体验", nil];
    [alertview show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex ==1) {
        //        NSLog(@"跳转App Store");
        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@",
                         IOS_APPID ];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}
- (GZMShareView *)gView{
    if (!_gView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _gView = [GZMShareView setGZMShareView:window];
        _gView.delegate = self;
    }
    return _gView;
}
- (void)weixinshareClick{
    WXWebpageObject *webpageObject = [WXWebpageObject object];
//    webpageObject.webpageUrl = @"https://www.shaogood.com/shaogood/shaogood_DownloadApp/index.html";
    webpageObject.webpageUrl = [NSString stringWithFormat:@"%@/shaogood/shaogood_DownloadApp/index.html",[[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"]];
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"捎东西CN";
    message.description = @"全球闲置商品交易讯息服务平台";
    [message setThumbImage:[UIImage imageNamed:@"share"]];
    message.mediaObject = webpageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
}
- (void)weixinfrindClick{
    WXWebpageObject *webpageObject = [WXWebpageObject object];
//    webpageObject.webpageUrl = @"https://www.shaogood.com/shaogood/shaogood_DownloadApp/index.html";
    webpageObject.webpageUrl = [NSString stringWithFormat:@"%@/shaogood/shaogood_DownloadApp/index.html",[[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"]];
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"捎东西CN";
    message.description = @"全球闲置商品交易讯息服务平台";
    [message setThumbImage:[UIImage imageNamed:@"share"]];
    message.mediaObject = webpageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req];
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
