//
//  NewClassViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/8/26.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "NewClassViewController.h"
#import "AppDelegate.h"
#import "ClassCell.h"
#import "GoodsListViewController.h"
#import "CollectionViewHeaderView.h"
#import "EbayGoodsListViewController.h"
#define CellIdentifier2 @"CellIdentifier2"
#define CellIdentifier1 @"CellIdentifier1"
#import "ClassCollectionViewCell.h"

#define leftT  (SCREEN_WIDTH*0.28)
#define rightT  (SCREEN_WIDTH*0.72)

#define W  ([Unity widthOfString:@"日本雅虎" OfFontSize:17 OfHeight:44])
@interface NewClassViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,CollectionViewHeaderDelegate>
{
    NSArray *sectionTitles; // 每个分区的标题
    NSArray *contentsArray; // 每行的内容
    NSArray * arr;
    NSString * oneID;//yahoo 默认选中分类
    NSString * twoID;//ebay 默认选中分类
    BOOL isOne;//首次加载是否完成 默认NO
    BOOL isTwo;//
}
@property (nonatomic , strong)UIView * navV;
@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic , strong) UIButton * yahooBtn;
@property (nonatomic , strong) UIButton * ebayBtn;
@property (nonatomic , strong) UIButton * webBtn;

@property (nonatomic, strong) UILabel * yahooLine;
@property (nonatomic, strong) UILabel * ebayLine;
@property (nonatomic, strong) UILabel * webLine;

@property (nonatomic , strong) UIView * oneView;
@property (nonatomic , strong) UIView * twoView;
@property (nonatomic , strong) UIView * threeView;

/* 日本yahoo*/
@property (nonatomic, strong) UITableView * OneLeftTableView;
@property (nonatomic,strong) UICollectionView * OneRightCollectionView;

@property (nonatomic,strong) UICollectionViewFlowLayout * flowLayout1;

@property (nonatomic , strong) NSArray * OneLeftArr;
@property (nonatomic , strong) NSArray * OneRightArr;
/* 美国Ebay*/
@property (nonatomic, strong) UITableView *TwoLeftTableView;
@property (nonatomic,strong) UICollectionView * TwoRightCollectionView;

@property (nonatomic,strong) UICollectionViewFlowLayout * flowLayout2;

@property (nonatomic , strong) NSArray * TwoLeftArr;
@property (nonatomic , strong) NSArray * TwoRightArr;
/*品牌库*/
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) NSMutableArray * sectionTitles;
@property (nonatomic , strong) NSMutableArray * contentsArray;
@end

