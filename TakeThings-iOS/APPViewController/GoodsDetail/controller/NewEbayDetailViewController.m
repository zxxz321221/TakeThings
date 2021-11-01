//
//  NewEbayDetailViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/8/16.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "NewEbayDetailViewController.h"
#import "SDCycleScrollView.h"
#import "ProductParametersView.h"
#import "ActivityWebViewController.h"
#import "LoginViewController.h"
#import "UsTrialViewController.h"
#import "EntrustViewController.h"
#import "WebViewController.h"
#import "EbayGoodsListViewController.h"
#import <WebKit/WebKit.h>
#import "WKWebView+WKview.h"
#import "SDPhotoBrowser.h"
#import "EbayGoodsListViewController.h"
#import "GZMShareView.h"
#import "WXApi.h"
#import "GuessViewController.h"
#import "RecomHeaderView.h"
#import "RecomeCell.h"
#import "ServiceViewController.h"
#define CellIdentifier @"CellIdentifier"
@interface NewEbayDetailViewController ()<UIScrollViewDelegate,SDCycleScrollViewDelegate,WKNavigationDelegate,UIScrollViewDelegate,WKUIDelegate,SDPhotoBrowserDelegate,GZMShareViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSDictionary * userInfo;
    NSString * salerStr;
    NSString * goodsStr;
    NSString * endTime;
    BOOL isYuanwen;//默认yes  原文
    CGFloat newHeight;
    BOOL isAction;
    BOOL isbanner;
    NSString * bjTime;
    NSInteger buystate;//1允许购买 0不允许购买
    NSString * buystate_msg;
}
@property (nonatomic , strong) NSDictionary * dataDic;
//自定义导航栏
@property (nonatomic , strong) UIView * navView;
@property (nonatomic , strong) UIImageView * navIcon;
@property (nonatomic , strong) UIButton * oldLeftBtn;
@property (nonatomic , strong) UIButton * oldRightBtn;
@property (nonatomic , strong) UIButton * oldShareBtn;
@property (nonatomic , strong) UIButton * LeftBtn;
@property (nonatomic , strong) UIButton * RightBtn;
@property (nonatomic , strong) UIButton * shareBtn;


@property (nonatomic , strong) UIScrollView * scrollView;

@property (nonatomic , strong) SDCycleScrollView * cycleScrollView;//轮播图
@property (nonatomic , strong) NSMutableArray * imagesURLStrings;

// topView
@property (nonatomic, strong) UIView * topView;
@property (nonatomic , strong) UIView * mView;//倒计时view
@property (nonatomic , strong) UILabel * timeL;//倒计时
@property (nonatomic , strong) UILabel * annotationL;//商品提醒
@property (nonatomic , strong) UILabel * goodsTitle;//商品标题
@property (nonatomic , strong) UILabel * offerL;//目前出价
@property (nonatomic , strong) UILabel * currencyL;//币种
@property (nonatomic , strong) UILabel * currentOffer;//当前出价
@property (nonatomic , strong) UILabel * RMBL;//人民币显示
@property (nonatomic , strong) UILabel * numberL;//竞拍人数
@property (nonatomic , strong) UILabel * winL;//当前赢标人
@property (nonatomic , strong) UILabel * taxL;//附加税
@property (nonatomic , strong) NSTimer * timer;

//twoView
@property (nonatomic , strong) UIView * twoView;
@property (nonatomic , strong) UILabel * currentTime;
@property (nonatomic , strong) UILabel * stopTime;
@property (nonatomic , strong) UILabel * amount;

//threeView
@property (nonatomic , strong) UIView * threeView;
@property (nonatomic,strong) UIButton * parameterBtn;
@property (nonatomic , strong) ProductParametersView * pView;
@property (nonatomic , strong) UIImageView * icon;
@property (nonatomic , strong) UILabel * sellerL;
@property (nonatomic , strong) UIButton * sellerBtn;
@property (nonatomic , strong) UILabel * nameL;

@property (nonatomic , strong) UILabel * evaluate;
//好评h差评 图片和数量
@property (nonatomic , strong) UIImageView * haoImg;
@property (nonatomic , strong) UILabel * haoL;
@property (nonatomic , strong) UIImageView * chaImg;
@property (nonatomic , strong) UILabel * chaL;
@property (nonatomic , strong) UIButton * originalPageBtn;
@property (nonatomic , strong) UIButton * allGoodsBtn;
@property (nonatomic , strong) UILabel * threeLine;


//bottomView
@property (nonatomic , strong) UIView * bottomView;
@property (nonatomic , strong) UIImageView * collectionImg;

//fourView
@property (nonatomic , strong) UIView * fourView;
@property (nonatomic , strong) UIButton * yuanwen;
@property (nonatomic , strong) UIButton * fanyi;
@property (nonatomic , strong) UILabel * foutLine;

//webview
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic , strong) NSMutableArray * imageUrlArr;

@property (nonatomic , strong) UIScrollView * routerView;
@property (nonatomic , strong) UIImageView * seletedImg;
@property (nonatomic , strong) NSArray * pathArr;

@property (nonatomic , strong) GZMShareView * gView;

@property (nonatomic,strong)UIButton *spButton;//悬浮按钮

@property (nonatomic,strong) UICollectionViewFlowLayout * flowLayout;
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic , strong) UIView * dView;
@property (nonatomic , strong) NSMutableArray * recomeList;
@end

@implementation NewEbayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isYuanwen = YES;
    isAction = YES;
    isbanner = NO;
    [self createUI];
    [self.view addSubview:self.spButton];
    [self requestGoodsDetail];
}
- (void)createUI{
    _scrollView = [UIScrollView new];
    _scrollView.delegate=self;
    _scrollView.showsVerticalScrollIndicator = FALSE;//垂直滚动条
    _scrollView.showsHorizontalScrollIndicator = FALSE;//水平滚动条
    
    [self.view addSubview:_scrollView];
    _scrollView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }//解决导航栏设置透明的情况下 scrollView发生偏移的问题：
    
    [self.scrollView addSubview:self.cycleScrollView];
    [self.scrollView addSubview:self.topView];
    [self.scrollView addSubview:self.twoView];
    [self.scrollView addSubview:self.threeView];
    [self.scrollView addSubview:self.fourView];
    [self.scrollView addSubview:self.wkWebView];
    [self.scrollView addSubview:self.collectionView];
    self.collectionView.hidden = YES;
//    [self.scrollView addSubview:self.dView];
    //
    //    /*将ui添加到scrollView数组中*/
//    [self.scrollView sd_addSubviews:@[self.cycleScrollView,self.topView,self.twoView,self.threeView,self.fourView,self.wkWebView]];
    
    // scrollview自动contentsize
    [self.scrollView setupAutoContentSizeWithBottomView:self.wkWebView bottomMargin:bottomH];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.LeftBtn];
    [self.view addSubview:self.RightBtn];
    [self.view addSubview:self.shareBtn];
    [self.view addSubview:self.bottomView];
}
- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-[Unity countcoordinatesW:5])/2, [Unity countcoordinatesH:250]);
        _flowLayout.minimumLineSpacing = [Unity countcoordinatesW:2.5];
        _flowLayout.minimumInteritemSpacing = [Unity countcoordinatesW:2.5];
    }
    return _flowLayout;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.wkWebView.bottom, SCREEN_WIDTH, [Unity countcoordinatesW:538]) collectionViewLayout:self.flowLayout];
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[RecomeCell class] forCellWithReuseIdentifier:CellIdentifier];
        _collectionView.backgroundColor = [Unity getColor:@"#e0e0e0"];
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:[RecomHeaderView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"CollectionViewHeaderView"];
    }
    return _collectionView;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.recomeList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RecomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //美国时间转换成中国时间
//    NSLog(@"%@",self.recomeList[indexPath.row][@"endTime"]);
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    format.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"]; //将时间字符串当utc处理，打印时根据本地时区自动打印 +8
    NSDate *utcDate = [format dateFromString:self.recomeList[indexPath.row][@"endTime"]];  // Summary 2017-10-25 02:07:39 UTC
    //        NSLog(@"utc = %@",utcDate);
    NSString * ssss = [self getLocalDateFormateUTCDate:[format stringFromDate:utcDate]];
