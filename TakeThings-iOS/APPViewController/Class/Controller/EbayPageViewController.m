//
//  EbayPageViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/17.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "EbayPageViewController.h"
#import "ClassCell.h"
#import "CollectionViewHeaderView.h"
#import "EbayGoodsListViewController.h"
#import "UIViewController+YINNav.h"
#define CellIdentifier @"CellIdentifier"

#define leftT  (SCREEN_WIDTH*0.28)
#define rightT  (SCREEN_WIDTH*0.72)
@interface EbayPageViewController ()<UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CollectionViewHeaderDelegate>
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic,strong) UICollectionView * rightCollectionView;

@property (nonatomic,assign) NSInteger  selectIndex;
@property (nonatomic,assign) BOOL  isScrollDown;
@property (nonatomic,strong) UICollectionViewFlowLayout * flowLayout;
@property (nonatomic,strong) NSArray * dataSource;
@property (nonatomic,strong) NSArray * array;

@property (nonatomic , strong) alertView * altView;
@property (nonatomic , strong) AroundAnimation * aAnimation;

@property (nonatomic , strong) NSArray * leftArr;
@property (nonatomic , strong) NSArray * rightArr;
@end

@implementation EbayPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.y_navBarBgColor = [Unity getColor:@"aa112d"];
    [self creareUI];
    [self requestClassifyData];
}
- (void)creareUI{
    // 默认选中第一行
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightCollectionView];
}
#pragma mark - private
-(UITableView *)leftTableView{
    
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, leftT, SCREEN_HEIGHT-NavBarHeight-TabBarHeight) style:UITableViewStylePlain];
        [_leftTableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
    }
    return _leftTableView;
}
-(UICollectionView *)rightCollectionView{
    
    if (!_rightCollectionView) {
        
        self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _rightCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(leftT, 0, rightT, SCREEN_HEIGHT-NavBarHeight-TabBarHeight) collectionViewLayout:self.flowLayout];
        self.flowLayout.minimumLineSpacing = 0;
        self.flowLayout.minimumInteritemSpacing = 0;
        if (@available(iOS 9.0, *)) {
            self.flowLayout.sectionHeadersPinToVisibleBounds = true;
        } else {
            // Fallback on earlier versions
        }
        
        self.flowLayout.itemSize = CGSizeMake((rightT)/3,[Unity countcoordinatesH:100]);
        self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _rightCollectionView.delegate = self;
        _rightCollectionView.dataSource = self;
        _rightCollectionView.showsVerticalScrollIndicator = NO;
        [_rightCollectionView registerClass:[ClassCell class] forCellWithReuseIdentifier:CellIdentifier];
        _rightCollectionView.backgroundColor = [UIColor whiteColor];
        [_rightCollectionView registerClass:[CollectionViewHeaderView class]
                 forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                        withReuseIdentifier:@"CollectionViewHeaderView"];
        _rightCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //进行数据刷新操作
            [self requestClassifyData];
            [_rightCollectionView.mj_header endRefreshing];
        }];
    }
    return _rightCollectionView;
}

#pragma mark UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.leftArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        UIView *view = [[UIView alloc]initWithFrame:cell.frame];
        view.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
        cell.selectedBackgroundView = view;
    }
    cell.backgroundColor = [Unity getColor:@"#f0f0f0"];
    cell.textLabel.text = self.leftArr[indexPath.row][@"w_name_tw"];
    cell.textLabel.textColor = LabelColor6;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    //修改点击效果
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    UILabel * label = [Unity lableViewAddsuperview_superView:cell.selectedBackgroundView _subViewFrame:CGRectMake(0, [Unity countcoordinatesH:12], [Unity countcoordinatesW:5], [Unity countcoordinatesH:16]) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentCenter];
    label.backgroundColor = [UIColor redColor];
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",self.leftArr[indexPath.row][@"id"]);
    [self requesOtherClass:self.leftArr[indexPath.row][@"id"]];
    ////    self.selectIndex = indexPath.row;
    ////    [self scrollToTopOfSection:self.selectIndex animated:YES];
    ////    [self.leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    //    // 点击cell，UITableView滚动到相应的row
    //    [self.leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    //
    //    // !!!重点:解决点击 TableView 后 CollectionView 的 Header 遮挡问题
    //    // 获取CollectionView需要滚动的Section
    //    NSIndexPath *collectionIndexPath = [NSIndexPath indexPathForItem:0 inSection:indexPath.row];
    //    // 获取Section对应CollectionView布局属性
    //    UICollectionViewLayoutAttributes *attributes = [self.rightCollectionView layoutAttributesForItemAtIndexPath:collectionIndexPath];
    //    // 设置CollectionView滚动位置
    //    [self.rightCollectionView setContentOffset:CGPointMake(0, attributes.frame.origin.y - self.rightCollectionView.contentInset.top) animated:YES];
    //
}

//- (void)scrollToTopOfSection:(NSInteger)section animated:(BOOL)animated{
//
//    CGRect headerRect = [self frameForHeaderForSection:section];
//    CGPoint topOfHeader = CGPointMake(0, headerRect.origin.y-self.rightCollectionView.contentInset.top);
//    [self.rightCollectionView setContentOffset:topOfHeader animated:animated];
//}

