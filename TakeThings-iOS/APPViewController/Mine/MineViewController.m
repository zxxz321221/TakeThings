//
//  MineViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/24.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "MineViewController.h"
#import "PersonViewController.h"
#import "BidBeforePaymentViewController.h"
#import "ABidBeforePaymentViewController.h"
#import "HelpViewController.h"
#import "AddressViewController.h"
#import "BalanceViewController.h"
#import "LoginViewController.h"
#import "CollectionViewController.h"
#import "CaseHandlingViewController.h"
#import "MarginViewController.h"
#import "CouponsViewController.h"
#import "AppDelegate.h"
#import "ActivityWebViewController.h"
#import "FootprintViewController.h"
#import "ShaoshaoleViewController.h"
#import "UIViewController+YINNav.h"
#import "NewCouponsViewController.h"
#import "KsViewController.h"
#import <KsIMSDK/KsIMSDK.h>
#import "ServiceViewController.h"
#import "NewCaseListViewController.h"
#import "NewOrderViewController.h"
#import "NewSendViewController.h"
#import "HaitaoListViewController.h"
#import "HaitaoSendViewController.h"
@interface MineViewController ()<UIScrollViewDelegate,personViewDelegate>
{
    NSDictionary * userInfo;
    NSString * remainappear;
    NSString * eyu;
}
@property (nonatomic , assign) CGFloat lastcontentOffset;
//创建导航栏渐变view  生成image

@property (nonatomic , strong) UIImage * image;
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UIView * navView;
@property (nonatomic , strong) UIButton * msgBtn;

@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) UIScrollView * scrollView;

//hearderView上控件
@property (nonatomic , strong) UIView * hearderView;
@property (nonatomic , strong) UIImageView * hearderImg;
@property (nonatomic , strong) UILabel * nameL;
@property (nonatomic , strong) UILabel * userLevel;
@property (nonatomic , strong) UILabel * emailL;//邮箱
@property (nonatomic , strong) UILabel * loginL;//登录注册
@property (nonatomic , strong) UILabel * balance;
@property (nonatomic , strong) UILabel * margin;
@property (nonatomic , strong) UILabel * collectionNum;
@property (nonatomic , strong) UIView * blackV;

//保证金
@property (nonatomic , strong) UILabel * marginLabel;

//先投标后付款
@property (nonatomic , strong) UIView * backV1;
//先付款后投标
@property (nonatomic , strong) UIView * backV2;
//案件处理
@property (nonatomic , strong) UIView * backV3;
//我的服务
@property (nonatomic , strong) UIView * backV4;

//页面ui数据源（名称 图标）
@property (nonatomic , strong) NSArray * oneArray;
@property (nonatomic , strong) NSArray * twoArray;
@property (nonatomic , strong) NSArray * threeArray;
@property (nonatomic , strong) NSArray * fourArray;

//所有角标
@property (nonatomic , strong) UILabel * cornerL0;
@property (nonatomic , strong) UILabel * cornerL1;
@property (nonatomic , strong) UILabel * cornerL2;
@property (nonatomic , strong) UILabel * cornerL3;
@property (nonatomic , strong) UILabel * cornerL4;
@property (nonatomic , strong) UILabel * cornerL5;
@property (nonatomic , strong) UILabel * cornerL6;
@property (nonatomic , strong) UILabel * cornerL7;
@property (nonatomic , strong) UILabel * cornerL8;
@property (nonatomic , strong) UILabel * cornerL9;
@property (nonatomic , strong) UILabel * cornerL10;

//新加的view（新的包裹列表）
@property (nonatomic , strong) UIView * nView;
//新委托单列表view
@property (nonatomic , strong) UIView * orderView;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册通知(接收,监听,一个通知)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification) name:@"userInfo" object:nil];
    [self.navigationItem setTitle:@""];
    self.y_navLineHidden = YES;
    self.y_navBarBgColor = [Unity getColor:@"#aa112d"];
    
    [self creareUI];
}
//登录成功通知  刷新我的页面
-(void)notification{
    userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSLog(@"登录通知%@",userInfo);
    self.nameL.hidden = NO;
    self.nameL.text = [userInfo objectForKey:@"w_nickname"];
//    NSLog(@"%lf",[Unity widthOfString:[userInfo objectForKey:@"w_name"] OfFontSize:FontSize(19) OfHeight:[Unity countcoordinatesH:30]]);
    CGFloat W = 0.0;
    //设置最大宽度
    if ([Unity widthOfString:[userInfo objectForKey:@"w_nickname"] OfFontSize:FontSize(19) OfHeight:[Unity countcoordinatesH:30]]>[Unity countcoordinatesW:150]) {
        W = [Unity countcoordinatesW:150];
    }else{
        W = [Unity widthOfString:[userInfo objectForKey:@"w_nickname"] OfFontSize:FontSize(19) OfHeight:[Unity countcoordinatesH:30]];
    }
    self.nameL.frame = CGRectMake(90+[Unity countcoordinatesW:20], NavBarHeight+[Unity countcoordinatesH:18], W, [Unity countcoordinatesH:30]);
    self.userLevel.hidden = NO;
    self.userLevel.frame = CGRectMake(self.nameL.right+[Unity countcoordinatesW:10], self.nameL.top+[Unity countcoordinatesH:5], [Unity widthOfString:@"体验用户" OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:20]]+10, [Unity countcoordinatesH:20]);
    self.emailL.hidden = NO;
    self.emailL.text = [userInfo objectForKey:@"w_email"];
    self.loginL.hidden = YES;
    if (![userInfo[@"w_photo"]isEqualToString:@""]) {
        [_hearderImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"],userInfo[@"w_photo"]]]];
    }
    if ([userInfo[@"w_coins"] floatValue]>0) {
        [self marginLoad:YES];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    if (userInfo) {
        [self notification];
        [self statusCount:[userInfo objectForKey:@"member_id"]];
    }
}
- (void)creareUI{
    
    _scrollView = [UIScrollView new];
    _scrollView.delegate=self;
    _scrollView.showsVerticalScrollIndicator = FALSE;//垂直滚动条
    _scrollView.showsHorizontalScrollIndicator = FALSE;//水平滚动条
    _scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //进行数据刷新操作
        if (userInfo) {
            [self notification];
            [self statusCount:[userInfo objectForKey:@"member_id"]];
        }
    }];
    [self.view addSubview:_scrollView];
    _scrollView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }//解决导航栏设置透明的情况下 scrollView发生偏移的问题：
    
    [self creareHearderView];
    [self.scrollView addSubview:self.marginLabel];
//    [self.scrollView addSubview:self.orderView];
//    [self.scrollView addSubview:self.nView];
    [self.scrollView addSubview:self.backV1];
    [self.scrollView addSubview:self.backV2];
    [self.scrollView addSubview:self.backV3];
    [self.scrollView addSubview:self.backV4];
    
    /*将ui添加到scrollView数组中*/
    [self.scrollView sd_addSubviews:@[_hearderView,self.marginLabel,self.backV1,self.backV2,self.backV3,self.backV4]];
    
    // scrollview自动contentsize
    [self.scrollView setupAutoContentSizeWithBottomView:self.backV4 bottomMargin:0];
    
    
    [self.view addSubview:self.navView];
    [self.view addSubview:self.hearderImg];
