//
//  HomeViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/11.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "HomeViewController.h"
#import "BannerCell.h"
#import "RollingMsgCell.h"
#import "AuctionWebCell.h"
#import "BrandCell.h"
#import "GoodsCell.h"
#import "GoodCell.h"
#import "SearchViewController.h"
#import "NewYahooDetailViewController.h"
#import "MessageViewController.h"
#import "ClassViewController.h"
#import "AppDelegate.h"
#import "GoodsListViewController.h"
#import "InfomationViewController.h"
#import "HelpDetailViewController.h"
#import "WebViewController.h"
#import "HelpViewController.h"
#import "BalanceViewController.h"
#import "EbayGoodsListViewController.h"
#import "ConverView.h"
#import "HaitaoViewController.h"
#import "CalculateViewController.h"
#import "ceshiViewController.h"
#import "ActivityWebViewController.h"
#import "NewYahooDetailViewController.h"
#import "LoginViewController.h"
#import "HomeCollectionViewCell.h"
#import <StoreKit/StoreKit.h>
#import "CollectionViewController.h"
#import "NewEbayDetailViewController.h"
#import "ServiceViewController.h"
#import "DemoViewController.h"
#import "advertising.h"
#import "ShooseGJViewController.h"
extern NSString * urll;
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,BannerCellDelegate,BrandCellDelegate,AuctionWebCellDelegate,GoodsCellDelegate,UITextFieldDelegate,RollingMsgCellDelegate,UIAlertViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger localeIndex;//0 原文 1中文
    NSInteger btnIndex;
    NSDictionary * jpushDic;
}
@property (nonatomic , strong) UIView * navView;
@property (nonatomic , strong) UIView * searchView;
@property (nonatomic , strong) UITextField * searchText;
@property (nonatomic , strong) UIButton * originalBtn;
@property (nonatomic , strong) UIButton * ChineseBtn;
@property (nonatomic , strong) UILabel * originalL;//原文下方指示线
@property (nonatomic , strong) UILabel * chineseL;//中文下方指示线
@property (nonatomic , strong) UIButton * classBtn;
@property (nonatomic , strong) UIButton * msgBtn;

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) NSMutableArray * bannerList;
@property (nonatomic , strong) NSMutableArray * msgList;
@property (nonatomic , strong) NSArray * subjectList;
@property (nonatomic , strong) NSArray * brandList;
@property (nonatomic , strong) NSDictionary * dataSource;
@property (nonatomic , strong) NSMutableArray * specialList;

@property (nonatomic , strong) ConverView * cView;

@property (nonatomic , strong) UIScrollView * topScro;
@property (nonatomic , strong) UICollectionView * collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout * gridLayout;
@property (nonatomic , strong) UIButton * seletedBtn;
@property (nonatomic , strong) UILabel * seletedLine;
@property (nonatomic , strong) NSMutableArray * collectionArr;

@property (nonatomic , strong) UIView * footerView;

@property (nonatomic , strong) advertising * aView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:@"loginSuccess" object:nil];
    if (urll != nil) {
        NSArray *paramerArray = [urll componentsSeparatedByString:@"?"];
        NSArray *paramerArray1 = [paramerArray[1] componentsSeparatedByString:@"&"];
        NSArray *paramerArray2 = [paramerArray1[0] componentsSeparatedByString:@"="];
        NSArray *paramerArray3 = [paramerArray1[1] componentsSeparatedByString:@"="];
        
        if ([paramerArray3[1] isEqualToString:@"0"]) {
            NewYahooDetailViewController * nvc = [[NewYahooDetailViewController alloc]init];
            nvc.hidesBottomBarWhenPushed = YES;
            nvc.item = paramerArray2[1];
            nvc.platform = paramerArray3[1];
            [self.navigationController pushViewController:nvc animated:YES];
        }else{
            NewEbayDetailViewController * nvc = [[NewEbayDetailViewController alloc]init];
            nvc.hidesBottomBarWhenPushed = YES;
            nvc.item = paramerArray2[1];
            nvc.platform = paramerArray3[1];
            [self.navigationController pushViewController:nvc animated:YES];
        }
    }
    [self requestLogin];
    [self requestExrate];
    localeIndex = 1;
    btnIndex = 0;
    [self.navigationItem setTitle:@""];
//    [self.navigationController.view addSubview:self.searchView];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.tableView];
    
    //版本请求
    [self requestVersion];
    [self requestSliderData];
//    [self.aView.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://attachments.gfan.com/forum/attachments2/day_120526/120526203928785c499eabc4b5.gif"]];
//    [self.aView showAdvertising];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(APNSJpush:) name:@"SystemMsgCallApp" object:nil];
    
}

