//
//  WellcomeViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/9.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "WellcomeViewController.h"
#import "TabBarViewController.h"
#import "AppDelegate.h"
@interface WellcomeViewController ()<UIScrollViewDelegate>
{
    UIButton * btn;
}
@property (nonatomic,strong) UIScrollView * scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic , strong) TabBarViewController *tabbar;
@end

@implementation WellcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //请求域名
    [self requestDomain];
}
- (void)requestDomain{
//    [GZMrequest getWithURLString:@"https://www.shaogood.com.hk/geturl.php" parameters:nil success:^(NSDictionary *data) {
//        NSLog(@"%@",data);
//    } failure:^(NSError *error) {
//
//    }];
    //创建一个NSURL：请求路径
     NSString *strURL = @"https://www.shaogood.com.hk/geturl.php";
    NSURL *url = [NSURL URLWithString:strURL];
    //创建一个请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //同步请求
    [self sendSyncWithRequest:request];
}
//同步请求
- (void)sendSyncWithRequest:(NSURLRequest *)request{
     //发送用户名和密码给服务器（HTTP协议）
     NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
     /*
      JSON
      1>JSON是一种轻量级的数据格式，一般用于数据交互
      服务器返回给客户端的数据一般都是JSON格式或者XML格式
      标准的JSON合适注意点：key必须用双引号

      2>要想从JSON中挖出具体数据得对JSON进行解析
      JSON           OC
132      {}-----------NSDictonary
133      []-----------NSArray
134      " "-----------NSString
135      数字-----------NSNumber
136
137      3>JSON解析方案
138      第三方框架：JSONKit、SBJson、TouchJSON（性能从左到右，越差）
139      苹果原生（自带）：NSJSONSerialization(性能最好)
140      4>JSON数据转-->OC对象
141      + (nullable id)JSONObjectWithData:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError **)error;
142      5>OC对象-->JSON数据
143      + (nullable NSData *)dataWithJSONObject:(id)obj options:(NSJSONWritingOptions)opt error:(NSError **)error;
144      */
     //解析服务器返回的JSON数据
     NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
     NSString *error = dict[@"error"];
     if (error) {
//         [MBProgressHUD showError:error];
     }
     else{
//         NSString *success = dict[@"success"];
         [[NSUserDefaults standardUserDefaults] setObject:dict[@"base_url"] forKey:@"sdxurl"];
         [[NSUserDefaults standardUserDefaults] setObject:dict[@"new_url"] forKey:@"new_sdxurl"];
//         [MBProgressHUD showSuccess:success];
         
     }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;//隐藏引导页状态栏
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self toLoginViewController];
    btn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-[Unity countcoordinatesW:150])/2, SCREEN_HEIGHT-[Unity countcoordinatesH:100], [Unity countcoordinatesW:150], [Unity countcoordinatesH:40])];
    [btn addTarget:self action:@selector(homeClick) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor whiteColor];
    btn.alpha= 0;
    [btn setTitle:@"进入首页" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:FontSize(24)];
    [btn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
    btn.layer.cornerRadius = btn.height/2;
    btn.layer.masksToBounds = YES;
    [self.view addSubview:btn];
}
-(void)toLoginViewController
{
    NSString *isjoin = [[NSUserDefaults standardUserDefaults]objectForKey:@"isFirstjoin"];
    if(isjoin == nil || [isjoin isEqualToString:@""]){
        [[NSUserDefaults standardUserDefaults] setObject:@"isFirstjoin" forKey:@"isFirstjoin"];
        [self.view addSubview:self.scrollView];
        [self.view addSubview:self.pageControl];
    }else{//不是首次登陆的时
        [self pushTabbarViewController];
    }
}
- (UIScrollView *)scrollView{
    if (_scrollView==nil) {
        [self prefersStatusBarHidden];
        _scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        NSArray * array;
        if (IS_iPhoneX) {
            array=@[@"one1",@"two1",@"three1",@"four1"];
        }else{
            array=@[@"one",@"two",@"three",@"four"];
        }
        
        for (int i = 0; i<array.count; i++) {
            UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0+SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            imageview.image = [UIImage imageNamed:[array objectAtIndex:i]];
            if (i == array.count-1) {
//                imageview.userInteractionEnabled = YES;
//                UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(poseView_swip:)];
//                swip.direction = UISwipeGestureRecognizerDirectionLeft;
//                [imageview addGestureRecognizer:swip];
//                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(poseView:)];
//                [imageview addGestureRecognizer:tap];
                
            }
            [_scrollView addSubview:imageview];
        }
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * array.count, SCREEN_HEIGHT);
    }
    
    return _scrollView;
}
- (UIPageControl *)pageControl{
    if (!_pageControl) {
        //设置视图上的小圆点
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 30)];
        _pageControl.numberOfPages = 4;
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}
-(void)poseView:(id)sender
{
    [self pushTabbarViewController];
}

-(void)poseView_swip:(UISwipeGestureRecognizer *)swip
{
    if (swip.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self pushTabbarViewController];
    }
}
- (void)pushTabbarViewController{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        TabBarViewController * tab = [[TabBarViewController alloc]init];
//        [self presentViewController:tab animated:YES completion:nil];

    UIApplication *app = [UIApplication sharedApplication];
    AppDelegate *dele = (AppDelegate*)app.delegate;
    dele.window.rootViewController = self.tabbar;

//    });
}
- (TabBarViewController *)tabbar{
    if (!_tabbar) {
        _tabbar = [[TabBarViewController alloc]init];
    }
    return _tabbar;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.x);

    int page = scrollView.contentOffset.x/SCREEN_WIDTH;
    if (page == 3) {
        [self performSelector:@selector(laterExecute) withObject:nil afterDelay:1.0f];
    }
    self.pageControl.currentPage = page;
}
- (void)laterExecute{
    [UIView animateWithDuration:0.5 animations:^{
        self->btn.alpha = 0.7;
    }completion:nil];
}
- (void)homeClick{
    [self pushTabbarViewController];
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
