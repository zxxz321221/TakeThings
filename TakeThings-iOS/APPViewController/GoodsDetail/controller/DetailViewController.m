//
//  DetailViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/24.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "DetailViewController.h"
#import "GoodsWebCell.h"
#import "GoodsTitleCell.h"
#import "AuctionCell.h"
#import "GoodsTimeCell.h"
#import "GoodsDetailCell.h"
#import "SellerCell.h"
#import "TrialViewController.h"
#import "EntrustViewController.h"
#import "ProductParametersView.h"
#import "SDCycleScrollView.h"
#import "LoginViewController.h"
#import "WebViewController.h"
#import "GoodsListViewController.h"
#import "ActivityWebViewController.h"
@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,AuctionCellDelegate,GoodsDetailCellDelegate,SellerCellDelegate,SDCycleScrollViewDelegate>
{
    NSInteger index;
    NSString * endTime;
    NSDictionary * userInfo;
    BOOL isGoods;
    BOOL isSaler;
    NSString *goodsStr;
    NSString *salerStr;
    NSString * webUrl;
}
@property (nonatomic , strong) UIView * headerView;
@property (nonatomic , strong) NSMutableArray * imagesURLStrings;
@property (nonatomic , strong) SDCycleScrollView * cycleScrollView;//轮播图
@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic ,assign) CGFloat webHeight;

@property (nonatomic , strong) UILabel * line;
@property (nonatomic , strong) UIButton * translateBtn;
@property (nonatomic , strong) UILabel * translateLine;
@property (nonatomic , strong) UIButton * originalBtn;
@property (nonatomic , strong) UILabel * originalLine;
@property (nonatomic , strong) UIButton * helpBtn;
@property (nonatomic , strong) UILabel * helpLine;

@property (nonatomic , strong) UIView * footerView;
@property (nonatomic , strong) UIImageView * collectionImg;
@property (nonatomic , strong) UIImageView * navIcon;

@property (nonatomic , strong) UIButton *leftButton;
@property (nonatomic , strong) UIButton * rightButton;

@property (nonatomic , strong) UIButton * backBtn;
@property (nonatomic , strong) UIButton * rightBtn;

@property (nonatomic , strong) ProductParametersView * pView;
@property (nonatomic , strong) alertView * altView;
@property (nonatomic , strong) AroundAnimation * aAnimation;

@property (nonatomic , strong) NSDictionary * dict;
@property (nonatomic , strong) NSMutableArray * webArr;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    endTime = @"";
    isGoods = NO;
    isSaler = NO;
    index=0;
//    self.y_navLineHidden = YES;
//    self.y_navBarAlpha = 0;
    
    
    [self.navigationController.view addSubview:self.navIcon];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.footerView];
    
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.rightBtn];
    
//    [self requestGoodsDetail];
}
- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(21, NavBarHeight-44+7.5, 28.5, 28.5)];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"good_back"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-49.5, NavBarHeight-44+7.5, 28.5, 28.5)];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(refreshClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat H = 0.0;
        if (IS_iPhoneX) {
            H=TabBarHeight;
        }else{
            H = [Unity countcoordinatesH:50];
        }
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-H) style:UITableViewStylePlain];
        self.tableView.delegate=self;
        self.tableView.dataSource = self;
        self.tableView.contentInset = UIEdgeInsetsMake([Unity countcoordinatesH:300], 0, 0, 0);
        self.tableView.showsVerticalScrollIndicator = FALSE;
        self.tableView.showsHorizontalScrollIndicator = FALSE;
        
        //没有数据时不显示cell
        self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}
- (UIImageView *)navIcon{
    if (!_navIcon) {
        _navIcon = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-40)/2, NavBarHeight-44, 40, 40)];
