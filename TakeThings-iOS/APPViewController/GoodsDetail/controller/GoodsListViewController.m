//
//  GoodsListViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/12.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsListViewController.h"
#import "GoodsListCell.h"
#import "GoodsGridCell.h"
#import "ScreenView.h"
//#import "DetailViewController.h"
//#import "UsDetailViewController.h"
#import "NewYahooDetailViewController.h"
#import "NewEbayDetailViewController.h"
//侧滑
#import "CWScrollView.h"
#import "CWTableViewInfo.h"
#import "UIViewController+CWLateralSlide.h"
#import "LeftViewController.h"
#import "JYTimerUtil.h"
#import "ToastImg.h"
#import "LoginViewController.h"
#import "YhLeftViewController.h"
#import "CategoryViewController.h"
#import <Masonry.h>
#import "UIViewController+YINNav.h"
#define ICellIdentifier @"CellIdentifier"
#define ICellIdentifier1 @"CellIdentifier1"
@interface GoodsListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,LeftViewDelegate,UIAlertViewDelegate,YhLeftViewDelegate>
{
    BOOL isSwitch;//yes  默认状态   一行显示2个    no显示1个
    NSInteger defaultNum;// 默认按钮状态   0未选 1已选  默认已选
    NSInteger numberNum;// 0 未选 1降序 2升序
    NSInteger amountNum;// 0 未选 1降序 2升序
    NSInteger timeNum;// 0 未选 1降序 2升序
//    NSInteger priceNum;// 0 未选 1已选
//    NSInteger auctionNum;// 0 未选 1已选
    NSInteger page;
    
    NSString * type;//
    NSString * buynow;//
    NSString * istatus;//
    NSString * pstagefree;//
    NSString * min;//
    NSString * max;//
    NSString * order;
    NSString * key;
    NSIndexPath * caIndex;//长按到的indexPath
    NSString * sellerID;//卖家id
    NSString * categoryId;//分类id
    NSString * brandWord;//侧滑框关键字
    //侧滑充值 记录默认参数
    NSString * keyA;
    NSString * keyB;
    NSString * keyC;
    NSString * keyD;
    NSString * keyE;
    NSString * keyF;
    NSString * keyG;
    NSString * abatch;
}
@property (nonatomic , strong) UIButton * switchBtn;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout * gridLayout;
@property (nonatomic, strong) UICollectionViewFlowLayout * listLayout;
@property (nonatomic , strong) UIView * headerView;
@property (nonatomic , strong) ScreenView * sView;

//headerView上6个按钮
@property (nonatomic , strong) UIButton * defaultBtn;//默认
@property (nonatomic , strong) UIButton * numberBtn;//次数
@property (nonatomic , strong) UIButton * amountBtn;//价格
@property (nonatomic , strong) UIButton * timeBtn;//时间
@property (nonatomic , strong) UIButton * priceBtn;//一口价
@property (nonatomic , strong) UIButton * auctionBtn;//竞拍

@property (nonatomic , strong) NSMutableArray * goodsList;
@property (nonatomic , strong) AroundAnimation * aAnimation;
@property (nonatomic , strong) alertView * altView;

@property (nonatomic , strong) ToastImg * tView;

@property (nonatomic , strong) UIScrollView * routerView;
@property (nonatomic , strong) UIImageView * seletedImg;
@property (nonatomic , strong) NSArray * pathArr;

@property (nonatomic , strong) UILabel * bottomLine;
@property (nonatomic , strong) UIView * minBtn;
@property (nonatomic , strong) UIView * bigMinView;
@property (nonatomic , strong) UIView * maxBtn;
@property (nonatomic , strong) UIView * bigMaxView;
@property (nonatomic , strong) UILabel * progressLine;

@property (nonatomic , strong) NSArray * placeArray;

@property (nonatomic , retain) NSDate *requestDate;


@end

@implementation GoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    brandWord = @"";
//    sellerID = @"";//卖家id
//    categoryId = @"";//分类id
    abatch = @"";
    min = @"1";
    max = @"";
    buynow = @"";
    istatus = @"";
    pstagefree = @"";
    type = @"";
    order = @"";
    key = @"123";//默认随便
    page = 1;
    defaultNum = 1;
    numberNum = 0;
    amountNum =0;
    timeNum =0 ;
//    priceNum = 0;
//    auctionNum = 0;
    isSwitch = YES;
    self.y_navLineHidden = YES;
    if (!self.isSearch) {
        [self.view addSubview:self.routerView];
    }
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.collectionView];
    
//    [self  requestGoods];
/*
    // 注册手势驱动  暂时禁用
    __weak typeof(self)weakSelf = self;
    [self cw_registerShowIntractiveWithEdgeGesture:YES transitionDirectionAutoBlock:^(CWDrawerTransitionDirection direction) {
        if (direction == CWDrawerTransitionFromLeft) { // 左侧滑出
//            [weakSelf defaultAnimationFromLeft];
        } else if (direction == CWDrawerTransitionFromRight) { // 右侧滑出
            [weakSelf defaultAnimationFromRight];
        }
    }];
 **/
    [self saveParameter];
}
- (UIScrollView *)routerView{
    if (!_routerView) {
        _routerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:40])];
        _routerView.backgroundColor = [Unity getColor:@"f0f0f0"];
        _routerView.scrollEnabled = YES;
        _routerView.userInteractionEnabled = YES;
        // 隐藏水平滚动条
        _routerView.showsHorizontalScrollIndicator = NO;
    }
    return _routerView;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"商品列表";
    [self addRightTwoBarButtonsWithFirstImage:[UIImage imageNamed:@"screen"] firstAction:@selector(screening) secondImage:[UIImage imageNamed:@"gridg"] secondAction:@selector(switchLayout)];
}
//右侧两个图片item的情况
- (void)addRightTwoBarButtonsWithFirstImage:(UIImage *)firstImage firstAction:(SEL)firstAction secondImage:(UIImage *)secondImage secondAction:(SEL)secondAction
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.frame = CGRectMake(40, 0, 40, 44);
    [firstButton setImage:firstImage forState:UIControlStateNormal];
    [firstButton addTarget:self action:firstAction forControlEvents:UIControlEventTouchUpInside];
    firstButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, - 8 * SCREEN_WIDTH/375.0)];
    [view addSubview:firstButton];
    
    self.switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.switchBtn.frame = CGRectMake(0, 0, 40, 44);
    [self.switchBtn setImage:secondImage forState:UIControlStateNormal];
    [self.switchBtn setImage:[UIImage imageNamed:@"listg"] forState:UIControlStateSelected];
    [self.switchBtn addTarget:self action:secondAction forControlEvents:UIControlEventTouchUpInside];
    self.switchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.switchBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, - 15 * SCREEN_WIDTH/375.0)];
    [view addSubview:self.switchBtn];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