@implementation NewClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isOne = NO;
    isTwo = NO;
    arr = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    [self creareUI];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    AppDelegate * myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (myDelegate.pageTrue == 3) {
        [self webClick];
    }else if (myDelegate.pageTrue == 2) {
        [self ebayClick];
    }else{
        [self yahooClick];
    }
}
- (void)creareUI{
    [self.view addSubview:self.navV];
    
    [self.navV addSubview:self.yahooBtn];
    [self.navV addSubview:self.ebayBtn];
    [self.navV addSubview:self.webBtn];
    
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.oneView];
    [self.mainScrollView addSubview:self.twoView];
    [self.mainScrollView addSubview:self.threeView];
}
- (UIView *)navV{
    if (!_navV) {
        _navV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight)];
        _navV.backgroundColor = [Unity getColor:@"aa112d"];
    }
    return _navV;
}
- (UIButton *)yahooBtn{
    if (!_yahooBtn) {
        _yahooBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-(W*3+30))/2, StatusBarHeight, W, 44)];
        [_yahooBtn setTitle:@"日本雅虎" forState:UIControlStateNormal];
        [_yahooBtn setTitleColor:[Unity getColor:@"#d58896"] forState:UIControlStateNormal];
        _yahooBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_yahooBtn addTarget:self action:@selector(yahooClick) forControlEvents:UIControlEventTouchUpInside];
        
        _yahooLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, _yahooBtn.width, 1)];
        _yahooLine.backgroundColor = [Unity getColor:@"#d58896"];
        [_yahooBtn addSubview:_yahooLine];
    }
    return _yahooBtn;
}
- (UIButton *)ebayBtn{
    if (!_ebayBtn) {
        _ebayBtn = [[UIButton alloc]initWithFrame:CGRectMake(_yahooBtn.right+15, StatusBarHeight, W, 44)];
        [_ebayBtn setTitle:@"美国易贝" forState:UIControlStateNormal];
        [_ebayBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
        _ebayBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_ebayBtn addTarget:self action:@selector(ebayClick) forControlEvents:UIControlEventTouchUpInside];
        
        _ebayLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, _ebayBtn.width, 1)];
        _ebayLine.backgroundColor = [Unity getColor:@"#d58896"];
        _ebayLine.hidden = YES;
        [_ebayBtn addSubview:_ebayLine];
    }
    return _ebayBtn;
}
- (UIButton *)webBtn{
    if (!_webBtn) {
        _webBtn = [[UIButton alloc]initWithFrame:CGRectMake(_ebayBtn.right+15, StatusBarHeight, W/2, 44)];
        [_webBtn setTitle:@"品牌" forState:UIControlStateNormal];
        [_webBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
        _webBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_webBtn addTarget:self action:@selector(webClick) forControlEvents:UIControlEventTouchUpInside];
        
        _webLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, _webBtn.width, 1)];
        _webLine.backgroundColor = [Unity getColor:@"#d58896"];
        _webLine.hidden = YES;
        [_webBtn addSubview:_webLine];
    }
    return _webBtn;
}
- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.frame = CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-TabBarHeight);
        _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 0);
        _mainScrollView.backgroundColor = [UIColor clearColor];
        [_mainScrollView setScrollEnabled:NO];
        // 开启分页
        _mainScrollView.pagingEnabled = YES;
        // 没有弹簧效果
        _mainScrollView.bounces = NO;
        // 隐藏水平滚动条
        _mainScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _mainScrollView;
}
// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    CGFloat offsetX = index * SCREEN_WIDTH;
    UIViewController *vc = self.childViewControllers[index];
    NSLog(@"VC = %@",vc);
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-TabBarHeight);
}
- (void)yahooClick{
    [_yahooBtn setTitleColor:[Unity getColor:@"#d58896"] forState:UIControlStateNormal];
    _yahooLine.hidden = NO;
    [_ebayBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
    _ebayLine.hidden = YES;
    [_webBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
    _webLine.hidden = YES;
    self.mainScrollView.contentOffset = CGPointMake(0, 0);
//    [self showVc:0];
    if (self.OneLeftArr.count==0 || self.OneRightArr.count ==0) {
        [self requestClassifyData];
    }
    AppDelegate * myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    myDelegate.pageTrue = 1;
}
- (void)ebayClick{
    [_yahooBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
    _yahooLine.hidden = YES;
    [_ebayBtn setTitleColor:[Unity getColor:@"#d58896"] forState:UIControlStateNormal];
    _ebayLine.hidden = NO;
    [_webBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
    _webLine.hidden = YES;
    self.mainScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
//    [self showVc:1];
    if (self.TwoLeftArr.count ==0 || self.TwoRightArr.count==0) {
        [self requestClassifyData1];
    }
    AppDelegate * myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    myDelegate.pageTrue = 2;
}
- (void)webClick{
    [_yahooBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
    _yahooLine.hidden = YES;
    [_ebayBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
    _ebayLine.hidden = YES;
    [_webBtn setTitleColor:[Unity getColor:@"#d58896"] forState:UIControlStateNormal];
    _webLine.hidden = NO;
    self.mainScrollView.contentOffset = CGPointMake(SCREEN_WIDTH*2, 0);
//    [self showVc:2];
    if (sectionTitles.count == 0) {
        [self requestBrand];
    }
    AppDelegate * myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    myDelegate.pageTrue = 3;
}
- (UIView *)oneView{
    if (!_oneView) {
        _oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.mainScrollView.height)];
        [self.OneLeftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        [_oneView addSubview:self.OneLeftTableView];
        [_oneView addSubview:self.OneRightCollectionView];
    }
    return _oneView;
}
- (UIView *)twoView{
    if (!_twoView) {
        _twoView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.mainScrollView.height)];
//        _twoView.backgroundColor = [UIColor yellowColor];
        [self.TwoLeftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        [_twoView addSubview:self.TwoLeftTableView];
        [_twoView addSubview:self.TwoRightCollectionView];
    }
    return _twoView;
}
- (UIView *)threeView{
    if (!_threeView) {
        _threeView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, self.mainScrollView.height)];
//        _threeView.backgroundColor = [UIColor blueColor];
        [_threeView addSubview:self.tableView];
    }
    return _threeView;
}

#pragma mark - private
-(UITableView *)OneLeftTableView{
    
    if (!_OneLeftTableView) {
        _OneLeftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, leftT, SCREEN_HEIGHT-NavBarHeight-TabBarHeight) style:UITableViewStylePlain];
        [_OneLeftTableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _OneLeftTableView.showsVerticalScrollIndicator = NO;
        _OneLeftTableView.delegate = self;
        _OneLeftTableView.dataSource = self;
        _OneLeftTableView.tag = 10000;
    }
    return _OneLeftTableView;
}
-(UICollectionView *)OneRightCollectionView{
    
    if (!_OneRightCollectionView) {
        
        self.flowLayout1 = [[UICollectionViewFlowLayout alloc]init];
        _OneRightCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(leftT, 0, rightT, SCREEN_HEIGHT-NavBarHeight-TabBarHeight) collectionViewLayout:self.flowLayout1];
        self.flowLayout1.minimumLineSpacing = 0;
        self.flowLayout1.minimumInteritemSpacing = 0;
        if (@available(iOS 9.0, *)) {
            self.flowLayout1.sectionHeadersPinToVisibleBounds = true;
        } else {
            // Fallback on earlier versions
        }
        
        self.flowLayout1.itemSize = CGSizeMake((rightT-10)/3,[Unity countcoordinatesH:40]);
        self.flowLayout1.sectionInset = UIEdgeInsetsMake(0, 0, 0, 10);
        self.flowLayout1.scrollDirection = UICollectionViewScrollDirectionVertical;
        _OneRightCollectionView.delegate = self;
        _OneRightCollectionView.dataSource = self;
        _OneRightCollectionView.showsVerticalScrollIndicator = NO;
//        [_OneRightCollectionView registerClass:[ClassCell class] forCellWithReuseIdentifier:CellIdentifier1];
        
        
        [_OneRightCollectionView registerNib:[UINib nibWithNibName:@"ClassCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellIdentifier1];
        //ClassCollectionViewCell
        _OneRightCollectionView.backgroundColor = [UIColor whiteColor];
        _OneRightCollectionView.tag = 20000;
        [_OneRightCollectionView registerClass:[CollectionViewHeaderView class]
                 forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                        withReuseIdentifier:@"CollectionViewHeaderView"];
        _OneRightCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //进行数据刷新操作
//            [self requestClassifyData];
            if (isOne) {
                [self requesOtherClass:oneID];
            }else{
                [self yahooClick];
            }
//            [self requesOtherClass:oneID];
            [_OneRightCollectionView.mj_header endRefreshing];
        }];
        // 马上进入刷新状态
//        [_OneRightCollectionView.mj_header beginRefreshing];
    }
    return _OneRightCollectionView;
}