//接收到通知  拿到参数 在这里做跳转相应页面 (app未运行状态走这个方法)
- (void)APNSJpush:(NSNotification *)notification{
    jpushDic = notification.object;
    NSDictionary * loginDic = [[NSUserDefaults standardUserDefaults]objectForKey:@"login"];
    if (loginDic == nil) {
//        return;
        [self pushLogin];
    }
    [Unity showanimate];
    NSDictionary *params = @{@"token":loginDic[@"token"],@"customer":loginDic[@"member_id"],@"tag":[Unity getLanguage]};
    [GZMrequest postWithURLString:[GZMUrl get_avoidLogin_url] parameters:params success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            if ([notification.object[@"app_jump_type"] intValue]) {
                CollectionViewController * cvc = [[CollectionViewController alloc]init];
                cvc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:cvc animated:YES];
            }
            NSMutableDictionary * dict = [NSMutableDictionary new];
            [dict setObject:data[@"data"][@"id"] forKey:@"member_id"];
            [dict setObject:data[@"data"][@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"login"];
            NSMutableDictionary * muDic = [Unity editLoginData:data[@"data"]];

            [[NSUserDefaults standardUserDefaults]setObject:muDic forKey:@"userInfo"];
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfo" object:nil];
    //            NSLog(@"免登录成功%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"]);
            //登陆成功 如果有本地足迹 上传服务器
            [self uploadFoot:data[@"data"][@"w_email"]];

        }else{
    //           NSLog(@"登录失败");
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userInfo"];
            [self pushLogin];
        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [self pushLogin];
    }];
    
}
- (void)pushLogin{
    LoginViewController * lvc = [[LoginViewController alloc]init];
    lvc.hidesBottomBarWhenPushed = YES;
    lvc.status = 999;
    [self.navigationController pushViewController:lvc animated:YES];
}
- (void)loginSuccess{
    if ([jpushDic[@"app_jump_type"] intValue]) {
        CollectionViewController * cvc = [[CollectionViewController alloc]init];
        cvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cvc animated:YES];
    }
}
- (UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight)];
        _navView.backgroundColor = [Unity getColor:@"aa112d"];
        [_navView addSubview:self.searchView];
        [_navView addSubview:self.classBtn];
        [_navView addSubview:self.msgBtn];
    }
    return _navView;
}
- (UIButton *)classBtn{
    if (!_classBtn) {
        _classBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidth(12), NavBarHeight-44+kWidth(12), kWidth(20), kWidth(20))];
        [_classBtn setBackgroundImage:[UIImage imageNamed:@"home_class"] forState:UIControlStateNormal];
        [_classBtn addTarget:self action:@selector(classClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _classBtn;
}
- (UIButton *)msgBtn{
    if (!_msgBtn) {
        _msgBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-kWidth(12)-kWidth(20), NavBarHeight-44+kWidth(12), kWidth(20), kWidth(20))];
        [_msgBtn setBackgroundImage:[UIImage imageNamed:@"home_msg"] forState:UIControlStateNormal];
        [_msgBtn addTarget:self action:@selector(msgClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _msgBtn;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-TabBarHeight) style:UITableViewStyleGrouped];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = NO;//隐藏 tableView.separatorStyle = YES；
        _tableView.delegate = self;
        _tableView.dataSource = self;
        // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //进行数据刷新操作
            [self requesHometData];
            btnIndex = 0;
        }];

        // 马上进入刷新状态
        [self.tableView.mj_header beginRefreshing];
    }
    return _tableView;
}
- (UIView *)searchView{
    if (_searchView == nil) {
        _searchView = [[UIView alloc]initWithFrame:CGRectMake(kWidth(50), NavBarHeight-44, SCREEN_WIDTH-kWidth(100), kWidth(36))];
//        _searchView.backgroundColor = [UIColor yellowColor];
        UIImageView * searchImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kWidth(10), kWidth(15), kWidth(18))];
        searchImgView.image = [UIImage imageNamed:@"home_search"];
        [_searchView addSubview:searchImgView];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, kWidth(35), _searchView.width, 1)];
        line.backgroundColor = [Unity getColor:@"#d58896"];
        [_searchView addSubview:line];
        
        [_searchView addSubview:self.searchText];
        [_searchView addSubview:self.originalBtn];
        [_searchView addSubview:self.ChineseBtn];
        
        _originalL = [[UILabel alloc]initWithFrame:CGRectMake(_originalBtn.left, _originalBtn.bottom+4, _originalBtn.width, 2)];
        _originalL.backgroundColor = [UIColor clearColor];
        [_searchView addSubview:self.originalL];
        _chineseL = [[UILabel alloc]initWithFrame:CGRectMake(_ChineseBtn.left, _ChineseBtn.bottom+4, _ChineseBtn.width, 2)];
        _chineseL.backgroundColor = [UIColor whiteColor];
        [_searchView addSubview:self.chineseL];
    }
    return _searchView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(APNSJpush:) name:@"SystemMsgCallApp" object:nil];
//    self.searchView.hidden = NO;
//    [self addLeftBarButtonWithImage:[UIImage imageNamed:@"home_class"] action:@selector(classClick)];
//    [self addRightBarButtonWithFirstImage:[UIImage imageNamed:@"home_msg"] action:@selector(msgClick)];
//    [self requesHometData];
}
- (void)classClick{
    self.tabBarController.selectedIndex =1;
//    DemoViewController * dvc = [[DemoViewController alloc]init];
//    dvc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:dvc animated:YES];
}
- (void)msgClick{
    ServiceViewController * svc = [[ServiceViewController alloc]init];
    svc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:svc animated:YES];