//-(CGRect)frameForHeaderForSection:(NSInteger)section{
//
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
//    UICollectionViewLayoutAttributes *attributes = [self.rightCollectionView layoutAttributesForItemAtIndexPath:indexPath];
//    CGRect frameForFirstCell = attributes.frame;
//    CGFloat headerHeight = [self collectionView:self.rightCollectionView layout:self.flowLayout referenceSizeForHeaderInSection:section].height;
//    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.rightCollectionView.collectionViewLayout;
//    CGFloat cellTopEdge = flowLayout.sectionInset.top;
//    return CGRectOffset(frameForFirstCell, 0, -headerHeight-cellTopEdge);
//
//
//}
#pragma mark UICollectionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.rightArr.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.rightArr[section][@"son_category"] count];//每个section有多少个cell
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ClassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.name.text = self.rightArr[indexPath.section][@"son_category"][indexPath.row][@"w_name_tw"];// cell
//        cell.imgView sd_setImageWithURL:[] placeholderImage:<#(nullable UIImage *)#>
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"],self.rightArr[indexPath.section][@"son_category"][indexPath.row][@"w_imgadd"]]] placeholderImage:[UIImage imageNamed:@"Loading"]];
    cell.name.textColor = LabelColor9;
    //    cell.imgView.image =nil;
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
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
        view.label.text = self.rightArr[indexPath.section][@"w_name_tw"];//section
        view.delegate = self;
        view.tag = indexPath.section;
        UITapGestureRecognizer *singleTap =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionView:)];
        singleTap.numberOfTapsRequired = 1; //点击次数
        singleTap.numberOfTouchesRequired = 1; //点击手指数
        [view addGestureRecognizer:singleTap];
    }
    return view;
    
}
- (void)sectionView:(UITapGestureRecognizer *)tap{
    NSLog(@"%@",self.rightArr[tap.view.tag]);
    EbayGoodsListViewController * gvc = [[EbayGoodsListViewController alloc]init];
    gvc.hidesBottomBarWhenPushed = YES;
    gvc.pageIndex =0;
    gvc.isSearch = NO;
    gvc.platform = @"5";
    gvc.classId = self.rightArr[tap.view.tag][@"w_categoryid"];
    [self.navigationController pushViewController:gvc animated:YES];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(rightT, [Unity countcoordinatesH:40]);
}
//
//-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    if (!self.isScrollDown && collectionView.dragging) {
//        [self selectRowAtIndexPath:indexPath.section];
//    }
//}
//
//
//-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (self.isScrollDown && collectionView.dragging) {
//        [self selectRowAtIndexPath:indexPath.section];
//    }
//}
//// CollectionView分区标题即将展示
//- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
//    // 当前CollectionView滚动的方向向上，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
//    if (!_isScrollDown && collectionView.dragging) {
//        [self selectRowAtIndexPath:indexPath.section];
//    }
//}

//// CollectionView分区标题展示结束
//- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath {
//
//    // 当前CollectionView滚动的方向向下，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
//    if ( _isScrollDown && collectionView.dragging) {
//        [self selectRowAtIndexPath:indexPath.section + 1];
//    }
//}

//// 当拖动CollectionView的时候，处理TableView
//- (void)selectRowAtIndexPath:(NSInteger)index {
//    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
//}

//#pragma mark - UIScrollView Delegate
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    static float lastOffSetY = 0;
//    if (self.rightCollectionView == scrollView) {
//        self.isScrollDown = lastOffSetY < scrollView.contentOffset.y;
//        lastOffSetY = scrollView.contentOffset.y;
//    }
//}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",self.rightArr[indexPath.section][@"son_category"][indexPath.row]);
    EbayGoodsListViewController * gvc = [[EbayGoodsListViewController alloc]init];
    gvc.hidesBottomBarWhenPushed = YES;
    gvc.pageIndex =0;
    gvc.isSearch = NO;
    gvc.platform = @"5";
    gvc.classId = self.rightArr[indexPath.section][@"son_category"][indexPath.row][@"w_categoryid"];
    [self.navigationController pushViewController:gvc animated:YES];
    //
    //    if (indexPath.section == 0) {
    //        if (indexPath.row == 0) {
    //            NSLog(@"别摸我");
    //        }
    //    }
//    NSLog(@"%ld分组 %ld单元格",indexPath.section,indexPath.row);
    //    NSLog(@"%@",rightArr[indexPath.section][indexPath.row]);
}
//- (void)moreClick:(NSString *)title{
//    NSLog(@"%@",title);
//}

- (void)requestClassifyData{
    [self.aAnimation startAround];
    NSDictionary *params = @{@"platform":@"5"};
    [GZMrequest getWithURLString:[GZMUrl get_classify_url] parameters:params success:^(NSDictionary *data) {
        [self.aAnimation stopAround];
        NSLog(@"%@",data);
        
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            [self.rightCollectionView.mj_header endRefreshing];
            self.leftArr = data[@"data"];
            [self.leftTableView reloadData];
            [self requesOtherClass:self.leftArr[0][@"id"]];
            //默认选中第一个
            NSInteger selectedIndex = 0;
            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
            [self.leftTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }else{
            [self.altView showAlertView];
            self.altView.msgL.text = [data objectForKey:@"msg"];
        }
    } failure:^(NSError *error) {
        [self.aAnimation stopAround];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)requesOtherClass:(NSString *)categoryid{
    [self.aAnimation startAround];
    NSDictionary *params = @{@"platform":@"5",@"parent":categoryid};
    [GZMrequest getWithURLString:[GZMUrl get_otherclassify_url] parameters:params success:^(NSDictionary *data) {
        [self.aAnimation stopAround];
        NSLog(@"%@",data);
        
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            self.rightArr = data[@"data"];
            [self.rightCollectionView reloadData];
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
- (NSArray *)leftArr{
    if (!_leftArr) {
        _leftArr = [NSArray new];
    }
    return _leftArr;
}
- (NSArray *)rightArr{
    if (!_rightArr) {
        _rightArr = [NSArray new];
    }
    return _rightArr;
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
