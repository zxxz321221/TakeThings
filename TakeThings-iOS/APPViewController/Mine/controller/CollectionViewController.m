//
//  CollectionViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/11.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "CollectionViewController.h"
#import "BabyCell.h"
#import "SelleCell.h"
#import "BabyModel.h"
#import "SellerModel.h"
#import <MJExtension.h>
#import "WebViewController.h"
#import "NewYahooDetailViewController.h"
#import "NewEbayDetailViewController.h"
#define navBtnH  ([Unity widthOfString:@"宝贝" OfFontSize:17 OfHeight:44])
#define bottomH (IS_iPhoneX ? [Unity countcoordinatesH:70] : [Unity countcoordinatesH:50])
@interface CollectionViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,BabyCellDelegate,SelleCellDelegate>
{
    BOOL isTableView;//yes  第一个  no第二个 默认yes
    BOOL isStatus;//yes点击状态  默认no
    BOOL isOneAdmin;//  第一页是否管理  默认no
    BOOL isTwoAdmin;// 同上
    
    BOOL isOver;//默认全部显示  no  yes只显示已结标
    
    NSInteger onePage;
    NSInteger twoPage;
}
@property (nonatomic , strong) UIView * navView;
@property (nonatomic , strong) UIButton * babyBtn;
@property (nonatomic , strong) UIView * indicator;
@property (nonatomic , strong) UIButton * sellerBtn;
@property (nonatomic , strong) UIButton * adminBtn;

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic , strong) UITableView * babyTableView;
@property (nonatomic , strong) UIView * headerView;
@property (nonatomic , strong) UIButton * statusBtn;
@property (nonatomic , strong) UIImageView * statusImg;
@property (nonatomic , strong) UIView * maskView;
@property (nonatomic , strong) UIView * statusView;
@property (nonatomic , strong) UIButton * allStatus;
@property (nonatomic , strong) UIButton * auctionBtn;
@property (nonatomic , strong) UIImageView * allStatusIcon;
@property (nonatomic , strong) UIImageView * auctionIcon;
@property (nonatomic , strong) UITableView * sellerTableView;

@property (nonatomic , strong) UIView * bottomView;
@property (nonatomic , strong) UIButton * allSeletedBtn;

@property (nonatomic , strong) UIView * bottomView1;
@property (nonatomic , strong) UIButton * allSeletedBtn1;

@property (nonatomic , strong) NSMutableArray * leftArray;
@property (nonatomic , strong) NSArray * leftModel;
@property (nonatomic , strong) NSMutableArray * rightArray;
@property (nonatomic , strong) NSArray * rightModel;
@property (nonatomic , strong) NSMutableArray * overArray;
@property (nonatomic , strong) NSArray * overModel;

@property (nonatomic , strong) alertView * altView;
@property (nonatomic , strong) AroundAnimation * aAnimation;

@property (nonatomic , strong) UIView * noView1;
@property (nonatomic , strong) UIView * noView2;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isOver= NO;
    onePage = 1;
    twoPage = 1;
    isTableView = YES;
    isStatus = NO;
    isOneAdmin = NO;
    isTwoAdmin = NO;
    [self createUI];
    
    [self.view addSubview:self.mainScrollView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.bottomView1];

    [self.mainScrollView addSubview:self.babyTableView];
    [self.mainScrollView addSubview:self.sellerTableView];
    [self.mainScrollView addSubview:self.maskView];
    [self.mainScrollView addSubview:self.statusView];
    
    [self.mainScrollView addSubview:self.noView1];
    [self.mainScrollView addSubview:self.noView2];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)createUI{
    [self.view addSubview:self.navView];
}
- (UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight)];
        _navView.backgroundColor = [UIColor whiteColor];
        UIButton * back = [Unity buttonAddsuperview_superView:_navView _subViewFrame:CGRectMake(12, StatusBarHeight+11.5, 11, 21) _tag:self _action:@selector(goBack) _string:@"" _imageName:@"back"];
        back.backgroundColor = [UIColor clearColor];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, NavBarHeight-1, SCREEN_WIDTH, 1)];
        line.backgroundColor = [Unity getColor:@"#e0e0e0"];
        [_navView addSubview:line];
        [_navView addSubview:self.babyBtn];
        [_navView addSubview:self.sellerBtn];
        [_navView addSubview:self.indicator];
        [_navView addSubview:self.adminBtn];
    }
    return _navView;
}
- (UIButton *)babyBtn{
    if (!_babyBtn) {
        _babyBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-navBtnH-[Unity countcoordinatesW:21], StatusBarHeight, navBtnH, 44)];
        [_babyBtn addTarget:self action:@selector(babyClick) forControlEvents:UIControlEventTouchUpInside];
        [_babyBtn setTitle:@"宝贝" forState:UIControlStateNormal];
        [_babyBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_babyBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateSelected];
        _babyBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        _babyBtn.selected = YES;
    }
    return _babyBtn;
}
- (UIView *)indicator{
    if (!_indicator) {
        _indicator = [[UIView alloc]initWithFrame:CGRectMake(_babyBtn.left, NavBarHeight-2, navBtnH, 2)];
        _indicator.backgroundColor = [Unity getColor:@"#aa112d"];
    }
    return _indicator;
}
- (UIButton *)sellerBtn{
    if (!_sellerBtn) {
        _sellerBtn = [[UIButton alloc]initWithFrame:CGRectMake(_babyBtn.right+[Unity countcoordinatesW:42], StatusBarHeight, navBtnH, 44)];
        [_sellerBtn addTarget:self action:@selector(sellerClick) forControlEvents:UIControlEventTouchUpInside];
        [_sellerBtn setTitle:@"卖家" forState:UIControlStateNormal];
        [_sellerBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_sellerBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateSelected];
        _sellerBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _sellerBtn;
}
- (UIButton *)adminBtn{
    if (!_adminBtn) {
        _adminBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-navBtnH-10, StatusBarHeight, navBtnH, 44)];
        [_adminBtn addTarget:self action:@selector(adminClick) forControlEvents:UIControlEventTouchUpInside];
        [_adminBtn setTitle:@"管理" forState:UIControlStateNormal];
        [_adminBtn setTitle:@"取消" forState:UIControlStateSelected];
        [_adminBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        _adminBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _adminBtn;
}
- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)babyClick{
    self.babyBtn.selected = YES;
    self.sellerBtn.selected = NO;
    self.indicator.frame = CGRectMake(self.babyBtn.left, NavBarHeight-2, navBtnH, 2);
    self.mainScrollView.contentOffset = CGPointMake(0, 0);
    isTableView = YES;
    if (isOneAdmin) {
        self.adminBtn.selected=YES;
        self.bottomView.hidden = NO;
    }else{
        self.adminBtn.selected = NO;
    }
    //q切换第一个的时候 如果第二页管理状态下 隐藏掉bottomview1
    if (self.bottomView1.hidden == NO) {
        self.bottomView1.hidden = YES;
    }
}
- (void)sellerClick{
    self.babyBtn.selected = NO;
    self.sellerBtn.selected = YES;
    self.indicator.frame = CGRectMake(self.sellerBtn.left, NavBarHeight-2, navBtnH, 2);
    self.mainScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    isTableView = NO;
    if (isTwoAdmin) {
        self.adminBtn.selected=YES;
        self.bottomView1.hidden = NO;
    }else{
        self.adminBtn.selected = NO;
    }
    //切换第二页的时候  如果第一页管理状态下 隐藏掉底部view
    if (self.bottomView.hidden == NO) {
        self.bottomView.hidden = YES;
    }
}
- (void)adminClick{
    if (isTableView) {//第一页
        if (!isOneAdmin) {
            self.adminBtn.selected = YES;
            isOneAdmin = YES;
            self.bottomView.hidden = NO;
            self.statusBtn.userInteractionEnabled = NO;
        }else{
            self.adminBtn.selected = NO;
            isOneAdmin = NO;
            self.bottomView.hidden = YES;
            self.statusBtn.userInteractionEnabled = YES;
        }
        [self.babyTableView reloadData];
    }else{
        if (!isTwoAdmin) {
            self.adminBtn.selected = YES;
            isTwoAdmin = YES;
            self.bottomView1.hidden = NO;
        }else{
            self.adminBtn.selected = NO;
            isTwoAdmin = NO;
            self.bottomView1.hidden = YES;
        }
        [self.sellerTableView reloadData];
    }
    
}