//    NSLog(@"ssss=%@",ssss);
    
    cell.time = [Unity timeSwitchTimestamp:ssss andFormatter:@"YYYY-MM-dd hh:mm:ss" andForTimeZone:@"Asia/Beijing"];
    NSNumber * price = [NSNumber numberWithInteger:[self.recomeList[indexPath.row][@"currentPrice"] integerValue]];
    [cell configCellWithImage:self.recomeList[indexPath.row][@"image"] WithTitle:self.recomeList[indexPath.row][@"title"] WithPrice:[price stringValue] WithBid:self.recomeList[indexPath.row][@"bidCount"] WithType:@"ebay"];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NewEbayDetailViewController * nvc = [[NewEbayDetailViewController alloc]init];
    nvc.item = self.recomeList[indexPath.row][@"id"];
    nvc.platform = @"5";
    [self.navigationController pushViewController:nvc animated:YES];
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        RecomHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                   withReuseIdentifier:@"CollectionViewHeaderView"
                                                                          forIndexPath:indexPath];
        //        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        //            view.backgroundColor = [Unity getColor:@"e0e0e0"];
        //
        //        }
        reusableView = view;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        // 底部视图
    }
    return reusableView;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_WIDTH, [Unity countcoordinatesH:35]);
}

- (UIView *)dView{
    if (!_dView) {
        _dView = [[UIView alloc]initWithFrame:CGRectMake(0, _collectionView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        _dView.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _dView;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight)];
        _navView.backgroundColor = [UIColor whiteColor];
        _navView.alpha = 0;
        
        [_navView addSubview:self.oldLeftBtn];
        [_navView addSubview:self.oldRightBtn];
        [_navView addSubview:self.oldShareBtn];
        [_navView addSubview:self.navIcon];
    }
    return _navView;
}
- (UIButton *)oldLeftBtn{
    if (!_oldLeftBtn) {
        _oldLeftBtn = [[UIButton alloc]initWithFrame:CGRectMake(12, NavBarHeight-44+7.5, 28.5, 28.5)];
        [_oldLeftBtn setBackgroundImage:[UIImage imageNamed:@"detailback"] forState:UIControlStateNormal];
        [_oldLeftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _oldLeftBtn;
}
- (UIButton *)LeftBtn{
    if (!_LeftBtn) {
        _LeftBtn = [[UIButton alloc]initWithFrame:CGRectMake(12, NavBarHeight-44+7.5, 28.5, 28.5)];
        [_LeftBtn setBackgroundImage:[UIImage imageNamed:@"good_back"] forState:UIControlStateNormal];
        [_LeftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _LeftBtn;
}
- (UIButton *)oldRightBtn{
    if (!_oldRightBtn) {
        _oldRightBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-12-28.5, NavBarHeight-44+7.5, 28.5, 28.5)];
        [_oldRightBtn setBackgroundImage:[UIImage imageNamed:@"detailR"] forState:UIControlStateNormal];
        [_oldRightBtn addTarget:self action:@selector(refreshClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _oldRightBtn;
}
- (UIButton *)RightBtn{
    if (!_RightBtn) {
        _RightBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-12-28.5, NavBarHeight-44+7.5, 28.5, 28.5)];
        [_RightBtn setBackgroundImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
        [_RightBtn addTarget:self action:@selector(refreshClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _RightBtn;
}
- (UIButton *)oldShareBtn{
    if (!_oldShareBtn) {
        _oldShareBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-24-57, NavBarHeight-44+7.5, 28.5, 28.5)];
        [_oldShareBtn setBackgroundImage:[UIImage imageNamed:@"detail__share"] forState:UIControlStateNormal];
        [_oldShareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _oldShareBtn;
}
- (UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-24-57, NavBarHeight-44+7.5, 28.5, 28.5)];
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"detail_share"] forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}
- (UIImageView *)navIcon{
    if (!_navIcon) {
        _navIcon = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-40)/2, NavBarHeight-44, 40, 40)];
        //        _navIcon.alpha = 0;
    }
    return _navIcon;
}
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-bottomH, SCREEN_WIDTH, bottomH)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        line.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [_bottomView addSubview:line];
        UIButton * consultBtn = [Unity buttonAddsuperview_superView:_bottomView _subViewFrame:CGRectMake([Unity countcoordinatesW:5], 0, [Unity countcoordinatesW:40], [Unity countcoordinatesH:50]) _tag:self _action:@selector(consultClick) _string:@"" _imageName:@""];
        UIImageView * imgView = [Unity imageviewAddsuperview_superView:consultBtn _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:20], [Unity countcoordinatesH:20]) _imageName:@"咨询" _backgroundColor:nil];
        imgView.userInteractionEnabled=YES;
        UILabel * consultL = [Unity lableViewAddsuperview_superView:consultBtn _subViewFrame:CGRectMake( 0, imgView.bottom, [Unity countcoordinatesW:40], [Unity countcoordinatesH:20]) _string:@"咨询" _lableFont:[UIFont systemFontOfSize:15] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentCenter];
        consultL.backgroundColor = [UIColor clearColor];
        
        UIButton * collectionBtn = [Unity buttonAddsuperview_superView:_bottomView _subViewFrame:CGRectMake(consultBtn.right+[Unity countcoordinatesW:10], consultBtn.top, consultBtn.width, consultBtn.height) _tag:self _action:@selector(collectionClick) _string:@"" _imageName:@""];
        _collectionImg = [Unity imageviewAddsuperview_superView:collectionBtn _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:20], [Unity countcoordinatesH:20]) _imageName:@"未收藏" _backgroundColor:nil];
        _collectionImg.userInteractionEnabled=NO;
        UILabel * collectionL = [Unity lableViewAddsuperview_superView:collectionBtn _subViewFrame:CGRectMake( 0, _collectionImg.bottom, [Unity countcoordinatesW:40], [Unity countcoordinatesH:20]) _string:@"收藏" _lableFont:[UIFont systemFontOfSize:15] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentCenter];
        collectionL.backgroundColor = [UIColor clearColor];
        
        UIButton * calculaBtn = [Unity buttonAddsuperview_superView:_bottomView _subViewFrame:CGRectMake(collectionBtn.right+[Unity countcoordinatesW:20], [Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:37]) _tag:self _action:@selector(calculaClick) _string:@"费用试算" _imageName:@"费用试算"];
        [calculaBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        UIButton * biddingBtn = [Unity buttonAddsuperview_superView:_bottomView _subViewFrame:CGRectMake(calculaBtn.right, calculaBtn.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:37]) _tag:self _action:@selector(biddingClick) _string:@"帮我代购" _imageName:@"我要竞标"];
    }
    return _bottomView;
}
- (SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, NavBarHeight-44, SCREEN_WIDTH, [Unity countcoordinatesH:300]- (NavBarHeight-44)-5) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _cycleScrollView.backgroundColor = [UIColor clearColor];
        _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
        _cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
        //        _cycleScrollView.imageURLStringsGroup = _imagesURLStrings;
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
    }
    return _cycleScrollView;
}
//topview
- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, _cycleScrollView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:220])];
        [_topView addSubview:self.mView];
        [_topView addSubview:self.timeL];
        [_topView addSubview:self.annotationL];
        [_topView addSubview:self.goodsTitle];
        [_topView addSubview:self.offerL];
        [_topView addSubview:self.currencyL];
        [_topView addSubview:self.currentOffer];
        [_topView addSubview:self.RMBL];
        
        for (int i=1; i<=2; i++) {
            UILabel * line = [Unity lableViewAddsuperview_superView:_topView _subViewFrame:CGRectMake(i*(SCREEN_WIDTH/3), self.RMBL.bottom+[Unity countcoordinatesH:15], 1, [Unity countcoordinatesH:15]) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentLeft];
            line.backgroundColor = [Unity getColor:@"#f0f0f0"];
        }
        
        [_topView addSubview:self.numberL];
        [_topView addSubview:self.winL];
        [_topView addSubview:self.taxL];
    }
    return _topView;
}
- (UIView *)mView{
    if (!_mView) {
        _mView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        _mView.backgroundColor = [Unity getColor:@"e5294c"];
        UILabel * label = [Unity lableViewAddsuperview_superView:_mView _subViewFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:15], [Unity countcoordinatesW:160], [Unity countcoordinatesH:20]) _string:@"剩余时间" _lableFont:[UIFont systemFontOfSize:FontSize(18)] _lableTxtColor:[UIColor whiteColor] _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
    }
    return _mView;
}
- (UILabel *)timeL{
    if (!_timeL) {
        _timeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:165], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:170], [Unity countcoordinatesH:30])];
        _timeL.text = @"";
        _timeL.textAlignment = NSTextAlignmentRight;
        _timeL.textColor = [UIColor whiteColor];
        _timeL.font = [UIFont systemFontOfSize:FontSize(30)];
    }
    return _timeL;
}
- (UILabel *)annotationL{
    if (!_annotationL) {
        _annotationL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _mView.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:10], [Unity countcoordinatesH:20])];
        _annotationL.text = @"提醒：倒计时可能存在误差，请及时刷新提前出价";
        _annotationL.textColor = LabelColor9;
        _annotationL.font = [UIFont systemFontOfSize:FontSize(12)];
        _annotationL.textAlignment = NSTextAlignmentLeft;
    }
    return _annotationL;
}
- (UILabel *)goodsTitle{
    if (!_goodsTitle) {
        _goodsTitle = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _annotationL.bottom+[Unity countcoordinatesH:12], SCREEN_WIDTH-[Unity countcoordinatesW:10], [Unity countcoordinatesH:40])];
        _goodsTitle.text = @"";
        _goodsTitle.textColor = LabelColor3;
        _goodsTitle.font = [UIFont systemFontOfSize:FontSize(16)];
        _goodsTitle.numberOfLines = 0;//表示label可以多行显示
    }
    return _goodsTitle;
}
- (UILabel *)offerL{
    if (!_offerL) {
        _offerL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _goodsTitle.bottom+[Unity countcoordinatesH:25], [Unity widthOfString:@"目前价格:" OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:20]], [Unity countcoordinatesH:20])];
        _offerL.text= @"目前价格:";
        _offerL.textColor = LabelColor6;
        _offerL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _offerL;
}
- (UILabel *)currencyL{
    if (!_currencyL) {
        _currencyL = [[UILabel alloc]initWithFrame:CGRectMake(_offerL.right, _goodsTitle.bottom+[Unity countcoordinatesH:25], [Unity widthOfString:@"日币" OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:20]], [Unity countcoordinatesH:20])];
        _currencyL.text= @"";
        _currencyL.textColor = [Unity getColor:@"#aa112d"];
        _currencyL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _currencyL;
}
- (UILabel *)currentOffer{
    if (!_currentOffer) {
        _currentOffer = [[UILabel alloc]initWithFrame:CGRectMake(_currencyL.right, _goodsTitle.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:200], [Unity countcoordinatesH:30])];
        _currentOffer.text = @"";
        _currentOffer.font = [UIFont systemFontOfSize:FontSize(34)];
        _currentOffer.textColor = [Unity getColor:@"#aa112d"];
    }
    return  _currentOffer;
}
- (UILabel *)RMBL{
    if (!_RMBL) {
        _RMBL = [[UILabel  alloc]initWithFrame:CGRectMake(_currencyL.left, _currencyL.bottom, [Unity countcoordinatesW:200], [Unity countcoordinatesH:15])];
        _RMBL.text = @"";
        _RMBL.textColor = LabelColor6;
        _RMBL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _RMBL;
}
- (UILabel *)numberL{
    if (!_numberL) {
        _numberL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], self.RMBL.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH/3-[Unity countcoordinatesW:5], [Unity countcoordinatesH:15])];
        _numberL.text = @"";
        _numberL.textColor = LabelColor3;
        _numberL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _numberL;
}
- (UILabel *)winL{
    if (!_winL) {
        _winL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, self.RMBL.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH/3, [Unity countcoordinatesH:15])];
        _winL.text = @"";
        
        _winL.textColor = LabelColor3;
        _winL.textAlignment = NSTextAlignmentCenter;
        _winL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _winL;
}
- (UILabel *)taxL{
    if (!_taxL) {
        _taxL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, self.RMBL.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH/3-[Unity countcoordinatesW:5], [Unity countcoordinatesH:15])];
        _taxL.text = @"附加税0%";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_taxL.text];
        [str addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0,3)];
        _taxL.textColor = LabelColor3;
        _taxL.attributedText = str;
        _taxL.textAlignment = NSTextAlignmentRight;
        _taxL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _taxL;
}
//twoView
- (UIView *)twoView{
    if (!_twoView) {
        _twoView = [[UIView alloc]initWithFrame:CGRectMake(0, _topView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:95])];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        label.backgroundColor = [Unity getColor:@"f0f0f0"];
        [_twoView addSubview:label];
        UILabel * amountL = [Unity lableViewAddsuperview_superView:_twoView _subViewFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:20], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15]) _string:@"最小价格单位:" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentLeft];
        self.amount = [Unity lableViewAddsuperview_superView:_twoView _subViewFrame:CGRectMake(amountL.right, amountL.top, [Unity countcoordinatesW:200], [Unity countcoordinatesH:15]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        
        UILabel * stopTimeL = [Unity lableViewAddsuperview_superView:_twoView _subViewFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:45], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15]) _string:@"截止时间:" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentLeft];
        self.stopTime = [Unity lableViewAddsuperview_superView:_twoView _subViewFrame:CGRectMake(stopTimeL.right, stopTimeL.top, [Unity countcoordinatesW:200], [Unity countcoordinatesH:15]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        [_twoView addSubview:self.routerView];
    }
    return _twoView;
}
- (UIScrollView *)routerView{
    if (!_routerView) {
        _routerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:70], SCREEN_WIDTH, [Unity countcoordinatesH:15])];
        _routerView.scrollEnabled = YES;
        _routerView.userInteractionEnabled = YES;
        // 没有弹簧效果
        //        _topScrollView.bounces = NO;
        // 隐藏水平滚动条
        _routerView.showsHorizontalScrollIndicator = NO;
    }
    return _routerView;
}
//threeview
- (UIView *)threeView{
    if (!_threeView) {
        _threeView = [[UIView alloc]initWithFrame:CGRectMake(0, _twoView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:146])];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        label.backgroundColor = [Unity getColor:@"f0f0f0"];
        [_threeView addSubview:label];
        [_threeView addSubview:self.parameterBtn];
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, self.parameterBtn.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        label1.backgroundColor = [Unity getColor:@"f0f0f0"];
        [_threeView addSubview:label1];
        [_threeView addSubview:self.nameL];
        [_threeView addSubview:self.sellerBtn];
        [_threeView addSubview:self.evaluate];
        [_threeView addSubview:self.originalPageBtn];
        [_threeView addSubview:self.allGoodsBtn];
        [_threeView addSubview:self.threeLine];
    }
    return _threeView;
}
- (UIButton *)parameterBtn{
    if (!_parameterBtn) {
        _parameterBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        [_parameterBtn addTarget:self action:@selector(parClick) forControlEvents:UIControlEventTouchUpInside];
        UILabel * parameterL = [Unity lableViewAddsuperview_superView:_parameterBtn _subViewFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20]) _string:@"牌品参数:" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentLeft];
        UILabel * label = [Unity lableViewAddsuperview_superView:_parameterBtn _subViewFrame:CGRectMake(parameterL.right, [Unity countcoordinatesH:15], [Unity countcoordinatesW:200], [Unity countcoordinatesH:20]) _string:@"商品情况 商品ID..." _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
    }
    return _parameterBtn;
}
- (ProductParametersView *)pView{
    if (!_pView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _pView = [ProductParametersView setProductParametersView:window];
    }
    return _pView;
}
- (UILabel *)nameL{
    if (!_nameL) {
        _nameL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:80], [Unity countcoordinatesW:80], [Unity countcoordinatesH:18])];
        _nameL.text = @"";
        _nameL.textColor = LabelColor3;
        _nameL.textAlignment = NSTextAlignmentLeft;
        _nameL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _nameL;
}
- (UIButton *)sellerBtn{
    if (!_sellerBtn) {
        _sellerBtn = [[UIButton alloc]initWithFrame:CGRectMake(_nameL.right+[Unity countcoordinatesW:10], _nameL.top+[Unity countcoordinatesH:1.5], [Unity countcoordinatesW:50], [Unity countcoordinatesH:15])];
        [_sellerBtn addTarget:self action:@selector(sellerCollectionClick) forControlEvents:UIControlEventTouchUpInside];
        _sellerBtn.backgroundColor = LabelColor9;
        [_sellerBtn setTitle:@"关注卖家" forState:UIControlStateNormal];
        [_sellerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sellerBtn.layer.cornerRadius = _sellerBtn.height/2;
        _sellerBtn.layer.masksToBounds = YES;
        _sellerBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(12)];
        //卖家已关注 背景颜色AA112D
    }
    return _sellerBtn;
}
- (UILabel *)evaluate{
    if (!_evaluate) {
        _evaluate = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesH:10], _nameL.bottom+[Unity countcoordinatesH:10],[Unity countcoordinatesW:140], [Unity countcoordinatesH:18])];
        _evaluate.text = @"";
        _evaluate.font = [UIFont systemFontOfSize:FontSize(12)];
        _evaluate.textColor = LabelColor6;
        
    }
    return _evaluate;
}