//        _navIcon.backgroundColor = [UIColor redColor];
        _navIcon.alpha = 0;
    }
    return _navIcon;
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:300])];
//        _headerView.backgroundColor = [UIColor yellowColor];
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _headerView.height) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _cycleScrollView.backgroundColor = [UIColor clearColor];
        _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
        _cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
        _cycleScrollView.autoScrollTimeInterval = 4;
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
//        _cycleScrollView.imageURLStringsGroup = _imagesURLStrings;
        [_headerView addSubview:_cycleScrollView];
    }
    return _headerView;
}
- (UIView *)footerView{
    if (!_footerView) {
        CGFloat H = 0.0;
        if (IS_iPhoneX) {
            H = TabBarHeight;
        }else{
            H = [Unity countcoordinatesH:50];
        }
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-H, SCREEN_WIDTH, H)];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        line.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [_footerView addSubview:line];
        
        UIButton * consultBtn = [Unity buttonAddsuperview_superView:_footerView _subViewFrame:CGRectMake([Unity countcoordinatesW:5], 0, [Unity countcoordinatesW:40], [Unity countcoordinatesH:50]) _tag:self _action:@selector(consultClick) _string:@"" _imageName:@""];
        UIImageView * imgView = [Unity imageviewAddsuperview_superView:consultBtn _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:20], [Unity countcoordinatesH:20]) _imageName:@"咨询" _backgroundColor:nil];
        imgView.userInteractionEnabled=YES;
        UILabel * consultL = [Unity lableViewAddsuperview_superView:consultBtn _subViewFrame:CGRectMake( 0, imgView.bottom, [Unity countcoordinatesW:40], [Unity countcoordinatesH:20]) _string:@"咨询" _lableFont:[UIFont systemFontOfSize:15] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentCenter];
        consultL.backgroundColor = [UIColor clearColor];
        
        UIButton * collectionBtn = [Unity buttonAddsuperview_superView:_footerView _subViewFrame:CGRectMake(consultBtn.right+[Unity countcoordinatesW:10], consultBtn.top, consultBtn.width, consultBtn.height) _tag:self _action:@selector(collectionClick) _string:@"" _imageName:@""];
        _collectionImg = [Unity imageviewAddsuperview_superView:collectionBtn _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:20], [Unity countcoordinatesH:20]) _imageName:@"未收藏" _backgroundColor:nil];
        _collectionImg.userInteractionEnabled=NO;
        UILabel * collectionL = [Unity lableViewAddsuperview_superView:collectionBtn _subViewFrame:CGRectMake( 0, _collectionImg.bottom, [Unity countcoordinatesW:40], [Unity countcoordinatesH:20]) _string:@"收藏" _lableFont:[UIFont systemFontOfSize:15] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentCenter];
        collectionL.backgroundColor = [UIColor clearColor];
        
        UIButton * calculaBtn = [Unity buttonAddsuperview_superView:_footerView _subViewFrame:CGRectMake(collectionBtn.right+[Unity countcoordinatesW:20], [Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:37]) _tag:self _action:@selector(calculaClick) _string:@"费用试算" _imageName:@"费用试算"];
        [calculaBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        UIButton * biddingBtn = [Unity buttonAddsuperview_superView:_footerView _subViewFrame:CGRectMake(calculaBtn.right, calculaBtn.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:37]) _tag:self _action:@selector(biddingClick) _string:@"我要竞标" _imageName:@"我要竞标"];
        biddingBtn.backgroundColor = [UIColor clearColor];
        
    }
    return _footerView;
}
#pragma mark - tableView  搭理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        return [Unity countcoordinatesH:220];
    }
//    else if (indexPath.section == 1){
//        return [Unity countcoordinatesH:210];
//    }
    else if (indexPath.section == 1){
        return [Unity countcoordinatesH:80];
    }else if(indexPath.section == 2){
        return [Unity countcoordinatesH:60];
    }else if(indexPath.section == 3){
        return [Unity countcoordinatesH:106];
    }else{
        return [GoodsWebCell cellHeight];//web高度，全局属性
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 4) {
        return [Unity countcoordinatesH:60];
    }
    return 0.1;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tableViewSectionHeaderV = [UIView new];
    tableViewSectionHeaderV.backgroundColor = [UIColor whiteColor];
    if (section == 4) {
        _translateBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, [Unity countcoordinatesH:50])];
        [_translateBtn setTitle:@"翻译介绍" forState:UIControlStateNormal];
        [_translateBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        _translateBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_translateBtn addTarget:self action:@selector(translateClick) forControlEvents:UIControlEventTouchUpInside];
        
        _translateLine = [Unity lableViewAddsuperview_superView:_translateBtn _subViewFrame:CGRectMake(0, [Unity countcoordinatesH:47], _translateBtn.width, [Unity countcoordinatesH:3]) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentCenter];
        _translateLine.backgroundColor = [Unity getColor:@"#aa112d"];
        [tableViewSectionHeaderV addSubview:self.translateBtn];
        
        _originalBtn = [[UIButton alloc]initWithFrame:CGRectMake(_translateBtn.right, 0, SCREEN_WIDTH/2, [Unity countcoordinatesH:50])];
        [_originalBtn setTitle:@"原文介绍" forState:UIControlStateNormal];
        [_originalBtn setTitleColor:LabelColor9 forState:UIControlStateNormal];
        _originalBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_originalBtn addTarget:self action:@selector(originaClick) forControlEvents:UIControlEventTouchUpInside];
        
        _originalLine = [Unity lableViewAddsuperview_superView:_originalBtn _subViewFrame:CGRectMake(0, [Unity countcoordinatesH:47], _originalBtn.width, [Unity countcoordinatesH:3]) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentCenter];
        _originalLine.backgroundColor = [Unity getColor:@"#aa112d"];
        _originalLine.hidden = YES;
        [tableViewSectionHeaderV addSubview:self.originalBtn];
        