#pragma mark  ---   创建baby seller   viewcontroller

- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] init];
//        _mainScrollView.alwaysBounceHorizontal = YES;
        _mainScrollView.delegate = self;
        _mainScrollView.tag = 1001;
        _mainScrollView.frame = CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight);
        _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 0);
        _mainScrollView.backgroundColor = [UIColor clearColor];
//        [_mainScrollView setScrollEnabled:NO];
        // 开启分页
        _mainScrollView.pagingEnabled = YES;
        // 没有弹簧效果
        _mainScrollView.bounces = NO;
        // 隐藏水平滚动条
        _mainScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _mainScrollView;
}
- (UITableView *)babyTableView{
    if (!_babyTableView) {
        _babyTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,_mainScrollView.height) style:UITableViewStylePlain];
        _babyTableView.tag = 6666;
        _babyTableView.backgroundColor = [UIColor clearColor];
        _babyTableView.showsVerticalScrollIndicator = NO;
        _babyTableView.delegate = self;
        _babyTableView.dataSource = self;
        _babyTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        if (@available(iOS 11,*)) {
            _babyTableView.estimatedRowHeight = 0;
            _babyTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        //隐藏tableViewCell下划线 隐藏所有分割线
        _babyTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _babyTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //进行数据刷新操作
            [self.leftArray removeAllObjects];
            [self.overArray removeAllObjects];
            [self requestCollectionLeft:1];
            
        }];
        _babyTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [_babyTableView.mj_footer beginRefreshing];
            [self requestCollectionLeft:onePage];
        }];
        // 马上进入刷新状态
        [_babyTableView.mj_footer beginRefreshing];
    }
    return _babyTableView;
}
- (UITableView *)sellerTableView{
    if (!_sellerTableView) {
        _sellerTableView =[[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0,SCREEN_WIDTH ,_mainScrollView.height) style:UITableViewStylePlain];
        _sellerTableView.tag = 8888;
        _sellerTableView.backgroundColor = [UIColor clearColor];
        _sellerTableView.showsVerticalScrollIndicator = NO;
        _sellerTableView.delegate = self;
        _sellerTableView.dataSource = self;
        _sellerTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        if (@available(iOS 11,*)) {
            _sellerTableView.estimatedRowHeight = 0;
            _sellerTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        //隐藏tableViewCell下划线 隐藏所有分割线
        _sellerTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _sellerTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //进行数据刷新操作
            [self.rightArray removeAllObjects];
            [self requestCollectionRight:1];
            
        }];
        _sellerTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [_sellerTableView.mj_footer beginRefreshing];
            [self requestCollectionRight:twoPage];
        }];
        // 马上进入刷新状态
        [_sellerTableView.mj_footer beginRefreshing];
    }
    return _sellerTableView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag == 1001) {
//        NSLog(@"scro %f",scrollView.contentOffset.x);
        if (scrollView.contentOffset.x == 0) {
            self.babyBtn.selected = YES;
            self.sellerBtn.selected = NO;
            self.indicator.frame = CGRectMake(self.babyBtn.left, NavBarHeight-2, navBtnH, 2);
            isTableView = YES;
            if (isOneAdmin) {
                self.adminBtn.selected=YES;
                self.bottomView.hidden = NO;
            }else{
                self.adminBtn.selected = NO;
            }
            //q切换第一个的时候 如果第二页管理状态下 隐藏掉bottomview1
            if (self.bottomView1.hidden == NO) {
                self.bottomView1.hidden = YES;
            }
        }
        if (scrollView.contentOffset.x == SCREEN_WIDTH) {
            self.babyBtn.selected = NO;
            self.sellerBtn.selected = YES;
            self.indicator.frame = CGRectMake(self.sellerBtn.left, NavBarHeight-2, navBtnH, 2);
            isTableView = NO;
            if (isTwoAdmin) {
                self.adminBtn.selected=YES;
                self.bottomView1.hidden = NO;
            }else{
                self.adminBtn.selected = NO;
            }
            //切换第二页的时候  如果第一页管理状态下 隐藏掉底部view
            if (self.bottomView.hidden == NO) {
                self.bottomView.hidden = YES;
            }
        }
    }
}
#pragma mark - tableView  搭理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_babyTableView]) {
        if (!isOver) {
            return self.leftModel.count;
        }else{
            return self.overModel.count;
        }
    }else{
        return self.rightModel.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_babyTableView]) {
        return [Unity countcoordinatesH:125];
    }
    return [Unity countcoordinatesH:60];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_babyTableView]) {
        if (!isOver) {
            // 定义cell标识  每个cell对应一个自己的标识
            NSString *CellIdentifier = [NSString stringWithFormat:@"cello%ld%ld",(long)indexPath.section,indexPath.row];
            BabyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[BabyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            cell.model = self.leftModel[indexPath.row];
            [cell config:isOneAdmin];
            return cell;
        }else{
            // 定义cell标识  每个cell对应一个自己的标识
            NSString *CellIdentifier = [NSString stringWithFormat:@"cellt%ld%ld",(long)indexPath.section,indexPath.row];
            BabyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[BabyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            cell.model = self.overModel[indexPath.row];
            [cell config:isOneAdmin];
            return cell;
        }
        
    }else{
        // 定义cell标识  每个cell对应一个自己的标识
        NSString *CellIdentifier = [NSString stringWithFormat:@"scell%ld%ld",indexPath.section,indexPath.row];
        SelleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[SelleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.model = self.rightModel[indexPath.row];
        [cell config:isTwoAdmin];
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    //    BillDetailViewController * bvc = [[BillDetailViewController alloc]init];
    //    [self.navigationController pushViewController:bvc animated:YES];
}

#pragma mark - 自定义headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:_babyTableView]) {
        return self.headerView;
    }
    return [UIView new];
}
//section 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:_babyTableView]) {
        return [Unity countcoordinatesH:40];
    }
    return 0.01;
}