- (UIButton *)originalPageBtn{
    if (!_originalPageBtn) {
        _originalPageBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:150], [Unity countcoordinatesH:79.5], [Unity countcoordinatesW:70], [Unity countcoordinatesH:27])];
        [_originalPageBtn setTitle:@"原始页面" forState:UIControlStateNormal];
        _originalPageBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(12)];
        [_originalPageBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        _originalPageBtn.layer.cornerRadius = _originalPageBtn.height/2;
        //设置边框颜色
        _originalPageBtn.layer.borderColor = [[Unity getColor:@"#aa112d"] CGColor];
        //设置边框宽度
        _originalPageBtn.layer.borderWidth = 1.0f;
        [_originalPageBtn addTarget:self action:@selector(originalClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _originalPageBtn;
}
- (UIButton *)allGoodsBtn{
    if (!_allGoodsBtn) {
        _allGoodsBtn = [[UIButton alloc]initWithFrame:CGRectMake(_originalPageBtn.right+[Unity countcoordinatesW:5], [Unity countcoordinatesH:79.5], [Unity countcoordinatesW:70], [Unity countcoordinatesH:27])];
        [_allGoodsBtn setTitle:@"全部商品" forState:UIControlStateNormal];
        _allGoodsBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(12)];
        [_allGoodsBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        _allGoodsBtn.layer.cornerRadius = _allGoodsBtn.height/2;
        //设置边框颜色
        _allGoodsBtn.layer.borderColor = [[Unity getColor:@"#aa112d"] CGColor];
        //设置边框宽度
        _allGoodsBtn.layer.borderWidth = 1.0f;
        [_allGoodsBtn addTarget:self action:@selector(allGoodsClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allGoodsBtn;
}
- (UILabel *)threeLine{
    if (!_threeLine) {
        _threeLine = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:136], SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        _threeLine.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return  _threeLine;
}

//fourview
- (UIView *)fourView{
    if (!_fourView) {
        _fourView = [[UIView alloc]initWithFrame:CGRectMake(0, _threeView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        [_fourView addSubview:self.yuanwen];
        [_fourView addSubview:self.fanyi];
        [_fourView addSubview:self.foutLine];
    }
    return _fourView;
}
- (UIButton *)yuanwen{
    if (!_yuanwen) {
        _yuanwen = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, [Unity countcoordinatesH:50])];
        [_yuanwen setTitle:@"原文介绍" forState:UIControlStateNormal];
        [_yuanwen setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
        [_yuanwen setTitleColor:LabelColor9 forState:UIControlStateSelected];
        _yuanwen.titleLabel.font = [UIFont systemFontOfSize:FontSize(15)];
        [_yuanwen addTarget:self action:@selector(originaClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _yuanwen;
}
- (UIButton *)fanyi{
    if (!_fanyi) {
        _fanyi = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, [Unity countcoordinatesH:50])];
        [_fanyi setTitle:@"翻译介绍" forState:UIControlStateNormal];
        [_fanyi setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
        [_fanyi setTitleColor:LabelColor9 forState:UIControlStateSelected];
        _fanyi.titleLabel.font = [UIFont systemFontOfSize:FontSize(15)];
        [_fanyi addTarget:self action:@selector(fanyiClick) forControlEvents:UIControlEventTouchUpInside];
        _fanyi.selected = YES;
    }
    return _fanyi;
}
- (UILabel *)foutLine{
    if (!_foutLine) {
        _foutLine = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:50]-3, SCREEN_WIDTH/2, 3)];
        _foutLine.backgroundColor = [Unity getColor:@"aa112d"];
    }
    return _foutLine;
}
//webview

-(WKWebView *)wkWebView{
    if (!_wkWebView) {
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        wkWebConfig.userContentController = wkUController;
        wkWebConfig.userContentController = wkUController;
        wkWebConfig.userContentController = wkUController;
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, _fourView.bottom, SCREEN_WIDTH, 1) configuration:wkWebConfig];
        _wkWebView.navigationDelegate = self;
        _wkWebView.scrollView.delegate = self;
        _wkWebView.scrollView.bounces = false;//禁止滑动
//        _wkWebView.userInteractionEnabled = NO;
        _wkWebView.UIDelegate = self;
        
        WKPreferences *preferences = [WKPreferences new];
        wkWebConfig.preferences = preferences;
        wkWebConfig.preferences.javaScriptEnabled = NO;
        wkWebConfig.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        //        self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
        //        self.progressView.progressTintColor = [UIColor greenColor];
        //        [self.contentView addSubview:self.progressView];
        
        // 给webview添加监听
        //        [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
        [self.wkWebView.scrollView addObserver:self forKeyPath:@"contentSize"
                                       options:NSKeyValueObservingOptionNew context:nil];
    }
    return _wkWebView;
}
#pragma mark  - KVO回调
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    //更具内容的高重置webView视图的高度
    //    if (newHeight < 10) {
    //        NSLog(@"Height is changed! new=%@", [change valueForKey:NSKeyValueChangeNewKey]);
    //        NSLog(@"tianxia :%@",NSStringFromCGSize(self.wkWebView.scrollView.contentSize));
    newHeight = self.wkWebView.scrollView.contentSize.height;
    self.wkWebView.frame = CGRectMake(0, self.fourView.bottom, SCREEN_WIDTH, newHeight);
    //     scrollview自动contentsize
//    self.collectionView.frame = CGRectMake(0, self.wkWebView.bottom, SCREEN_WIDTH, [Unity countcoordinatesW:538]);
//    self.dView.frame = CGRectMake(0, self.collectionView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:10]);
//    [self.scrollView setupAutoContentSizeWithBottomView:self.dView bottomMargin:bottomH];
    if (self.collectionView.hidden == YES) {
        [self.scrollView setupAutoContentSizeWithBottomView:self.wkWebView bottomMargin:bottomH];
    }else{
        self.collectionView.frame = CGRectMake(0, self.wkWebView.bottom, SCREEN_WIDTH, [Unity countcoordinatesW:548]);
        [self.scrollView setupAutoContentSizeWithBottomView:self.collectionView bottomMargin:bottomH];
    }
    //    }
    
}
#pragma mark -- scrollViewDelegate --

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.scrollView) {
        CGFloat maxAlphaOffset = [Unity countcoordinatesH:200];
        CGFloat alpha = scrollView.contentOffset.y/maxAlphaOffset;
        if (alpha<=0) {
            alpha = 0;
        }
        if (alpha>=1) {
            alpha = 1;
        }
        self.navView.alpha = alpha;
        self.LeftBtn.alpha = 1-alpha;
        self.RightBtn.alpha = 1-alpha;
    }
    
    
    if (scrollView == self.wkWebView.scrollView) {
        // 让webview的内容一直居左显示
        scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
    }
}