//        //至此就实现在App内直接评论了。然而需要注意的是：打开次数一年不能多于3次。（当然开发期间可以无限制弹出，方便测试）
//        if (@available(iOS 10.3, *)) {
//            [SKStoreReviewController requestReview];
//        } else {
            // Fallback on earlier versions
//            MessageViewController * mvc = [[MessageViewController alloc]init];
//            mvc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:mvc animated:YES];
//        }

    
//    ActivityWebViewController *webService = [[ActivityWebViewController alloc]init];
    // 获得当前iPhone使用的语言
//    NSString* currentLanguage = NSLocalizedString(@"GlobalBuyer_Nativelanguage", nil);
//    NSLog(@"当前使用的语言：%@",currentLanguage);
//    if ([currentLanguage isEqualToString:@"zh-Hans-US"]) {
//        webService.href = @"http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html";
//    }else if([currentLanguage isEqualToString:@"zh-Hant"]){
//    http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html
//        webService.href = @"http://service.shaogood.com";
//    }else if([currentLanguage isEqualToString:@"en"]){
//        webService.href = @"http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html";
//    }else{
//        webService.href = @"http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html";
//    }
//    webService.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:webService animated:YES];
}

- (UITextField *)searchText{
    if (_searchText == nil) {
        _searchText = [[UITextField alloc]initWithFrame:CGRectMake(kWidth(25), kWidth(10), _searchView.width-kWidth(25)-kWidth(85), kWidth(20))];
//        _searchText.placeholder = @"直接搜索关键词/粘贴商品网址";
        _searchText.delegate=self;
        _searchText.textColor = [UIColor whiteColor];
//        [_searchText setValue:[Unity getColor:@"#d58896"]forKeyPath:@"_placeholderLabel.textColor"];
//        [_searchText setValue:[UIFont  boldSystemFontOfSize:13]forKeyPath:@"_placeholderLabel.font"];
        _searchText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"直接搜索关键词/粘贴商品网址" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[Unity getColor:@"#d58896"]}]; ///新的实现
    }
    return _searchText;
}
- (UIButton *)originalBtn{
    if (_originalBtn == nil) {
        _originalBtn = [[UIButton alloc]initWithFrame:CGRectMake(_searchView.width-kWidth(85), kWidth(10), kWidth(40), kWidth(20))];
        [_originalBtn setTitle:@"原文" forState:UIControlStateNormal];
        _originalBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        [_originalBtn addTarget:self  action:@selector(originalClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _originalBtn;
}
- (UIButton *)ChineseBtn{
    if (_ChineseBtn == nil) {
        _ChineseBtn = [[UIButton alloc]initWithFrame:CGRectMake(_searchView.width-kWidth(40), kWidth(10), kWidth(40), kWidth(20))];
        [_ChineseBtn setTitle:@"中文" forState:UIControlStateNormal];
        _ChineseBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        [_ChineseBtn addTarget:self  action:@selector(chineseClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ChineseBtn;
}
- (void)originalClick{
    localeIndex = 0;
    _chineseL.backgroundColor = [UIColor clearColor];
    _originalL.backgroundColor = [UIColor whiteColor];
    SearchViewController * svc = [[SearchViewController alloc]init];
    svc.hidesBottomBarWhenPushed = YES;
    svc.local = [NSString stringWithFormat:@"%ld",(long)localeIndex];
    //    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController pushViewController:svc animated:YES];
}
- (void)chineseClick{
    localeIndex = 1;
    _chineseL.backgroundColor = [UIColor whiteColor];
    _originalL.backgroundColor = [UIColor clearColor];
    SearchViewController * svc = [[SearchViewController alloc]init];
    svc.hidesBottomBarWhenPushed = YES;
    svc.local = [NSString stringWithFormat:@"%ld",(long)localeIndex];
    //    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController pushViewController:svc animated:YES];
}
#pragma mark - tableView  搭理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    if ([self.dataSource[@"special"] count] == 0) {
//        return self.dataSource.count-1;
//    }else{
//        return self.dataSource.count-1+[self.dataSource[@"special"] count];
//    }
    return self.dataSource.count-1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kWidth(255);
    }else if (indexPath.section == 1){
        return kWidth(40);
    }else if (indexPath.section == 2){
        return kWidth(135);
    }else{
        return kWidth(222);
    }
//    else{
//        return [Unity countcoordinatesH:508];
//    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.1;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        BannerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BannerCell class])];
        if (cell == nil) {
            cell = [[BannerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([BannerCell class])];
        }
        [cell configWithBannerArray:self.bannerList];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }else if(indexPath.section == 1){
        RollingMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RollingMsgCell class])];
        if (cell == nil) {
            cell = [[RollingMsgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([RollingMsgCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWithMsgList:self.msgList];
        cell.delegate = self;
        return cell;
    }else if(indexPath.section == 2){
        AuctionWebCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AuctionWebCell class])];
        if (cell == nil) {
            cell = [[AuctionWebCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([AuctionWebCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWithSubject:self.subjectList];
        cell.delegate = self;
        return cell;
    }else {
        BrandCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BrandCell class])];
        if (cell == nil) {
            cell = [[BrandCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([BrandCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWithBrandList:self.brandList];
        cell.delegate = self;
        return cell;
    }
//        else{
//        NSString * identifier = [NSString stringWithFormat:@"NewTravelMediaCell%@", [NSString stringWithFormat:@"%@", indexPath]];
//        GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//        if (cell == nil) {
//            cell = [[GoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        }
////        self.specialList[indexPath.row-4];
////        NSLog(@"--%d",indexPath.section-4);
//        NSLog(@"%@",self.specialList);
//        [cell configWithGoods:self.specialList[indexPath.section-4]];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.delegate = self;
//        return cell;
//    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return [Unity countcoordinatesH:561];
    }else{
        return 0.1;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    self.footerView = [UIView new];
    if (section == 3) {
        self.footerView.backgroundColor = [UIColor whiteColor];
        UILabel * kLine = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:15], [Unity countcoordinatesW:3], [Unity countcoordinatesH:10])];
        kLine.backgroundColor = [Unity getColor:@"aa112d"];
        [self.footerView addSubview:kLine];
        UILabel * kLabel = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], 100, [Unity countcoordinatesH:20])];
        kLabel.text = @"精选商品";
        kLabel.font = [UIFont systemFontOfSize:FontSize(16)];
        kLabel.textColor = LabelColor3;
        [self.footerView addSubview:kLabel];
        
        _topScro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:40], SCREEN_WIDTH, [Unity countcoordinatesH:30])];
        //        _topScro.backgroundColor = [UIColor yellowColor];
        _topScro.scrollEnabled = YES;
        _topScro.userInteractionEnabled = YES;
        // 没有弹簧效果
        _topScro.bounces = NO;
        // 隐藏水平滚动条Thread 6
        _topScro.showsHorizontalScrollIndicator = NO;
        [self.footerView addSubview:self.topScro];
        self.seletedBtn.frame = CGRectMake(0, 0, 0, 0);
        for (int i=0; i<self.specialList.count; i++) {
            UIButton * btn;
            if (i == 0) {
                //btn = [[UIButton alloc]initWithFrame:CGRectMake(self.seletedBtn.right+(i/i+1)*[Unity countcoordinatesW:8], 0, 100, [Unity countcoordinatesH:30])];
                btn = [[UIButton alloc]initWithFrame:CGRectMake(self.seletedBtn.right+[Unity countcoordinatesW:8], 0, 100, [Unity countcoordinatesH:30])];
            }else{
                btn = [[UIButton alloc]initWithFrame:CGRectMake(self.seletedBtn.right+(i/i+1)*[Unity countcoordinatesW:16], 0, 100, [Unity countcoordinatesH:30])];
            }
            btn.tag = 9000+i;
            [btn addTarget:self action:@selector(seletedClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:self.specialList[i][@"a_title"] forState:UIControlStateNormal];
            [btn setTitleColor:LabelColor9 forState:UIControlStateNormal];
            [btn setTitleColor:LabelColor3 forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
            if (btnIndex==i) {
                btn.selected = YES;
            }
            [btn sizeToFit];
            self.seletedBtn = btn;
            [self.topScro addSubview:btn];
            
        }
        
        self.topScro.contentSize =  CGSizeMake(self.seletedBtn.right+[Unity countcoordinatesW:16], 0);
        if (btnIndex ==0) {
            UIButton *btn1 = (UIButton *)[self.topScro viewWithTag:9000];
            self.seletedBtn = btn1;
            btnIndex = 0;
            
            self.seletedLine = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:28], self.seletedBtn.width+[Unity countcoordinatesW:32], [Unity countcoordinatesH:2])];
            self.seletedLine.backgroundColor = [Unity getColor:@"aa112d"];
            [self.topScro addSubview:self.seletedLine];
        }else{
            //滚到屏幕外面 在滚进来 会重新创建cell 所以如果之前选择的不是第一个  那么初始化以后  第一个文字颜色改变  之前点击的恢复选中状态
//            UIButton *btn1 = (UIButton *)[self.topScro viewWithTag:9000];
//            btn1.selected = NO;
            UIButton *btn2 = (UIButton *)[self.topScro viewWithTag:btnIndex+9000];
//            btn2.selected = YES;
            self.seletedBtn = btn2;

            if (btn2.centerX <SCREEN_WIDTH/2) {
                //左边滚动距离不够
                [self.topScro setContentOffset:CGPointMake(0, 0) animated:YES];
            }else if (self.topScro.contentSize.width-btn2.centerX < SCREEN_WIDTH/2) {
                //右边滚动距离不够
                [self.topScro setContentOffset:CGPointMake(self.topScro.contentSize.width-SCREEN_WIDTH, 0) animated:YES];
            }else{
                [self.topScro setContentOffset:CGPointMake(btn2.centerX-SCREEN_WIDTH/2, 0) animated:YES];
            }

            self.seletedLine = [[UILabel alloc]initWithFrame:CGRectMake(btn2.centerX-btn2.width/2-[Unity countcoordinatesW:16], [Unity countcoordinatesH:28], btn2.width+[Unity countcoordinatesW:32], [Unity countcoordinatesH:2])];
            self.seletedLine.backgroundColor = [Unity getColor:@"aa112d"];
            [self.topScro addSubview:self.seletedLine];
        }

        UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.topScro.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:1])];
        view1.backgroundColor = [Unity getColor:@"f0f0f0"];
        [self.footerView addSubview:view1];
        [self.footerView addSubview:self.collectionView];
        UIButton * moreBtn = [Unity buttonAddsuperview_superView:self.footerView _subViewFrame:CGRectMake(0, [Unity countcoordinatesH:521], SCREEN_WIDTH, [Unity countcoordinatesH:40]) _tag:self _action:@selector(moreClick) _string:@"查看更多>>" _imageName:nil];
        [moreBtn setTitleColor:[Unity getColor:@"#999999"] forState:UIControlStateNormal];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    
    
    return self.footerView;
}
//- (UIView *)footerView{
//    if (!_footerView) {
//        _footerView = [UIView new];
//    }
//    return _footerView;
//}
-(UICollectionViewFlowLayout *)gridLayout{
    if (!_gridLayout) {
        _gridLayout = [[UICollectionViewFlowLayout alloc] init];
        _gridLayout.itemSize = CGSizeMake(SCREEN_WIDTH/2, [Unity countcoordinatesH:225]);
        _gridLayout.minimumLineSpacing = [Unity countcoordinatesH:0];
        _gridLayout.minimumInteritemSpacing = [Unity countcoordinatesW:0];
        _gridLayout.sectionInset = UIEdgeInsetsZero;
    }
    return _gridLayout;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:71], SCREEN_WIDTH, [Unity countcoordinatesH:450]) collectionViewLayout:self.gridLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _collectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSLog(@"collectionGESH %lu",(unsigned long)self.collectionArr.count);
    return self.collectionArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString * identifier = [NSString stringWithFormat:@"homecell%@", [NSString stringWithFormat:@"%@", indexPath]];
        // 如果你是代码写的cell那么注册用下面的方法
    
    [collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell configCollectionViewCellImage:self.specialList[btnIndex][@"product"][indexPath.row][@"Image"] WithTitle:self.specialList[btnIndex][@"product"][indexPath.row][@"Title"] WithCurrentPlace:self.specialList[btnIndex][@"product"][indexPath.row][@"CurrentPrice"]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NewYahooDetailViewController * dvc = [[NewYahooDetailViewController alloc]init];
    dvc.hidesBottomBarWhenPushed = YES;
    dvc.item = self.collectionArr[indexPath.row][@"AuctionID"];
    dvc.platform = @"0";//暂时写死
    [self.navigationController pushViewController:dvc animated:YES];
}
- (void)moreClick{
    GoodsListViewController * gvc = [[GoodsListViewController alloc]init];
    gvc.platform = @"0";
    gvc.pageIndex = 0;
    gvc.isSearch = NO;
    NSDictionary * dic = [self dictionaryWithJsonString:self.specialList[btnIndex][@"a_keyword"]];
    gvc.classId = dic[@"cid"];
    gvc.home = YES;
    gvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:gvc animated:YES];
}
- (void)seletedClick:(UIButton *)sender{
    if (btnIndex != sender.tag-9000) {
        btnIndex = sender.tag-9000;
        
        NSArray *productArr = self.specialList[sender.tag-9000][@"product"];
        if (!productArr.count) {
            [self.collectionArr removeAllObjects];
            [self.collectionView reloadData];
            [GZMrequest postWithURLString:[GZMUrl get_home_special_url] parameters:@{@"id":self.specialList[sender.tag-9000][@"id"]} success:^(NSDictionary *data) {
        //        [self.tableView.mj_header endRefreshing];
        //        NSLog(@"%@",data);
                if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
                    NSDictionary *specialDic = data[@"data"][@"special"];
                    [self.specialList replaceObjectAtIndex:sender.tag-9000 withObject:specialDic];
                    //刷新collectionview
                    self.collectionArr = [self.specialList[sender.tag-9000][@"product"] mutableCopy];
                    [self.collectionView reloadData];

                }else{
                    [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
                }
            } failure:^(NSError *error) {
                [self.tableView.mj_header endRefreshing];
                [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            }];
        }else{
            self.collectionArr = [self.specialList[sender.tag-9000][@"product"] mutableCopy];
            [self.collectionView reloadData];
        }
        
        
        self.seletedBtn.selected = NO;
        UIButton *btn = (UIButton *)[self.topScro viewWithTag:sender.tag];
        btn.selected = YES;
        self.seletedBtn = btn;
        
        NSLog(@"btn.x = %f",btn.centerX);
        if (btn.centerX <SCREEN_WIDTH/2) {
            //左边滚动距离不够
            [self.topScro setContentOffset:CGPointMake(0, 0) animated:YES];
        }else if (self.topScro.contentSize.width-btn.centerX < SCREEN_WIDTH/2) {
            //右边滚动距离不够
            [self.topScro setContentOffset:CGPointMake(self.topScro.contentSize.width-SCREEN_WIDTH, 0) animated:YES];
        }else{
            [self.topScro setContentOffset:CGPointMake(btn.centerX-SCREEN_WIDTH/2, 0) animated:YES];
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            [self.seletedLine setFrame:CGRectMake(btn.centerX-btn.width/2-[Unity countcoordinatesW:16], [Unity countcoordinatesH:28], btn.width+[Unity countcoordinatesW:32], [Unity countcoordinatesH:2])];
        }completion:nil];
        
        
    }
}
//- (UIScrollView *)topScro{
//    if (!_topScro) {
//        _topScro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:40], SCREEN_WIDTH, [Unity countcoordinatesH:30])];
////        _topScro.backgroundColor = [UIColor yellowColor];
//        _topScro.scrollEnabled = YES;
//        _topScro.userInteractionEnabled = YES;
//        // 没有弹簧效果
//        _topScro.bounces = NO;
//        // 隐藏水平滚动条
//        _topScro.showsHorizontalScrollIndicator = NO;
//    }
//    return _topScro;
//}
#pragma mark - BannerCell 事件
- (void)homeBtn:(NSInteger)tag{
//    NSLog(@"%ld",(long)tag);
    switch (tag) {
        case 0:
        {
            [self.cView optionConverView];
        }
            break;
        case 1:
        {
            NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
            if (userInfo == nil) {
                LoginViewController * lvc = [[LoginViewController alloc]init];
                lvc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:lvc animated:YES];
            }else{
                BalanceViewController *bvc = [[BalanceViewController alloc]init];
                bvc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:bvc animated:YES];
            }
        }
            break;