//    [self.view addSubview:self.msgBtn];
}
- (void)creareHearderView{
    self.hearderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight+[Unity countcoordinatesH:200])];
    [self gradientColorBackWIthHeight:NavBarHeight+[Unity countcoordinatesH:200]];
    UIImage * image = [self convertViewToImage:self.backView];
    self.hearderView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    //姓名 用户等级 邮箱  只有登录才显示 默认未登录
    self.nameL = [Unity lableViewAddsuperview_superView:self.hearderView _subViewFrame:CGRectMake(90+[Unity countcoordinatesW:20], NavBarHeight+[Unity countcoordinatesH:18], [Unity widthOfString:@"" OfFontSize:FontSize(18) OfHeight:[Unity countcoordinatesH:30]], [Unity countcoordinatesH:30]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(19)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentLeft];
    self.nameL.hidden = YES;
    self.userLevel = [Unity lableViewAddsuperview_superView:self.hearderView _subViewFrame:CGRectMake(self.nameL.right+[Unity countcoordinatesW:10], self.nameL.top+[Unity countcoordinatesH:5], [Unity widthOfString:@"体验用户" OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:20]]+10, [Unity countcoordinatesH:20]) _string:@"体验用户" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:[Unity getColor:@"#ffffff"] _textAlignment:NSTextAlignmentCenter];
    self.userLevel.backgroundColor = [UIColor blackColor];
    self.userLevel.layer.cornerRadius = self.userLevel.height/2;
    self.userLevel.layer.masksToBounds = YES;
    self.userLevel.alpha = 0.5;
    self.userLevel.hidden = YES;
    self.emailL = [Unity lableViewAddsuperview_superView:self.hearderView _subViewFrame:CGRectMake(self.nameL.left, self.nameL.bottom, [Unity countcoordinatesW:200], [Unity countcoordinatesH:30]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentLeft];
    self.emailL.hidden = YES;
    //登录注册
    self.loginL = [Unity lableViewAddsuperview_superView:self.hearderView _subViewFrame:CGRectMake(self.hearderImg.right+[Unity countcoordinatesW:10], self.hearderImg.top+30, [Unity countcoordinatesW:200], 30) _string:@"登录/注册" _lableFont:[UIFont systemFontOfSize:22] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentLeft];
    self.loginL.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap11 =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(login_register)];
    singleTap11.numberOfTapsRequired = 1; //点击次数
    singleTap11.numberOfTouchesRequired = 1; //点击手指数
    [self.loginL addGestureRecognizer:singleTap11];
    
    
    UIButton * balanceBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.hearderImg.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH/3, [Unity countcoordinatesH:40])];
    [balanceBtn addTarget:self action:@selector(balanceAction) forControlEvents:UIControlEventTouchUpInside];
    [self.hearderView addSubview:balanceBtn];
    UIButton * marginBtn = [[UIButton alloc]initWithFrame:CGRectMake(balanceBtn.right, balanceBtn.top, balanceBtn.width, balanceBtn.height)];
    [marginBtn addTarget:self action:@selector(marginAction1) forControlEvents:UIControlEventTouchUpInside];
    [self.hearderView addSubview:marginBtn];
    UIButton * collectionBtn = [[UIButton alloc]initWithFrame:CGRectMake(marginBtn.right, marginBtn.top, marginBtn.width, marginBtn.height)];
    [collectionBtn addTarget:self action:@selector(marginAction3) forControlEvents:UIControlEventTouchUpInside];
    [self.hearderView addSubview:collectionBtn];
    
    self.balance = [Unity lableViewAddsuperview_superView:balanceBtn _subViewFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, [Unity countcoordinatesH:15]) _string:@"****" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
    self.margin = [Unity lableViewAddsuperview_superView:marginBtn _subViewFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, [Unity countcoordinatesH:15]) _string:@"0.00" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
    self.collectionNum = [Unity lableViewAddsuperview_superView:collectionBtn _subViewFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, [Unity countcoordinatesH:15]) _string:@"0" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
    
    UILabel * balanceL = [Unity lableViewAddsuperview_superView:balanceBtn _subViewFrame:CGRectMake(0, self.balance.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH/3, [Unity countcoordinatesH:15]) _string:@"余额" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];

    UILabel * marginL = [Unity lableViewAddsuperview_superView:marginBtn _subViewFrame:CGRectMake(0, self.margin.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH/3, [Unity countcoordinatesH:15]) _string:@"保证金" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];

    UILabel * collectionL = [Unity lableViewAddsuperview_superView:collectionBtn _subViewFrame:CGRectMake(0, self.collectionNum.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH/3, [Unity countcoordinatesH:15]) _string:@"收藏" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
    collectionL.backgroundColor = [UIColor clearColor];
}
-(UIView *)blackV{
    if (!_blackV) {
        _blackV = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], self.hearderView.height-[Unity countcoordinatesH:40], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];;
        _blackV.backgroundColor = [UIColor blackColor];
        // 左上和右上为圆角
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:_blackV.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(45, 45)];
        CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
        cornerRadiusLayer.frame = _blackV.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        _blackV.layer.mask = cornerRadiusLayer;
        
        UIImageView * img = [Unity imageviewAddsuperview_superView:_blackV _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:12], [Unity countcoordinatesW:18], [Unity countcoordinatesH:16]) _imageName:@"会员" _backgroundColor:nil];
        UILabel * vipL = [Unity lableViewAddsuperview_superView:_blackV _subViewFrame:CGRectMake(img.right+[Unity countcoordinatesW:10], img.top, [Unity countcoordinatesW:70], [Unity countcoordinatesH:16]) _string:@"超级VIP" _lableFont:[UIFont systemFontOfSize:FontSize(16)] _lableTxtColor:[Unity getColor:@"#e5cfa4"] _textAlignment:NSTextAlignmentLeft];
         UILabel * tt = [Unity lableViewAddsuperview_superView:_blackV _subViewFrame:CGRectMake(vipL.right, vipL.top, [Unity countcoordinatesW:110], [Unity countcoordinatesH:16]) _string:@"更多优惠专享服务" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:[Unity getColor:@"#e5cfa4"] _textAlignment:NSTextAlignmentRight];
        UIButton * rechargeBtn = [Unity buttonAddsuperview_superView:_blackV _subViewFrame:CGRectMake(tt.right+[Unity countcoordinatesW:10], vipL.top-[Unity countcoordinatesH:2], [Unity countcoordinatesW:60], [Unity countcoordinatesH:20]) _tag:self _action:@selector(rechargeClick) _string:@"敬请期待" _imageName:nil];
        rechargeBtn.backgroundColor = [Unity getColor:@"#e5cfa4"];
        rechargeBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(12)];
        [rechargeBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        rechargeBtn.layer.cornerRadius = [Unity countcoordinatesH:10];
        rechargeBtn.layer.masksToBounds=YES;
       
        
    }
    return _blackV;
}
- (UILabel *)marginLabel{
    if (!_marginLabel) {
        _marginLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.hearderView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:25])];
        _marginLabel.backgroundColor = [Unity getColor:@"#f0f0f0"];
        _marginLabel.text = @"您还未交保证金现在是体验用户！去交保证金>>";
        _marginLabel.textColor = LabelColor6;
        _marginLabel.textAlignment = NSTextAlignmentCenter;
        _marginLabel.font = [UIFont systemFontOfSize:FontSize(12)];
        UITapGestureRecognizer *singleTap =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(marginAction)];
        singleTap.numberOfTapsRequired = 1; //点击次数
        singleTap.numberOfTouchesRequired = 1; //点击手指数
        [_marginLabel addGestureRecognizer:singleTap];
        _marginLabel.userInteractionEnabled = YES;
    }
    return _marginLabel;
}
- (UIView *)orderView{
    if (!_orderView) {
        _orderView = [[UIView alloc]initWithFrame:CGRectMake(0, _marginLabel.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:225])];
//        UIButton * btn = [Unity buttonAddsuperview_superView:_orderView _subViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:40]) _tag:self _action:nil _string:@"" _imageName:@""];
        UILabel * label = [Unity lableViewAddsuperview_superView:_orderView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:200], [Unity countcoordinatesH:35]) _string:@"我的委托单" _lableFont:[UIFont systemFontOfSize:FontSize(17)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
        UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], label.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:30], [Unity countcoordinatesH:80])];
        view1.backgroundColor = [Unity getColor:@"f0f0f0"];
        view1.layer.cornerRadius = 10;
        [_orderView addSubview:view1];
        UILabel * title1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, 200, [Unity countcoordinatesH:25])];
        title1.text = @"竞拍委托单";
        title1.textColor = LabelColor3;
        title1.font = [UIFont systemFontOfSize:FontSize(14)];
        [view1 addSubview:title1];

        NSArray * arr = @[@{@"title":@"进行中",@"icon":@"代拍中"},@{@"title":@"已得标",@"icon":@"已得标"},@{@"title":@"已结束",@"icon":@"没得标"},@{@"title":@"通知发货",@"icon":@"通知发货"}];
        for (int i=0; i<arr.count; i++) {
            UIButton * button = [Unity buttonAddsuperview_superView:view1 _subViewFrame:CGRectMake(i*(view1.width/4), title1.bottom, view1.width/4, [Unity countcoordinatesH:55]) _tag:self _action:@selector(orderViewClick:) _string:@"" _imageName:@""];
            button.tag = i+10000;
            UIImageView * icon = [Unity imageviewAddsuperview_superView:button _subViewFrame:CGRectMake((button.width-[Unity countcoordinatesW:25])/2, 0, [Unity countcoordinatesW:25], [Unity countcoordinatesH:25]) _imageName:arr[i][@"icon"] _backgroundColor:nil];
            UILabel * label = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(0, icon.bottom, button.width, [Unity countcoordinatesH:30]) _string:arr[i][@"title"] _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentCenter];
            label.backgroundColor = [UIColor clearColor];