#pragma mark -- 导航栏上左右按钮事件
- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)refreshClick{
    [self requestGoodsDetail];
}
- (void)shareClick{
    [self.gView showShareView];
}



- (void)requestGoodsDetail{
    [Unity showanimate];
    NSDictionary *params = @{@"platform":@"5",@"item":self.item,@"os":@"1"};
//    [WHToast showMessage:self.item originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    NSLog(@"详情参数  %@",params);
    [GZMrequest getWithURLString:[GZMUrl get_goodsDetail_url] parameters:params success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        NSLog(@"-------%@",data);
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            buystate = [data[@"data"][@"buystate"] intValue];
            buystate_msg = data[@"data"][@"buystate_msg"];
            [self loadView:data[@"data"]];
            [self loadRouterView:data[@"patharr"]];
            [self requestIsCollection];
            [self uploadFootprint:data];
            [self requestRecomeList:data[@"data"][@"goods"][@"Item"][@"PrimaryCategoryID"]];
        }else{
            [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)loadRouterView:(NSArray *)arr{
    self.pathArr = arr;
    self.seletedImg.frame = CGRectMake(0, 0, 0, 0);
    for (int i=0; i<arr.count; i++) {
        NSArray * array = [arr[i] allKeys];
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(self.seletedImg.right+[Unity countcoordinatesW:10], 0, [Unity widthOfString:arr[i][array[0]] OfFontSize:FontSize(12) OfHeight:[Unity countcoordinatesH:15]], [Unity countcoordinatesH:15])];
        btn.tag = 9000+i;
        [btn addTarget:self action:@selector(pathBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:arr[i][array[0]] forState:UIControlStateNormal];
        [btn setTitleColor:LabelColor9 forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:FontSize(12)];
        [self.routerView addSubview:btn];
        if (i != (arr.count -1)) {
            UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(btn.right+[Unity countcoordinatesW:8], [Unity countcoordinatesH:2.5], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10])];
            img.image = [UIImage imageNamed:@"go"];
            [self.routerView addSubview:img];
            
            self.seletedImg = img;
        }
        if (i==(arr.count -1)) {
            [btn setTitleColor:LabelColor3 forState:UIControlStateNormal];
            self.routerView.contentSize =  CGSizeMake(btn.right+[Unity countcoordinatesW:10], 0);
        }
    }
}
- (void)pathBtn:(UIButton *)sender{
    NSLog(@"%@",self.pathArr[sender.tag- 9000]);
    NSString * classId = [self.pathArr[sender.tag- 9000] allKeys][0];
    NSString * className = self.pathArr[sender.tag- 9000][classId];
    NSLog(@"id = %@ name = %@",classId,className);
    EbayGoodsListViewController * gvc = [[EbayGoodsListViewController alloc]init];
    gvc.pageIndex =0;
    gvc.isSearch = NO;
    gvc.platform = @"5";
    gvc.classId = classId;
    gvc.className = className;
    [self.navigationController pushViewController:gvc animated:YES];
}
- (void)loadView:(NSDictionary *)dict{
    //ebay有可能会出现异常
    NSArray * allkeys = [dict[@"goods"] allKeys];
    int count=0;
    for (int i=0; i<allkeys.count; i++) {
        if ([allkeys[i]isEqualToString:@"Item"]) {
            count = count+1;
        }
    }
    if (count ==0) {
        [WHToast showMessage:@"数据异常，请咨询客服" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:3 finishHandler:^{}];
        isAction = NO;
        return;
    }
    
    self.dataDic = dict;
    if ([dict[@"goods"][@"Item"][@"PictureURL"] isKindOfClass:[NSString class]]) {
        [self.imagesURLStrings addObject:dict[@"goods"][@"Item"][@"PictureURL"]];
    }else{
        self.imagesURLStrings = [dict[@"goods"][@"Item"][@"PictureURL"] mutableCopy];
    }
    self.cycleScrollView.imageURLStringsGroup = self.imagesURLStrings;
    [self.navIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.imagesURLStrings[0]]]];
    NSString * time = dict[@"goods"][@"Item"][@"EndTime"];
    NSArray *array = [time componentsSeparatedByString:@"."];
    NSArray * array1 = [array[0] componentsSeparatedByString:@"T"];
    NSArray * array2 = [array1[0] componentsSeparatedByString:@"-"];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *timeStr = [NSString stringWithFormat:@"%@ %@",array1[0],array1[1]]; //将时间字符串默认当本地时区处理，转成NSDate时 -8，打印时再 +8
    format.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"]; //将时间字符串当utc处理，打印时根据本地时区自动打印 +8
    NSDate *utcDate = [format dateFromString:timeStr];  // Summary 2017-10-25 02:07:39 UTC
    NSString * ssss = [self getLocalDateFormateUTCDate:[format stringFromDate:utcDate]];
    NSArray * array10 = [ssss componentsSeparatedByString:@"-"];
    endTime = [NSString stringWithFormat:@"%@/%@/%@",array10[0],array10[1],array10[2]];
    bjTime = [NSString stringWithFormat:@"%@-%@-%@",array10[0],array10[1],array10[2]];
    //倒计时
    [self countdownWithCurrentDate:endTime];
    
    self.currencyL.text = @"美金";
    self.goodsTitle.text = dict[@"goods"][@"Item"][@"Title"];
    self.currentOffer.text = [NSString stringWithFormat:@"%@元",dict[@"goods"][@"Item"][@"CurrentPrice"]];
    self.RMBL.text = [NSString stringWithFormat:@"约人民币:%@元",[Unity configWithCurrentCurrency:@"us" WithTargetCurrency:@"cn" WithAmount:dict[@"goods"][@"Item"][@"CurrentPrice"]]];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"参与人数 0"];
    [str addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0,4)];
    self.numberL.attributedText = str;
    
    NSDictionary *zidian =dict[@"goods"][@"Result"][@"HighestBidders"];
    if([[zidian allKeys] containsObject:@"Bidder"]){
        //        NSLog(@"有");
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"当前买家 %@",dict[@"goods"][@"Result"][@"HighestBidders"][@"Bidder"][@"Id"]]];
        [str1 addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0,5)];
        _winL.attributedText = str1;
    }else{
        //        NSLog(@"没有 ");
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"当前买家 无"];
        [str1 addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0,5)];
        _winL.attributedText = str1;
    }
    
    self.stopTime.text = [NSString stringWithFormat:@"%@（中国）",endTime];
    self.amount.text = [NSString stringWithFormat:@"%@美元",[Unity getSmallestUnitOfBid:dict[@"goods"][@"Item"][@"CurrentPrice"]]];
    
    self.nameL.text = dict[@"goods"][@"Item"][@"Seller"][@"UserID"];
    NSInteger W=0;
    if ([Unity widthOfString:self.nameL.text OfFontSize:FontSize(12) OfHeight:[Unity countcoordinatesH:18]]>[Unity countcoordinatesW:90]) {
        W=[Unity countcoordinatesW:90];
    }else{
        W=[Unity widthOfString:self.nameL.text OfFontSize:FontSize(12) OfHeight:[Unity countcoordinatesH:18]];
    }
    self.nameL.frame = CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:80], W, [Unity countcoordinatesH:18]);
    self.sellerBtn.frame = CGRectMake(self.nameL.right+[Unity countcoordinatesW:10], self.nameL.top+[Unity countcoordinatesH:1.5], [Unity countcoordinatesW:50], [Unity countcoordinatesH:15]);
    NSString * str1 = @"%";
    NSMutableAttributedString *str00 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"全部评价  %@(%@%@)",dict[@"goods"][@"Item"][@"Seller"][@"FeedbackScore"],dict[@"goods"][@"Item"][@"Seller"][@"PositiveFeedbackPercent"],str1]];
    [str00 addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0,4)];
    self.evaluate.attributedText = str00;
    NSString * htmlStr;
    if (isYuanwen) {
        htmlStr = [NSString stringWithFormat:@"<!DOCTYPE html> \n"
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
                   "</html>",dict[@"goods"][@"Item"][@"Description"]];
    }else{
        htmlStr = [NSString stringWithFormat:@"<!DOCTYPE html> \n"
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
                   "</html>",dict[@"goods"][@"Item"][@"Description"]];
    }
    [self.wkWebView loadHTMLString:htmlStr baseURL:nil];
}
- (NSString *)getLocalDateFormateUTCDate:(NSString *)utcStr {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    format.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSDate *utcDate = [format dateFromString:utcStr];
    format.timeZone = [NSTimeZone localTimeZone];
    NSString *dateString = [format stringFromDate:utcDate];
    return dateString;
}
- (NSDictionary * )dataDic{
    if (!_dataDic) {
        _dataDic = [NSDictionary new];
    }
    return _dataDic;
}
- (NSMutableArray *)imagesURLStrings{
    if (!_imagesURLStrings) {
        _imagesURLStrings = [NSMutableArray new];
    }
    return _imagesURLStrings;
}
- (void)requestIsCollection{
    if (userInfo == nil){
        return;
    }
    NSDictionary * dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"area":@"1",@"item":self.dataDic[@"goods"][@"Item"][@"ItemID"],@"saler":self.dataDic[@"goods"][@"Item"][@"Seller"][@"UserID"]};