//        case 2:
//               {
//                   ShooseGJViewController * nvc = [[ShooseGJViewController alloc]init];
//                   nvc.hidesBottomBarWhenPushed = YES;
//                   [self.navigationController pushViewController:nvc animated:YES];
//               }
//                   break;
        case 2:
        {
            CalculateViewController * cvc = [[CalculateViewController alloc]init];
            cvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cvc animated:YES];
        }
            break;
        case 3:
        {
            HaitaoViewController * hvc = [[HaitaoViewController alloc]init];
            hvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:hvc animated:YES];
        }
            break;
            
        default:
            break;
    }
}
- (void)bannerImg:(NSDictionary *)dic{
    if ([dic[@"w_sepcial"] isKindOfClass:[NSNull class]] || [dic[@"w_sepcial"] isEqualToString:@""]) {
        WebViewController * wvc= [[WebViewController alloc]init];
        wvc.hidesBottomBarWhenPushed = YES;
        wvc.webUrl = dic[@"w_link"];
        wvc.nav_t = dic[@"w_title"];
        [self.navigationController pushViewController:wvc animated:YES];
    }else{
        NSLog(@"%@",dic);
        if ([dic[@"w_cc"]isEqualToString:@"0"]) {
            GoodsListViewController * gvc = [[GoodsListViewController alloc]init];
            gvc.platform = @"0";
            gvc.pageIndex = 0;
            gvc.isSearch = NO;
            gvc.zhutiId = dic[@"w_sepcial"];
            gvc.home = YES;
            gvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:gvc animated:YES];
        }else{
            EbayGoodsListViewController * gvc = [[EbayGoodsListViewController alloc]init];
            gvc.platform = @"5";
            gvc.pageIndex = 0;
            gvc.isSearch = NO;
            gvc.zhutiId = dic[@"w_sepcial"];
            gvc.home = YES;
            gvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:gvc animated:YES];
        }
    }

}
- (void)about{
    HelpViewController * hvc = [[HelpViewController alloc]init];
    hvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hvc animated:YES];
}
#pragma mark - AuctionWebCell 事件
- (void)auctionIndex:(NSInteger)index{
    NSLog(@"%@",self.subjectList);
    AppDelegate * myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([self.subjectList[index][@"is_link"] isEqualToString:@"0"]) {
        myDelegate.pageTrue = index+1;
        self.tabBarController.selectedIndex =1;
    }else{
        WebViewController * wvc= [[WebViewController alloc]init];
        wvc.hidesBottomBarWhenPushed = YES;
        wvc.webUrl = self.subjectList[index][@"link_url"];
        wvc.nav_t = self.subjectList[index][@"a_title"];
        [self.navigationController pushViewController:wvc animated:YES];
    }
}
#pragma mark - BrandCell 事件
- (void)brandCellMore{
    AppDelegate * myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    myDelegate.pageTrue = 3;
    self.tabBarController.selectedIndex =1;
//    ClassViewController * cvc = [[ClassViewController alloc]init];
//    cvc.tag = 2;
//    [self.navigationController pushViewController:cvc animated:YES];
    
}
- (void)brandCellItem:(NSInteger)index{
//    NSLog(@"=====%@",self.brandList[index-1000]);
    GoodsListViewController * gvc = [[GoodsListViewController alloc]init];
    gvc.hidesBottomBarWhenPushed = YES;
    gvc.pageIndex =1;
    gvc.isSearch = NO;
    gvc.platform = @"0";
    gvc.brandId = self.brandList[index-1000][@"a_keyword"];
    [self.navigationController pushViewController:gvc animated:YES];
}
#pragma mark - GoodsCell 事件
- (void)goodsCellMore:(NSDictionary *)dic{
    GoodsListViewController * gvc = [[GoodsListViewController alloc]init];
    gvc.platform = @"0";
    gvc.pageIndex = 3;
    gvc.isSearch = NO;
    gvc.zhutiId = dic[@"id"];
    gvc.home = YES;
    gvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:gvc animated:YES];
}
- (void)goodsCellData:(NSDictionary *_Nullable)dic{
    NewYahooDetailViewController * dvc = [[NewYahooDetailViewController alloc]init];
    dvc.hidesBottomBarWhenPushed = YES;
    dvc.item = dic[@"AuctionID"];
    dvc.platform = @"0";//暂时写死
    [self.navigationController pushViewController:dvc animated:YES];
}