//        _helpBtn = [[UIButton alloc]initWithFrame:CGRectMake(_originalBtn.right, 0, SCREEN_WIDTH/3, [Unity countcoordinatesH:50])];
//        [_helpBtn setTitle:@"帮助与说明" forState:UIControlStateNormal];
//        [_helpBtn setTitleColor:LabelColor9 forState:UIControlStateNormal];
//        _helpBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//        [_helpBtn addTarget:self action:@selector(helpClick) forControlEvents:UIControlEventTouchUpInside];
//
//        _helpLine = [Unity lableViewAddsuperview_superView:_helpBtn _subViewFrame:CGRectMake(0, [Unity countcoordinatesH:47], _helpBtn.width, [Unity countcoordinatesH:3]) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentCenter];
//        _helpLine.backgroundColor = [Unity getColor:@"#aa112d"];
//        _helpLine.hidden = YES;
//        [tableViewSectionHeaderV addSubview:self.helpBtn];
        
        _line = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:50], SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        _line.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [tableViewSectionHeaderV addSubview:self.line];
        
        if (index==0) {
            [self.translateBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
            [self.originalBtn setTitleColor:LabelColor9 forState:UIControlStateNormal];
            [self.helpBtn setTitleColor:LabelColor9 forState:UIControlStateNormal];
            self.translateLine.hidden = NO;
            self.originalLine.hidden = YES;
            self.helpLine.hidden=YES;
        }else if (index ==1){
            [self.translateBtn setTitleColor:LabelColor9 forState:UIControlStateNormal];
            [self.originalBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
            [self.helpBtn setTitleColor:LabelColor9 forState:UIControlStateNormal];
            self.originalLine.hidden = NO;
            self.translateLine.hidden = YES;
            self.helpLine.hidden=YES;
        }else{
            [self.translateBtn setTitleColor:LabelColor9 forState:UIControlStateNormal];
            [self.originalBtn setTitleColor:LabelColor9 forState:UIControlStateNormal];
            [self.helpBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
            self.translateLine.hidden = YES;
            self.originalLine.hidden = YES;
            self.helpLine.hidden=NO;
        }
    }
    
    return tableViewSectionHeaderV;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        GoodsTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GoodsTitleCell class])];
        if (cell == nil) {
            cell = [[GoodsTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([GoodsTitleCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cell.delegate = self;
        [cell configWithDict:self.dict WithPlaform:self.platform];
        return cell;
    }
//    else if(indexPath.section ==1){
//        AuctionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AuctionCell class])];
//        if (cell == nil) {
//            cell = [[AuctionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([AuctionCell class])];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        cell.delegate = self;
//        return cell;
//    }
    else if(indexPath.section ==1){
        GoodsTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GoodsTimeCell class])];
        if (cell == nil) {
            cell = [[GoodsTimeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([GoodsTimeCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWithEndTime:endTime WithPlatform:self.platform WithPrice:[Unity getSmallestUnitOfBid:self.dict[@"goods"][@"Result"][@"Price"]] WithBidCount:@""];
        return cell;
    }else if(indexPath.section == 2){
        GoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GoodsDetailCell class])];
        if (cell == nil) {
            cell = [[GoodsDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([GoodsDetailCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }else if(indexPath.section == 3){
        SellerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SellerCell class])];
        if (cell == nil) {
            cell = [[SellerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([SellerCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWithDict:self.dict isCollection:isSaler];
        cell.delegate = self;
        return cell;
    }else{
        GoodsWebCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GoodsWebCell class])];
        if (cell == nil) {
            cell = [[GoodsWebCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([GoodsWebCell class])];
        }
        if (index ==0) {
            cell.htmlString = [NSString stringWithFormat:@"<!DOCTYPE html> \n"
                               "<html> \n"
                               "<head> \n"
                               "<meta charset=\"UTF-8\"> \n"
                               "</head> \n"
                               "<body>%@"
                               "</body>"
                               "<script type='text/javascript'>"
                               "window.onload = function(){\n"
                               "var $img = document.getElementsByTagName('img');\n"
                               "for(var p in  $img){\n"
                               " $img[p].style.width = '100%%';\n"
                               "$img[p].style.height ='auto'\n"
                               "}\n"
                               "}"
                               "</script>"
                               "</html>",webUrl];
        }else{
//            webUrl = @"china";
            cell.htmlString = [NSString stringWithFormat:@"<!DOCTYPE html> \n"
                               "<html> \n"
                               "<head> \n"
                               "<meta charset=\"UTF-8\"> \n"
                               "</head> \n"
                               "<body>%@"
                               "</body>"
                               "<script type='text/javascript'>"
                               "var head = document.head || document.getElementsByTagName('head')[0]; \n"
                               "var script4 = document.createElement('div'); \n"
                               "script4.id = \"ytWidget\"; \n"
                               "script4.style.display = \"none\"; \n"
                               "document.body.appendChild(script4); \n"
                               "var script5 = document.createElement('script'); \n"
                               "script5.src = \"https://translate.yandex.net/website-widget/v1/widget.js?widgetId=ytWidget&pageLang=auto&widgetTheme=light&autoMode=true\"; \n"
                               "head.appendChild(script5); \n"
                               "window.onload = function(){\n"
                               "var $img = document.getElementsByTagName('img');\n"
                               "for(var p in  $img){\n"
                               " $img[p].style.width = '100%%';\n"
                               "$img[p].style.height ='auto'\n"
                               "}\n"
                               "}"
                               "</script>"
                               "</html>",webUrl];
        }
//        cell.htmlString = webUrl;
        __weak typeof(self) weakSelf = self;
        cell.reloadBlock = ^(void){
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //禁止tableview下拉
    CGPoint offset1 = _tableView.contentOffset;
//    NSLog(@"%f",offset1.y);
    if (offset1.y <= -[Unity countcoordinatesH:300]) {
        offset1.y = -[Unity countcoordinatesH:300];
    }
    _tableView.contentOffset = offset1;
    
    if (scrollView.contentOffset.y <=0 && scrollView.contentOffset.y>=0-[Unity countcoordinatesH:300]) {
        CGFloat headerH = scrollView.contentOffset.y+[Unity countcoordinatesH:300];
        _headerView.frame = CGRectMake(0, 0-headerH, SCREEN_WIDTH, [Unity countcoordinatesH:300]);
    }
    CGFloat sectionHeaderHeight = [Unity countcoordinatesH:300];
    if (scrollView.contentOffset.y<=(0-NavBarHeight) && scrollView.contentOffset.y>=0-sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(0-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=(0-NavBarHeight)) {
        scrollView.contentInset = UIEdgeInsetsMake(NavBarHeight, 0, 0, 0);
    }
    
    
    CGFloat minAlphaOffset = NavBarHeight;
    CGFloat maxAlphaOffset = [Unity countcoordinatesH:300];
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = 0.99-((0-offset-minAlphaOffset) / (maxAlphaOffset-minAlphaOffset));
//        NSLog(@"%f",alpha);
    //左右两边按钮
    CGFloat btnalpha = alpha;
    if (btnalpha<=0.05) {
        btnalpha = 0.05;
    }else if(btnalpha >= 0.99){
        btnalpha = 0.99;
    }
    
    if (alpha<=0) {
        alpha = 0;
    }else if(alpha >=0.99){
        alpha = 0.99;
    }
//    self.y_navBarAlpha = alpha;
    self.navIcon.alpha = alpha;
    self.leftButton.alpha = btnalpha;
    self.rightButton.alpha = btnalpha;
}
- (void)addLeftBarButtonWithImage:(UIImage *)image action:(SEL)action
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    view.backgroundColor = [UIColor clearColor];
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton .frame = CGRectMake(0, 0, 44, 44);
    [self.leftButton  setImage:image forState:UIControlStateNormal];
    [self.leftButton  addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    self.leftButton .contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.leftButton  setImageEdgeInsets:UIEdgeInsetsMake(0, 5 * SCREEN_WIDTH / 375.0, 0, 0)];
    self.leftButton.alpha = 0.05;
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton ];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}
//右侧一个图片按钮的情况
- (void)addRightBarButtonWithFirstImage:(UIImage *)firstImage action:(SEL)action
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    view.backgroundColor = [UIColor clearColor];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(0, 0, 44, 44);
    [self.rightButton setImage:firstImage forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    self.rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5 * SCREEN_WIDTH / 375.0)];
    self.rightButton.alpha = 0.05;
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
#pragma mark - GoodsButtonCell事件（翻译介绍 原文介绍 帮助与说明）
- (void)translateClick{
    if (index ==0) {
        return;
    }
    index=0;
    
    [self.tableView reloadData];
}
- (void)originaClick{
    if (index==1) {
        return;
    }
    index=1;
    [self.tableView reloadData];
}
- (void)helpClick{
    if (index==2) {
        return;
    }
    index=2;
    [self.tableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.navIcon.hidden=NO;
    self.navIcon.alpha=0;
    [self addLeftBarButtonWithImage:[UIImage imageNamed:@"detailback"] action:@selector(backClick)];
    [self addRightBarButtonWithFirstImage:[UIImage imageNamed:@"detailR"] action:@selector(refreshClick)];
    userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    [self requestGoodsDetail];
}
- (void)viewWillDisappear:(BOOL)animated{
    self.navIcon.hidden=YES;
}

#pragma mark - 导航栏按钮事件（导航栏两边按钮）
- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)refreshClick{
    [self requestGoodsDetail];
}
#pragma mark - footerView 事件(咨询，收藏，费用试算，我要竞标)
- (void)consultClick{
//    NSLog(@"footerView 事件（咨询）");
    ActivityWebViewController *webService = [[ActivityWebViewController alloc]init];
    // 获得当前iPhone使用的语言
    NSString* currentLanguage = NSLocalizedString(@"GlobalBuyer_Nativelanguage", nil);
    NSLog(@"当前使用的语言：%@",currentLanguage);
    if ([currentLanguage isEqualToString:@"zh-Hans-US"]) {
        webService.href = @"http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html";
    }else if([currentLanguage isEqualToString:@"zh-Hant"]){
        webService.href = @"http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html";
    }else if([currentLanguage isEqualToString:@"en"]){
        webService.href = @"http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html";
    }else{
        webService.href = @"http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html";
    }
    webService.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webService animated:YES];
}
- (void)collectionClick{
//    NSLog(@"footerView 事件（收藏）");
    if (userInfo == nil) {
        LoginViewController * lvc = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:lvc animated:YES];
        
        return;
    }
    if (isGoods) {
        //删除收藏
        NSDictionary * dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"type":@"goods",@"ids":goodsStr};
        [self.aAnimation startAround];
        [GZMrequest postWithURLString:[GZMUrl get_deleteCollection_url] parameters:dic success:^(NSDictionary *data) {
            [self.aAnimation stopAround];
            if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
                self.collectionImg.image = [UIImage imageNamed:@"未收藏"];
                [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
                isGoods = NO;
            }else{
                [self.altView showAlertView];
                self.altView.msgL.text = [data objectForKey:@"msg"];
            }
        } failure:^(NSError *error) {
            [self.aAnimation stopAround];
            [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }];
    }else{
        NSArray * arr = [self.dict[@"goods"][@"Result"][@"CategoryIdPath"] componentsSeparatedByString:@","];
        NSString * str1 = @"";
        NSString * str2 = @"";
        if (arr.count >=2) {
            str1 = arr[1];
        }
        if (arr.count >=6){
            str2 = arr[5];
        }else if (arr.count >=4){
            str2 = arr[3];
        }
        NSDictionary * dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"area":@"0",@"type":@"goods",@"w_main_category_id":str1,@"w_goods_category_id":str2,@"w_object":self.dict[@"goods"][@"Result"][@"Title"],@"w_link":self.dict[@"goods"][@"Result"][@"AuctionItemUrl"],@"w_overtime":self.dict[@"goods"][@"Result"][@"EndTime"],@"w_jpnid":self.dict[@"goods"][@"Result"][@"AuctionID"],@"w_imgsrc":self.dict[@"goods"][@"Result"][@"Img"][@"Image1"],@"w_saler":self.dict[@"goods"][@"Result"][@"Seller"][@"Id"],@"w_tag":@""};
        NSLog(@"收藏请求= %@",dic);
        [self.aAnimation startAround];
        [GZMrequest postWithURLString:[GZMUrl get_collection_url] parameters:dic success:^(NSDictionary *data) {
            [self.aAnimation stopAround];
            if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
                [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
                goodsStr = data[@"data"];
                self.collectionImg.image = [UIImage imageNamed:@"已收藏"];
                isGoods = YES;
//                NSLog(@"%@",data);
            }else{
                [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            }
        } failure:^(NSError *error) {
            [self.aAnimation stopAround];
            [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }];
    }
}
- (void)calculaClick{
    NSLog(@"footerView 事件（费用试算）");
    TrialViewController * tvc = [[TrialViewController alloc]init];
    tvc.platform = self.platform;
    tvc.price = self.dict[@"goods"][@"Result"][@"Price"];
    tvc.goodsTitle = self.dict[@"goods"][@"Result"][@"Title"];
    tvc.imageUrl = self.imagesURLStrings[0];
    tvc.taxRate = self.dict[@"goods"][@"Result"][@"TaxRate"];
    tvc.endTime = endTime;
    tvc.increment = [Unity getSmallestUnitOfBid:self.dict[@"goods"][@"Result"][@"Price"]];
    tvc.goodsID= self.dict[@"goods"][@"Result"][@"AuctionID"];
    tvc.bidorbuy = self.dict[@"goods"][@"Result"][@"Bidorbuy"];
    tvc.link = self.dict[@"goods"][@"Result"][@"AuctionItemUrl"];
    tvc.isDetail = YES;
    [self.navigationController pushViewController:tvc animated:YES];
}
- (void)biddingClick{
    if (userInfo == nil) {
        LoginViewController * lvc = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:lvc animated:YES];
        
        return;
    }
    NSLog(@"footerView 事件（我要竞标）");
    EntrustViewController * evc = [[EntrustViewController alloc]init];
    evc.platform = self.platform;
    evc.price = self.dict[@"goods"][@"Result"][@"Price"];
    evc.goodsTitle = self.dict[@"goods"][@"Result"][@"Title"];
    evc.imageUrl = self.imagesURLStrings[0];
    evc.endTime = endTime;
    evc.increment = [Unity getSmallestUnitOfBid:self.dict[@"goods"][@"Result"][@"Price"]];
    evc.goodId = self.dict[@"goods"][@"Result"][@"AuctionID"];
    evc.bidorbuy = self.dict[@"goods"][@"Result"][@"Bidorbuy"];
    [self.navigationController pushViewController:evc animated:YES];
}
#pragma mark - AuctionCell事件（竞拍列表查看更多）
- (void)moreClick{
    NSLog(@"AuctionCell事件（竞拍列表查看更多）");
}
#pragma mark - GoodsDetailCell事件（竞拍列表查看更多）
- (void)goodsDetail{
    NSLog(@"GoodsDetailCell事件（拍品参数）");
    self.pView.freight.text = @"日本国内运费:";
    self.pView.remark.text = @"本网站为第三方资讯服务平台，本商品信息均来自日本yahoo!";
    self.pView.inStockL.text = [NSString stringWithFormat:@"%@单位（个，片，台...）",self.dict[@"goods"][@"Result"][@"Quantity"]];
    if ([self.dict[@"goods"][@"Result"][@"ItemReturnable"][@"Allowed"] isEqualToString:@"false"]) {
        self.pView.returnGoodsL.text = @"不能退货";
    }else{
        self.pView.returnGoodsL.text = @"可以退货";
    }
    if ([self.dict[@"goods"][@"Result"][@"ItemStatus"][@"Condition"] isEqualToString:@"new"]) {
        self.pView.goodsDetailL.text = @"新品";
    }else if ([self.dict[@"goods"][@"Result"][@"ItemStatus"][@"Condition"] isEqualToString:@"used"]){
        self.pView.goodsDetailL.text = @"二手";
    }else if ([self.dict[@"goods"][@"Result"][@"ItemStatus"][@"Condition"] isEqualToString:@"other"]){
        self.pView.goodsDetailL.text = @"其他";
    }
    if ([self.dict[@"goods"][@"Result"][@"IsAutomaticExtension"] isEqualToString:@"true"]) {
        self.pView.earlyTerminatL.text = @"是";
    }else{
        self.pView.earlyTerminatL.text = @"否";
    }
    if ([self.dict[@"goods"][@"Result"][@"IsEarlyClosing"] isEqualToString:@"true"]) {
        self.pView.earlyTerminatL.text = @"是";
    }else{
        self.pView.earlyTerminatL.text = @"否";
    }
    if ([self.dict[@"goods"][@"Result"][@"IsAutomaticExtension"] isEqualToString:@"true"]) {
        self.pView.extendL.text = @"是";
    }else{
        self.pView.extendL.text = @"否";
    }
    self.pView.bidIdL.text = self.dict[@"goods"][@"Result"][@"AuctionID"];
    [self.pView showPPView];
}
#pragma mark - SellerCell事件（原始页面 全部商品）
- (void)originalClick{
//    NSLog(@"SellerCell事件（原始页面）");
    WebViewController * wvc = [[WebViewController alloc]init];
    wvc.webUrl = self.dict[@"goods"][@"Result"][@"AuctionItemUrl"];
    [self.navigationController pushViewController:wvc animated:YES];
}
- (void)allGoodsClick{
//    NSLog(@"%@",self.dict);
    GoodsListViewController * gvc = [[GoodsListViewController alloc]init];
    gvc.hidesBottomBarWhenPushed = YES;
    gvc.pageIndex =2;
    gvc.isSearch = NO;
    gvc.platform = self.platform;
    gvc.sellerId = self.dict[@"goods"][@"Result"][@"Seller"][@"Id"];
    [self.navigationController pushViewController:gvc animated:YES];
}
- (ProductParametersView *)pView{
    if (!_pView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _pView = [ProductParametersView setProductParametersView:window];
    }
    return _pView;
}
- (void)requestGoodsDetail{
    [self.aAnimation startAround];
    NSDictionary *params = @{@"platform":self.platform,@"item":self.item,@"os":@"1"};
    NSLog(@"详情参数  %@",params);
    [GZMrequest getWithURLString:[GZMUrl get_goodsDetail_url] parameters:params success:^(NSDictionary *data) {
        [self.aAnimation stopAround];
        NSLog(@"-------%@",data);
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            
            [self loadView:data[@"data"]];
            [self requestIsCollection];
        }else{
            [self.altView showAlertView];
            self.altView.msgL.text = [data objectForKey:@"msg"];
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
- (alertView *)altView{
    if (_altView == nil) {
        _altView = [alertView setAlertView:self.view];
    }
    return _altView;
}
- (NSMutableArray *)imagesURLStrings{
    if (!_imagesURLStrings) {
        _imagesURLStrings = [NSMutableArray new];
    }
    return _imagesURLStrings;
}
- (NSDictionary *)dict{
    if (!_dict) {
        _dict = [NSDictionary new];
    }
    return _dict;
}
- (void)loadView:(NSDictionary *)dic{
    NSLog(@"==%@",dic);
    self.dict = dic;
    NSArray *arrKeys = [dic[@"goods"][@"Result"][@"Img"] allKeys];
    for (int i=0; i<arrKeys.count; i++) {
        [self.imagesURLStrings addObject:dic[@"goods"][@"Result"][@"Img"][arrKeys[i]]];
    }
    self.cycleScrollView.imageURLStringsGroup = self.imagesURLStrings;
    [self.navIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic[@"goods"][@"Result"][@"Img"][@"Image1"]]]];
//    [self.navIcon sd_setImageWithURL:[NSURL URLWithString:@"%@",self.imagesURLStrings[0]] placeholderImage:[UIImage imageNamed:@"Loading"]];
    NSString * time = dic[@"goods"][@"Result"][@"EndTime"];
    NSArray *array = [time componentsSeparatedByString:@"+"];
//    NSLog(@"array:%@",array);
    NSArray * array1 = [array[0] componentsSeparatedByString:@"T"];
//    NSLog(@"array1:%@",array1);
    NSArray * array2 = [array1[0] componentsSeparatedByString:@"-"];
//    NSLog(@"array1:%@",array2);
    endTime = [NSString stringWithFormat:@"%@/%@/%@ %@",array2[0],array2[1],array2[2],array1[1]];
    
//    for (int i=0; i<2; i++) {
////        NSString * str1 = @"<div style="width:750px">";
////        NSString * str  = [NSString stringWithFormat:@"%@</div>",dic[@"content"][@"0"]];
//        [self.webArr addObject:dic[@"content"][@"0"]];
//    }
    webUrl = dic[@"content"];
    [self.tableView reloadData];
}
- (NSMutableArray *)webArr{
    if (!_webArr) {
        _webArr = [NSMutableArray new];
    }
    return _webArr;
}
- (void)requestIsCollection{
    if (userInfo == nil){
        return;
    }
    NSDictionary * dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"area":self.platform,@"item":self.dict[@"goods"][@"Result"][@"AuctionID"],@"saler":self.dict[@"goods"][@"Result"][@"Seller"][@"Id"]};
    NSLog(@"请求参数1 %@",dic);
    [GZMrequest getWithURLString:[GZMUrl get_isCollection_url] parameters:dic success:^(NSDictionary *data) {
        NSLog(@"%@",data);
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            goodsStr = [NSString stringWithFormat:@"%@",data[@"data"][@"goods"]];
            if (![goodsStr isEqualToString:@"0"]) {//商品未收藏
                self.collectionImg.image = [UIImage imageNamed:@"已收藏"];
                isGoods = YES;
            }
            salerStr = [NSString stringWithFormat:@"%@",data[@"data"][@"saler"]];
            if (![salerStr isEqualToString:@"0"]) {//
                isSaler = YES;
                
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
}
- (void)sellerCollectionClick{
    if (userInfo == nil) {
        LoginViewController * lvc = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:lvc animated:YES];
        
        return;
    }
    if (isSaler) {
        //删除收藏
        NSDictionary * dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"type":@"saler",@"ids":goodsStr};
        [self.aAnimation startAround];
        [GZMrequest postWithURLString:[GZMUrl get_deleteCollection_url] parameters:dic success:^(NSDictionary *data) {
            [self.aAnimation stopAround];
            if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
                [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
                isSaler = NO;
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
                [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            }else{
                [self.altView showAlertView];
                self.altView.msgL.text = [data objectForKey:@"msg"];
            }
        } failure:^(NSError *error) {
            [self.aAnimation stopAround];
            [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }];
    }else{
        NSArray * arr = [self.dict[@"goods"][@"Result"][@"CategoryIdPath"] componentsSeparatedByString:@","];
        NSString * str1 = @"";
        NSString * str2 = @"";
        if (arr.count >=2) {
            str1 = arr[1];
        }
        if (arr.count >=6){
            str2 = arr[5];
        }else if (arr.count >=4){
            str2 = arr[3];
        }
        NSDictionary * dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"area":@"0",@"type":@"saler",@"w_main_category_id":str1,@"w_goods_category_id":str2,@"w_object":self.dict[@"goods"][@"Result"][@"Title"],@"w_link":self.dict[@"goods"][@"Result"][@"AuctionItemUrl"],@"w_overtime":self.dict[@"goods"][@"Result"][@"EndTime"],@"w_jpnid":self.dict[@"goods"][@"Result"][@"AuctionID"],@"w_imgsrc":self.dict[@"goods"][@"Result"][@"Img"][@"Image1"],@"w_saler":self.dict[@"goods"][@"Result"][@"Seller"][@"Id"],@"w_tag":@""};
        NSLog(@"收藏请求= %@",dic);
        [self.aAnimation startAround];
        [GZMrequest postWithURLString:[GZMUrl get_collection_url] parameters:dic success:^(NSDictionary *data) {
            [self.aAnimation stopAround];
            if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
                [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
                salerStr = data[@"data"];
                isSaler = YES;
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
                [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];

            }else{
                [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            }
        } failure:^(NSError *error) {
            [self.aAnimation stopAround];
            [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }];
    }
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