//            if (i==0) {
//                _cornerL0 = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(icon.right-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity countcoordinatesW:12], [Unity countcoordinatesH:12]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(7)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
//                _cornerL0.layer.cornerRadius = _cornerL0.height/2;
//                _cornerL0.backgroundColor = [UIColor redColor];
//                _cornerL0.layer.masksToBounds = YES;
//                _cornerL0.hidden = YES;
//            }else if (i==1){
//                _cornerL1 = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(icon.right-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity countcoordinatesH:12], [Unity countcoordinatesH:12]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(7)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
//                _cornerL1.layer.cornerRadius = _cornerL1.height/2;
//                _cornerL1.backgroundColor = [UIColor redColor];
//                _cornerL1.layer.masksToBounds = YES;
//                _cornerL1.hidden = YES;
//            }else{
//                _cornerL2 = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(icon.right-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity countcoordinatesH:12], [Unity countcoordinatesH:12]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(7)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
//                _cornerL2.layer.cornerRadius = _cornerL2.height/2;
//                _cornerL2.backgroundColor = [UIColor redColor];
//                _cornerL2.layer.masksToBounds = YES;
//                _cornerL2.hidden = YES;
//            }
        }
        // ---------------------------海淘委托单
        UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], view1.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:30], [Unity countcoordinatesH:80])];
            view2.backgroundColor = [Unity getColor:@"f0f0f0"];
            view2.layer.cornerRadius = 10;
        [_orderView addSubview:view2];
        UILabel * title2 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, 200, [Unity countcoordinatesH:25])];
        title2.text = @"海淘委托单";
        title2.textColor = LabelColor3;
        title2.font = [UIFont systemFontOfSize:FontSize(14)];
        [view2 addSubview:title2];

        NSArray * arr1 = @[@{@"title":@"询价中",@"icon":@"haitao1"},@{@"title":@"已支付",@"icon":@"haitao2"},@{@"title":@"已结束",@"icon":@"haitao3"},@{@"title":@"通知发货",@"icon":@"通知发货"}];
        for (int i=0; i<arr1.count; i++) {
            UIButton * button = [Unity buttonAddsuperview_superView:view2 _subViewFrame:CGRectMake(i*(view2.width/4), title2.bottom, view2.width/4, [Unity countcoordinatesH:55]) _tag:self _action:@selector(haitaoClick:) _string:@"" _imageName:@""];
            button.tag = i+30000;
            UIImageView * icon = [Unity imageviewAddsuperview_superView:button _subViewFrame:CGRectMake((button.width-[Unity countcoordinatesW:25])/2, 0, [Unity countcoordinatesW:25], [Unity countcoordinatesH:25]) _imageName:arr1[i][@"icon"] _backgroundColor:nil];
            UILabel * label = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(0, icon.bottom, button.width, [Unity countcoordinatesH:30]) _string:arr1[i][@"title"] _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentCenter];
            label.backgroundColor = [UIColor clearColor];
        //            if (i==0) {
        //                _cornerL0 = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(icon.right-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity countcoordinatesW:12], [Unity countcoordinatesH:12]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(7)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
        //                _cornerL0.layer.cornerRadius = _cornerL0.height/2;
        //                _cornerL0.backgroundColor = [UIColor redColor];
        //                _cornerL0.layer.masksToBounds = YES;
        //                _cornerL0.hidden = YES;
        //            }else if (i==1){
        //                _cornerL1 = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(icon.right-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity countcoordinatesH:12], [Unity countcoordinatesH:12]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(7)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
        //                _cornerL1.layer.cornerRadius = _cornerL1.height/2;
        //                _cornerL1.backgroundColor = [UIColor redColor];
        //                _cornerL1.layer.masksToBounds = YES;
        //                _cornerL1.hidden = YES;
        //            }else{
        //                _cornerL2 = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(icon.right-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity countcoordinatesH:12], [Unity countcoordinatesH:12]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(7)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
        //                _cornerL2.layer.cornerRadius = _cornerL2.height/2;
        //                _cornerL2.backgroundColor = [UIColor redColor];
        //                _cornerL2.layer.masksToBounds = YES;
        //                _cornerL2.hidden = YES;
        //            }
        }
        UILabel * lien = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:215], SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        lien.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [_orderView addSubview:lien];
    }
    return _orderView;
}
- (UIView *)nView{
    if (!_nView) {
        _nView = [[UIView alloc]initWithFrame:CGRectMake(0, _marginLabel.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:130])];
        UIButton * btn = [Unity buttonAddsuperview_superView:_nView _subViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:40]) _tag:self _action:nil _string:@"" _imageName:@""];
        UILabel * label = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:200], [Unity countcoordinatesH:20]) _string:@"我的包裹" _lableFont:[UIFont systemFontOfSize:FontSize(17)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
        UIImageView * img = [Unity imageviewAddsuperview_superView:btn _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:15], [Unity countcoordinatesH:15], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10]) _imageName:@"go" _backgroundColor:nil];
        img.userInteractionEnabled = YES;
        
        NSArray * arr = @[@{@"title":@"进行中",@"icon":@"代拍中"},@{@"title":@"已发出",@"icon":@"已得标"},@{@"title":@"已结束",@"icon":@"没得标"}];
        for (int i=0; i<arr.count; i++) {
            UIButton * button = [Unity buttonAddsuperview_superView:_nView _subViewFrame:CGRectMake(i*(SCREEN_WIDTH/3), btn.bottom, SCREEN_WIDTH/3, [Unity countcoordinatesH:80]) _tag:self _action:@selector(nViewClick:) _string:@"" _imageName:@""];
            button.tag = i+8000;
            UIImageView * icon = [Unity imageviewAddsuperview_superView:button _subViewFrame:CGRectMake((button.width-[Unity countcoordinatesW:25])/2, [Unity countcoordinatesH:10], [Unity countcoordinatesW:25], [Unity countcoordinatesH:25]) _imageName:arr[i][@"icon"] _backgroundColor:nil];
            UILabel * label = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(0, icon.bottom+[Unity countcoordinatesH:10], button.width, [Unity countcoordinatesH:15]) _string:arr[i][@"title"] _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentCenter];
            label.backgroundColor = [UIColor clearColor];