#pragma mark UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 10000) {
        return self.OneLeftArr.count;
    }else if (tableView.tag == 10001){
        return self.TwoLeftArr.count;
    }else{
       return [self.contentsArray[section] count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 10000) {
        static NSString *ID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            UIView *view = [[UIView alloc]initWithFrame:cell.frame];
            view.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
            cell.selectedBackgroundView = view;
        }
        cell.backgroundColor = [Unity getColor:@"#f0f0f0"];
        cell.textLabel.text = self.OneLeftArr[indexPath.row][@"w_name_tw"];
        cell.textLabel.textColor = LabelColor6;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        //修改点击效果
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
        UILabel * label = [Unity lableViewAddsuperview_superView:cell.selectedBackgroundView _subViewFrame:CGRectMake(0, [Unity countcoordinatesH:12], [Unity countcoordinatesW:5], [Unity countcoordinatesH:16]) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentCenter];
        label.backgroundColor = [UIColor redColor];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        return cell;
    }else if (tableView.tag == 10001){
        static NSString *ID1 = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID1];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID1];
            UIView *view = [[UIView alloc]initWithFrame:cell.frame];
            view.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
            cell.selectedBackgroundView = view;
        }
        cell.backgroundColor = [Unity getColor:@"#f0f0f0"];
        cell.textLabel.text = self.TwoLeftArr[indexPath.row][@"w_name_tw"];
        cell.textLabel.textColor = LabelColor6;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        //修改点击效果
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
        UILabel * label = [Unity lableViewAddsuperview_superView:cell.selectedBackgroundView _subViewFrame:CGRectMake(0, [Unity countcoordinatesH:12], [Unity countcoordinatesW:5], [Unity countcoordinatesH:16]) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentCenter];
        label.backgroundColor = [UIColor redColor];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        return cell;
    }else{
        static NSString *ID2 = @"cellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID2];
        if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID2];
        
        cell.textLabel.text = self.contentsArray[indexPath.section][indexPath.row][@"w_title"];
        cell.textLabel.textColor = LabelColor3;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag ==10000) {
//        NSLog(@"%@",self.OneLeftArr[indexPath.row][@"id"]);
        [self requesOtherClass:self.OneLeftArr[indexPath.row][@"id"]];
        oneID = self.OneLeftArr[indexPath.row][@"id"];
    }else if (tableView.tag == 10001){
//        NSLog(@"%@",self.TwoLeftArr[indexPath.row][@"id"]);
        [self requesOtherClass1:self.TwoLeftArr[indexPath.row][@"id"]];
        twoID = self.TwoLeftArr[indexPath.row][@"id"];
    }else{
        GoodsListViewController * gvc = [[GoodsListViewController alloc]init];
        gvc.hidesBottomBarWhenPushed = YES;
        gvc.pageIndex =1;
        gvc.isSearch = NO;
        gvc.platform = @"0";
        gvc.brandId = self.contentsArray[indexPath.section][indexPath.row][@"w_title"];
        [self.navigationController pushViewController:gvc animated:YES];
    }
    
}
#pragma mark UICollectionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    if (collectionView.tag == 20000) {
        return self.OneRightArr.count;
    }else{
        return self.TwoRightArr.count;
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView.tag == 20000) {
        return [self.OneRightArr[section][@"son_category"] count];//每个section有多少个cell
    }else{
        return [self.TwoRightArr[section][@"son_category"] count];//每个section有多少个cell
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 20000) {
        ClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier1 forIndexPath:indexPath];
        //    NSLog(@"%@",self.rightArr[indexPath.section]);