//    NSLog(@"请求参数1 %@",dic);
    [GZMrequest getWithURLString:[GZMUrl get_isCollection_url] parameters:dic success:^(NSDictionary *data) {
//        NSLog(@"%@",data);
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            goodsStr = [NSString stringWithFormat:@"%@",data[@"data"][@"goods"]];
            if (![goodsStr isEqualToString:@"0"]) {//商品未收藏
                self.collectionImg.image = [UIImage imageNamed:@"已收藏"];
                goodsStr = data[@"data"][@"goods"];
            }
            salerStr = [NSString stringWithFormat:@"%@",data[@"data"][@"saler"]];
            if (![salerStr isEqualToString:@"0"]) {//
                self.sellerBtn.backgroundColor = [Unity getColor:@"aa112d"];
                salerStr = data[@"data"][@"saler"];
                
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
}
- (void)countdownWithCurrentDate:(NSString *)currentDate{
    // 当前时间的时间戳
    NSString *nowStr = [Unity getCurrentTimeyyyymmdd];
    // 计算时间差值
    NSInteger secondsCountDown = [Unity getDateDifferenceWithNowDateStr:nowStr deadlineStr:currentDate];
    [self daojishi:secondsCountDown];
}
- (void)daojishi:(NSInteger)ss{
    __weak __typeof(self) weakSelf = self;
    
    if (_timer == nil) {
        __block NSInteger timeout = ss; // 倒计时时间
        
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC,  0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                //                NSLog(@"%ld",(long)timeout);
                if(timeout <= 0){ //  当倒计时结束时做需要的操作: 关闭 活动到期不能提交
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //倒计时结束
                        //                        NSLog(@"++++++++++++");
                        self.timeL.text = @"已结束";
                    });
                } else { // 倒计时重新计算 时/分/秒
                    NSInteger days = (int)(timeout/(3600*24));
                    NSInteger hours = (int)((timeout-days*24*3600)/3600);
                    NSInteger minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    NSInteger second = timeout - days*24*3600 - hours*3600 - minute*60;
                    NSString *strTime;
                    strTime = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hours+days*24, minute, second];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.timeL.text = strTime;
                    });
                    timeout--; // 递减 倒计时-1(总时间以秒来计算)
                }
            });
            dispatch_resume(_timer);
        }
    }
}
- (void)parClick{
    if (!isAction) {
        return;
    }
    NSLog(@"GoodsDetailCell事件（拍品参数）");
    self.pView.freight.text = @"美国国内运费:";
    self.pView.remark.text = @"本网站为第三方资讯服务平台，本商品信息均来自美国ebay!";
    self.pView.inStockL.text = [NSString stringWithFormat:@"%@单位（个，片，台...）",self.dataDic[@"goods"][@"Item"][@"Quantity"]];
    for (int i=0; i<[self.dataDic[@"goods"][@"Item"][@"ItemSpecifics"][@"NameValueList"] count]; i++) {
        if ([[self.dataDic[@"goods"][@"Item"][@"ItemSpecifics"][@"NameValueList"][i] objectForKey:@"Name"] isEqualToString:@"All returns accepted"]) {
            if ([[self.dataDic[@"goods"][@"Item"][@"ItemSpecifics"][@"NameValueList"][i] objectForKey:@"Value"] isEqualToString:@"Returns Accepted"]) {
                self.pView.returnGoodsL.text = @"可以退货";
            }else{
                self.pView.returnGoodsL.text = @"不能退货";
            }
        }
    }
    self.pView.goodsDetailL.text = @"其他";
    self.pView.bidIdL.text = self.dataDic[@"goods"][@"Item"][@"ItemID"];
    [self.pView showPPView];
}
#pragma mark - footerView 事件(咨询，收藏，费用试算，我要竞标)
- (void)consultClick{
    //    NSLog(@"footerView 事件（咨询）");
//    ActivityWebViewController *webService = [[ActivityWebViewController alloc]init];
//    // 获得当前iPhone使用的语言
//    NSString* currentLanguage = NSLocalizedString(@"GlobalBuyer_Nativelanguage", nil);
//    NSLog(@"当前使用的语言：%@",currentLanguage);
//    if ([currentLanguage isEqualToString:@"zh-Hans-US"]) {
//        webService.href = @"http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html";
//    }else if([currentLanguage isEqualToString:@"zh-Hant"]){
//        webService.href = @"http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html";
//    }else if([currentLanguage isEqualToString:@"en"]){
//        webService.href = @"http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html";
//    }else{
//        webService.href = @"http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html";
//    }
//    webService.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:webService animated:YES];
    ServiceViewController * svc = [[ServiceViewController alloc]init];
    svc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:svc animated:YES];
}
- (void)collectionClick{
    if (!isAction) {
        return;
    }
    if (userInfo == nil) {
        LoginViewController * lvc = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:lvc animated:YES];
        
        return;
    }
    if (goodsStr != nil && ![goodsStr isEqualToString:@"0"]) {
        //删除收藏
        NSDictionary * dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"type":@"goods",@"ids":goodsStr};
        [Unity showanimate];
        [GZMrequest postWithURLString:[GZMUrl get_deleteCollection_url] parameters:dic success:^(NSDictionary *data) {
            [Unity hiddenanimate];
            if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
                self.collectionImg.image = [UIImage imageNamed:@"未收藏"];
                [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
                goodsStr = @"0";
            }else{
                [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            }
        } failure:^(NSError *error) {
            [Unity hiddenanimate];
            [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }];
    }else{
        NSString * img = @"";
        if ([self.dataDic[@"goods"][@"Item"][@"PictureURL"] isKindOfClass:[NSString class]]) {
            img =self.dataDic[@"goods"][@"Item"][@"PictureURL"];
        }else{
            img = self.dataDic[@"goods"][@"Item"][@"PictureURL"][0];
        }
        NSDictionary * dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"area":@"1",@"type":@"goods",@"w_object":self.dataDic[@"goods"][@"Item"][@"Title"],@"w_link":self.dataDic[@"goods"][@"Item"][@"ViewItemURLForNaturalSearch"],@"w_overtime":bjTime,@"w_jpnid":self.dataDic[@"goods"][@"Item"][@"ItemID"],@"w_imgsrc":img,@"w_saler":self.dataDic[@"goods"][@"Item"][@"Seller"][@"UserID"],@"w_tag":@""};
        [Unity showanimate];
        [GZMrequest postWithURLString:[GZMUrl get_collection_url] parameters:dic success:^(NSDictionary *data) {
            [Unity hiddenanimate];
            if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
                [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
                self.collectionImg.image = [UIImage imageNamed:@"已收藏"];
                goodsStr = [NSString stringWithFormat:@"%@",data[@"data"]];
            }else{
                [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            }
        } failure:^(NSError *error) {
            [Unity hiddenanimate];
            [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }];
    }
}
- (void)calculaClick{
    if (!isAction) {
        return;
    }
    UsTrialViewController * tvc = [[UsTrialViewController alloc]init];
    tvc.platform = self.platform;
    tvc.price = self.dataDic[@"goods"][@"Item"][@"CurrentPrice"];
    tvc.goodsTitle = self.dataDic[@"goods"][@"Item"][@"Title"];
    tvc.imageUrl = self.imagesURLStrings[0];
    tvc.endTime = endTime;
    tvc.increment = [Unity getSmallestUnitOfBid:self.dataDic[@"goods"][@"Item"][@"CurrentPrice"] WithCount:self.dataDic[@"goods"][@"Item"][@"BidCount"]];
    tvc.goodsID = self.dataDic[@"goods"][@"Item"][@"ItemID"];
    tvc.bidorbuy = @"";
    tvc.isDetail = YES;
    tvc.link = self.dataDic[@"goods"][@"Item"][@"ViewItemURLForNaturalSearch"];
    tvc.buystatus = buystate;
    tvc.buy_msg = buystate_msg;
    [self.navigationController pushViewController:tvc animated:YES];
}
- (void)biddingClick{
    if (userInfo == nil) {
        LoginViewController * lvc = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:lvc animated:YES];
        
        return;
    }
    if (!isAction) {
        return;
    }
    if (buystate != 1) {
        [WHToast showMessage:buystate_msg originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
        return;
    }
    EntrustViewController * evc = [[EntrustViewController alloc]init];
    evc.platform = self.platform;
    evc.price = self.dataDic[@"goods"][@"Item"][@"CurrentPrice"];
    evc.goodsTitle = self.dataDic[@"goods"][@"Item"][@"Title"];
    evc.imageUrl = self.imagesURLStrings[0];
    evc.endTime = endTime;
    evc.increment = [Unity getSmallestUnitOfBid:self.dataDic[@"goods"][@"Item"][@"CurrentPrice"] WithCount:self.dataDic[@"goods"][@"Item"][@"BidCount"]];
    evc.goodId = self.dataDic[@"goods"][@"Item"][@"ItemID"];
    evc.bidorbuy = @"";
    [self.navigationController pushViewController:evc animated:YES];
}
#pragma mark - SellerCell事件（原始页面 全部商品）
- (void)originalClick{
    if (!isAction) {
        return;
    }
    WebViewController * wvc = [[WebViewController alloc]init];
    wvc.webUrl =[NSString stringWithFormat:@"%@/index/order_bid/getyahoo?url=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"new_sdxurl"],self.dataDic[@"goods"][@"Item"][@"ViewItemURLForNaturalSearch"]];
    [self.navigationController pushViewController:wvc animated:YES];
}
- (void)allGoodsClick{
    if (!isAction) {
        return;
    }
    EbayGoodsListViewController * gvc = [[EbayGoodsListViewController alloc]init];
    gvc.hidesBottomBarWhenPushed = YES;
    gvc.pageIndex =2;
    gvc.isSearch = NO;
    gvc.platform = self.platform;
    gvc.sellerId = self.dataDic[@"goods"][@"Item"][@"Seller"][@"UserID"];
    [self.navigationController pushViewController:gvc animated:YES];
}
- (void)sellerCollectionClick{
    if (!isAction) {
        return;
    }
    if (userInfo == nil) {
        LoginViewController * lvc = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:lvc animated:YES];
        
        return;
    }
    if (salerStr != nil && ![salerStr isEqualToString:@"0"]) {
        //删除收藏
        NSDictionary * dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"type":@"saler",@"ids":goodsStr};
        [Unity showanimate];
        [GZMrequest postWithURLString:[GZMUrl get_deleteCollection_url] parameters:dic success:^(NSDictionary *data) {
            [Unity hiddenanimate];
            if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
                [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
                self.sellerBtn.backgroundColor = LabelColor9;
                salerStr = @"0";
            }else{
                [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            }
        } failure:^(NSError *error) {
            [Unity hiddenanimate];
            [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }];
    }else{
        NSString * img = @"";
        if ([self.dataDic[@"goods"][@"Item"][@"PictureURL"] isKindOfClass:[NSString class]]) {
            img =self.dataDic[@"goods"][@"Item"][@"PictureURL"];
        }else{
            img = self.dataDic[@"goods"][@"Item"][@"PictureURL"][0];
        }
        NSDictionary * dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"area":@"1",@"type":@"saler",@"w_object":self.dataDic[@"goods"][@"Item"][@"Title"],@"w_link":self.dataDic[@"goods"][@"Item"][@"ViewItemURLForNaturalSearch"],@"w_overtime":bjTime,@"w_jpnid":self.dataDic[@"goods"][@"Item"][@"ItemID"],@"w_imgsrc":img,@"w_saler":self.dataDic[@"goods"][@"Item"][@"Seller"][@"UserID"],@"w_tag":@""};
        [Unity showanimate];
        [GZMrequest postWithURLString:[GZMUrl get_collection_url] parameters:dic success:^(NSDictionary *data) {
            [Unity hiddenanimate];
            if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
                [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
                self.sellerBtn.backgroundColor = [Unity getColor:@"aa112d"];
                salerStr = [NSString stringWithFormat:@"%@",data[@"data"]];
            }else{
                [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            }
        } failure:^(NSError *error) {
            [Unity hiddenanimate];
            [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }];
    }
}
#pragma mark  原文  翻译
- (void)originaClick{
    if (self.yuanwen.selected == NO) {
        return;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            [self.foutLine setFrame:CGRectMake(0, [Unity countcoordinatesH:50]-3, SCREEN_WIDTH/2, 3)];
        }completion:nil];
        isYuanwen = YES;
        self.yuanwen.selected = NO;
        self.fanyi.selected = YES;
        NSString * htmlStr = [NSString stringWithFormat:@"<!DOCTYPE html> \n"
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
                              "</html>",self.dataDic[@"goods"][@"Item"][@"Description"]];
        [self.wkWebView loadHTMLString:htmlStr baseURL:nil];
    }
}
- (void)fanyiClick{
    if (self.fanyi.selected == NO) {
        return;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            [self.foutLine setFrame:CGRectMake(SCREEN_WIDTH/2, [Unity countcoordinatesH:50]-3, SCREEN_WIDTH/2, 3)];
        }completion:nil];
        isYuanwen = NO;
        self.yuanwen.selected = YES;
        self.fanyi.selected = NO;
        NSString * htmlStr = [NSString stringWithFormat:@"<!DOCTYPE html> \n"
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
                              "</html>",self.dataDic[@"goods"][@"Item"][@"Description"]];
        [self.wkWebView loadHTMLString:htmlStr baseURL:nil];
    }
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"加载完成");
    [self.wkWebView getImageUrlByJS:webView];
    
    //    // 禁止放大缩小
    NSString *injectionJSString = @"var script = document.createElement('meta');"
    "script.name = 'viewport';"
    "script.content=\"width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    [webView evaluateJavaScript:injectionJSString completionHandler:nil];
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return self.wkWebView.scrollView.subviews.firstObject;
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    //前缀
    NSString *path = [navigationAction.request.URL.absoluteString stringByRemovingPercentEncoding];
    NSLog(@"%@",path);
    if ([scheme isEqualToString:@"dujiaoshou"]) {
        
        //        [self handleCustomAction:URL];
        
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    } else if ([scheme isEqualToString:@"myweb"]){
        
        if ([path hasPrefix:@"myweb:imageClick:"]){
            NSString *imageUrl = [path substringFromIndex:@"myweb:imageClick:".length];
            NSLog(@"image url------%@", imageUrl);
            
            NSArray *imgUrlArr=[self.wkWebView getImgUrlArray];
            
            if (imgUrlArr.count == 0) {
                NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                [tempArray addObject:imageUrl];
                imgUrlArr = [tempArray copy];
            }
            NSLog(@"%@",imgUrlArr);
            
            NSInteger index=0;
            for (NSInteger i=0; i<[imgUrlArr count]; i++) {
                if([imageUrl isEqualToString:imgUrlArr[i]]) {
                    index=i;
                    isbanner = NO;
                    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
                    browser.sourceImagesContainerView = self.view; // 原图的父控件
                    browser.imageCount = imgUrlArr.count; // 图片总数
                    browser.currentImageIndex = index;
                    
                    browser.delegate = self;
                    [browser show];
                    
                    break;
                }
            }
            
        }
        
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
#pragma mark - photobrowser代理方法
// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    
    return [[UIImage alloc] init];
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    //bmiddle//thumbnail
    
    NSString *urlStr;
    if (isbanner) {
        urlStr = [self.imagesURLStrings objectAtIndex:index];
    }else{
        NSArray *imgUrlArr=[self.wkWebView getImgUrlArray];
        urlStr = [imgUrlArr objectAtIndex:index];
    }
    
    return [NSURL URLWithString:urlStr];
    
}
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击的是第几个banner%ld",(long)index);
    isbanner = YES;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self.view; // 原图的父控件
    browser.imageCount = self.imagesURLStrings.count; // 图片总数
    browser.currentImageIndex = index;
    
    browser.delegate = self;
    [browser show];
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
    webpageObject.webpageUrl = [NSString stringWithFormat:@"%@/shaogood/mobile-goodsdetail-ebay.php?ItemID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"],self.dataDic[@"goods"][@"Item"][@"ItemID"]];
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = self.goodsTitle.text;
    message.description = self.stopTime.text;
    NSString *urlString = self.imagesURLStrings[0];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:urlString]];
    UIImage *image = [UIImage imageWithData:data]; // 取得图片
    [message setThumbImage:image];
    message.mediaObject = webpageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
}
- (void)weixinfrindClick{
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = [NSString stringWithFormat:@"%@/shaogood/mobile-goodsdetail-ebay.php?ItemID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"],self.dataDic[@"goods"][@"Item"][@"ItemID"]];
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = self.goodsTitle.text;
    message.description = self.stopTime.text;
    NSString *urlString = self.imagesURLStrings[0];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:urlString]];
    UIImage *image = [UIImage imageWithData:data]; // 取得图片
    [message setThumbImage:image];
    message.mediaObject = webpageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req];
}