//导航右侧2个按钮事件
- (void)switchLayout{
    __weak __typeof(self) weakSelf = self;
    if (isSwitch) {//显示一行一个
        self.switchBtn.selected = YES;
        isSwitch = NO;
        [self.collectionView setCollectionViewLayout:self.listLayout animated:YES completion:^(BOOL finished) {
            [weakSelf.collectionView reloadData];
        }];
        
    }else{//显示一行2个
        self.switchBtn.selected = NO;
        isSwitch = YES;
        [self.collectionView setCollectionViewLayout:self.gridLayout animated:YES completion:^(BOOL finished) {
            [weakSelf.collectionView reloadData];
        }];
    }

}
- (void)screening{
//    [self.sView showScreenView];
    [self defaultAnimationFromRight];
}
-(UICollectionViewFlowLayout *)gridLayout{
    if (!_gridLayout) {
        _gridLayout = [[UICollectionViewFlowLayout alloc] init];
        _gridLayout.itemSize = CGSizeMake((SCREEN_WIDTH)/2, [Unity countcoordinatesH:240]);
        _gridLayout.minimumLineSpacing = [Unity countcoordinatesH:0];
        _gridLayout.minimumInteritemSpacing = [Unity countcoordinatesW:0];
        _gridLayout.sectionInset = UIEdgeInsetsZero;
    }
    return _gridLayout;
}
-(UICollectionViewFlowLayout *)listLayout{
    if (!_listLayout) {
        _listLayout = [[UICollectionViewFlowLayout alloc] init];
        _listLayout.itemSize = CGSizeMake(SCREEN_WIDTH, [Unity countcoordinatesH:125]);
        _listLayout.minimumLineSpacing = [Unity countcoordinatesW:0];
        _listLayout.sectionInset = UIEdgeInsetsZero;
    }
    return _listLayout;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        if (!self.isSearch) {
             _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:90]+60, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-[Unity countcoordinatesH:90]-60) collectionViewLayout:self.gridLayout];
        }else{
             _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:50]+60, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-[Unity countcoordinatesH:50]-60) collectionViewLayout:self.gridLayout];
        }
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [Unity getColor:@"#f0f0f0"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        [_collectionView registerClass:[GoodsGridCell class] forCellWithReuseIdentifier:ICellIdentifier];
//        [_collectionView registerClass:[GoodsListCell class] forCellWithReuseIdentifier:ICellIdentifier1];
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
//        _collectionView.es
//        _collectionView.estimatedRowHeight = 0;
//        _collectionView.estimatedSectionHeaderHeight = 0;
//        _collectionView.estimatedSectionFooterHeight = 0;

        // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //进行数据刷新操作
            [self.collectionView.mj_footer resetNoMoreData];
            page=1;
            if (self.isSearch) {
                [self requestGoods];
            }else{
                [self requestGoods1];
            }
            
        }];
        
        // 马上进入刷新状态
        [_collectionView.mj_header beginRefreshing];
        // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            page = page+1;
            [_collectionView.mj_footer beginRefreshing];
            if (self.isSearch) {
                [self loadMoreData];
            }else{
                [self loadMoreData1];
            }
            
        }];
    }
    return _collectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.goodsList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.collectionViewLayout == self.gridLayout) {
        NSString * identifier = [NSString stringWithFormat:@"NewTravelMediaCell%@", [NSString stringWithFormat:@"%@", indexPath]];
        // 如果你是代码写的cell那么注册用下面的方法
        [collectionView registerClass:[GoodsGridCell class] forCellWithReuseIdentifier:identifier];
        GoodsGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//        [cell config:self.goodsList[indexPath.row] WithPlatform:self.platform];
        cell.time = [self.goodsList[indexPath.row][@"EndTime"] intValue];
        cell.imageUrl = self.goodsList[indexPath.row][@"Image"];
        cell.goodTitle = self.goodsList[indexPath.row][@"Title"];
        cell.currPlace = self.goodsList[indexPath.row][@"CurrentPrice"];
        cell.countNum = self.goodsList[indexPath.row][@"Bids"];
        cell.w_cc = self.platform;
        //添加长按手势
        UILongPressGestureRecognizer * longPressGesture =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(cellLongPress:)];
        
        longPressGesture.minimumPressDuration=1.5f;//设置长按 时间
        [cell addGestureRecognizer:longPressGesture];
        return cell;
    }else{
        NSString * identifier = [NSString stringWithFormat:@"NewTravelMediaCell1%@", [NSString stringWithFormat:@"%@", indexPath]];
        // 如果你是代码写的cell那么注册用下面的方法
        [collectionView registerClass:[GoodsListCell class] forCellWithReuseIdentifier:identifier];
        GoodsListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//        [cell config:self.goodsList[indexPath.row] WithPlatform:self.platform];
        cell.time = [self.goodsList[indexPath.row][@"EndTime"] intValue];
        cell.imageUrl = self.goodsList[indexPath.row][@"Image"];
        cell.goodTitle = self.goodsList[indexPath.row][@"Title"];
        cell.currPlace = self.goodsList[indexPath.row][@"CurrentPrice"];
        cell.countNum = self.goodsList[indexPath.row][@"Bids"];
        cell.w_cc = self.platform;
        //添加长按手势
        UILongPressGestureRecognizer * longPressGesture =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(cellLongPress:)];
        
        longPressGesture.minimumPressDuration=1.5f;//设置长按 时间
        [cell addGestureRecognizer:longPressGesture];
        return cell;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSLog(@"%ld",indexPath.row);
    if ([self.platform isEqualToString:@"0"]) {
        NewYahooDetailViewController * dvc = [[NewYahooDetailViewController alloc]init];
        dvc.item = self.goodsList[indexPath.row][@"AuctionID"];
        dvc.platform = self.platform;//暂时写死
        [self.navigationController pushViewController:dvc animated:YES];
    }else{
        NSLog(@"%@",self.goodsList[indexPath.row]);
        NewEbayDetailViewController * uvc = [[NewEbayDetailViewController alloc]init];
        uvc.item = self.goodsList[indexPath.row][@"AuctionID"];
        uvc.platform = self.platform;//暂时写死
        [self.navigationController pushViewController:uvc animated:YES];
    }
    
}
- (UIView *)headerView{
    if (!_headerView) {
        if (!self.isSearch) {
            _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:40], SCREEN_WIDTH, [Unity countcoordinatesH:50]+60)];
        }else{
             _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        }
       
        _headerView.backgroundColor = [UIColor whiteColor];
        [_headerView addSubview:self.defaultBtn];
        [_headerView addSubview:self.numberBtn];
        [_headerView addSubview:self.amountBtn];
        [_headerView addSubview:self.timeBtn];
//        [_headerView addSubview:self.priceBtn];
//        [_headerView addSubview:self.auctionBtn];
        
        [self createSlider];
    }
    return _headerView;
}
- (void)createSlider{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:50], SCREEN_WIDTH, 60)];
    [self.headerView addSubview:view];
    
    [view addSubview:self.bigMinView];
    [view addSubview:self.bigMaxView];
    [view addSubview:self.bottomLine];
    [view addSubview:self.progressLine];
    
    _mxLabelView = [[SFDualWayIndicateView alloc] init];
    _mxLabelView.backIndicateColor = [Unity getColor:@"aa112d"];
    [_mxLabelView setTitle:@"我来了"];
    _mxLabelView.hidden = YES;
    [view addSubview:self.mxLabelView];
    
    [_mxLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.centerX.equalTo(view);
        make.width.mas_offset([Unity countcoordinatesW:90]);
        make.height.mas_offset(30);
    }];