//            if (i==0) {
//                _cornerL0 = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(icon.right-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity countcoordinatesW:12], [Unity countcoordinatesH:12]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(7)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
//                _cornerL0.layer.cornerRadius = _cornerL0.height/2;
//                _cornerL0.backgroundColor = [UIColor redColor];
//                _cornerL0.layer.masksToBounds = YES;
//                _cornerL0.hidden = YES;
//            }else if (i==1){
//                _cornerL1 = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(icon.right-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity countcoordinatesH:12], [Unity countcoordinatesH:12]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(7)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
//                _cornerL1.layer.cornerRadius = _cornerL1.height/2;
//                _cornerL1.backgroundColor = [UIColor redColor];
//                _cornerL1.layer.masksToBounds = YES;
//                _cornerL1.hidden = YES;
//            }else{
//                _cornerL2 = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(icon.right-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity countcoordinatesH:12], [Unity countcoordinatesH:12]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(7)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
//                _cornerL2.layer.cornerRadius = _cornerL2.height/2;
//                _cornerL2.backgroundColor = [UIColor redColor];
//                _cornerL2.layer.masksToBounds = YES;
//                _cornerL2.hidden = YES;
//            }
        }
        
        UILabel * lien = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:120], SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        lien.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [_nView addSubview:lien];
        
//        UIButton * send = [Unity buttonAddsuperview_superView:_nView _subViewFrame:CGRectMake(0, btn.bottom, SCREEN_WIDTH/4, [Unity countcoordinatesH:80]) _tag:self _action:@selector(sendClick) _string:@"" _imageName:@""];
//        UIImageView * icon1 = [Unity imageviewAddsuperview_superView:send _subViewFrame:CGRectMake((send.width-[Unity countcoordinatesW:25])/2, [Unity countcoordinatesH:10], [Unity countcoordinatesW:25], [Unity countcoordinatesH:25]) _imageName:@"通知发货" _backgroundColor:nil];
//        UILabel * label1 = [Unity lableViewAddsuperview_superView:send _subViewFrame:CGRectMake(0, icon1.bottom+[Unity countcoordinatesH:10], send.width, [Unity countcoordinatesH:15]) _string:@"通知发货" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentCenter];
//        label1.backgroundColor = [UIColor clearColor];
    }
    return _nView;
}
- (UIView *)backV1{
    if (!_backV1) {
        _backV1 = [[UIView alloc]initWithFrame:CGRectMake(0, _marginLabel.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:130])];
        UIButton * btn = [Unity buttonAddsuperview_superView:_backV1 _subViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:40]) _tag:self _action:@selector(moreClick1) _string:@"" _imageName:@""];
        UILabel * label = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:200], [Unity countcoordinatesH:20]) _string:@"直接消费案件" _lableFont:[UIFont systemFontOfSize:FontSize(17)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
        UIImageView * img = [Unity imageviewAddsuperview_superView:btn _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:15], [Unity countcoordinatesH:15], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10]) _imageName:@"go" _backgroundColor:nil];
        img.userInteractionEnabled = YES;
        
        _oneArray = @[@{@"title":@"进行中",@"icon":@"代拍中"},@{@"title":@"购买成功",@"icon":@"已得标"},@{@"title":@"购买失败",@"icon":@"没得标"}];
        for (int i=0; i<_oneArray.count; i++) {
            UIButton * button = [Unity buttonAddsuperview_superView:_backV1 _subViewFrame:CGRectMake(i*(SCREEN_WIDTH/3), btn.bottom, SCREEN_WIDTH/3, [Unity countcoordinatesH:80]) _tag:self _action:@selector(btnClick1:) _string:@"" _imageName:@""];
            button.tag = i+1000;
            UIImageView * icon = [Unity imageviewAddsuperview_superView:button _subViewFrame:CGRectMake((button.width-[Unity countcoordinatesW:25])/2, [Unity countcoordinatesH:10], [Unity countcoordinatesW:25], [Unity countcoordinatesW:25]) _imageName:_oneArray[i][@"icon"] _backgroundColor:nil];
            UILabel * label = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(0, icon.bottom+[Unity countcoordinatesH:10], button.width, [Unity countcoordinatesH:15]) _string:_oneArray[i][@"title"] _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentCenter];
            label.backgroundColor = [UIColor clearColor];
            if (i==0) {
                _cornerL0 = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(icon.right-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity countcoordinatesW:12], [Unity countcoordinatesH:12]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(7)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
                _cornerL0.layer.cornerRadius = _cornerL0.height/2;
                _cornerL0.backgroundColor = [UIColor redColor];
                _cornerL0.layer.masksToBounds = YES;
                _cornerL0.hidden = YES;
            }else if (i==1){
                _cornerL1 = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(icon.right-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity countcoordinatesH:12], [Unity countcoordinatesH:12]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(7)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
                _cornerL1.layer.cornerRadius = _cornerL1.height/2;
                _cornerL1.backgroundColor = [UIColor redColor];
                _cornerL1.layer.masksToBounds = YES;
                _cornerL1.hidden = YES;
            }else{
                _cornerL2 = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(icon.right-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity countcoordinatesH:12], [Unity countcoordinatesH:12]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(7)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
                _cornerL2.layer.cornerRadius = _cornerL2.height/2;
                _cornerL2.backgroundColor = [UIColor redColor];
                _cornerL2.layer.masksToBounds = YES;
                _cornerL2.hidden = YES;
            }
        }
        
        UILabel * lien = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:120], SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        lien.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [_backV1 addSubview:lien];
    }
    return _backV1;
}
- (UIView *)backV2{
    if (!_backV2) {
        _backV2 = [[UIView alloc]initWithFrame:CGRectMake(0, _backV1.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:130])];
        UIButton * btn = [Unity buttonAddsuperview_superView:_backV2 _subViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:40]) _tag:self _action:@selector(moreClick2) _string:@"" _imageName:@""];
        UILabel * label = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:200], [Unity countcoordinatesH:20]) _string:@"定金消费案件" _lableFont:[UIFont systemFontOfSize:FontSize(17)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
        UIImageView * img = [Unity imageviewAddsuperview_superView:btn _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:15], [Unity countcoordinatesH:15], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10]) _imageName:@"go" _backgroundColor:nil];
        img.userInteractionEnabled = YES;
        
        _twoArray = @[@{@"title":@"进行中",@"icon":@"付款代拍"},@{@"title":@"购买成功",@"icon":@"付款已得标"},@{@"title":@"购买失败",@"icon":@"付款没得标"}];
        for (int i=0; i<_twoArray.count; i++) {
            UIButton * button = [Unity buttonAddsuperview_superView:_backV2 _subViewFrame:CGRectMake(i*(SCREEN_WIDTH/3), btn.bottom, SCREEN_WIDTH/3, [Unity countcoordinatesH:80]) _tag:self _action:@selector(btnClick2:) _string:@"" _imageName:@""];
            button.tag = i+2000;
            UIImageView * icon = [Unity imageviewAddsuperview_superView:button _subViewFrame:CGRectMake((button.width-[Unity countcoordinatesW:25])/2, [Unity countcoordinatesH:10], [Unity countcoordinatesW:25], [Unity countcoordinatesW:25]) _imageName:_twoArray[i][@"icon"] _backgroundColor:nil];
            UILabel * label = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(0, icon.bottom+[Unity countcoordinatesH:10], button.width, [Unity countcoordinatesH:15]) _string:_twoArray[i][@"title"] _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentCenter];
            label.backgroundColor = [UIColor clearColor];
            if (i==0) {
                _cornerL3 = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(icon.right-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity countcoordinatesH:12], [Unity countcoordinatesH:12]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(7)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
                _cornerL3.layer.cornerRadius = _cornerL3.height/2;
                _cornerL3.backgroundColor = [UIColor redColor];
                _cornerL3.layer.masksToBounds = YES;
                _cornerL3.hidden = YES;
            }else if (i==1){
                _cornerL4 = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(icon.right-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity countcoordinatesH:12], [Unity countcoordinatesH:12]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(7)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
                _cornerL4.layer.cornerRadius = _cornerL4.height/2;
                _cornerL4.backgroundColor = [UIColor redColor];
                _cornerL4.layer.masksToBounds = YES;
                _cornerL4.hidden = YES;
            }else{
                _cornerL5 = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(icon.right-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity countcoordinatesH:12], [Unity countcoordinatesH:12]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(7)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
                _cornerL5.layer.cornerRadius = _cornerL5.height/2;
                _cornerL5.backgroundColor = [UIColor redColor];
                _cornerL5.layer.masksToBounds = YES;
                _cornerL5.hidden = YES;
            }
        }
        
        UILabel * lien = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:120], SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        lien.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [_backV2 addSubview:lien];
    }
    return _backV2;
}
- (UIView *)backV3{
    if (!_backV3) {
        _backV3 = [[UIView alloc]initWithFrame:CGRectMake(0, _backV2.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:210])];
        UIButton * btn = [Unity buttonAddsuperview_superView:_backV3 _subViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:40]) _tag:self _action:@selector(moreClick3) _string:@"" _imageName:@""];
        UILabel * label = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:200], [Unity countcoordinatesH:20]) _string:@"案件处理" _lableFont:[UIFont systemFontOfSize:FontSize(17)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
        UIImageView * img = [Unity imageviewAddsuperview_superView:btn _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:15], [Unity countcoordinatesH:15], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10]) _imageName:@"go" _backgroundColor:nil];
        img.userInteractionEnabled = YES;
        
        _threeArray = @[@{@"title":@"案件处理中",@"icon":@"得标处理中"},@{@"title":@"发货处理中",@"icon":@"发货处理"},@{@"title":@"通知发货",@"icon":@"通知发货"},@{@"title":@"案件已发货",@"icon":@"代拍已发货"},@{@"title":@"结案案件",@"icon":@"代拍结案"}];
        for (int i=0; i<_threeArray.count; i++) {
            UIButton * button = [Unity buttonAddsuperview_superView:_backV3 _subViewFrame:CGRectMake((i%4)*(SCREEN_WIDTH/4), btn.bottom+(i/4)*[Unity countcoordinatesH:80], SCREEN_WIDTH/4, [Unity countcoordinatesH:80]) _tag:self _action:@selector(btnClick3:) _string:@"" _imageName:@""];
            button.tag = i+3000;
            UIImageView * icon = [Unity imageviewAddsuperview_superView:button _subViewFrame:CGRectMake((button.width-[Unity countcoordinatesW:25])/2, [Unity countcoordinatesH:10], [Unity countcoordinatesW:25], [Unity countcoordinatesW:25]) _imageName:_threeArray[i][@"icon"] _backgroundColor:nil];
            UILabel * label = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(0, icon.bottom+[Unity countcoordinatesH:10], button.width, [Unity countcoordinatesH:15]) _string:_threeArray[i][@"title"] _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentCenter];
            label.backgroundColor = [UIColor clearColor];
            if (i==0) {
                _cornerL6 = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(icon.right-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity countcoordinatesH:12], [Unity countcoordinatesH:12]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(7)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
                _cornerL6.layer.cornerRadius = _cornerL6.height/2;
                _cornerL6.backgroundColor = [UIColor redColor];
                _cornerL6.layer.masksToBounds = YES;
                _cornerL6.hidden = YES;
            }else if (i==1){
                _cornerL7 = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(icon.right-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity countcoordinatesH:12], [Unity countcoordinatesH:12]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(7)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
                _cornerL7.layer.cornerRadius = _cornerL7.height/2;
                _cornerL7.backgroundColor = [UIColor redColor];
                _cornerL7.layer.masksToBounds = YES;
                _cornerL7.hidden = YES;
            }else if(i==2){
                _cornerL8 = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(icon.right-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity countcoordinatesH:12], [Unity countcoordinatesH:12]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(7)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
                _cornerL8.layer.cornerRadius = _cornerL8.height/2;
                _cornerL8.backgroundColor = [UIColor redColor];
                _cornerL8.layer.masksToBounds = YES;
                _cornerL8.hidden = YES;
            }else if(i==3){
                _cornerL9 = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(icon.right-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity countcoordinatesH:12], [Unity countcoordinatesH:12]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(7)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
                _cornerL9.layer.cornerRadius = _cornerL9.height/2;
                _cornerL9.backgroundColor = [UIColor redColor];
                _cornerL9.layer.masksToBounds = YES;
                _cornerL9.hidden = YES;
            }else{
                _cornerL10 = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(icon.right-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity countcoordinatesH:12], [Unity countcoordinatesH:12]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(7)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentCenter];
                _cornerL10.layer.cornerRadius = _cornerL9.height/2;
                _cornerL10.backgroundColor = [UIColor redColor];
                _cornerL10.layer.masksToBounds = YES;
                _cornerL10.hidden = YES;
            }
        }
        
        UILabel * lien = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:200], SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        lien.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [_backV3 addSubview:lien];
    }
    return _backV3;
}
- (UIView *)backV4{
    if (!_backV4) {
        _backV4 = [[UIView alloc]initWithFrame:CGRectMake(0, _backV3.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:200])];
        UIButton * btn = [Unity buttonAddsuperview_superView:_backV4 _subViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:40]) _tag:nil _action:nil _string:@"" _imageName:@""];
        UILabel * label = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:200], [Unity countcoordinatesH:20]) _string:@"我的服务" _lableFont:[UIFont systemFontOfSize:FontSize(17)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
//        _fourArray = @[@"售后服务",@"客服与帮助",@"行情查询",@"收货地址",@"积分",@"收藏",@"回馈金",@"小工具"];,@"回馈金"
        _fourArray = @[@"售后服务",@"客服与帮助",@"收货地址",@"收藏",@"足迹",@"捎捎乐"];//,@"回馈金"
        for (int i=0; i<_fourArray.count; i++) {
            UIButton * button = [Unity buttonAddsuperview_superView:_backV4 _subViewFrame:CGRectMake((i%4)*(SCREEN_WIDTH/4), btn.bottom+((i/4)*[Unity countcoordinatesH:80]), SCREEN_WIDTH/4, [Unity countcoordinatesH:80]) _tag:self _action:@selector(btnClick4:) _string:@"" _imageName:@""];
            button.tag = i+4000;
            UIImageView * icon = [Unity imageviewAddsuperview_superView:button _subViewFrame:CGRectMake((button.width-[Unity countcoordinatesW:25])/2, [Unity countcoordinatesH:10], [Unity countcoordinatesW:25], [Unity countcoordinatesW:25]) _imageName:_fourArray[i] _backgroundColor:nil];
            UILabel * label = [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(0, icon.bottom+[Unity countcoordinatesH:10], button.width, [Unity countcoordinatesH:15]) _string:_fourArray[i] _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentCenter];
            label.backgroundColor = [UIColor clearColor];
        }
    }
    return _backV4;
}
//右侧一个图片按钮的情况
- (void)addRightBarButtonWithFirstImage:(UIImage *)firstImage action:(SEL)action
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 44, 44);
    [rightButton setImage:firstImage forState:UIControlStateNormal];
    [rightButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5 * SCREEN_WIDTH / 375.0)];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