#pragma mark - 自定义footerView
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return bottomH;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [UIView new];
    
    return footer;
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:40])];
        _headerView.backgroundColor = [UIColor whiteColor];
        [_headerView addSubview:self.statusBtn];
        [_headerView addSubview:self.statusImg];
    }
    return _headerView;
}
- (UIButton *)statusBtn{
    if (!_statusBtn) {
        _statusBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity widthOfString:@"全部状态" OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:20]], [Unity countcoordinatesH:20])];
        [_statusBtn addTarget:self action:@selector(statusClick) forControlEvents:UIControlEventTouchUpInside];
        [_statusBtn setTitle:@"全部状态" forState:UIControlStateNormal];
        [_statusBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        _statusBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _statusBtn;
}
- (UIImageView *)statusImg{
    if (!_statusImg) {
        _statusImg = [[UIImageView alloc]initWithFrame:CGRectMake(_statusBtn.right+5, [Unity countcoordinatesH:18.5], [Unity countcoordinatesW:6], [Unity countcoordinatesH:3])];
        _statusImg.image = [UIImage imageNamed:@"下三角"];
    }
    return _statusImg;
}
- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:40], SCREEN_WIDTH, SCREEN_HEIGHT-[Unity countcoordinatesH:40]-NavBarHeight)];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.3;
        _maskView.hidden=YES;
        UITapGestureRecognizer *singleTap =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskAction)];
        singleTap.numberOfTapsRequired = 1; //点击次数
        singleTap.numberOfTouchesRequired = 1; //点击手指数
        [_maskView addGestureRecognizer:singleTap];
    }
    return _maskView;
}
- (UIView *)statusView{
    if (!_statusView) {
        _statusView = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:40], SCREEN_HEIGHT, 0)];
        _statusView.backgroundColor = [UIColor whiteColor];
        [_statusView addSubview:self.allStatus];
        [_statusView addSubview:self.auctionBtn];
        _statusView.hidden = YES;
    }
    return _statusView;
}
- (UIButton *)allStatus{
    if (!_allStatus) {
        _allStatus = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, (SCREEN_WIDTH-[Unity countcoordinatesW:30])/2, [Unity countcoordinatesH:35])];
        [_allStatus addTarget:self action:@selector(allClick) forControlEvents:UIControlEventTouchUpInside];
        _allStatus.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [_allStatus setTitle:@"   全部状态" forState:UIControlStateNormal];
        [_allStatus setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_allStatus setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateSelected];
        _allStatus.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _allStatus.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _allStatus.layer.cornerRadius =10;
        _allStatus.selected = YES;
        self.allStatusIcon = [[UIImageView alloc]initWithFrame:CGRectMake(_allStatus.width-[Unity countcoordinatesW:25], [Unity countcoordinatesH:12.5], [Unity countcoordinatesW:16], [Unity countcoordinatesH:10])];
        self.allStatusIcon.image = [UIImage imageNamed:@"对号"];
        [_allStatus addSubview:self.allStatusIcon];
    }
    return _allStatus;
}
- (UIButton *)auctionBtn{
    if (!_auctionBtn) {
        _auctionBtn = [[UIButton alloc]initWithFrame:CGRectMake(_allStatus.right+[Unity countcoordinatesW:10], 0, (SCREEN_WIDTH-[Unity countcoordinatesW:30])/2, [Unity countcoordinatesH:35])];
        [_auctionBtn addTarget:self action:@selector(aucClick) forControlEvents:UIControlEventTouchUpInside];
        _auctionBtn.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [_auctionBtn setTitle:@"   已结束" forState:UIControlStateNormal];
        [_auctionBtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_auctionBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateSelected];
        _auctionBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _auctionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _auctionBtn.layer.cornerRadius =10;
        self.auctionIcon = [[UIImageView alloc]initWithFrame:CGRectMake(_auctionBtn.width-[Unity countcoordinatesW:25], [Unity countcoordinatesH:12.5], [Unity countcoordinatesW:16], [Unity countcoordinatesH:10])];
        self.auctionIcon.image = [UIImage imageNamed:@"对号"];
        [_auctionBtn addSubview:self.auctionIcon];
        self.auctionIcon.hidden = YES;
    }
    return _auctionBtn;
}
//headerview上状态按钮事件
- (void)statusClick{
    if (isStatus) {
        [self hiddenMaskView];
    }else{
        self.statusImg.image = [UIImage imageNamed:@"上三角"];
        isStatus = YES;
        self.maskView.hidden = NO;
        self.statusView.hidden = NO;
        [UIView animateWithDuration:0.1 animations:^{
            [self.statusView setFrame:CGRectMake(0, [Unity countcoordinatesH:40], SCREEN_WIDTH,[Unity countcoordinatesH:45])];
        }completion:nil];
    }
}
//弹出view   全部和一结标按钮点击事件
- (void)allClick{
    [self.statusBtn setTitle:@"全部状态" forState:UIControlStateNormal];
    self.allStatusIcon.hidden = NO;
    self.auctionIcon.hidden = YES;
    self.allStatus.selected = YES;
    self.auctionBtn.selected = NO;
    [self hiddenMaskView];
    isOver = NO;
    [self.babyTableView reloadData];
    if (self.leftArray.count ==0) {
        self.noView1.hidden = NO;
    }else{
        self.noView1.hidden = YES;
    }
    
}
- (void)aucClick{
    [self.statusBtn setTitle:@"已结标" forState:UIControlStateNormal];
    self.allStatusIcon.hidden = YES;
    self.auctionIcon.hidden = NO;
    self.allStatus.selected = NO;
    self.auctionBtn.selected = YES;
    [self hiddenMaskView];
    isOver = YES;
    [self.babyTableView reloadData];
    if (self.overArray.count ==0) {
        self.noView1.hidden = NO;
    }else{
        self.noView1.hidden = YES;
    }
}
//隐藏蒙版弹出框
- (void)hiddenMaskView{
    self.statusImg.image = [UIImage imageNamed:@"下三角"];
    isStatus = NO;
    self.maskView.hidden = YES;
    self.statusView.hidden = YES;
    self.statusView.frame = CGRectMake(0, [Unity countcoordinatesH:40], SCREEN_WIDTH, 0);
}
//蒙版点击事件
- (void)maskAction{
    [self hiddenMaskView];
}
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-bottomH, SCREEN_WIDTH, bottomH)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        line.backgroundColor = [Unity getColor:@"#e0e0e0"];
        [_bottomView addSubview:line];
        
        [_bottomView addSubview:self.allSeletedBtn];
        
        UIButton * delete = [Unity buttonAddsuperview_superView:_bottomView _subViewFrame:CGRectMake(self.allSeletedBtn.right+[Unity countcoordinatesW:10], [Unity countcoordinatesH:7], [Unity countcoordinatesW:210], [Unity countcoordinatesH:35]) _tag:self _action:@selector(deleteClick) _string:@"删除" _imageName:@""];
        delete.backgroundColor = [Unity getColor:@"#aa112d"];
        delete.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        [delete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        delete.layer.cornerRadius = delete.height/2;
        _bottomView.hidden = YES;
    }
    return _bottomView;
}
- (UIButton *)allSeletedBtn{
    if (!_allSeletedBtn) {
        _allSeletedBtn = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:80], [Unity countcoordinatesH:50])];
        [_allSeletedBtn addTarget:self action:@selector(allSeletedClick) forControlEvents:UIControlEventTouchUpInside];