//        cell.name.text = self.OneRightArr[indexPath.section][@"son_category"][indexPath.row][@"w_name_tw"];// cell
//        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"],self.OneRightArr[indexPath.section][@"son_category"][indexPath.row][@"w_imgadd"]]] placeholderImage:[UIImage imageNamed:@"Loading"]];
//        cell.name.textColor = LabelColor9;
        //    cell.imgView.image =nil;
        cell.titleLabel.backgroundColor = [Unity getColor:@"#dadada"];
        cell.titleLabel.layer.cornerRadius = 4;
        cell.titleLabel.clipsToBounds = YES;
        cell.titleLabel.textColor = [Unity getColor:@"#202020"];
        cell.titleLabel.text = self.OneRightArr[indexPath.section][@"son_category"][indexPath.row][@"w_name_tw"];
        return cell;
    }else{
        ClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier2 forIndexPath:indexPath];
//        cell.name.text = self.TwoRightArr[indexPath.section][@"son_category"][indexPath.row][@"w_name_tw"];// cell
//        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"],self.TwoRightArr[indexPath.section][@"son_category"][indexPath.row][@"w_imgadd"]]] placeholderImage:[UIImage imageNamed:@"Loading"]];
//        cell.name.textColor = LabelColor9;
        cell.titleLabel.backgroundColor = [Unity getColor:@"#dadada"];
        cell.titleLabel.layer.cornerRadius = 4;
        cell.titleLabel.clipsToBounds = YES;
        cell.titleLabel.textColor = [Unity getColor:@"#202020"];
        cell.titleLabel.text = self.TwoRightArr[indexPath.section][@"son_category"][indexPath.row][@"w_name_tw"];
        return cell;
    }
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
        viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 20000) {
        NSString *reuseIdentifier;
        // header
        if ([kind isEqualToString:UICollectionElementKindSectionHeader])
        {
            reuseIdentifier = @"CollectionViewHeaderView";
        }
        CollectionViewHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                            withReuseIdentifier:reuseIdentifier
                                                                                   forIndexPath:indexPath];
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            view.backgroundColor = [UIColor whiteColor];
            view.label.text = self.OneRightArr[indexPath.section][@"w_name_tw"];//section
            view.delegate = self;
            view.tag = indexPath.section;
            UITapGestureRecognizer *singleTap =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionView:)];
            singleTap.numberOfTapsRequired = 1; //点击次数
            singleTap.numberOfTouchesRequired = 1; //点击手指数
            [view addGestureRecognizer:singleTap];
        }
        return view;
    }else{
        NSString *reuseIdentifier;
        // header
        if ([kind isEqualToString:UICollectionElementKindSectionHeader])
        {
            reuseIdentifier = @"CollectionViewHeaderView";
        }
        CollectionViewHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                            withReuseIdentifier:reuseIdentifier
                                                                                   forIndexPath:indexPath];
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            view.backgroundColor = [UIColor whiteColor];
            view.label.text = self.TwoRightArr[indexPath.section][@"w_name_tw"];//section
            view.delegate = self;
            view.tag = indexPath.section;
            UITapGestureRecognizer *singleTap =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionView1:)];
            singleTap.numberOfTapsRequired = 1; //点击次数
            singleTap.numberOfTouchesRequired = 1; //点击手指数
            [view addGestureRecognizer:singleTap];
        }
        return view;
    }
}
- (void)sectionView:(UITapGestureRecognizer *)tap{
    NSLog(@"%@",self.OneRightArr[tap.view.tag]);
    GoodsListViewController * gvc = [[GoodsListViewController alloc]init];
    gvc.hidesBottomBarWhenPushed = YES;
    gvc.pageIndex =0;
    gvc.isSearch = NO;
    gvc.platform = @"0";
    gvc.classId = self.OneRightArr[tap.view.tag][@"w_categoryid"];
    gvc.className = self.OneRightArr[tap.view.tag][@"w_name_tw"];
    [self.navigationController pushViewController:gvc animated:YES];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (collectionView.tag == 20000) {
        return CGSizeMake(rightT, [Unity countcoordinatesH:40]);
    }else{
        return CGSizeMake(rightT, [Unity countcoordinatesH:40]);
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 20000) {
        NSLog(@"%@",self.OneRightArr[indexPath.section][@"son_category"][indexPath.row]);
        GoodsListViewController * gvc = [[GoodsListViewController alloc]init];
        gvc.hidesBottomBarWhenPushed = YES;
        gvc.pageIndex =0;
        gvc.isSearch = NO;
        gvc.platform = @"0";
        gvc.classId = self.OneRightArr[indexPath.section][@"son_category"][indexPath.row][@"w_categoryid"];
        gvc.className = self.OneRightArr[indexPath.section][@"son_category"][indexPath.row][@"w_name_tw"];
        [self.navigationController pushViewController:gvc animated:YES];
    }else{
        NSLog(@"%@",self.TwoRightArr[indexPath.section][@"son_category"][indexPath.row]);
        EbayGoodsListViewController * gvc = [[EbayGoodsListViewController alloc]init];
        gvc.hidesBottomBarWhenPushed = YES;
        gvc.pageIndex =0;
        gvc.isSearch = NO;
        gvc.platform = @"5";
        gvc.classId = self.TwoRightArr[indexPath.section][@"son_category"][indexPath.row][@"w_categoryid"];
        gvc.className = self.TwoRightArr[indexPath.section][@"son_category"][indexPath.row][@"w_name_tw"];
        [self.navigationController pushViewController:gvc animated:YES];
    }
}
- (void)requestClassifyData{
    [Unity showanimate];
    NSDictionary *params = @{@"platform":@"0"};
    [GZMrequest getWithURLString:[GZMUrl get_classify_url] parameters:params success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        //        NSLog(@"||||||||||||%@",data);
        
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            isOne = YES;
            [self.OneRightCollectionView.mj_header endRefreshing];
            self.OneLeftArr = data[@"data"];
            [self.OneLeftTableView reloadData];
            [self requesOtherClass:self.OneLeftArr[0][@"id"]];
            //默认选中第一个
            NSInteger selectedIndex = 0;
            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
            [self.OneLeftTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            oneID = self.OneLeftArr[0][@"id"];
        }else{
           [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)requesOtherClass:(NSString *)categoryid{
    [Unity showanimate];
    NSDictionary *params = @{@"platform":@"0",@"parent":categoryid};
    [GZMrequest getWithURLString:[GZMUrl get_otherclassify_url] parameters:params success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        //        NSLog(@"」』」』」』%@",data);
        
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            self.OneRightArr = data[@"data"];
            [self.OneRightCollectionView reloadData];
        }else{
            [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];;
        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (NSArray *)OneLeftArr{
    if (!_OneLeftArr) {
        _OneLeftArr = [NSArray new];
    }
    return _OneLeftArr;
}
- (NSArray *)OneRightArr{
    if (!_OneRightArr) {
        _OneRightArr = [NSArray new];
    }
    return _OneRightArr;
}
#pragma mark - private
-(UITableView *)TwoLeftTableView{
    
    if (!_TwoLeftTableView) {
        _TwoLeftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, leftT, SCREEN_HEIGHT-NavBarHeight-TabBarHeight) style:UITableViewStylePlain];
        [_TwoLeftTableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _TwoLeftTableView.showsVerticalScrollIndicator = NO;
        _TwoLeftTableView.delegate = self;
        _TwoLeftTableView.dataSource = self;
        _TwoLeftTableView.tag = 10001;
    }
    return _TwoLeftTableView;
}
-(UICollectionView *)TwoRightCollectionView{
    
    if (!_TwoRightCollectionView) {
        
        self.flowLayout2 = [[UICollectionViewFlowLayout alloc]init];
        _TwoRightCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(leftT, 0, rightT, SCREEN_HEIGHT-NavBarHeight-TabBarHeight) collectionViewLayout:self.flowLayout2];
        self.flowLayout2.minimumLineSpacing = 0;
        self.flowLayout2.minimumInteritemSpacing = 0;
        if (@available(iOS 9.0, *)) {
            self.flowLayout2.sectionHeadersPinToVisibleBounds = true;
        } else {
            // Fallback on earlier versions
        }
        
        self.flowLayout2.itemSize = CGSizeMake((rightT-10)/3,[Unity countcoordinatesH:40]);
        self.flowLayout2.sectionInset = UIEdgeInsetsMake(0, 0, 0, 10);
        self.flowLayout2.scrollDirection = UICollectionViewScrollDirectionVertical;
        _TwoRightCollectionView.delegate = self;
        _TwoRightCollectionView.dataSource = self;
        _TwoRightCollectionView.showsVerticalScrollIndicator = NO;
        _TwoRightCollectionView.tag = 20001;
//        [_TwoRightCollectionView registerClass:[ClassCell class] forCellWithReuseIdentifier:CellIdentifier2];
        [_TwoRightCollectionView registerNib:[UINib nibWithNibName:@"ClassCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellIdentifier2];
        _TwoRightCollectionView.backgroundColor = [UIColor whiteColor];
        [_TwoRightCollectionView registerClass:[CollectionViewHeaderView class]
                 forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                        withReuseIdentifier:@"CollectionViewHeaderView"];
        _TwoRightCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //进行数据刷新操作
//            [self requestClassifyData1];
            if (isTwo) {
                [self requesOtherClass1:twoID];
            }else{
                [self ebayClick];
            }
            
            [_TwoRightCollectionView.mj_header endRefreshing];
        }];
        // 马上进入刷新状态
//        [_TwoRightCollectionView.mj_header beginRefreshing];
    }
    return _TwoRightCollectionView;
}
- (void)requestClassifyData1{
    [Unity showanimate];
    NSDictionary *params = @{@"platform":@"5"};
    [GZMrequest getWithURLString:[GZMUrl get_classify_url] parameters:params success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        NSLog(@"%@",data);
        
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            isTwo = YES;
            [self.TwoRightCollectionView.mj_header endRefreshing];
            self.TwoLeftArr = data[@"data"];
            [self.TwoLeftTableView reloadData];
            [self requesOtherClass1:self.TwoLeftArr[0][@"id"]];
            //默认选中第一个
            NSInteger selectedIndex = 0;
            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
            [self.TwoLeftTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            twoID = self.TwoLeftArr[0][@"id"];
        }else{
            [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)requesOtherClass1:(NSString *)categoryid{
    [Unity showanimate];
    NSDictionary *params = @{@"platform":@"5",@"parent":categoryid};
    [GZMrequest getWithURLString:[GZMUrl get_otherclassify_url] parameters:params success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        NSLog(@"%@",data);
        
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            self.TwoRightArr = data[@"data"];
            [self.TwoRightCollectionView reloadData];
        }else{
            [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)sectionView1:(UITapGestureRecognizer *)tap{
    NSLog(@"%@",self.TwoRightArr[tap.view.tag]);
    EbayGoodsListViewController * gvc = [[EbayGoodsListViewController alloc]init];
    gvc.hidesBottomBarWhenPushed = YES;
    gvc.pageIndex =0;
    gvc.isSearch = NO;
    gvc.platform = @"5";
    gvc.classId = self.TwoRightArr[tap.view.tag][@"w_categoryid"];
    gvc.className = self.TwoRightArr[tap.view.tag][@"w_name_tw"];
    [self.navigationController pushViewController:gvc animated:YES];
}
- (NSArray *)TwoLeftArr{
    if (!_TwoLeftArr) {
        _TwoLeftArr = [NSArray new];
    }
    return _TwoLeftArr;
}
- (NSArray *)TwoRightArr{
    if (!_TwoRightArr) {
        _TwoRightArr = [NSArray new];
    }
    return _TwoRightArr;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-TabBarHeight)];
        _tableView.tag = 10002;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = FALSE;
        _tableView.showsHorizontalScrollIndicator = FALSE;
        [_tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //进行数据刷新操作
            [self requestBrand];
        }];
        // 马上进入刷新状态
//        [self.tableView.mj_header beginRefreshing];
    }
    return _tableView;
}
//多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag == 10002) {
        return self.sectionTitles.count;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 10002) {
        return [Unity countcoordinatesH:50];
    }
    return [Unity countcoordinatesH:40];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 10002) {
        return [Unity countcoordinatesH:30];
    }
    return 0.1;
}
// 每个分区的页眉
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 10002) {
        return [self.sectionTitles objectAtIndex:section];//组头
    }
    return nil;
}
// 索引目录
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (tableView.tag == 10002) {
        return self.sectionTitles;
    }
    return nil;
}
// 点击目录
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    if (tableView.tag == 10002) {
        // 获取所点目录对应的indexPath值
        NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:index];
        
        // 让table滚动到对应的indexPath位置
        [tableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
        return index;
    }
    return nil;
}
//右侧索引字体和大小
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (tableView.tag == 10002) {
        for (UIView *view in [tableView subviews]) {
            if ([view isKindOfClass:[NSClassFromString(@"UITableViewIndex") class]]) {
                // 设置字体大小
                [view setValue:[UIFont fontWithName:@"Thonburi" size:16] forKey:@"_font"];
                
                //设置view的大小
                view.bounds = CGRectMake(0, 0, 30, SCREEN_HEIGHT-NavBarHeight-TabBarHeight);
                [view setBackgroundColor:[UIColor clearColor]];
                //单单设置其中一个是无效的
            }
        }
    }
}
- (void)requestBrand{
    //    [self.aAnimation startAround];
    [GZMrequest getWithURLString:[GZMUrl get_brand_url] parameters:nil success:^(NSDictionary *data) {
        //        [self.aAnimation stopAround];
        //        NSLog(@"品牌列表%@",data);
        [self.tableView.mj_header endRefreshing];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            [self.sectionTitles removeAllObjects];
            [self.contentsArray removeAllObjects];
            [self.tableView.mj_header endRefreshing];
            NSArray *arrKeys = [data[@"data"] allKeys];
            NSMutableArray * mutableArray = [self sorting:arrKeys];
            //            NSLog(@"arrkeys  %@",arrKeys);
            for (int i=0; i<mutableArray.count; i++) {
                int j=[mutableArray[i] intValue];
                [self.sectionTitles addObject:arr[j]];
            }
            
            for (int i=0; i<[data[@"data"] count]; i++) {
                NSMutableArray * mArr = [NSMutableArray new];
                for (int j=0; j<[data[@"data"][mutableArray[i]] count]; j++) {
                    [mArr addObject:data[@"data"][mutableArray[i]][j]];
                }
                [self.contentsArray addObject:mArr];
            }
            [self.tableView reloadData];
        }else{
            [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        //        [self.aAnimation stopAround];
        [self.tableView.mj_header endRefreshing];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
//数组排序
- (NSMutableArray *)sorting:(NSArray *)arr1{
    
    NSMutableArray *priceArray = [arr1 mutableCopy];
    
    [priceArray sortUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2)
     {
         if ([obj1 integerValue] < [obj2 integerValue]){
             return NSOrderedAscending;
         }else{
             return NSOrderedDescending;
         }
     }];
    //    NSLog(@"排序 %@",priceArray);
    return priceArray;
}
- (NSMutableArray *)sectionTitles{
    if (!_sectionTitles) {
        _sectionTitles = [NSMutableArray new];
    }
    return _sectionTitles;
}
- (NSMutableArray * )contentsArray{
    if (!_contentsArray) {
        _contentsArray = [NSMutableArray new];
    }
    return _contentsArray;
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