#pragma mark - 生成渐变色
- (void)gradientColorBackWIthHeight:(CGFloat)height{
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:229.0/255.0 green:41.0/255.0 blue:76.0/255.0 alpha:1].CGColor,  (__bridge id)[UIColor colorWithRed:170.0/255.0 green:17.0/255.0 blue:45.0/255.0 alpha:1].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = self.backView.frame;
    [self.backView.layer addSublayer:gradientLayer];
    
}
-(UIImage*)convertViewToImage:(UIView*)v{
    CGSize s = v.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需  要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, YES, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (UIImageView *)hearderImg{
    if (!_hearderImg) {
        _hearderImg = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], NavBarHeight+[Unity countcoordinatesH:10], 90, 90)];
//        [Unity imageviewAddsuperview_superView:self.hearderView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], NavBarHeight+[Unity countcoordinatesH:10], 90, 90) _imageName:@"我的头像" _backgroundColor:nil];
        _hearderImg.image = [UIImage imageNamed:@"我的头像"];
//        UIImage *selectedImage=[UIImage imageNamed: @""];
//        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UITapGestureRecognizer *singleTap =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerAction)];
        singleTap.numberOfTapsRequired = 1; //点击次数
        singleTap.numberOfTouchesRequired = 1; //点击手指数
        [self.hearderImg addGestureRecognizer:singleTap];
        self.hearderImg.userInteractionEnabled = YES;
        self.hearderImg.layer.cornerRadius = 45;
        self.hearderImg.clipsToBounds = YES;
        //添加边框
        CALayer * layer = [self.hearderImg layer];
        layer.borderColor = [[Unity getColor:@"#e17387"] CGColor];
        layer.borderWidth = 5.0f;
    }
    return _hearderImg;
}
- (UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight)];
        [self gradientColorBackWIthHeight:NavBarHeight];
        UIImage * image = [self convertViewToImage:self.backView];
        _navView.backgroundColor = [UIColor colorWithPatternImage:image];
        _navView.alpha = 0.01;
    }
    return _navView;
}
- (UIButton *)msgBtn{
    if (!_msgBtn) {
        _msgBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-40, StatusBarHeight+10, 24, 24)];
        [_msgBtn setBackgroundImage:[UIImage imageNamed:@"home_msg"] forState:UIControlStateNormal];
        [_msgBtn addTarget:self action:@selector(msgClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _msgBtn;
}
#pragma mark - UIScrollView代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<=80 && scrollView.contentOffset.y>=0) {
        self.hearderImg.frame = CGRectMake([Unity countcoordinatesW:10], (NavBarHeight+[Unity countcoordinatesH:10])-(42+[Unity countcoordinatesH:10])/80 * scrollView.contentOffset.y, 80-(scrollView.contentOffset.y/2)+((5-(scrollView.contentOffset.y/16))*2), 80-(scrollView.contentOffset.y/2)+((5-(scrollView.contentOffset.y/16))*2));
        self.hearderImg.layer.cornerRadius = 45-((scrollView.contentOffset.y/2)/2)-(5-(scrollView.contentOffset.y/16));
        CALayer * layer = [self.hearderImg layer];
        layer.borderColor = [[Unity getColor:@"#e17387"] CGColor];
        layer.borderWidth = 5-(scrollView.contentOffset.y/16);
        self.hearderImg.layer.cornerRadius = (80-(scrollView.contentOffset.y/2)+((5-(scrollView.contentOffset.y/16))*2))/2;
        self.hearderImg.clipsToBounds = YES;
    }
    CGFloat hight = scrollView.frame.size.height;
    CGFloat contentOffset = scrollView.contentOffset.y;
    CGFloat distanceFromBottom = scrollView.contentSize.height - contentOffset;
    CGFloat offset = contentOffset - self.lastcontentOffset;
    self.lastcontentOffset = contentOffset;
    
    if (offset > 0 && contentOffset > 0) {
//        NSLog(@"上拉行为");
        if (scrollView.contentOffset.y >= 80){
            self.hearderImg.frame = CGRectMake([Unity countcoordinatesW:10], (NavBarHeight+[Unity countcoordinatesH:10])-(42+[Unity countcoordinatesH:10])/80 * 80, 80-(80/2)+((5-(80/16))*2), 80-(80/2)+((5-(80/16))*2));
            self.hearderImg.layer.cornerRadius = 45-((80/2)/2)-(5-(80/16));
            CALayer * layer = [self.hearderImg layer];
            layer.borderColor = [[Unity getColor:@"#e17387"] CGColor];
            layer.borderWidth = 5-(scrollView.contentOffset.y/16);
            self.hearderImg.layer.cornerRadius = (80-(80/2)+((5-(80/16))*2))/2;
            self.hearderImg.clipsToBounds = YES;
        }
    }
    if (offset < 0 && distanceFromBottom > hight) {
//        NSLog(@"下拉行为");
        if (scrollView.contentOffset.y <= 0) {
            self.hearderImg.frame = CGRectMake([Unity countcoordinatesW:10],NavBarHeight+[Unity countcoordinatesH:10], 90, 90);
            self.hearderImg.layer.cornerRadius = 45;
            CALayer * layer = [self.hearderImg layer];
            layer.borderColor = [[Unity getColor:@"#e17387"] CGColor];
            layer.borderWidth = 5;
            self.hearderImg.clipsToBounds = YES;
        }
    }