//    [self loadMin:55000];
//    [self loadMax:55555];
}
- (UIView *)bigMinView{
    if (!_bigMinView) {
        _bigMinView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [Unity countcoordinatesW:40], 60)];
        _bigMinView.backgroundColor = [UIColor clearColor];
        
        [_bigMinView addSubview:self.minBtn];
        _minIndicateView = [[SFDualWayIndicateView alloc] init];
        _minIndicateView.backIndicateColor = [Unity getColor:@"aa112d"];
        [_minIndicateView setTitle:@"1円"];
        [_bigMinView addSubview:self.minIndicateView];
        [_minIndicateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.centerX.equalTo(self.minBtn);
            make.width.mas_offset([Unity countcoordinatesW:50]);
            make.height.mas_offset(30);
            //_minIndicateView 修改了 anchorPoint 所以参照的是centerY
            //        make.bottom.equalTo(self.minBtn.mas_centerY).offset(-[Unity countcoordinatesW:50]);
        }];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
        [_bigMinView addGestureRecognizer:pan];
    }
    return _bigMinView;
}
- (UIView *)bigMaxView{
    if (!_bigMaxView) {
        _bigMaxView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:40], 0, [Unity countcoordinatesW:40], 60)];
        _bigMaxView.backgroundColor = [UIColor clearColor];
        
        [_bigMaxView addSubview:self.maxBtn];
        _maxIndicateView = [[SFDualWayIndicateView alloc]init];
        _maxIndicateView.backIndicateColor = [Unity getColor:@"aa112d"];
        [self.maxIndicateView setTitle:@"未设置"];
        [_bigMaxView addSubview:self.maxIndicateView];
        [_maxIndicateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.centerX.equalTo(self.maxBtn);
            make.width.mas_offset([Unity countcoordinatesW:50]);
            make.height.mas_offset(30);
        }];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer1:)];
        [_bigMaxView addGestureRecognizer:pan];
    }
    return _bigMaxView;
}
- (UILabel *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-[Unity countcoordinatesW:260])/2, [Unity countcoordinatesH:35], [Unity countcoordinatesW:260], [Unity countcoordinatesH:4])];
        _bottomLine.backgroundColor = [Unity getColor:@"e0e0e0"];
        _bottomLine.layer.cornerRadius = _bottomLine.height/2;
        _bottomLine.layer.masksToBounds = YES;
    }
    return _bottomLine;
}
- (UIView *)minBtn{
    if (!_minBtn) {
        _minBtn = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], [Unity countcoordinatesH:30], [Unity countcoordinatesW:20], [Unity countcoordinatesW:14])];
        _minBtn.backgroundColor = [Unity getColor:@"aa112d"];
        _minBtn.layer.cornerRadius = _minBtn.height/2;
        _minBtn.userInteractionEnabled = YES;
    }
    return _minBtn;
}
- (UIView *)maxBtn{
    if (!_maxBtn) {
        _maxBtn = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:30], [Unity countcoordinatesW:20], [Unity countcoordinatesW:14])];
        _maxBtn.backgroundColor = [Unity getColor:@"aa112d"];
        _maxBtn.layer.cornerRadius =_maxBtn.height/2;
        _maxBtn.userInteractionEnabled = YES;
    }
    return _maxBtn;
}
- (UILabel *)progressLine{
    if (!_progressLine) {
        _progressLine = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:30], [Unity countcoordinatesH:35], [Unity countcoordinatesW:260], [Unity countcoordinatesH:4])];
        _progressLine.backgroundColor = [Unity getColor:@"aa112d"];
    }
    return _progressLine;
}


/**
 最小值 拖拽手势
 */
- (void)panGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer{
    //获取拖拽手势在self.view 的拖拽姿态
    CGPoint translation = [panGestureRecognizer translationInView:self.view];
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateChanged:
            {
                //改变panGestureRecognizer.view的中心点 就是self.imageView的中心点
                if (panGestureRecognizer.view.center.x + translation.x >= [Unity countcoordinatesW:20] && panGestureRecognizer.view.center.x + translation.x <= self.bigMaxView.center.x-[Unity countcoordinatesW:40]) {
                    panGestureRecognizer.view.center = CGPointMake(panGestureRecognizer.view.center.x + translation.x, 30);
                    
                    //重置拖拽手势的姿态
                    [panGestureRecognizer setTranslation:CGPointZero inView:self.view];
                    NSInteger index = (NSInteger)roundf((self.bigMinView.center.x-[Unity countcoordinatesW:20])/[Unity countcoordinatesW:240]*34);
                    //更新上框的文字
                    if (index == 34) {
                        [self.minIndicateView setTitle:self.placeArray[index]];
                    }else{
                        [self.minIndicateView setTitle:[NSString stringWithFormat:@"%@円",self.placeArray[index]]];
                    }
                    [self loadPro];
                    if (self.bigMaxView.left-self.bigMinView.right<=[Unity countcoordinatesW:30]) {
                        self.minIndicateView.hidden = YES;
                        self.maxIndicateView.hidden = YES;
                        self.mxLabelView.hidden = NO;
                        [self loadMaxLabel];
                    }else{
                        self.minIndicateView.hidden = NO;
                        self.maxIndicateView.hidden = NO;
                        self.mxLabelView.hidden = YES;
                    }
                }
            }
            break;
        case UIGestureRecognizerStateEnded:
        {
            NSLog(@"滑动结束%@",_minIndicateView.indicateLabel.text);
            if ([_maxIndicateView.indicateLabel.text isEqualToString:@"未设置"] && [_minIndicateView.indicateLabel.text isEqualToString:@"未设置"]) {
                [self loadMin:1];
                [WHToast showMessage:@"请正确选择价格区间" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
                return;
            }
            if ([_minIndicateView.indicateLabel.text isEqualToString:@"未设置"]) {
                min=@"";
            }else{
                min = [_minIndicateView.indicateLabel.text stringByReplacingOccurrencesOfString:@"円" withString:@""];
            }
            page=1;
            if (self.isSearch) {
                [self requestGoods];
            }else{
                [self requestGoods1];
            }
            
        }
            break;
            
        default:
            break;
    }
    
}
/**
 最大值 拖拽手势
 */
- (void)panGestureRecognizer1:(UIPanGestureRecognizer *)panGestureRecognizer{
    //获取拖拽手势在self.view 的拖拽姿态
    CGPoint translation = [panGestureRecognizer translationInView:self.view];
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateChanged:
        {
            //改变panGestureRecognizer.view的中心点 就是self.imageView的中心点
            if (panGestureRecognizer.view.center.x + translation.x >= self.bigMinView.center.x+[Unity countcoordinatesW:40] && panGestureRecognizer.view.center.x + translation.x <= [Unity countcoordinatesW:300]) {
                panGestureRecognizer.view.center = CGPointMake(panGestureRecognizer.view.center.x + translation.x, 30);
                //重置拖拽手势的姿态
                [panGestureRecognizer setTranslation:CGPointZero inView:self.view];
                
                NSInteger index = (NSInteger)roundf((self.bigMaxView.center.x-[Unity countcoordinatesW:60])/[Unity countcoordinatesW:240]*34);
                if (index == 34) {
                    [self.maxIndicateView setTitle:self.placeArray[index]];
                }else{
                    [self.maxIndicateView setTitle:[NSString stringWithFormat:@"%@円",self.placeArray[index]]];
                }
                [self loadPro];
                if (self.bigMaxView.left-self.bigMinView.right<=[Unity countcoordinatesW:30]) {
                    self.minIndicateView.hidden = YES;
                    self.maxIndicateView.hidden = YES;
                    self.mxLabelView.hidden = NO;
                    [self loadMaxLabel];
                }else{
                    self.minIndicateView.hidden = NO;
                    self.maxIndicateView.hidden = NO;
                    self.mxLabelView.hidden = YES;
                }
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            NSLog(@"最大滑动结束%@",_maxIndicateView.indicateLabel.text);
            if ([_maxIndicateView.indicateLabel.text isEqualToString:@"未设置"]) {
                max=@"";
            }else{
                max = [_maxIndicateView.indicateLabel.text stringByReplacingOccurrencesOfString:@"円" withString:@""];
            }
            page=1;
            if (self.isSearch) {
                [self requestGoods];
            }else{
                [self requestGoods1];
            }
        }
            break;
            
        default:
            break;
    }
    
}

- (void)loadPro{
    self.progressLine.frame = CGRectMake(self.bigMinView.center.x, [Unity countcoordinatesH:35], self.bigMaxView.center.x-self.bigMinView.center.x, [Unity countcoordinatesH:4]);
}
/**
 重定位
 */