- (UIButton *)spButton{
    if (!_spButton) {
        _spButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:50], SCREEN_HEIGHT-bottomH-[Unity countcoordinatesH:60], [Unity countcoordinatesW:50], [Unity countcoordinatesH:50])];
        [_spButton addTarget:self action:@selector(spbuttonClick) forControlEvents:UIControlEventTouchUpInside];
        [_spButton setBackgroundImage:[UIImage imageNamed:@"caijia"] forState:UIControlStateNormal];
        _spButton.layer.cornerRadius = _spButton.height/2;
    }
    return _spButton;
}
- (void)spbuttonClick{
    if (userInfo == nil) {
        LoginViewController * lvc = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:lvc animated:YES];
        
        return;
    }
    if (!isAction) {
        return;
    }
    GuessViewController * gvc = [[GuessViewController alloc]init];
    gvc.platform = self.platform;
    gvc.currentPrice = self.dataDic[@"goods"][@"Item"][@"CurrentPrice"];
    gvc.goodsTitle = self.dataDic[@"goods"][@"Item"][@"Title"];
    gvc.imageUrl = self.imagesURLStrings[0];
    gvc.countdown = endTime;
    gvc.link = self.dataDic[@"goods"][@"Item"][@"ViewItemURLForNaturalSearch"];
    gvc.incrementStr = [Unity getSmallestUnitOfBid:self.dataDic[@"goods"][@"Item"][@"CurrentPrice"] WithCount:self.dataDic[@"goods"][@"Item"][@"BidCount"]];
    gvc.goodId = self.dataDic[@"goods"][@"Item"][@"ItemID"];
    gvc.price = @"";
    [self.navigationController pushViewController:gvc animated:YES];
}
- (void)uploadFootprint:(NSDictionary *)dict{
    NSString * rouid = @"";
    NSString * rouName = @"";
    for (int i=0; i<[dict[@"patharr"] count] ; i++) {
        NSString * key = [dict[@"patharr"][i] allKeys][0];
        if (i == 0) {
            rouid = key;
            rouName = dict[@"patharr"][i][key];
        }else{
            rouid = [rouid stringByAppendingFormat:@",%@", key];
            rouName = [rouName stringByAppendingFormat:@">%@", dict[@"patharr"][i][key]];
        }
    }
    NSString * imgJson;
    if ([dict[@"data"][@"goods"][@"Item"][@"PictureURL"] isKindOfClass:[NSString class]]) {
        imgJson = dict[@"data"][@"goods"][@"Item"][@"PictureURL"];
    }else{
        NSMutableDictionary * dicc = [NSMutableDictionary new];
        for (int i=0; i<[dict[@"data"][@"goods"][@"Item"][@"PictureURL"] count]; i++) {
            NSString * str = [NSString stringWithFormat:@"%d",i];
            [dicc setObject:dict[@"data"][@"goods"][@"Item"][@"PictureURL"][i] forKey:str];
        }
        imgJson = [Unity dictionaryToJson:dicc];
    }
    NSString * ThumbnailsJson;
    if (dict[@"data"][@"goods"][@"Item"][@"GalleryURL"] == nil) {
        ThumbnailsJson = @"";
    }else{
        if ([dict[@"data"][@"goods"][@"Item"][@"GalleryURL"] isKindOfClass:[NSString class]]) {
            ThumbnailsJson = dict[@"data"][@"goods"][@"Item"][@"GalleryURL"];
        }else{
            NSMutableDictionary * dicc = [NSMutableDictionary new];
            for (int i=0; i<[dict[@"data"][@"goods"][@"Item"][@"GalleryURL"] count]; i++) {
                NSString * str = [NSString stringWithFormat:@"%d",i];
                [dicc setObject:dict[@"data"][@"goods"][@"Item"][@"GalleryURL"][i] forKey:str];
            }
            ThumbnailsJson = [Unity dictionaryToJson:dicc];
//            ThumbnailsJson = [Unity gs_jsonStringCompactFormatForNSArray:dict[@"data"][@"goods"][@"Item"][@"GalleryURL"]];
        }
    }
    
    NSString * userID;
    if (userInfo != nil) {
        userID = userInfo[@"w_email"];
    }else{
        userID = @"";
        
        NSArray * arr = [[NSUserDefaults standardUserDefaults]objectForKey:@"footInfo"];
        if (arr == nil) {
            arr = [NSArray new];
        }
        NSMutableArray * array = [arr mutableCopy];
        NSMutableDictionary * map = [NSMutableDictionary new];
        [map setObject:dict[@"data"][@"goods"][@"Item"][@"ItemID"] forKey:@"auction_id"];
        [map setObject:@"4" forKey:@"terminal"];
        [map setObject:@"ebay" forKey:@"source"];
        NSString * time = [Unity getCurrentTimeyyyymmdd];
        [map setObject:time forKey:@"read_time"];
        for (int i=0; i<array.count; i++) {
            if ([array[i][@"auction_id"] isEqualToString:dict[@"data"][@"goods"][@"Result"][@"AuctionID"] ]) {
                [array removeObjectAtIndex:i];
                break;
            }
        }
        [array addObject:map];
        arr = [array copy];
        [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"footInfo"];
    }
    NSDictionary * dic = @{@"user":userID,@"auction_id":dict[@"data"][@"goods"][@"Item"][@"ItemID"],@"goods_name":dict[@"data"][@"goods"][@"Item"][@"Title"],@"source":@"ebay",@"category_id_path":rouid,@"category_path":rouName,@"seller_id":dict[@"data"][@"goods"][@"Item"][@"Seller"][@"UserID"],@"over_price":dict[@"data"][@"goods"][@"Item"][@"CurrentPrice"],@"over_time":bjTime,@"terminal":@"4",@"goods_img":imgJson,@"goods_img_thumbnail":ThumbnailsJson,@"goods_url":dict[@"data"][@"goods"][@"Item"][@"ViewItemURLForNaturalSearch"],@"goods_num":dict[@"data"][@"goods"][@"Item"][@"Quantity"],@"is_auction":@"1",@"freeshipping":@"1",@"is_new":@"0",@"bid_count":@"0"};
    [GZMrequest postWithURLString:[GZMUrl get_footmarkadd_url] parameters:dic success:^(NSDictionary *data) {
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
//请求推荐商品列表
- (void)requestRecomeList:(NSString *)classId{
    [self.recomeList removeAllObjects];
    NSDictionary * dic = @{@"source":@"ebay",@"categoryid":classId,@"AuctionID":self.item};
    [GZMrequest getWithURLString:[GZMUrl get_recomeList_url] parameters:dic success:^(NSDictionary *data) {
        if ([data[@"status"] intValue] == 1) {
            for (int i=0; i<[data[@"data"] count]; i++) {
                [self.recomeList addObject:data[@"data"][i]];
            }
            NSLog(@"%@",self.recomeList);
            [self.collectionView reloadData];
            self.collectionView.hidden = NO;
        }
    } failure:^(NSError *error) {
        
    }];
}
- (NSMutableArray *)recomeList{
    if (!_recomeList) {
        _recomeList = [NSMutableArray new];
    }
    return _recomeList;
}
@end