//    NSLog(@"%f",scrollView.contentOffset.y);
    
    
    
    float i=0;
    if (scrollView.contentOffset.y/(NavBarHeight+[Unity countcoordinatesH:100])>=1) {
        i=0.999;
    }else{
        i=scrollView.contentOffset.y/(NavBarHeight+[Unity countcoordinatesH:100]);
    }
    self.navView.alpha = i;
}
#pragma mark 导航栏右侧消息
- (void)msgClick{
//    self.balance.text = @"1.00";
//    [self.view layoutIfNeeded];
}
- (void)login_register{
    if (userInfo == nil) {
        [self login];
    }
}
//头像
- (void)headerAction{
//    userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    if (userInfo == nil) {
        [self login];
    }else{
        PersonViewController * ivc = [[PersonViewController alloc]init];
        ivc.hidesBottomBarWhenPushed = YES;
        ivc.delegate =self;
        [self.navigationController pushViewController:ivc animated:YES];
    }
    
}
//充值按钮
- (void)rechargeClick{
//    if (userInfo == nil) {
//        [self login];
//    }else{
//
//    }
    [WHToast showMessage:@"暂未开通,敬请期待" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
}
//交保证金
- (void)marginAction{
    if (userInfo == nil) {
        [self login];
    }else{
        
    }
}
- (void)orderViewClick:(UIButton *)btn{
    if (userInfo == nil) {
        [self login];
    }else{
        if (btn.tag == 10003) {
            NewSendViewController * nvc = [[NewSendViewController alloc]init];
            nvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:nvc animated:YES];
        }else{
            NewOrderViewController * bvc = [[NewOrderViewController alloc]init];
            bvc.hidesBottomBarWhenPushed = YES;
            bvc.tap = btn.tag-10000;
            [self.navigationController pushViewController:bvc animated:YES];
        }
    }
}
- (void)haitaoClick:(UIButton *)btn{
    if (userInfo == nil) {
        [self login];
    }else{
        if (btn.tag == 30003) {
            HaitaoSendViewController * hvc = [[HaitaoSendViewController alloc]init];
            hvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:hvc animated:YES];
        }else{
            HaitaoListViewController * bvc = [[HaitaoListViewController alloc]init];
            bvc.hidesBottomBarWhenPushed = YES;
            bvc.tap = btn.tag-30000;
            [self.navigationController pushViewController:bvc animated:YES];
        }
    }
}
- (void)nViewClick:(UIButton *)btn{
    if (userInfo == nil) {
        
        [self login];
    }else{
        NewCaseListViewController * bvc = [[NewCaseListViewController alloc]init];
        bvc.hidesBottomBarWhenPushed = YES;
        bvc.tap = btn.tag-8000;
        [self.navigationController pushViewController:bvc animated:YES];
    }
}
//先投标后付款 查看更多
- (void)moreClick1{}
- (void)btnClick1:(UIButton *)btn{
    if (userInfo == nil) {
        [self login];
    }else{
        BidBeforePaymentViewController * bvc = [[BidBeforePaymentViewController alloc]init];
        bvc.hidesBottomBarWhenPushed = YES;
        bvc.tap = btn.tag-1000;
        [self.navigationController pushViewController:bvc animated:YES];
    }
}
//先付款后投标
- (void)moreClick2{
    
}
- (void)btnClick2:(UIButton *)btn{
    if (userInfo == nil) {
        [self login];
    }else{
        ABidBeforePaymentViewController * bvc = [[ABidBeforePaymentViewController alloc]init];
        bvc.hidesBottomBarWhenPushed = YES;
        bvc.tap = btn.tag-2000;
        [self.navigationController pushViewController:bvc animated:YES];
    }
}
//案件处理更多
- (void)moreClick3{
    
}
//案件处理
- (void)btnClick3:(UIButton *)btn{
    if (userInfo == nil) {
        [self login];
    }else{
        CaseHandlingViewController * cvc = [[CaseHandlingViewController alloc]init];
        cvc.hidesBottomBarWhenPushed = YES;
        cvc.tap = btn.tag - 3000;
        [self.navigationController pushViewController:cvc animated:YES];
    }
}
//我的服务
- (void)btnClick4:(UIButton *)btn{
        if (btn.tag == 4000) {
            ServiceViewController * svc = [[ServiceViewController alloc]init];
            svc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:svc animated:YES];
//            ActivityWebViewController *webService = [[ActivityWebViewController alloc]init];
//            // 获得当前iPhone使用的语言
//            NSString* currentLanguage = NSLocalizedString(@"GlobalBuyer_Nativelanguage", nil);
//            NSLog(@"当前使用的语言：%@",currentLanguage);
//            if ([currentLanguage isEqualToString:@"zh-Hans-US"]) {
//                webService.href = @"http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html";
//            }else if([currentLanguage isEqualToString:@"zh-Hant"]){
//                webService.href = @"http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html";
//            }else if([currentLanguage isEqualToString:@"en"]){
//                webService.href = @"http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html";
//            }else{
//                webService.href = @"http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html";
//            }
//            webService.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:webService animated:YES];
        }else if (btn.tag == 4001){
            HelpViewController * hvc = [[HelpViewController alloc]init];
            hvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:hvc animated:YES];
        }else if (btn.tag == 4002){
            if (userInfo == nil) {
                [self login];
                return;
            }
            AddressViewController * avc = [[AddressViewController alloc]init];
            avc.hidesBottomBarWhenPushed = YES;
            avc.page = 2;
            [self.navigationController pushViewController:avc animated:YES];
        }else if (btn.tag == 4003){
            if (userInfo == nil) {
                [self login];
                return;
            }
            CollectionViewController * cvc = [[CollectionViewController alloc]init];
            cvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cvc animated:YES];
        }