- (void)loadMin:(CGFloat)min{
    if (min>100000) {
        self.bigMinView.frame = CGRectMake(34/34*[Unity countcoordinatesW:240], 0, [Unity countcoordinatesW:40], 60);
//        [self.minIndicateView setTitle:[NSString stringWithFormat:@"%.f円",min]];
    }else{
        CGFloat subMax;
        for (int i=0; i<self.placeArray.count; i++) {
            if (min > [self.placeArray[i] floatValue]) {
                
            }else if (min ==[self.placeArray[i] floatValue]){
                CGFloat index = (CGFloat)[self.placeArray indexOfObject:self.placeArray[i]];
                self.bigMinView.frame = CGRectMake(index/34*[Unity countcoordinatesW:240], 0, [Unity countcoordinatesW:40], 60);
                break;
            }else{
                subMax = (CGFloat)[self.placeArray indexOfObject:self.placeArray[i]];
                self.bigMinView.frame = CGRectMake((subMax*2-1)/2/34*[Unity countcoordinatesW:240], 0, [Unity countcoordinatesW:40], 60);
                break;
            }
        }
//        [self.minIndicateView setTitle:[NSString stringWithFormat:@"%.f円",min]];
    }
    [self.minIndicateView setTitle:[NSString stringWithFormat:@"%.f円",min]];
    [self loadPro];
    if (self.bigMaxView.left-self.bigMinView.right<=[Unity countcoordinatesW:30]) {
        self.minIndicateView.hidden = YES;
        self.maxIndicateView.hidden = YES;
        self.mxLabelView.hidden = NO;
        [self loadMaxLabel];
    }else{
        self.minIndicateView.hidden = NO;
        self.maxIndicateView.hidden = NO;
        self.mxLabelView.hidden = YES;
    }
}
/**
 重定位
 */
- (void)loadMax:(CGFloat)max{
    if (max == 0) {
        self.bigMaxView.frame = CGRectMake(34/34*[Unity countcoordinatesW:240]+[Unity countcoordinatesW:40], 0, [Unity countcoordinatesW:40], 60);
    }else if (max>100000) {
        self.bigMaxView.frame = CGRectMake(34/34*[Unity countcoordinatesW:240]+[Unity countcoordinatesW:40], 0, [Unity countcoordinatesW:40], 60);
    }else{
        CGFloat subMax;
        for (int i=0; i<self.placeArray.count; i++) {
            if (max > [self.placeArray[i] floatValue]) {
                
            }else if (max ==[self.placeArray[i] floatValue]){
                CGFloat index = (CGFloat)[self.placeArray indexOfObject:self.placeArray[i]];
                self.bigMaxView.frame = CGRectMake(index/34*[Unity countcoordinatesW:240]+[Unity countcoordinatesW:40], 0, [Unity countcoordinatesW:40], 60);
                break;
            }else{
                subMax = (CGFloat)[self.placeArray indexOfObject:self.placeArray[i]];
                self.bigMaxView.frame = CGRectMake((subMax*2-1)/2/34*[Unity countcoordinatesW:240]+[Unity countcoordinatesW:40], 0, [Unity countcoordinatesW:40], 60);
                break;
            }
        }
    }
    if (max== 0) {
        [self.maxIndicateView setTitle:@"未设置"];
    }else{
        [self.maxIndicateView setTitle:[NSString stringWithFormat:@"%.f円",max]];
    }
    [self loadPro];
    if (self.bigMaxView.left-self.bigMinView.right<=[Unity countcoordinatesW:30]) {
        self.minIndicateView.hidden = YES;
        self.maxIndicateView.hidden = YES;
        self.mxLabelView.hidden = NO;
        [self loadMaxLabel];
    }else{
        self.minIndicateView.hidden = NO;
        self.maxIndicateView.hidden = NO;
        self.mxLabelView.hidden = YES;
    }
}
- (void)loadMaxLabel{
    self.mxLabelView.frame = CGRectMake(self.bigMaxView.left-((self.bigMaxView.left-self.bigMinView.right)/2)-[Unity countcoordinatesW:45], -5, [Unity countcoordinatesW:90], 30);
    if ([self.maxIndicateView.indicateLabel.text isEqualToString:@"未设置"]) {
        self.mxLabelView.indicateLabel.text = [NSString stringWithFormat:@"%@~未设置",self.minIndicateView.indicateLabel.text];
    }else if ([self.minIndicateView.indicateLabel.text isEqualToString:self.maxIndicateView.indicateLabel.text]) {
        self.mxLabelView.indicateLabel.text = self.minIndicateView.indicateLabel.text;
    }else{
        self.mxLabelView.indicateLabel.text = [NSString stringWithFormat:@"%@~%@",[_minIndicateView.indicateLabel.text stringByReplacingOccurrencesOfString:@"円" withString:@""],self.maxIndicateView.indicateLabel.text];
    }
    
    
//    [_mxLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_offset(10);
//        make.centerX.mas_offset(self.bigMaxView.left-[Unity countcoordinatesW:15]);
//        make.width.mas_offset([Unity countcoordinatesW:100]);
//        make.height.mas_offset(30);
//    }];
}
- (NSArray *)placeArray{
    if (!_placeArray) {
        _placeArray = @[@"1",@"500",@"1000",@"1500",@"2000",@"2500",@"3000",@"3500",@"4000",@"4500",@"5000",@"6000",@"7000",@"8000",@"9000",@"10000",@"15000",@"20000",@"25000",@"30000",@"35000",@"40000",@"45000",@"50000",@"55000",@"60000",@"65000",@"70000",@"75000",@"80000",@"85000",@"90000",@"95000",@"100000",@"未设置"];
    }
    return _placeArray;
}

- (UIButton *)defaultBtn{
    if (!_defaultBtn) {
        _defaultBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/4, [Unity countcoordinatesH:50])];
        [_defaultBtn addTarget:self action:@selector(defaultClick) forControlEvents:UIControlEventTouchUpInside];
        [_defaultBtn setTitle:@"默认" forState:UIControlStateNormal];
        [_defaultBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_defaultBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateSelected];
        _defaultBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
        _defaultBtn.selected = YES;
    }
    return _defaultBtn;
}
- (UIButton *)numberBtn{
    if (!_numberBtn) {
        /* 获取按钮文字的宽度 获取按钮图片和文字的间距 获取图片宽度 */
        CGFloat    space = 5;// 图片和文字的间距
        NSString    * titleString = [NSString stringWithFormat:@"次数"];
        CGFloat    titleWidth = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FontSize(16)]}].width;
        UIImage    * btnImage = [UIImage imageNamed:@"goodsList_default"];// 11*6
        CGFloat    imageWidth = btnImage.size.width;
        //创建按钮
        _numberBtn = [[UIButton alloc] initWithFrame:CGRectMake(_defaultBtn.right, 0, SCREEN_WIDTH/4, [Unity countcoordinatesH:50])];
        [_numberBtn addTarget:self action:@selector(numberClick) forControlEvents:UIControlEventTouchUpInside];
        _numberBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
        [_numberBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_numberBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateSelected];
        [_numberBtn setTitle:@"次数" forState:UIControlStateNormal];
        [_numberBtn setImage:[UIImage imageNamed:@"goodsList_default"] forState:UIControlStateNormal];
        [_numberBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -(imageWidth+space*0.5), 0, (imageWidth+space*0.5))];
        [_numberBtn setImageEdgeInsets:UIEdgeInsetsMake(0, (titleWidth + space*0.5), 0, -(titleWidth + space*0.5))];
    }
    return _numberBtn;
}
- (UIButton *)amountBtn{
    if (!_amountBtn) {
        /* 获取按钮文字的宽度 获取按钮图片和文字的间距 获取图片宽度 */
        CGFloat    space = 5;// 图片和文字的间距
        NSString    * titleString = [NSString stringWithFormat:@"价格"];
        CGFloat    titleWidth = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FontSize(16)]}].width;
        UIImage    * btnImage = [UIImage imageNamed:@"goodsList_default"];// 11*6
        CGFloat    imageWidth = btnImage.size.width;
        //创建按钮
        _amountBtn = [[UIButton alloc] initWithFrame:CGRectMake(_numberBtn.right, 0, SCREEN_WIDTH/4, [Unity countcoordinatesH:50])];
        [_amountBtn addTarget:self action:@selector(amountClick) forControlEvents:UIControlEventTouchUpInside];
        _amountBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
        [_amountBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_amountBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateSelected];
        [_amountBtn setTitle:@"价格" forState:UIControlStateNormal];
        [_amountBtn setImage:[UIImage imageNamed:@"goodsList_default"] forState:UIControlStateNormal];
        [_amountBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -(imageWidth+space*0.5), 0, (imageWidth+space*0.5))];
        [_amountBtn setImageEdgeInsets:UIEdgeInsetsMake(0, (titleWidth + space*0.5), 0, -(titleWidth + space*0.5))];
    }
    return _amountBtn;
}
- (UIButton *)timeBtn{
    if (!_timeBtn) {
        /* 获取按钮文字的宽度 获取按钮图片和文字的间距 获取图片宽度 */
        CGFloat    space = 5;// 图片和文字的间距
        NSString    * titleString = [NSString stringWithFormat:@"时间"];
        CGFloat    titleWidth = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FontSize(16)]}].width;
        UIImage    * btnImage = [UIImage imageNamed:@"goodsList_default"];// 11*6
        CGFloat    imageWidth = btnImage.size.width;
        //创建按钮
        _timeBtn = [[UIButton alloc] initWithFrame:CGRectMake(_amountBtn.right, 0, SCREEN_WIDTH/4, [Unity countcoordinatesH:50])];
        [_timeBtn addTarget:self action:@selector(timeClick) forControlEvents:UIControlEventTouchUpInside];
        _timeBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
        [_timeBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_timeBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateSelected];
        [_timeBtn setTitle:@"时间" forState:UIControlStateNormal];
        [_timeBtn setImage:[UIImage imageNamed:@"goodsList_default"] forState:UIControlStateNormal];
        [_timeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -(imageWidth+space*0.5), 0, (imageWidth+space*0.5))];
        [_timeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, (titleWidth + space*0.5), 0, -(titleWidth + space*0.5))];
    }
    return _timeBtn;
}