#pragma mark - UITextField 代理
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    SearchViewController * svc = [[SearchViewController alloc]init];
    svc.hidesBottomBarWhenPushed = YES;
    svc.local = [NSString stringWithFormat:@"%ld",(long)localeIndex];
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController pushViewController:svc animated:YES];
    return NO;
}

-(void)requestSliderData{
    [GZMrequest getWithURLString:[GZMUrl get_home_slide_url] parameters:nil success:^(NSDictionary *data) {
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            NSInteger slideTime = [data[@"data"] integerValue];
            // 保存刷新时间
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:slideTime] forKey:@"slideTime"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    } failure:^(NSError *error) {
            
    }];
}
- (void)requesHometData{
    [self.bannerList removeAllObjects];
    [self.msgList removeAllObjects];
    NSString * homeJson = [[NSUserDefaults standardUserDefaults]objectForKey:@"homeData"];
    self.dataSource =[self dictionaryWithJsonString:homeJson];
    NSDictionary * dict2 = self.dataSource;
    if (homeJson != nil) {
        for (int i=0; i<[self.dataSource[@"carousel"] count]; i++) {
            [self.bannerList addObject:self.dataSource[@"carousel"][i]];
        }
        for (int i=0; i<[self.dataSource[@"notice"] count]; i++) {
            [self.msgList addObject:self.dataSource[@"notice"][i]];
        }
        self.subjectList = self.dataSource[@"subject"];
        self.brandList = self.dataSource[@"brand"];
        self.specialList = [self.dataSource[@"special"] mutableCopy];
        self.collectionArr = [self.specialList[0][@"product"] mutableCopy];
        
    }
    [self.collectionView reloadData];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [GZMrequest getWithURLString:[GZMUrl get_home_url] parameters:nil success:^(NSDictionary *data) {
//        [self.tableView.mj_header endRefreshing];
//        NSLog(@"%@",data);
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            [self.bannerList removeAllObjects];
            [self.msgList removeAllObjects];
            self.dataSource = data[@"data"];
            for (int i=0; i<[data[@"data"][@"carousel"] count]; i++) {
                [self.bannerList addObject:data[@"data"][@"carousel"][i]];
            }
            for (int i=0; i<[data[@"data"][@"notice"] count]; i++) {
                [self.msgList addObject:data[@"data"][@"notice"][i]];
            }
            self.subjectList = data[@"data"][@"subject"];
            self.brandList = data[@"data"][@"brand"];
            self.specialList = [data[@"data"][@"special"] mutableCopy];
            self.collectionArr = [self.specialList[0][@"product"] mutableCopy];

            if ([dict2 isEqual:self.dataSource] == 0) {
                [self.tableView reloadData];
                [[NSUserDefaults standardUserDefaults] setObject:[self dictionaryToJson:self.dataSource] forKey:@"homeData"];
            }
//            NSLog(@"是否相等 = %d",[dict2 isEqual:self.dataSource]);

        }else{
            [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
//字典转json格式字符串：
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//json格式字符串转字典：
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    _searchView.hidden = YES;
}
- (NSDictionary * )dataSource{
    if (!_dataSource) {
        _dataSource = [NSDictionary new];
    }
    return _dataSource;
}
- (NSMutableArray *)bannerList{
    if (!_bannerList) {
        _bannerList = [NSMutableArray new];
    }
    return _bannerList;
}
- (NSMutableArray *)msgList{
    if (!_msgList) {
        _msgList = [NSMutableArray new];
    }
    return _msgList;
}
- (NSArray *)subjectList{
    if (!_subjectList) {
        _subjectList = [NSArray new];
    }
    return _subjectList;
}
- (NSArray *)brandList{
    if (!_brandList) {
        _brandList = [NSArray new];
    }
    return _brandList;
}
- (NSMutableArray *)specialList{
    if (!_specialList) {
        _specialList = [NSMutableArray new];
    }
    return _specialList;
}
- (void)requestExrate{
    NSLog(@"请求汇率");
    [GZMrequest getWithURLString:[GZMUrl get_exrate_url] parameters:nil success:^(NSDictionary *data) {
        NSLog(@"%@",data);
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            [[NSUserDefaults standardUserDefaults] setObject:data[@"data"] forKey:@"exrate"];
        }
    } failure:^(NSError *error) {
    }];
}
- (void)requestLogin{
    NSLog(@"请求免登陆");
    NSDictionary * loginDic = [[NSUserDefaults standardUserDefaults]objectForKey:@"login"];
//    NSLog(@"登录信息 %@",loginDic);
    if (loginDic == nil) {
        return;
    }
    NSDictionary *params = @{@"token":loginDic[@"token"],@"customer":loginDic[@"member_id"],@"tag":[Unity getLanguage]};
    [GZMrequest postWithURLString:[GZMUrl get_avoidLogin_url] parameters:params success:^(NSDictionary *data) {
//        NSLog(@"%@",data);
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            NSMutableDictionary * dict = [NSMutableDictionary new];
            [dict setObject:data[@"data"][@"id"] forKey:@"member_id"];
            [dict setObject:data[@"data"][@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"login"];
            NSMutableDictionary * muDic = [Unity editLoginData:data[@"data"]];
            
            [[NSUserDefaults standardUserDefaults]setObject:muDic forKey:@"userInfo"];
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfo" object:nil];
//            NSLog(@"免登录成功%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"]);
            //登陆成功 如果有本地足迹 上传服务器
            [self uploadFoot:data[@"data"][@"w_email"]];
        }else{
//            NSLog(@"登录失败");
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userInfo"];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)msgMore{
    
    InfomationViewController * ivc = [[InfomationViewController alloc]init];
    ivc.hidesBottomBarWhenPushed= YES;
    [self.navigationController pushViewController:ivc animated:YES];
}
- (void)noticeBack:(NSDictionary *)dic{
    HelpDetailViewController * hvc = [[HelpDetailViewController alloc]init];
    hvc.navTitle = dic[@"w_title"];
    hvc.htmlStr = dic[@"w_content"];
    hvc.flow = @"0";
    hvc.type = 99;
    hvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hvc animated:YES];
}
- (ConverView *)cView{
    if (!_cView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _cView = [ConverView setConverView:window];
    }
    return _cView;
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
        NSDictionary * infoDictionary = [[NSBundle mainBundle] infoDictionary];
        // app版本
        NSString * app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSLog(@" ==%@",app_Version);
        if (sender[@"version"] != nil) {
            NSArray * lineArray = [sender[@"version"] componentsSeparatedByString:@"."];
            NSArray * array = [app_Version componentsSeparatedByString:@"."];
            if ([lineArray[0] intValue]>[array[0] intValue]) {
                //有新版本
                [self showAlertTitle:@"发现新版本，如不更新可能部分功能无法正常使用。" Message:sender[@"releaseNotes"]];
                return;
            }else if ([lineArray[0] intValue]==[array[0] intValue]){
                if ([lineArray[1] intValue]>[array[1] intValue]) {
                    //有新版本
                    [self showAlertTitle:@"发现新版本，如不更新可能部分功能无法正常使用。" Message:sender[@"releaseNotes"]];
                    return;
                }else if ([lineArray[1] intValue]==[array[1] intValue]){
                    if ([lineArray[2] intValue]>[array[2] intValue]) {
                        //有新版本
                        [self showAlertTitle:@"发现新版本，如不更新可能部分功能无法正常使用。" Message:sender[@"releaseNotes"]];
                        return;
                    }
                }
            }
        }
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
- (NSMutableArray *)collectionArr{
    if (!_collectionArr) {
        _collectionArr = [NSMutableArray new];
    }
    return _collectionArr;
}
- (void)uploadFoot:(NSString *)user{
    NSArray * arr =  [[NSUserDefaults standardUserDefaults] objectForKey:@"footInfo"];
    if (arr.count>1) {
        NSDictionary * dic = @{@"user":user,@"markdata":[Unity gs_jsonStringCompactFormatForNSArray:arr]};
        [GZMrequest postWithURLString:[GZMUrl get_saveFoot_url] parameters:dic success:^(NSDictionary *data) {
            NSLog(@"保存返回%@",data);
            if ([data[@"status"] intValue] == 1) {
                NSArray * array = [NSArray new];
                [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"footInfo"];
            }
        } failure:^(NSError *error) {
            
        }];
    }
}
- (advertising *)aView{
    if (!_aView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _aView = [advertising setadvertising:window];
    }
    return _aView;
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