//        else if (btn.tag == 4004){
//            CouponsViewController * cvc = [[CouponsViewController alloc]init];
//            cvc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:cvc animated:YES];
//
//        }
        else if (btn.tag == 4004){
            if (userInfo == nil) {
                [self login];
                return;
            }
            FootprintViewController * fvc = [[FootprintViewController alloc]init];
            fvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:fvc animated:YES];
        }else if (btn.tag == 4005){
            if (userInfo == nil) {
                [self login];
                return;
            }
            ShaoshaoleViewController * svc = [[ShaoshaoleViewController alloc]init];
            svc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:svc animated:YES];
        }else{
            NewCouponsViewController * nvc = [[NewCouponsViewController alloc]init];
            nvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:nvc animated:YES];
        }
}
- (void)balanceAction{
//    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    if (userInfo == nil) {
        [self login];
    }else{
        BalanceViewController * bvc = [[BalanceViewController alloc]init];
        bvc.hidesBottomBarWhenPushed = YES;
//        bvc.show = remainappear;
//        bvc.place = eyu;
        [self.navigationController pushViewController:bvc animated:YES];
    }
}
- (void)marginAction1{
    if (userInfo == nil) {
        [self login];
    }else{
        MarginViewController * mvc = [[MarginViewController alloc]init];
        mvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mvc animated:YES];
    }
}
- (void)marginAction3{
    if (userInfo == nil) {
        [self login];
    }else{
        CollectionViewController * cvc = [[CollectionViewController alloc]init];
        cvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cvc animated:YES];
    }
}
- (void)exit{
    self.nameL.hidden = YES;
    self.userLevel.hidden = YES;
    self.emailL.hidden = YES;
    self.loginL.hidden = NO;
    self.balance.text = @"****";
    self.margin.text = @"0.00";
    self.collectionNum.text = @"0";
    self.cornerL0.hidden = YES;
    self.cornerL1.hidden = YES;
    self.cornerL2.hidden = YES;
    self.cornerL3.hidden = YES;
    self.cornerL5.hidden = YES;
    self.cornerL6.hidden = YES;
    self.cornerL7.hidden = YES;
    self.cornerL8.hidden = YES;
    self.cornerL9.hidden = YES;
    self.cornerL10.hidden = YES;
    self.hearderImg.image = [UIImage imageNamed:@"我的头像"];
    
}
- (void)statusCount:(NSString *)customer{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"customer":userInfo[@"member_id"]};
    [GZMrequest getWithURLString:[GZMUrl get_statusCount_url] parameters:dic success:^(NSDictionary *data) {
        NSLog(@"我的页面状态数量%@",data);
        [self.scrollView.mj_header endRefreshing];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            
            remainappear = data[@"data"][@"remainappear"];
            eyu =data[@"data"][@"remain"];
            if ([remainappear isEqualToString:@"0"]) {
                self.balance.text = @"****";
            }else{
                self.balance.text = data[@"data"][@"remain"];
            }
            NSMutableDictionary * dicc = [userInfo mutableCopy];
            [dicc setObject:data[@"data"][@"remain"] forKey:@"w_yk_tw"];
            [dicc setObject:data[@"data"][@"remainappear"] forKey:@"w_remainappear"];
            [[NSUserDefaults standardUserDefaults] setObject:dicc forKey:@"userInfo"];
            self.margin.text = data[@"data"][@"coin"];
            if ([data[@"data"][@"coin"] floatValue] != 0) {
                self.userLevel.text = @"正式用户";
                [self marginLoad:YES];
            }
            self.collectionNum.text = data[@"data"][@"goods"];
            
            if ([data[@"data"][@"auction-b"] intValue]>0) {
                self.cornerL0.hidden = NO;
                self.cornerL0.text = data[@"data"][@"auction-b"];
                if ([Unity widthOfString:data[@"data"][@"auction-b"] OfFontSize:FontSize(7) OfHeight:[Unity countcoordinatesH:12]]>[Unity countcoordinatesW:10]) {
                    self.cornerL0.frame = CGRectMake(SCREEN_WIDTH/3-(SCREEN_WIDTH/3-[Unity countcoordinatesW:25])/2-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity widthOfString:data[@"data"][@"auction-b"] OfFontSize:FontSize(7) OfHeight:[Unity countcoordinatesH:12]]+[Unity countcoordinatesW:5], [Unity countcoordinatesH:12]);
                }
            }else{
                self.cornerL0.hidden = YES;
            }
            if ([data[@"data"][@"close-b"] intValue]>0) {
                self.cornerL1.hidden = NO;
                self.cornerL1.text = data[@"data"][@"close-b"];
                if ([Unity widthOfString:data[@"data"][@"close-b"] OfFontSize:FontSize(7) OfHeight:[Unity countcoordinatesH:12]]>[Unity countcoordinatesW:10]) {
                    self.cornerL1.frame = CGRectMake(SCREEN_WIDTH/3-(SCREEN_WIDTH/3-[Unity countcoordinatesW:25])/2-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity widthOfString:data[@"data"][@"close-b"] OfFontSize:FontSize(7) OfHeight:[Unity countcoordinatesH:12]]+[Unity countcoordinatesW:5], [Unity countcoordinatesH:12]);
                }
            }else{
                self.cornerL1.hidden = YES;
            }
            if ([data[@"data"][@"loss-b"] intValue]>0) {
                self.cornerL2.hidden = NO;
                self.cornerL2.text = data[@"data"][@"loss-b"];
                if ([Unity widthOfString:data[@"data"][@"loss-b"] OfFontSize:FontSize(7) OfHeight:[Unity countcoordinatesH:12]]>[Unity countcoordinatesW:10]) {
                    self.cornerL2.frame = CGRectMake(SCREEN_WIDTH/3-(SCREEN_WIDTH/3-[Unity countcoordinatesW:25])/2-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity widthOfString:data[@"data"][@"loss-b"] OfFontSize:FontSize(7) OfHeight:[Unity countcoordinatesH:12]]+[Unity countcoordinatesW:5], [Unity countcoordinatesH:12]);
                }
            }else{
                self.cornerL2.hidden = YES;
            }
            if ([data[@"data"][@"auction-a"] intValue]>0) {
                self.cornerL3.hidden = NO;
                self.cornerL3.text = data[@"data"][@"auction-a"];
                if ([Unity widthOfString:data[@"data"][@"auction-a"] OfFontSize:FontSize(7) OfHeight:[Unity countcoordinatesH:12]]>[Unity countcoordinatesW:10]) {
                    self.cornerL3.frame = CGRectMake(SCREEN_WIDTH/3-(SCREEN_WIDTH/3-[Unity countcoordinatesW:25])/2-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity widthOfString:data[@"data"][@"auction-a"] OfFontSize:FontSize(7) OfHeight:[Unity countcoordinatesH:12]]+[Unity countcoordinatesW:5], [Unity countcoordinatesH:12]);
                }
            }else{
                self.cornerL3.hidden = YES;
            }
            if ([data[@"data"][@"loss-a"] intValue]>0) {
                self.cornerL5.hidden = NO;
                self.cornerL5.text = data[@"data"][@"loss-a"];
                if ([Unity widthOfString:data[@"data"][@"loss-a"] OfFontSize:FontSize(7) OfHeight:[Unity countcoordinatesH:12]]>[Unity countcoordinatesW:10]) {
                    self.cornerL5.frame = CGRectMake(SCREEN_WIDTH/3-(SCREEN_WIDTH/3-[Unity countcoordinatesW:25])/2-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity widthOfString:data[@"data"][@"loss-a"] OfFontSize:FontSize(7) OfHeight:[Unity countcoordinatesH:12]]+[Unity countcoordinatesW:5], [Unity countcoordinatesH:12]);
                }
            }else{
                self.cornerL5.hidden = YES;
            }
            if ([data[@"data"][@"storage"] intValue]>0) {
                self.cornerL6.hidden = NO;
                self.cornerL6.text = data[@"data"][@"storage"];
                if ([Unity widthOfString:data[@"data"][@"storage"] OfFontSize:FontSize(7) OfHeight:[Unity countcoordinatesH:12]]>[Unity countcoordinatesW:10]) {
                    self.cornerL6.frame = CGRectMake(SCREEN_WIDTH/4-(SCREEN_WIDTH/4-[Unity countcoordinatesW:25])/2-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity widthOfString:data[@"data"][@"storage"] OfFontSize:FontSize(7) OfHeight:[Unity countcoordinatesH:12]]+[Unity countcoordinatesW:5], [Unity countcoordinatesH:12]);
                }
            }
            else{
                self.cornerL6.hidden = YES;
            }
            if ([data[@"data"][@"send"] intValue]>0) {
                self.cornerL7.hidden = NO;
                self.cornerL7.text = data[@"data"][@"send"];
                if ([Unity widthOfString:data[@"data"][@"send"] OfFontSize:FontSize(7) OfHeight:[Unity countcoordinatesH:12]]>[Unity countcoordinatesW:10]) {
                    self.cornerL7.frame = CGRectMake(SCREEN_WIDTH/4-(SCREEN_WIDTH/4-[Unity countcoordinatesW:25])/2-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity widthOfString:data[@"data"][@"send"] OfFontSize:FontSize(7) OfHeight:[Unity countcoordinatesH:12]]+[Unity countcoordinatesW:5], [Unity countcoordinatesH:12]);
                }
            }else{
                self.cornerL7.hidden = YES;
            }
            NSInteger noti = [data[@"data"][@"notice-j"] intValue]+[data[@"data"][@"notice-u"] intValue];
            /** 给全局变量赋值.
             通过单例模式获取属性
             */
            AppDelegate * myDelegate = [[UIApplication sharedApplication] delegate];
            myDelegate.japan = data[@"data"][@"notice-j"];
            myDelegate.usa = data[@"data"][@"notice-u"];
            if (noti>0) {
                self.cornerL8.hidden = NO;
                self.cornerL8.text = [NSString stringWithFormat:@"%ld",(long)noti];
                if ([Unity widthOfString:[NSString stringWithFormat:@"%ld",(long)noti] OfFontSize:FontSize(7) OfHeight:[Unity countcoordinatesH:12]]>[Unity countcoordinatesW:10]) {
                    self.cornerL8.frame = CGRectMake(SCREEN_WIDTH/4-(SCREEN_WIDTH/4-[Unity countcoordinatesW:25])/2-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity widthOfString:[NSString stringWithFormat:@"%ld",(long)noti] OfFontSize:FontSize(7) OfHeight:[Unity countcoordinatesH:12]]+[Unity countcoordinatesW:5], [Unity countcoordinatesH:12]);
                }
            }else{
                self.cornerL8.hidden = YES;
            }
            if ([data[@"data"][@"sent"] intValue]>0) {
                self.cornerL9.hidden = NO;
                self.cornerL9.text = data[@"data"][@"sent"];
                if ([Unity widthOfString:data[@"data"][@"sent"] OfFontSize:FontSize(7) OfHeight:[Unity countcoordinatesH:12]]>[Unity countcoordinatesW:10]) {
                    self.cornerL9.frame = CGRectMake(SCREEN_WIDTH/4-(SCREEN_WIDTH/4-[Unity countcoordinatesW:25])/2-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity widthOfString:data[@"data"][@"sent"] OfFontSize:FontSize(7) OfHeight:[Unity countcoordinatesH:12]]+[Unity countcoordinatesW:5], [Unity countcoordinatesH:12]);
                }
            }else{
                self.cornerL9.hidden = YES;
            }
            if ([data[@"data"][@"finish"] intValue]>0) {
                self.cornerL10.hidden = NO;
                self.cornerL10.text = data[@"data"][@"finish"];
                if ([Unity widthOfString:data[@"data"][@"finish"] OfFontSize:FontSize(7) OfHeight:[Unity countcoordinatesH:12]]>[Unity countcoordinatesW:10]) {
                    self.cornerL10.frame = CGRectMake(SCREEN_WIDTH/4-(SCREEN_WIDTH/4-[Unity countcoordinatesW:25])/2-[Unity countcoordinatesH:10],[Unity countcoordinatesH:6], [Unity widthOfString:data[@"data"][@"finish"] OfFontSize:FontSize(7) OfHeight:[Unity countcoordinatesH:12]]+[Unity countcoordinatesW:5], [Unity countcoordinatesH:12]);
                }
            }else{
                self.cornerL10.hidden = YES;
            }
        }else{
            [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.scrollView.mj_header endRefreshing];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)login{
    LoginViewController * lvc = [[LoginViewController alloc]init];
    lvc.hidesBottomBarWhenPushed=YES;
    
    [self.navigationController pushViewController:lvc animated:YES];
}
- (void)marginLoad:(BOOL)isShow{
    if (isShow) {
        self.marginLabel.frame = CGRectMake(0, self.hearderView.bottom, SCREEN_WIDTH, 0.1);
        self.marginLabel.text = @"";
//        self.orderView.frame = CGRectMake(0, self.hearderView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:225]);
//        self.nView.frame = CGRectMake(0, _orderView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:130]);
        self.backV1.frame = CGRectMake(0, _marginLabel.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:130]);
        self.backV2.frame = CGRectMake(0, _backV1.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:130]);
        self.backV3.frame = CGRectMake(0, _backV2.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:210]);
        self.backV4.frame = CGRectMake(0, _backV3.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:200]);
    }else{
        self.marginLabel.frame = CGRectMake(0, self.hearderView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:25]);
        self.marginLabel.text = @"您还未交保证金现在是体验用户！去交保证金>>";
//        self.orderView.frame = CGRectMake(0, self.marginLabel.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:225]);
//        self.nView.frame = CGRectMake(0, _orderView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:130]);
        self.backV1.frame = CGRectMake(0, _marginLabel.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:130]);
        self.backV2.frame = CGRectMake(0, _backV1.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:130]);
        self.backV3.frame = CGRectMake(0, _backV2.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:210]);
        self.backV4.frame = CGRectMake(0, _backV3.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:200]);
    }
}
////通知发货列表
//- (void)sendClick{
//    NewSendViewController * nvc = [[NewSendViewController alloc]init];
//    nvc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:nvc animated:YES];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController]
    // Pass the selected object to the new view controller.
}
*/

@end