//- (UIButton *)priceBtn{
//    if (!_priceBtn) {
//        _priceBtn = [[UIButton alloc]initWithFrame:CGRectMake(_timeBtn.right, 0, SCREEN_WIDTH/6, [Unity countcoordinatesH:50])];
//        [_priceBtn addTarget:self action:@selector(priceClick) forControlEvents:UIControlEventTouchUpInside];
//        [_priceBtn setTitle:@"一口价" forState:UIControlStateNormal];
//        [_priceBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
//        [_priceBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateSelected];
//        _priceBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
//    }
//    return _priceBtn;
//}
//- (UIButton *)auctionBtn{
//    if (!_auctionBtn) {
//        _auctionBtn = [[UIButton alloc]initWithFrame:CGRectMake(_priceBtn.right, 0, SCREEN_WIDTH/6, [Unity countcoordinatesH:50])];
//        [_auctionBtn addTarget:self action:@selector(auctionClick) forControlEvents:UIControlEventTouchUpInside];
//        [_auctionBtn setTitle:@"竞拍" forState:UIControlStateNormal];
//        [_auctionBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
//        [_auctionBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateSelected];
//        _auctionBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
//    }
//    return _auctionBtn;
//}
//- (ScreenView *)sView{
//    if (!_sView) {
//        UIWindow * window = [UIApplication sharedApplication].windows[0];
//        _sView = [ScreenView setScreenView:window];
////        _sView.delegate = self;
//    }
//    return _sView;
//}
#pragma mark  headerview 6个按钮处理事件
- (void)defaultClick{
    if (defaultNum == 1) {
        return;
    }
    if (defaultNum == 0) {
        self.defaultBtn.selected = YES;
        defaultNum = 1;
        numberNum = 0;
        amountNum =0;
        timeNum =0 ;
//        priceNum = 0;
//        auctionNum = 0;
        self.numberBtn.selected = NO;
        [self.numberBtn setImage:[UIImage imageNamed:@"goodsList_default"] forState:UIControlStateNormal];
        self.amountBtn.selected = NO;
        [self.amountBtn setImage:[UIImage imageNamed:@"goodsList_default"] forState:UIControlStateNormal];
        self.timeBtn.selected = NO;
        [self.timeBtn setImage:[UIImage imageNamed:@"goodsList_default"] forState:UIControlStateNormal];
//        self.priceBtn.selected = NO;
//        self.auctionBtn.selected = NO;
        //处理时间 刷新默认(默认)
        type = @"";
        order = @"";
        page=1;
        if (self.isSearch) {
            [self requestGoods];
        }else{
            [self requestGoods1];
        }
    }
}
- (void)numberClick{
    if (numberNum == 0) {
        self.defaultBtn.selected = NO;
        defaultNum = 0;
        numberNum = 1;
        amountNum =0;
        timeNum =0 ;
//        priceNum = 0;
//        auctionNum = 0;
        self.numberBtn.selected = YES;
        [self.numberBtn setImage:[UIImage imageNamed:@"goodsList_bottom"] forState:UIControlStateNormal];
        self.amountBtn.selected = NO;
        [self.amountBtn setImage:[UIImage imageNamed:@"goodsList_default"] forState:UIControlStateNormal];
        self.timeBtn.selected = NO;
        [self.timeBtn setImage:[UIImage imageNamed:@"goodsList_default"] forState:UIControlStateNormal];
//        self.priceBtn.selected = NO;
//        self.auctionBtn.selected = NO;
        //处理事件  次数降序
        type = @"bids";
        order = @"d";
    }else if (numberNum == 1){
        numberNum = 2;
        [self.numberBtn setImage:[UIImage imageNamed:@"goodsList_top"] forState:UIControlStateNormal];
        //次数升序
        type = @"bids";
        order = @"a";
    }else{
        numberNum = 1;
        [self.numberBtn setImage:[UIImage imageNamed:@"goodsList_bottom"] forState:UIControlStateNormal];
        //次数降序
        type = @"bids";
        order = @"d";
    }
    page=1;
    if (self.isSearch) {
        [self requestGoods];
    }else{
        [self requestGoods1];
    }
}
- (void)amountClick{
    if (amountNum == 0) {
        self.defaultBtn.selected = NO;
        defaultNum = 0;
        numberNum = 0;
        amountNum =1;
        timeNum =0 ;
//        priceNum = 0;
//        auctionNum = 0;
        self.numberBtn.selected = NO;
        [self.numberBtn setImage:[UIImage imageNamed:@"goodsList_default"] forState:UIControlStateNormal];
        self.amountBtn.selected = YES;
        [self.amountBtn setImage:[UIImage imageNamed:@"goodsList_bottom"] forState:UIControlStateNormal];
        self.timeBtn.selected = NO;
        [self.timeBtn setImage:[UIImage imageNamed:@"goodsList_default"] forState:UIControlStateNormal];
//        self.priceBtn.selected = NO;
//        self.auctionBtn.selected = NO;
        //处理事件  价格降序
        type = @"cbids";
        order = @"d";
    }else if (amountNum == 1){
        amountNum = 2;
        [self.amountBtn setImage:[UIImage imageNamed:@"goodsList_top"] forState:UIControlStateNormal];
        //价格升序
        type = @"cbids";
        order = @"a";
    }else{
        amountNum = 1;
        [self.amountBtn setImage:[UIImage imageNamed:@"goodsList_bottom"] forState:UIControlStateNormal];
        //价格降序
        type = @"cbids";
        order = @"d";
    }
    page=1;
    if (self.isSearch) {
        [self requestGoods];
    }else{
        [self requestGoods1];
    }
}
- (void)timeClick{
    if (timeNum == 0) {
        self.defaultBtn.selected = NO;
        defaultNum = 0;
        numberNum = 0;
        amountNum =0;
        timeNum =1 ;
//        priceNum = 0;
//        auctionNum = 0;
        self.numberBtn.selected = NO;
        [self.numberBtn setImage:[UIImage imageNamed:@"goodsList_default"] forState:UIControlStateNormal];
        self.amountBtn.selected = NO;
        [self.amountBtn setImage:[UIImage imageNamed:@"goodsList_default"] forState:UIControlStateNormal];
        self.timeBtn.selected = YES;
        [self.timeBtn setImage:[UIImage imageNamed:@"goodsList_bottom"] forState:UIControlStateNormal];
//        self.priceBtn.selected = NO;
//        self.auctionBtn.selected = NO;
        //处理事件  时间降序
        type = @"end";
        order = @"d";
    }else if (timeNum == 1){
        timeNum = 2;
        [self.timeBtn setImage:[UIImage imageNamed:@"goodsList_top"] forState:UIControlStateNormal];
        //时间升序
        type = @"end";
        order = @"a";
    }else{
        timeNum = 1;
        [self.timeBtn setImage:[UIImage imageNamed:@"goodsList_bottom"] forState:UIControlStateNormal];
        //时间降序
        type = @"end";
        order = @"d";
    }
    page=1;
    if (self.isSearch) {
        [self requestGoods];
    }else{
        [self requestGoods1];
    }
}
//- (void)priceClick{
//    if (priceNum == 0) {
//        self.defaultBtn.selected = NO;
//        defaultNum = 0;
//        numberNum = 0;
//        amountNum =0;
//        timeNum =0 ;
//        priceNum = 1;
//        auctionNum = 0;
//        self.numberBtn.selected = NO;
//        [self.numberBtn setImage:[UIImage imageNamed:@"goodsList_default"] forState:UIControlStateNormal];
//        self.amountBtn.selected = NO;
//        [self.amountBtn setImage:[UIImage imageNamed:@"goodsList_default"] forState:UIControlStateNormal];
//        self.timeBtn.selected = NO;
//        [self.timeBtn setImage:[UIImage imageNamed:@"goodsList_default"] forState:UIControlStateNormal];
//        self.priceBtn.selected = YES;
//        self.auctionBtn.selected = NO;
//        //处理事件 选中一口价
//    }
//}
//- (void)auctionClick{
//    if (auctionNum == 0) {
//        self.defaultBtn.selected = NO;
//        defaultNum = 0;
//        numberNum = 0;
//        amountNum =0;
//        timeNum =0 ;
//        priceNum = 0;
//        auctionNum = 1;
//        self.numberBtn.selected = NO;
//        [self.numberBtn setImage:[UIImage imageNamed:@"goodsList_default"] forState:UIControlStateNormal];
//        self.amountBtn.selected = NO;
//        [self.amountBtn setImage:[UIImage imageNamed:@"goodsList_default"] forState:UIControlStateNormal];
//        self.timeBtn.selected = NO;
//        [self.timeBtn setImage:[UIImage imageNamed:@"goodsList_default"] forState:UIControlStateNormal];
//        self.priceBtn.selected = NO;
//        self.auctionBtn.selected = YES;
//        //处理事件 选中竞拍
//    }
//}
- (NSMutableArray *)goodsList{
    if (!_goodsList) {
        _goodsList = [NSMutableArray new];
    }
    return _goodsList;
}
- (void)requestGoods{
    
    NSInteger slideTime = [[[NSUserDefaults standardUserDefaults]objectForKey:@"slideTime"] integerValue];
    if (self.requestDate && slideTime) {
        NSDate *currentDate = [NSDate date];
        NSInteger time = [currentDate timeIntervalSinceDate:self.requestDate];
        if (time < slideTime) {
            [self.collectionView.mj_header endRefreshing];
            [WHToast showMessage:@"操作太快了，休息一下" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
            return;
        }
    }
    self.requestDate = [NSDate date];
    
    [self.collectionView.mj_header endRefreshing];
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSString * customer;
    if (userInfo) {
        //已登录
        customer = [userInfo objectForKey:@"member_id"];
    }else{
        //未登录
        customer = @"";
    }
    [self.aAnimation startAround];
    if (self.locale ==nil) {
        self.locale = @"";
    }
    if (self.classId == nil) {
        self.classId = @"";
    }
    if (self.brandId == nil) {
        self.brandId = @"";
    }
    if (self.sellerId == nil) {
        self.sellerId = @"";
    }
    if (self.keyWord == nil) {
        self.keyWord = @"";
    }
    if (brandWord != nil) {
        self.keyWord = brandWord;
    }
    if (sellerID != nil) {
        self.sellerId = sellerID;
    }
    if (categoryId != nil) {
        self.classId = categoryId;
    }
    NSDictionary * params = @{@"platform":self.platform,@"locale":self.locale,@"customer":customer,@"word":self.keyWord,@"page":[NSString stringWithFormat:@"%ld",(long)page],@"sort":type,@"order":order,@"buynow":buynow,@"min":min,@"max":max,@"istatus":istatus,@"pstagefree":pstagefree,@"saler":self.sellerId,@"num":self.classId,@"abatch":abatch};
    params = [Unity deleteNullValue:params];
    NSLog(@"处理过后%@",params);
    [GZMrequest postWithURLString:[GZMUrl get_searchbar_url]parameters:params success:^(NSDictionary *data) {
        [self.aAnimation stopAround];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            self.goodsList = [data[@"data"] mutableCopy];
            [self.collectionView reloadData];
            //如果第一次打开
            NSString * frist = [[NSUserDefaults standardUserDefaults] objectForKey:@"frist"];
            if (frist == nil) {
                [self.tView showToastImg];
            }
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"frist"];
            [[JYTimerUtil sharedInstance] timerStart];
        }else{
            [self.altView showAlertView];
            self.altView.msgL.text = [data objectForKey:@"msg"];
        }
    } failure:^(NSError *error) {
        [self.aAnimation stopAround];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)loadMoreData{
    
    NSInteger slideTime = [[[NSUserDefaults standardUserDefaults]objectForKey:@"slideTime"] integerValue];
    if (self.requestDate && slideTime) {
        NSDate *currentDate = [NSDate date];
        NSInteger time = [currentDate timeIntervalSinceDate:self.requestDate];
        if (time < slideTime) {
            [self.collectionView.mj_footer endRefreshing];
            [WHToast showMessage:@"操作太快了，休息一下" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
            return;
        }
    }
    self.requestDate = [NSDate date];
    
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSString * customer;
    if (userInfo) {
        //已登录
        customer = [userInfo objectForKey:@"member_id"];
    }else{
        //未登录
        customer = @"";
    }
    [self.aAnimation startAround];

    
    NSDictionary * params = @{@"platform":self.platform,@"locale":self.locale,@"customer":customer,@"word":self.keyWord,@"page":[NSString stringWithFormat:@"%ld",(long)page],@"sort":type,@"order":order,@"buynow":buynow,@"min":min,@"max":max,@"istatus":istatus,@"pstagefree":pstagefree,@"saler":self.sellerId,@"num":self.classId,@"abatch":abatch};
    params = [Unity deleteNullValue:params];
    NSLog(@"处理过后%@",params);
    [GZMrequest postWithURLString:[GZMUrl get_searchbar_url]parameters:params success:^(NSDictionary *data) {
        [self.aAnimation stopAround];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {

            for (int i=0; i<[data[@"data"] count]; i++) {
                [self.goodsList addObject:data[@"data"][i]];
            }
            [self.collectionView reloadData];
            [[JYTimerUtil sharedInstance] timerStart];
            [self.collectionView.mj_footer endRefreshing];
            if ([data[@"data"] count]  < 20) {

                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
//                self.collectionView.mj_footer.hidden = YES;
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
- (void)requestGoods1{
    
    NSInteger slideTime = [[[NSUserDefaults standardUserDefaults]objectForKey:@"slideTime"] integerValue];
    if (self.requestDate && slideTime) {
        NSDate *currentDate = [NSDate date];
        NSInteger time = [currentDate timeIntervalSinceDate:self.requestDate];
        if (time < slideTime) {
            [self.collectionView.mj_header endRefreshing];
            [WHToast showMessage:@"操作太快了，休息一下" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
            return;
        }
    }
    self.requestDate = [NSDate date];
    
    [self.collectionView.mj_header endRefreshing];
    [self.aAnimation startAround];
    if (self.locale ==nil) {
        self.locale = @"";
    }
    if (self.classId == nil) {
        self.classId = @"";
    }
    if (self.brandId == nil) {
        self.brandId = @"";
    }
    if (self.sellerId == nil) {
        self.sellerId = @"";
    }
    if (self.zhutiId == nil) {
        self.zhutiId = @"";
    }
    if (brandWord != nil) {
        self.brandId = brandWord;
    }
    if (sellerID != nil) {
        self.sellerId = sellerID;
    }
    if (categoryId != nil) {
        self.classId = categoryId;
    }
    
    NSDictionary * params = @{@"platform":self.platform,@"locale":self.locale,@"num":self.classId,@"page":[NSString stringWithFormat:@"%ld",(long)page],@"sort":type,@"order":order,@"buynow":buynow,@"min":min,@"max":max,@"istatus":istatus,@"pstagefree":pstagefree,@"brand":self.brandId,@"saler":self.sellerId,@"special":self.zhutiId,@"abatch":abatch};

    params = [Unity deleteNullValue:params];
    NSLog(@"处理过后%@",params);
    
    
    [GZMrequest getWithURLString:[GZMUrl get_goodsList_url] parameters:params success:^(NSDictionary *data) {
//        NSLog(@"分类查询 %@",data);
        [self.aAnimation stopAround];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            self.goodsList = [data[@"data"] mutableCopy];
//            if (self.home) {
//                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
//            }
            [self loadRouterView:data[@"patharr"]];
            [self.collectionView reloadData];
            //如果第一次打开
            NSString * frist = [[NSUserDefaults standardUserDefaults] objectForKey:@"frist"];
            if (frist == nil) {
                [self.tView showToastImg];
            }
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"frist"];
            [[JYTimerUtil sharedInstance] timerStart];
        }else{
            [self.altView showAlertView];
            self.altView.msgL.text = [data objectForKey:@"msg"];
        }
    } failure:^(NSError *error) {
        [self.aAnimation stopAround];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)loadRouterView:(NSArray *)arr{
    for (UIView *subview in self.routerView.subviews) {
        [subview removeFromSuperview];
    }
    if (arr.count == 0) {
        self.routerView.hidden = YES;
        self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:50]+60);
        self.collectionView.frame = CGRectMake(0, self.headerView.height, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-self.headerView.height);
    }else{
        self.pathArr = arr;
        self.seletedImg.frame = CGRectMake(0, 0, 0, 0);
        for (int i=0; i<arr.count; i++) {
            NSArray * array = [arr[i] allKeys];
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(self.seletedImg.right+[Unity countcoordinatesW:10], 0, [Unity widthOfString:arr[i][array[0]] OfFontSize:FontSize(12) OfHeight:[Unity countcoordinatesH:40]], [Unity countcoordinatesH:40])];
            btn.tag = 9000+i;
            [btn addTarget:self action:@selector(pathBtn:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:arr[i][array[0]] forState:UIControlStateNormal];
            [btn setTitleColor:LabelColor9 forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:FontSize(12)];
            [self.routerView addSubview:btn];
            if (i != (arr.count -1)) {
                UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(btn.right+[Unity countcoordinatesW:8], [Unity countcoordinatesH:15], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10])];
                img.image = [UIImage imageNamed:@"go"];
                [self.routerView addSubview:img];
                
                self.seletedImg = img;
            }
            if (i==(arr.count -1)) {
                [btn setTitleColor:LabelColor3 forState:UIControlStateNormal];
                if (btn.right+[Unity countcoordinatesW:10]>SCREEN_WIDTH) {
                    [self.routerView setContentOffset:CGPointMake(btn.right+[Unity countcoordinatesW:10]-SCREEN_WIDTH, 0) animated:YES];
                }
                self.routerView.contentSize =  CGSizeMake(btn.right+[Unity countcoordinatesW:10], 0);
            }
        }
    }
}
- (void)pathBtn:(UIButton *)sender{
    NSLog(@"%@",self.pathArr[sender.tag- 9000]);
    NSString * classId = [self.pathArr[sender.tag- 9000] allKeys][0];
    NSString * className = self.pathArr[sender.tag- 9000][classId];
    NSLog(@"id = %@ name = %@",classId,className);
    GoodsListViewController * gvc = [[GoodsListViewController alloc]init];
    gvc.pageIndex =self.pageIndex;
    gvc.isSearch = NO;
    gvc.platform = @"0";
    gvc.classId = classId;
    gvc.className = className;
    [self.navigationController pushViewController:gvc animated:YES];
}
- (void)loadMoreData1{
    
    NSInteger slideTime = [[[NSUserDefaults standardUserDefaults]objectForKey:@"slideTime"] integerValue];
    if (self.requestDate && slideTime) {
        NSDate *currentDate = [NSDate date];
        NSInteger time = [currentDate timeIntervalSinceDate:self.requestDate];
        if (time < slideTime) {
            [self.collectionView.mj_footer endRefreshing];
            [WHToast showMessage:@"操作太快了，休息一下" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
            return;
        }
    }
    self.requestDate = [NSDate date];
    
    [self.aAnimation startAround];

    NSDictionary * params = @{@"platform":self.platform,@"locale":self.locale,@"num":self.classId,@"page":[NSString stringWithFormat:@"%ld",(long)page],@"sort":type,@"order":order,@"buynow":buynow,@"min":min,@"max":max,@"istatus":istatus,@"pstagefree":pstagefree,@"brand":self.brandId,@"saler":self.sellerId,@"special":self.zhutiId,@"abatch":abatch};
    
    params = [Unity deleteNullValue:params];
    NSLog(@"处理过后%@",params);
    [GZMrequest getWithURLString:[GZMUrl get_goodsList_url] parameters:params success:^(NSDictionary *data) {
        NSLog(@"分类查询 %@",data);
        [self.aAnimation stopAround];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {

            for (int i=0; i<[data[@"data"] count]; i++) {
                [self.goodsList addObject:data[@"data"][i]];
            }
            [self.collectionView reloadData];
            [[JYTimerUtil sharedInstance] timerStart];
            [self.collectionView.mj_footer endRefreshing];
            if ([data[@"data"] count]  < 20) {

                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                //                self.collectionView.mj_footer.hidden = YES;
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
#pragma mark  侧滑框代理
- (void)configYhLeftRadio:(NSString *)radio WithMinPlace:(NSString *)minPlace WithMaxPlace:(NSString *)maxPlace WithSellerId:(NSString *)sellerId WithClassId:(NSString *)classId WithIndex:(NSInteger)index WithKeyWord:(NSString *)keyWord WithClassName:(nonnull NSString *)className WithLanguage:(nonnull NSString *)language{
    
    
    min = minPlace;
    max = maxPlace;
    [self loadMin:[min floatValue]];
    [self loadMax:[max floatValue]];
    sellerID = sellerId;
    categoryId = classId;
    brandWord = keyWord;
    self.className =className;
    self.locale = language;
//    if (index ==0 && [sellerId isEqualToString:@""] && [minPlace isEqualToString:@""] && [maxPlace isEqualToString:@""] && [classId isEqualToString:@""] && [keyWord isEqualToString:@""]) {
//        [self reset];
//    }
    if (index == 0) {
        buynow = @"";
        istatus = @"";
        pstagefree = @"";
        abatch = @"";
    }else if (index == 1){
        buynow = @"";
        istatus = @"";
        pstagefree = @"1";
        abatch = @"";
    }else if (index == 2){
        buynow = @"0";
        istatus = @"";
        pstagefree = @"";
        abatch = @"";
    }else if (index == 3){
        buynow = @"1";
        istatus = @"";
        pstagefree = @"";
        abatch = @"";
    }else if (index == 4){
        buynow = @"";
        istatus = @"1";
        pstagefree = @"";
        abatch = @"";
    }else if (index == 5){
        buynow = @"";
        istatus = @"2";
        pstagefree = @"";
        abatch = @"";
    }else if (index == 6){
        buynow = @"";
        istatus = @"";
        pstagefree = @"";
        abatch = @"0";
    }else if (index == 7){
        buynow = @"";
        istatus = @"";
        pstagefree = @"";
        abatch = @"1";
    }else{
        buynow = @"";
        istatus = @"";
        pstagefree = @"";
        abatch = @"2";
    }
    page=1;
    if (self.isSearch) {
        [self requestGoods];
    }else{
        [self requestGoods1];
    }
    
}
- (void)screenBtnIndex:(NSInteger)btnIndex WithMin:(NSString *)placemin WithMax:(NSString *)placemax WithIndex:(NSInteger)index{
    min = placemin;
    max = placemax;
//    [self loadMin:[min floatValue]];
//    [self loadMax:[max floatValue]];
    
    NSLog(@"%@-%@-",min,max);
    if (index == 0) {
        buynow = @"";
        istatus = @"";
        pstagefree = @"";
        abatch = @"";
    }else if (index == 1){
        buynow = @"";
        istatus = @"";
        pstagefree = @"1";
        abatch = @"";
    }else if (index == 2){
        buynow = @"0";
        istatus = @"";
        pstagefree = @"";
        abatch = @"";
    }else if (index == 3){
        buynow = @"1";
        istatus = @"";
        pstagefree = @"";
        abatch = @"";
    }else if (index == 4){
        buynow = @"";
        istatus = @"1";
        pstagefree = @"";
        abatch = @"";
    }else if (index == 5){
        buynow = @"";
        istatus = @"2";
        pstagefree = @"";
        abatch = @"";
    }else if (index == 6){
        buynow = @"";
        istatus = @"";
        pstagefree = @"";
        abatch = @"0";
    }else if (index == 7){
        buynow = @"";
        istatus = @"";
        pstagefree = @"";
        abatch = @"1";
    }else{
        buynow = @"";
        istatus = @"";
        pstagefree = @"";
        abatch = @"2";
    }
    NSLog(@"%@-%@-%@-",buynow,istatus,pstagefree);
    if ([placemin isEqualToString:@""] && ![placemax isEqualToString:@""]) {
        [WHToast showMessage:@"请输入最低价" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }else if (![placemin isEqualToString:@""] && [placemax isEqualToString:@""]){
        [WHToast showMessage:@"请输入最高价" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }else{
        NSLog(@"可以执行");
        [self.sView maskAction];
        page=1;
        if (self.isSearch) {
            [self requestGoods];
        }else{
            [self requestGoods1];
        }
    }
}
//侧滑抽屉效果
// 仿QQ从右侧划出
- (void)defaultAnimationFromRight{
//    LeftViewController *vc = [[LeftViewController alloc] init];
//    vc.delegate = self;
//    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration defaultConfiguration];
//    conf.direction = CWDrawerTransitionFromRight; // 从右边滑出
//    conf.finishPercent = 0.2f;
//    conf.showAnimDuration = 1.0f;
//    conf.HiddenAnimDuration = 0.2;
//    conf.maskAlpha = 0.1;
//
//    [self cw_showDrawerViewController:vc animationType:CWDrawerAnimationTypeDefault configuration:conf];
    
    YhLeftViewController *vc = [[YhLeftViewController alloc] init];
    vc.delegate = self;
    vc.tjArr = @[@"默认",@"免当地运费",@"限时购",@"一口价",@"全新",@"二手",@"全部卖家",@"商家二手",@"个人"];
    vc.platForm = self.platform;
    vc.sellerStr = self.sellerId;
    if (self.isSearch) {
        vc.wordStr = self.keyWord;
    }else{
        vc.wordStr = self.brandId;
    }
    
    if (self.className == nil) {
        self.className = @"";
    }
    vc.categoryStr = self.className;
    vc.categoryID = self.classId;
    if (keyA == nil) {
        keyA = @"";
    }
    if (keyC == nil) {
        keyC = @"";
    }
    if (keyE == nil) {
        keyE = @"";
    }
    if (keyF == nil) {
        keyF = @"";
    }
    vc.categoryA = keyA;
    vc.categoryB = keyF;
    vc.sellerA = keyC;
    vc.wordA = keyE;
    vc.minStr = min;
    vc.maxStr = max;
    
    if (self.locale == nil) {
        self.locale = @"";
    }
    if (keyG == nil) {
        keyG = @"";
    }
    vc.localA = keyG;
    vc.local = self.locale;
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration defaultConfiguration];
    conf.direction = CWDrawerTransitionFromRight;
    conf.showAnimDuration = 1.0f;
    [self cw_showDrawerViewController:vc animationType:CWDrawerAnimationTypeMask configuration:conf];
    
}
#pragma mark - 自定义处理手势冲突接口
#if 0
- (BOOL)cw_gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;// 可以在这里实现自己需要处理的手势冲突逻辑
}
#endif



#pragma mark  cell长按手势处理
- (void)cellLongPress:(UILongPressGestureRecognizer *)lpGR{
    
    if (lpGR.state == UIGestureRecognizerStateBegan) {//手势开始
        CGPoint index = [lpGR locationInView:self.collectionView];
        caIndex = [self.collectionView indexPathForItemAtPoint:index];

        //  1.实例化UIAlertController对象
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否收藏" message:nil preferredStyle:UIAlertControllerStyleAlert];

        //  2.1实例化UIAlertAction按钮:取消按钮
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self collectionGoods];
        }];
        [alert addAction:defaultAction];

        //  2.2实例化UIAlertAction按钮:确定按钮
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                                  
        }];
        [alert addAction:cancelAction];

        //  3.显示alertController
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (void)collectionGoods{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    if (userInfo == nil) {
        LoginViewController * lvc = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:lvc animated:YES];
        return;
    }
    int time = [self.goodsList[caIndex.row][@"EndTime"] intValue];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:time];
    NSString *timeStr=[[self dateFormatWith:@"YYYY/MM/dd HH:mm:ss"] stringFromDate:date];
    NSDictionary * dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"area":@"0",@"type":@"goods",@"w_main_category_id":@"",@"w_goods_category_id":@"",@"w_object":self.goodsList[caIndex.row][@"Title"],@"w_link":self.goodsList[caIndex.row][@"ItemUrl"],@"w_overtime":timeStr,@"w_jpnid":self.goodsList[caIndex.row][@"AuctionID"],@"w_imgsrc":self.goodsList[caIndex.row][@"Image"],@"w_tag":@""};
    NSLog(@"收藏请求= %@",dic);
    [self.aAnimation startAround];
    [GZMrequest postWithURLString:[GZMUrl get_collection_url] parameters:dic success:^(NSDictionary *data) {
        [self.aAnimation stopAround];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }else{
            [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [self.aAnimation stopAround];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
//获取日期格式化器
-(NSDateFormatter *)dateFormatWith:(NSString *)formatStr {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formatStr];//@"YYYY-MM-dd HH:mm:ss"
    //设置时区
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Tokyo"];
    [formatter setTimeZone:timeZone];
    
    return formatter;
}
- (ToastImg *)tView{
    if (!_tView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _tView = [ToastImg setToastImg:window];
    }
    return _tView;
}
- (NSArray *)pathArr{
    if (!_pathArr) {
        _pathArr = [NSArray new];
    }
    return _pathArr;
}
- (void)saveParameter{
    keyA = self.classId;
    keyB = self.brandId;
    keyC = self.sellerId;
    keyD = self.zhutiId;
    keyE = self.keyWord;
    keyF = self.className;
    keyG = self.locale;
}
@end