//        _allSeletedBtn.backgroundColor = [UIColor yellowColor];
        [_allSeletedBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_allSeletedBtn setTitle:@"  全选" forState:UIControlStateNormal];
        _allSeletedBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _allSeletedBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_allSeletedBtn setImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [_allSeletedBtn setImage:[UIImage imageNamed:@"read"] forState:UIControlStateSelected];
    }
    return _allSeletedBtn;
}
- (void)allSeletedClick{
    if (self.allSeletedBtn.selected) {
        self.allSeletedBtn.selected = NO;
        [self allisSeleted:NO];
    }else{
        self.allSeletedBtn.selected = YES;
        [self allisSeleted:YES];
    }
}
- (void)allisSeleted:(BOOL)isSeleted{
    if (!isOver) {
        if (isSeleted) {
            for (BabyModel * model in self.leftModel)
            {
                model.isSelect = YES;
            }
            for (int i=0;i<self.leftArray.count; i++) {
                NSMutableDictionary * dic = [self.leftArray[i] mutableCopy];
                [dic setObject:@"1" forKey:@"isSelect"];
                [self.leftArray replaceObjectAtIndex:i withObject:dic];
            }
        }else{
            for (BabyModel * model in self.leftModel)
            {
                model.isSelect = NO;
            }
            for (int i=0;i<self.leftArray.count; i++) {
                NSMutableDictionary * dic = [self.leftArray[i] mutableCopy];
                [dic setObject:@"0" forKey:@"isSelect"];
                [self.leftArray replaceObjectAtIndex:i withObject:dic];
            }
        }
    }else{
        if (isSeleted) {
            for (BabyModel * model in self.overModel)
            {
                model.isSelect = YES;
            }
            for (int i=0;i<self.overArray.count; i++) {
                NSMutableDictionary * dic = [self.overArray[i] mutableCopy];
                [dic setObject:@"1" forKey:@"isSelect"];
                [self.overArray replaceObjectAtIndex:i withObject:dic];
            }
        }else{
            for (BabyModel * model in self.overModel)
            {
                model.isSelect = NO;
            }
            for (int i=0;i<self.overArray.count; i++) {
                NSMutableDictionary * dic = [self.overArray[i] mutableCopy];
                [dic setObject:@"0" forKey:@"isSelect"];
                [self.overArray replaceObjectAtIndex:i withObject:dic];
            }
        }
    }
    [self.babyTableView reloadData];
}
- (UIView *)bottomView1{
    if (!_bottomView1) {
        _bottomView1 = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-bottomH, SCREEN_WIDTH, bottomH)];
        _bottomView1.backgroundColor = [UIColor whiteColor];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        line.backgroundColor = [Unity getColor:@"#e0e0e0"];
        [_bottomView1 addSubview:line];
        
        [_bottomView1 addSubview:self.allSeletedBtn1];
        
        UIButton * delete = [Unity buttonAddsuperview_superView:_bottomView1 _subViewFrame:CGRectMake(self.allSeletedBtn.right+[Unity countcoordinatesW:10], [Unity countcoordinatesH:7], [Unity countcoordinatesW:210], [Unity countcoordinatesH:35]) _tag:self _action:@selector(deleteClick1) _string:@"删除" _imageName:@""];
        delete.backgroundColor = [Unity getColor:@"#aa112d"];
        delete.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        [delete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        delete.layer.cornerRadius = delete.height/2;
        _bottomView1.hidden = YES;
    }
    return _bottomView1;
}
- (UIButton *)allSeletedBtn1{
    if (!_allSeletedBtn1) {
        _allSeletedBtn1 = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:80], [Unity countcoordinatesH:50])];
        [_allSeletedBtn1 addTarget:self action:@selector(allSeletedClick1) forControlEvents:UIControlEventTouchUpInside];
        //        _allSeletedBtn.backgroundColor = [UIColor yellowColor];
        [_allSeletedBtn1 setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_allSeletedBtn1 setTitle:@"  全选" forState:UIControlStateNormal];
        _allSeletedBtn1.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _allSeletedBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_allSeletedBtn1 setImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [_allSeletedBtn1 setImage:[UIImage imageNamed:@"read"] forState:UIControlStateSelected];
    }
    return _allSeletedBtn1;
}
- (void)allSeletedClick1{
    if (self.allSeletedBtn1.selected) {
        self.allSeletedBtn1.selected = NO;
        [self allisSeleted1:NO];
    }else{
        self.allSeletedBtn1.selected = YES;
        [self allisSeleted1:YES];
    }
}
- (void)allisSeleted1:(BOOL)isSeleted{
    if (isSeleted) {
        for (SellerModel * model in self.rightModel)
        {
            model.isSelect = YES;
        }
        for (int i=0;i<self.rightArray.count; i++) {
            NSMutableDictionary * dic = [self.rightArray[i] mutableCopy];
            [dic setObject:@"1" forKey:@"isSelect"];
            [self.rightArray replaceObjectAtIndex:i withObject:dic];
        }
    }else{
        for (SellerModel * model in self.rightModel)
        {
            model.isSelect = NO;
        }
        for (int i=0;i<self.rightArray.count; i++) {
            NSMutableDictionary * dic = [self.rightArray[i] mutableCopy];
            [dic setObject:@"0" forKey:@"isSelect"];
            [self.rightArray replaceObjectAtIndex:i withObject:dic];
        }
    }
    [self.sellerTableView reloadData];
}
- (void)requestCollectionLeft:(NSInteger)page{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dict = @{@"customer":[userInfo objectForKey:@"member_id"],@"page":[NSString stringWithFormat:@"%ld",(long)page]};
    [GZMrequest getWithURLString:[GZMUrl get_collectionList_url] parameters:dict success:^(NSDictionary *data) {
//        NSLog(@"%@",data);
        [self.babyTableView.mj_footer endRefreshing];
        [self.babyTableView.mj_header endRefreshing];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            
            onePage = onePage+1;
            if ([data[@"data"][@"goods"] count] < 10) {
                //显示没有更多数据
                [self.babyTableView.mj_footer endRefreshingWithNoMoreData];
            }
            for (int i=0; i<[data[@"data"][@"goods"] count]; i++) {
                NSMutableDictionary * dic = [NSMutableDictionary new];
                [dic setObject:@"0" forKey:@"isSelect"];
                [dic setObject:data[@"data"][@"goods"][i][@"id"] forKey:@"numId"];
                [dic setObject:data[@"data"][@"goods"][i][@"w_object"] forKey:@"w_object"];
                [dic setObject:data[@"data"][@"goods"][i][@"w_link"] forKey:@"w_link"];
                [dic setObject:data[@"data"][@"goods"][i][@"w_overtime"] forKey:@"w_overtime"];
                [dic setObject:data[@"data"][@"goods"][i][@"w_imgsrc"] forKey:@"w_imgsrc"];
                [dic setObject:data[@"data"][@"goods"][i][@"w_jpnid"] forKey:@"w_jpnid"];
                [dic setObject:data[@"data"][@"goods"][i][@"w_cc"] forKey:@"w_cc"];
                [self.leftArray addObject:dic];
                if ([data[@"data"][@"goods"][i][@"w_cc"] isEqualToString:@"0"]) {
                    // 当前时间的时间戳
                    NSString *nowStr = [Unity getCurrentTimeyyyymmdd];
                    // 计算时间差值
                    NSInteger secondsCountDown = [Unity getDateDifferenceWithNowDateStr:nowStr deadlineStr:data[@"data"][@"goods"][i][@"w_overtime"]];
                    if (secondsCountDown-3600<=0) {
                        NSMutableDictionary * ddd = [NSMutableDictionary new];
                        [ddd setObject:@"0" forKey:@"isSelect"];
                        [ddd setObject:data[@"data"][@"goods"][i][@"id"] forKey:@"numId"];
                        [ddd setObject:data[@"data"][@"goods"][i][@"w_object"] forKey:@"w_object"];
                        [ddd setObject:data[@"data"][@"goods"][i][@"w_link"] forKey:@"w_link"];
                        [ddd setObject:data[@"data"][@"goods"][i][@"w_overtime"] forKey:@"w_overtime"];
                        [ddd setObject:data[@"data"][@"goods"][i][@"w_imgsrc"] forKey:@"w_imgsrc"];
                        [dic setObject:data[@"data"][@"goods"][i][@"w_jpnid"] forKey:@"w_jpnid"];
                        [ddd setObject:data[@"data"][@"goods"][i][@"w_cc"] forKey:@"w_cc"];
                        [self.overArray addObject:ddd];
                    }
                }else{
                    // 当前时间的时间戳
                    NSString *nowStr = [Unity getCurrentTimeyyyymmdd];
                    // 计算时间差值
                    NSInteger secondsCountDown = [Unity getDateDifferenceWithNowDateStr:nowStr deadlineStr:data[@"data"][@"goods"][i][@"w_overtime"]];
                    if (secondsCountDown<=0) {
                        NSMutableDictionary * ddd = [NSMutableDictionary new];
                        [ddd setObject:@"0" forKey:@"isSelect"];
                        [ddd setObject:data[@"data"][@"goods"][i][@"id"] forKey:@"numId"];
                        [ddd setObject:data[@"data"][@"goods"][i][@"w_object"] forKey:@"w_object"];
                        [ddd setObject:data[@"data"][@"goods"][i][@"w_link"] forKey:@"w_link"];
                        [ddd setObject:data[@"data"][@"goods"][i][@"w_overtime"] forKey:@"w_overtime"];
                        [ddd setObject:data[@"data"][@"goods"][i][@"w_imgsrc"] forKey:@"w_imgsrc"];
                        [dic setObject:data[@"data"][@"goods"][i][@"w_jpnid"] forKey:@"w_jpnid"];
                        [ddd setObject:data[@"data"][@"goods"][i][@"w_cc"] forKey:@"w_cc"];
                        [self.overArray addObject:ddd];
                    }
                }
            }
            self.overModel = [BabyModel mj_objectArrayWithKeyValuesArray:self.overArray];
            self.leftModel = [BabyModel mj_objectArrayWithKeyValuesArray:self.leftArray];
            [self.babyTableView reloadData];
            [self isallSelectAllPrice];
            if (self.leftArray.count == 0) {
                self.noView1.hidden = NO;
            }else{
                self.noView1.hidden = YES;
            }
        }else{
            [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [self.babyTableView.mj_footer endRefreshing];
        [self.babyTableView.mj_header endRefreshing];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)requestCollectionRight:(NSInteger)page{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dict = @{@"customer":userInfo[@"member_id"],@"page":[NSString stringWithFormat:@"%ld",(long)page]};
    [GZMrequest getWithURLString:[GZMUrl get_collectionList_url] parameters:dict success:^(NSDictionary *data) {
        [self.sellerTableView.mj_footer endRefreshing];
        [self.sellerTableView.mj_header endRefreshing];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            
            twoPage = twoPage+1;
            if ([data[@"data"][@"saler"] count] < 10) {
                //显示没有更多数据
                [self.sellerTableView.mj_footer endRefreshingWithNoMoreData];
            }
            for (int i=0; i<[data[@"data"][@"saler"] count]; i++) {
                NSMutableDictionary * dic = [NSMutableDictionary new];
                [dic setObject:@"0" forKey:@"isSelect"];
                [dic setObject:data[@"data"][@"saler"][i][@"id"] forKey:@"numId"];
                [dic setObject:data[@"data"][@"saler"][i][@"w_saler"] forKey:@"w_saler"];
                [dic setObject:data[@"data"][@"saler"][i][@"w_cc"] forKey:@"w_cc"];
                [self.rightArray addObject:data[@"data"][@"saler"][i]];
            }
            self.rightModel = [SellerModel mj_objectArrayWithKeyValuesArray:self.rightArray];
            [self.sellerTableView reloadData];
            if (self.rightArray.count == 0) {
                self.noView2.hidden = NO;
            }else{
                self.noView2.hidden = YES;
            }
        }else{
            [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [self.sellerTableView.mj_footer endRefreshing];
        [self.sellerTableView.mj_header endRefreshing];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (NSMutableArray *)leftArray{
    if (!_leftArray) {
        _leftArray = [NSMutableArray new];
    }
    return _leftArray;
}
- (NSArray *)leftModel{
    if (!_leftModel) {
        _leftModel = [NSArray new];
    }
    return _leftModel;
}
- (NSMutableArray *)rightArray{
    if (!_rightArray) {
        _rightArray = [NSMutableArray new];
    }
    return _rightArray;
}
- (NSArray *)rightModel{
    if (!_rightModel) {
        _rightModel = [NSArray new];
    }
    return _rightModel;
}
- (NSMutableArray *)overArray{
    if (!_overArray) {
        _overArray = [NSMutableArray new];
    }
    return _overArray;
}
- (NSArray *)overModel{
    if (!_overModel) {
        _overModel = [NSArray new];
    }
    return _overModel;
}
/**
 *  cell的代理方法
 *
 *  @param cell     cell可以拿到indexpath
 *  @param selectBt 选中按钮
 */
- (void)babyCellDelegate:(BabyCell *)cell WithSelectButton:(UIButton *)selectBt
{
    if (!isOver) {
        NSIndexPath * indexPath = [self.babyTableView indexPathForCell:cell];
        NSLog(@"indexpath%@",indexPath);
        BabyModel * model = self.leftModel[indexPath.row];
        model.isSelect = !selectBt.selected;
        
        NSString * isS = @"0";
        NSLog(@"ifReadOnly value: %@" ,model.isSelect?@"YES":@"NO");
        if (model.isSelect) {
            isS = @"1";
        }
        //在这里修改 元数据里的状态 默认0 不编辑 改成1   后期点击删除   状态为1的全删
        NSMutableDictionary * dic = [self.leftArray[indexPath.row] mutableCopy];
        [dic setObject:isS forKey:@"isSelect"];
        [self.leftArray replaceObjectAtIndex:indexPath.row withObject:dic];
    }else{
        NSIndexPath * indexPath = [self.babyTableView indexPathForCell:cell];
        NSLog(@"indexpath%@",indexPath);
        BabyModel * model = self.overModel[indexPath.row];
        model.isSelect = !selectBt.selected;
        
        NSString * isS = @"0";
        NSLog(@"ifReadOnly value: %@" ,model.isSelect?@"YES":@"NO");
        if (model.isSelect) {
            isS = @"1";
        }
        //在这里修改 元数据里的状态 默认0 不编辑 改成1   后期点击删除   状态为1的全删
        NSMutableDictionary * dic = [self.overArray[indexPath.row] mutableCopy];
        [dic setObject:isS forKey:@"isSelect"];
        [self.overArray replaceObjectAtIndex:indexPath.row withObject:dic];
    }
    [self isallSelectAllPrice];
    [self.babyTableView reloadData];
}
/**
 *  遍历所有是否全选
 */
- (void)isallSelectAllPrice
{
    if (!isOver) {
        NSInteger count = 0;
        for (BabyModel * model in self.leftModel)
        {
            if (!model.isSelect)
            {
                self.allSeletedBtn.selected = NO;
                return;
            }else
            {
                count = count+1;
            }
        }
        if (count == self.leftModel.count) {
            self.allSeletedBtn.selected = YES;
        }else{
            self.allSeletedBtn.selected = NO;
        }
    }else{
        NSInteger count = 0;
        for (BabyModel * model in self.overModel)
        {
            if (!model.isSelect)
            {
                self.allSeletedBtn.selected = NO;
                return;
            }else
            {
                count = count+1;
            }
        }
        if (count == self.overModel.count) {
            self.allSeletedBtn.selected = YES;
        }else{
            self.allSeletedBtn.selected = NO;
        }
    }
    
}
- (void)oldpageClick:(BabyCell *)cell{
    NSIndexPath * indexPath = [self.babyTableView indexPathForCell:cell];
    NSLog(@"原始页面  = %@",self.leftArray[indexPath.row]);
    WebViewController * wvc = [[WebViewController alloc]init];
    wvc.webUrl = [NSString stringWithFormat:@"%@/index/order_bid/getyahoo?url=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"new_sdxurl"],self.leftArray[indexPath.row][@"w_link"]];
    [self.navigationController pushViewController:wvc animated:YES];
}
/**
 *  cell的代理方法
 *
 *  @param cell     cell可以拿到indexpath
 *  @param selectBt 选中按钮
 */
- (void)sellerCellDelegate:(SelleCell *)cell WithSelectButton:(UIButton *)selectBt
{
    NSIndexPath * indexPath = [self.sellerTableView indexPathForCell:cell];
    NSLog(@"indexpath%@",indexPath);
    SellerModel * model = self.rightModel[indexPath.row];
    model.isSelect = !selectBt.selected;
    
    NSString * isS = @"0";
    NSLog(@"ifReadOnly value: %@" ,model.isSelect?@"YES":@"NO");
    if (model.isSelect) {
        isS = @"1";
    }
    //在这里修改 元数据里的状态 默认0 不编辑 改成1   后期点击删除   状态为1的全删
    NSMutableDictionary * dic = [self.rightArray[indexPath.row] mutableCopy];
    [dic setObject:isS forKey:@"isSelect"];
    [self.rightArray replaceObjectAtIndex:indexPath.row withObject:dic];
    
    [self isallSelectAllPrice1];
    [self.sellerTableView reloadData];
}
/**
 *  遍历所有是否全选
 */
- (void)isallSelectAllPrice1
{
    NSInteger count = 0;
    for (SellerModel * model in self.rightModel)
    {
        if (!model.isSelect)
        {
            self.allSeletedBtn1.selected = NO;
            return;
        }else
        {
            count = count+1;
        }
    }
    if (count == self.rightModel.count) {
        self.allSeletedBtn1.selected = YES;
    }else{
        self.allSeletedBtn1.selected = NO;
    }
}
- (void)deleteClick{
    NSMutableArray * arr = [NSMutableArray new];
//    for (int i=0; i<self.leftArray.count; i++) {
//        if ([self.leftArray[i][@"isSelect"] isEqualToString:@"1"]) {
//            [arr addObject:self.leftArray[i][@"numId"]];
//        }
//    }
    NSString * idsStr = @"";
//    NSMutableArray * array = [NSMutableArray new];
    if (!isOver) {
        for (int j=0; j<self.leftArray.count; j++) {
            if ([self.leftArray[j][@"isSelect"] isEqualToString:@"1"]) {
                NSLog(@"删除的 %@",self.leftArray[j]);
                [arr addObject:self.leftArray[j][@"numId"]];
                if ([idsStr isEqualToString:@""]) {
                    idsStr = self.leftArray[j][@"numId"];
                }else{
                    idsStr = [idsStr stringByAppendingString:[NSString stringWithFormat:@",%@",self.leftArray[j][@"numId"]]];
                }
            }
        }
    }else{
        for (int j=0; j<self.overArray.count; j++) {
            if ([self.overArray[j][@"isSelect"] isEqualToString:@"1"]) {
                NSLog(@"删除的 %@",self.overArray[j]);
                [arr addObject:self.overArray[j][@"numId"]];
                if ([idsStr isEqualToString:@""]) {
                    idsStr = self.overArray[j][@"numId"];
                }else{
                    idsStr = [idsStr stringByAppendingString:[NSString stringWithFormat:@",%@",self.overArray[j][@"numId"]]];
                }
            }
        }
    }
    
    if (arr.count == 0) {
        NSLog(@"没有勾选");
        return;
    }
    NSLog(@"删除收藏 %@",arr);
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"type":@"goods",@"ids":idsStr};
    [self.aAnimation startAround];
    [GZMrequest postWithURLString:[GZMUrl get_deleteCollection_url] parameters:dic success:^(NSDictionary *data) {
        [self.aAnimation stopAround];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            NSMutableArray * array = [NSMutableArray new];
            NSMutableArray * array1 = [NSMutableArray new];
            if (!isOver) {
                for (int i=0; i<self.leftArray.count; i++) {
                    if ([self.leftArray[i][@"isSelect"] isEqualToString:@"0"]) {
                        [array addObject:self.leftArray[i]];
                    }
                }
                [self.leftArray removeAllObjects];
                self.leftArray = array;
                self.leftModel = [BabyModel mj_objectArrayWithKeyValuesArray:self.leftArray];
            }else{
                for (int i=0; i<self.overArray.count; i++) {
                    if ([self.overArray[i][@"isSelect"] isEqualToString:@"0"]) {
                        [array addObject:self.overArray[i]];
                    }
                }
                NSArray *aray = [idsStr componentsSeparatedByString:@","];
                for (int i=0; i<self.leftArray.count; i++) {
                    NSInteger ccc =0;
                    for (int j=0; j<aray.count; j++) {
                        if ([self.leftArray[i][@"numId"] isEqualToString:aray[j]]) {
                            ccc = 1;
                        }
                    }
                    if (ccc ==0) {
                        [array1 addObject:self.leftArray[i]];
                    }
                }
                [self.leftArray removeAllObjects];
                self.leftArray = array1;
                self.leftModel = [BabyModel mj_objectArrayWithKeyValuesArray:self.leftArray];
                [self.overArray removeAllObjects];
                self.overArray = array;
                self.overModel = [BabyModel mj_objectArrayWithKeyValuesArray:self.overArray];
            }
            
            [self.babyTableView reloadData];
            if (!isOver) {
                if (self.leftArray.count == 0) {
                    self.noView1.hidden = NO;
                }else{
                    self.noView1.hidden = YES;
                }
            }else{
                if (self.overArray.count == 0) {
                    self.noView1.hidden = NO;
                }else{
                    self.noView1.hidden = YES;
                }
            }
            if (self.allSeletedBtn.selected == YES) {
                self.allSeletedBtn.selected = NO;
            }
        }else{
            [self.altView showAlertView];
            self.altView.msgL.text = [data objectForKey:@"msg"];
        }
    } failure:^(NSError *error) {
        [self.aAnimation stopAround];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)deleteClick1{
    NSMutableArray * arr = [NSMutableArray new];
    //    for (int i=0; i<self.leftArray.count; i++) {
    //        if ([self.leftArray[i][@"isSelect"] isEqualToString:@"1"]) {
    //            [arr addObject:self.leftArray[i][@"numId"]];
    //        }
    //    }
    NSString * idsStr = @"";
//    NSMutableArray * array = [NSMutableArray new];
    for (int j=0; j<self.rightArray.count; j++) {
        if ([self.rightArray[j][@"isSelect"] isEqualToString:@"1"]) {
            NSLog(@"删除的 %@",self.rightArray[j]);
            [arr addObject:self.rightArray[j][@"id"]];
            if ([idsStr isEqualToString:@""]) {
                idsStr = self.rightArray[j][@"id"];
            }else{
                idsStr = [idsStr stringByAppendingString:[NSString stringWithFormat:@",%@",self.rightArray[j][@"id"]]];
            }
        }
    }
    if (arr.count == 0) {
        NSLog(@"没有勾选");
        return;
    }
    NSLog(@"删除收藏 %@",arr);
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"type":@"saler",@"ids":idsStr};
    [self.aAnimation startAround];
    [GZMrequest postWithURLString:[GZMUrl get_deleteCollection_url] parameters:dic success:^(NSDictionary *data) {
        [self.aAnimation stopAround];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            NSMutableArray * array = [NSMutableArray new];
            for (int i=0; i<self.rightArray.count; i++) {
                if ([self.rightArray[i][@"isSelect"] isEqualToString:@"0"]) {
                    [array addObject:self.rightArray[i]];
                }
            }
            [self.rightArray removeAllObjects];
            self.rightArray = array;
            self.rightModel = [BabyModel mj_objectArrayWithKeyValuesArray:self.rightArray];
            [self.sellerTableView reloadData];
            if (self.rightArray.count == 0) {
                self.noView2.hidden = NO;
            }else{
                self.noView2.hidden = YES;
            }
        }else{
            [self.altView showAlertView];
            self.altView.msgL.text = [data objectForKey:@"msg"];
        }
        if (self.allSeletedBtn1.selected == YES) {
            self.allSeletedBtn1.selected = NO;
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
- (void)patClick:(BabyCell *)cell{
    NSIndexPath * indexPath = [self.babyTableView indexPathForCell:cell];
    NSLog(@"%ld",(long)indexPath.row);
    //防止越界
    if ((self.leftArray.count-1) < indexPath.row) {
        return;
    }
    if ([self.leftArray[indexPath.row][@"w_cc"] isEqualToString:@"0"]) {//日本
        NewYahooDetailViewController * dvc = [[NewYahooDetailViewController alloc]init];
        dvc.platform = @"0";
        dvc.item = self.leftArray[indexPath.row][@"w_jpnid"];
        [self.navigationController pushViewController:dvc animated:YES];
    }else{
        NewEbayDetailViewController * dvc = [[NewEbayDetailViewController alloc]init];
        dvc.platform = @"5";
        dvc.item = self.leftArray[indexPath.row][@"w_jpnid"];
        [self.navigationController pushViewController:dvc animated:YES];
    }
}

- (UIView *)noView1{
    if (!_noView1) {
        _noView1 = [[UIView alloc]initWithFrame:CGRectMake(0, (SCREEN_HEIGHT-[Unity countcoordinatesH:187]-NavBarHeight)/2, SCREEN_WIDTH, [Unity countcoordinatesH:187])];
        _noView1.backgroundColor = [UIColor clearColor];
        
        UIImageView * imageView = [Unity imageviewAddsuperview_superView:_noView1 _subViewFrame:CGRectMake((SCREEN_WIDTH-[Unity countcoordinatesW:80])/2, 0, [Unity countcoordinatesW:80], [Unity countcoordinatesH:92]) _imageName:@"nocollection" _backgroundColor:nil];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        UILabel * label = [Unity lableViewAddsuperview_superView:_noView1 _subViewFrame:CGRectMake(0, imageView.bottom+[Unity countcoordinatesH:30], SCREEN_WIDTH, [Unity countcoordinatesH:15]) _string:@"还没收藏，快逛起来吧~" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentCenter];
        UIButton * homeBtn = [[UIButton alloc]initWithFrame:CGRectMake(imageView.left, label.bottom+[Unity countcoordinatesH:20], imageView.width, [Unity countcoordinatesH:30])];
        [homeBtn addTarget:self action:@selector(homeBtnClck) forControlEvents:UIControlEventTouchUpInside];
        [homeBtn setTitle:@"逛逛首页" forState:UIControlStateNormal];
        [homeBtn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
        homeBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        homeBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        homeBtn.layer.borderWidth =1;
        homeBtn.layer.cornerRadius = homeBtn.height/2;
        [_noView1 addSubview:homeBtn];
        
        _noView1.hidden = YES;
    }
    return _noView1;
}
- (UIView *)noView2{
    if (!_noView2) {
        _noView2 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, (SCREEN_HEIGHT-[Unity countcoordinatesH:187]-NavBarHeight)/2, SCREEN_WIDTH, [Unity countcoordinatesH:187])];
        _noView2.backgroundColor = [UIColor clearColor];
        
        UIImageView * imageView = [Unity imageviewAddsuperview_superView:_noView2 _subViewFrame:CGRectMake((SCREEN_WIDTH-[Unity countcoordinatesW:80])/2, 0, [Unity countcoordinatesW:80], [Unity countcoordinatesH:92]) _imageName:@"nocollection" _backgroundColor:nil];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        UILabel * label = [Unity lableViewAddsuperview_superView:_noView2 _subViewFrame:CGRectMake(0, imageView.bottom+[Unity countcoordinatesH:30], SCREEN_WIDTH, [Unity countcoordinatesH:15]) _string:@"还没收藏，快逛起来吧~" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentCenter];
        UIButton * homeBtn = [[UIButton alloc]initWithFrame:CGRectMake(imageView.left, label.bottom+[Unity countcoordinatesH:20], imageView.width, [Unity countcoordinatesH:30])];
        [homeBtn addTarget:self action:@selector(homeBtnClck) forControlEvents:UIControlEventTouchUpInside];
        [homeBtn setTitle:@"逛逛首页" forState:UIControlStateNormal];
        [homeBtn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
        homeBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        homeBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        homeBtn.layer.borderWidth =1;
        homeBtn.layer.cornerRadius = homeBtn.height/2;
        [_noView2 addSubview:homeBtn];
        
        _noView2.hidden = YES;
    }
    return _noView2;
}
- (void)homeBtnClck{
    self.tabBarController.selectedIndex =0;
    [self.navigationController popViewControllerAnimated:NO];
}
@end
