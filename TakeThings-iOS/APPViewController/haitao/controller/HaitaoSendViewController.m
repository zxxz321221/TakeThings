//
//  HaitaoSendViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/3/6.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "HaitaoSendViewController.h"
#import "NoData.h"
#import <MJExtension.h>
#import "HaitaoSendCell.h"
//#import "Prompt.h"
#import "NewSendDetailViewController.h"
#import "CWScrollView.h"
#import "CWTableViewInfo.h"
#import "UIViewController+CWLateralSlide.h"
#import "HaitaoSendModel.h"
#import "HaitaoSendScreenViewController.h"
#import "WebViewController.h"
#define bottomH (IS_iPhoneX ? [Unity countcoordinatesH:70] : [Unity countcoordinatesH:50])

@interface HaitaoSendViewController ()<UITableViewDelegate,UITableViewDataSource,NoDataDelegate,HaitaoSendCellDelegate,NewSendDelegate,HaitaoSendScreenDelegate>
{
    NSInteger pageNumber;
    NSString * area;//默认0 日本yahoo  美国ebay
    NSString * order;//默认1委托单创建时间倒序
    NSInteger order_id;
}
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) UIView * headerView;
@property (nonatomic , strong) UIButton * japanBtn;
@property (nonatomic , strong) UIButton * usaBtn;
@property (nonatomic , strong) UIView * bottomView;
@property (nonatomic , strong) UIButton * allSeletedBtn;

@property (nonatomic , strong) NSMutableArray * listArray;
@property (nonatomic , strong) NSMutableArray * modelArrs;//模型数组
//@property (nonatomic , strong) Prompt * pView;
@property (nonatomic , strong) NoData * nData;
@end

@implementation HaitaoSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通知发货";
    pageNumber = 1;
    order_id = 1;
    order = @"1";
    area = @"円";

    self.view.backgroundColor = [Unity getColor:@"#f0f0f0"];
    [self creareUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addRightBarButtonWithFirstImage:[UIImage imageNamed:@"bgsx"] action:@selector(sxClick)];
}
- (void)sxClick{
    HaitaoSendScreenViewController *vc = [[HaitaoSendScreenViewController alloc] init];
    vc.delegate = self;
    vc.order = order_id;
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration defaultConfiguration];
    conf.direction = CWDrawerTransitionFromRight;
    conf.showAnimDuration = 1.0f;
    [self cw_showDrawerViewController:vc animationType:CWDrawerAnimationTypeMask configuration:conf];
}

//右侧一个图片按钮的情况
- (void)addRightBarButtonWithFirstImage:(UIImage *)firstImage action:(SEL)action{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.frame = CGRectMake(0, 0, 44, 44);
    [firstButton setImage:firstImage forState:UIControlStateNormal];
    [firstButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    firstButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5 * SCREEN_WIDTH / 375.0)];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:firstButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)creareUI{
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    self.nData.imageView.image = [UIImage imageNamed:@"nodata"];
    self.nData.msgLabel.text = @"您还没有相关委托单，快去挑选吧~";
    [self.nData.homeBtn setTitle:@"逛逛首页" forState:UIControlStateNormal];
    [self.nData showNoData];
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        _headerView.backgroundColor = [UIColor whiteColor];
        [_headerView addSubview:self.japanBtn];
        [_headerView addSubview:self.usaBtn];
    }
    return _headerView;
}
- (UIButton *)japanBtn{
    if (!_japanBtn) {
        _japanBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], [Unity countcoordinatesH:10], (SCREEN_WIDTH-[Unity countcoordinatesW:45])/2, [Unity countcoordinatesH:30])];
        [_japanBtn addTarget:self action:@selector(japanClick) forControlEvents:UIControlEventTouchUpInside];
        [_japanBtn setTitle:@"日本已发货" forState:UIControlStateNormal];
        _japanBtn.layer.cornerRadius = _japanBtn.height/2;
        _japanBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        _japanBtn.layer.borderWidth = 1;
        _japanBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        [_japanBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_japanBtn setTitleColor:LabelColor9 forState:UIControlStateSelected];
    }
    return _japanBtn;
}
- (UIButton *)usaBtn{
    if (!_usaBtn) {
        _usaBtn = [[UIButton alloc]initWithFrame:CGRectMake(_japanBtn.right+[Unity countcoordinatesW:15], _japanBtn.top, _japanBtn.width, _japanBtn.height)];
        [_usaBtn addTarget:self action:@selector(usaClick) forControlEvents:UIControlEventTouchUpInside];
        [_usaBtn setTitle:@"美国已发货" forState:UIControlStateNormal];
        _usaBtn.layer.cornerRadius = _usaBtn.height/2;
        _usaBtn.layer.borderColor = [Unity getColor:@"f0f0f0"].CGColor;
        _usaBtn.layer.borderWidth = 1;
        _usaBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _usaBtn.backgroundColor = [Unity getColor:@"f0f0f0"];
        [_usaBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_usaBtn setTitleColor:LabelColor9 forState:UIControlStateSelected];
        _usaBtn.selected = YES;
    }
    return _usaBtn;
}
#pragma  mark 顶部2个按钮事件处理
- (void)japanClick{
    if ([area isEqualToString:@"円"]) {
        return;
    }
    self.japanBtn.selected = NO;
    self.usaBtn.selected = YES;
    self.japanBtn.backgroundColor = [UIColor whiteColor];
    self.japanBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
    self.usaBtn.backgroundColor = [Unity getColor:@"f0f0f0"];
    self.usaBtn.layer.borderColor = [Unity getColor:@"f0f0f0"].CGColor;
    pageNumber = 1;
    area = @"円";
    [self.listArray removeAllObjects];
    [self requestOrderlist:pageNumber];
    self.allSeletedBtn.selected = NO;
}
- (void)usaClick{
    if ([area isEqualToString:@"USD"]) {
        return;
    }
    self.japanBtn.selected = YES;
    self.usaBtn.selected = NO;
    self.japanBtn.backgroundColor = [Unity getColor:@"f0f0f0"];
    self.japanBtn.layer.borderColor = [Unity getColor:@"f0f0f0"].CGColor;
    self.usaBtn.backgroundColor = [UIColor whiteColor];
    self.usaBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
    pageNumber = 1;
    area = @"USD";
    [self.listArray removeAllObjects];
    [self requestOrderlist:pageNumber];
    self.allSeletedBtn.selected = NO;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _headerView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-[Unity countcoordinatesH:50]-bottomH)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate=self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = FALSE;
        _tableView.showsHorizontalScrollIndicator = FALSE;
        [_tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        //没有数据时不显示cell
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [_tableView.mj_footer beginRefreshing];
            [self requestOrderlist:pageNumber];
        }];
        // 马上进入刷新状态
        [_tableView.mj_footer beginRefreshing];
    }
    return _tableView;
}
#pragma mark - tableView  搭理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.modelArrs.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [Unity countcoordinatesH:257];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HaitaoSendCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HaitaoSendCell class])];
    if (cell == nil) {
        cell = [[HaitaoSendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HaitaoSendCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.modelArrs[indexPath.row];
    cell.delegate = self;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [Unity countcoordinatesH:10];
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [UIView new];
    
    return footer;
}

- (NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [NSMutableArray new];
    }
    return _listArray;
}
- (NSMutableArray *)modelArrs{
    if (!_modelArrs) {
        _modelArrs = [NSMutableArray new];
    }
    return _modelArrs;
}
//无数据初始化
- (NoData *)nData{
    if (!_nData) {
        _nData = [NoData setNoData:self.view];
        _nData.delegate = self;
    }
    return _nData;
}
- (void)pushHome{
    self.tabBarController.selectedIndex =0;
    [self.navigationController popViewControllerAnimated:NO];
}
//#pragma mark - bottomView 创建
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-bottomH-NavBarHeight, SCREEN_WIDTH, bottomH)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        line.backgroundColor = [Unity getColor:@"#e0e0e0"];
        [_bottomView addSubview:line];

        [_bottomView addSubview:self.allSeletedBtn];

        UIButton * delete = [Unity buttonAddsuperview_superView:_bottomView _subViewFrame:CGRectMake(self.allSeletedBtn.right+[Unity countcoordinatesW:10], [Unity countcoordinatesH:7], [Unity countcoordinatesW:210], [Unity countcoordinatesH:35]) _tag:self _action:@selector(fahuoClick) _string:@"发货" _imageName:@""];
        delete.backgroundColor = [Unity getColor:@"#aa112d"];
        delete.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        [delete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        delete.layer.cornerRadius = delete.height/2;
    }
    return _bottomView;
}
- (void)requestOrderlist:(NSInteger)page{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"login_token":userInfo[@"token"],@"user":userInfo[@"w_email"],@"order":order,@"page":[NSString stringWithFormat:@"%ld",(long)page],@"order_bid_status_id":@"130",@"currency":area};
    [GZMrequest postWithURLString:[GZMUrl get_haitaoList_url] parameters:dic success:^(NSDictionary *data) {
        [self.tableView.mj_footer endRefreshing];
        pageNumber = pageNumber+1;
        if ([data[@"data"] count] <10) {
            //显示没有更多数据
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        for (int i=0; i<[data[@"data"] count]; i++) {
            NSMutableDictionary * dic = [NSMutableDictionary new];
            [dic setObject:data[@"data"][i][@"order_code"] forKey:@"order_code"];
            [dic setObject:data[@"data"][i][@"exchange_rate"] forKey:@"exchange_rate"];
            [dic setObject:data[@"data"][i][@"order_bid_status_id"] forKey:@"order_bid_status_id"];
            [dic setObject:data[@"data"][i][@"goods_name"] forKey:@"goods_name"];
            [dic setObject:data[@"data"][i][@"goods_num"] forKey:@"goods_num"];
            [dic setObject:data[@"data"][i][@"goods_price"] forKey:@"goods_price"];
            [dic setObject:data[@"data"][i][@"currency"] forKey:@"currency"];
            [dic setObject:data[@"data"][i][@"create_time"] forKey:@"create_time"];
            [dic setObject:data[@"data"][i][@"price_true"] forKey:@"price_true"];
            [dic setObject:data[@"data"][i][@"source_url"] forKey:@"source_url"];
            [dic setObject:data[@"data"][i][@"id"] forKey:@"num_id"];
            [dic setObject:@"0" forKey:@"isSelect"];
            [self.listArray addObject:dic];
        }
        if (self.listArray.count == 0) {
            self.nData.imageView.image = [UIImage imageNamed:@"nodata"];
            self.nData.msgLabel.text = @"您还没有相关委托单，快去挑选吧~";
            [self.nData.homeBtn setTitle:@"逛逛首页" forState:UIControlStateNormal];
            [self.nData showNoData];
        }else{
            [self.nData hiddenNoData];
        }
        [self.modelArrs removeAllObjects];
        self.modelArrs = [HaitaoSendModel mj_objectArrayWithKeyValuesArray:self.listArray];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
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
/**
 *  cell的代理方法
 *
 *  @param cell     cell可以拿到indexpath
 *  @param selectBt 选中按钮
 */
- (void)seleteCellDelegate:(HaitaoSendCell *)cell WithSelectButton:(UIButton *)selectBt
{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    NSLog(@"indexpath%@",indexPath);
    HaitaoSendModel * model = self.modelArrs[indexPath.row];
    model.isSelect = !selectBt.selected;

    NSString * isS = @"0";
    NSLog(@"ifReadOnly value: %@" ,model.isSelect?@"YES":@"NO");
    if (model.isSelect) {
        isS = @"1";
    }
    //在这里修改 元数据里的状态 默认0 不编辑 改成1   后期点击删除   状态为1的全删
    NSMutableDictionary * dic = [self.listArray[indexPath.row] mutableCopy];
    [dic setObject:isS forKey:@"isSelect"];
    [self.listArray replaceObjectAtIndex:indexPath.row withObject:dic];

    [self isallSelectAllPrice];
    [self.tableView reloadData];
}
/**
 *  遍历所有是否全选
 */
- (void)isallSelectAllPrice
{
    NSInteger count = 0;
        for (HaitaoSendModel * model in self.modelArrs)
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
    if (count == self.modelArrs.count) {
        self.allSeletedBtn.selected = YES;
    }
}
- (void)allisSeleted:(BOOL)isSeleted{
    if (isSeleted) {
        for (HaitaoSendModel * model in self.modelArrs)
        {
            model.isSelect = YES;
        }
        for (int i=0;i<self.listArray.count; i++) {
            NSMutableDictionary * dic = [self.listArray[i] mutableCopy];
            [dic setObject:@"1" forKey:@"isSelect"];
            [self.listArray replaceObjectAtIndex:i withObject:dic];
        }
    }else{
        for (HaitaoSendModel * model in self.modelArrs)
        {
            model.isSelect = NO;
        }
        for (int i=0;i<self.listArray.count; i++) {
            NSMutableDictionary * dic = [self.listArray[i] mutableCopy];
            [dic setObject:@"0" forKey:@"isSelect"];
            [self.listArray replaceObjectAtIndex:i withObject:dic];
        }
    }
    [self.tableView reloadData];
}
//- (Prompt *)pView{
//    if (!_pView) {
//        UIWindow * window = [UIApplication sharedApplication].windows[0];
//        _pView = [Prompt setPrompt:window];
//    }
//    return _pView;
//}
- (void)fahuoClick{
    NSLog(@"发货");
    NSMutableArray * array = [NSMutableArray new];
        for (int i=0; i<self.listArray.count; i++) {
            if ([self.listArray[i][@"isSelect"] isEqualToString:@"1"]) {
                [array addObject:self.listArray[i]];
            }
        }
        if (array.count == 0) {
            return;
        }
        
        NSMutableArray * arr1 = [NSMutableArray new];
        for (int i=0; i<array.count; i++) {
            [arr1 addObject:array[i][@"num_id"]];
        }
        NewSendDetailViewController * dvc = [[NewSendDetailViewController alloc]init];
        dvc.id_arr = [arr1 copy];
        dvc.isNew = YES;
        if ([array[0][@"currency"]isEqualToString:@"円"]) {//yahoo
            dvc.kdArray = @[@"EMS",@"SAL",@"海运"];//132
            dvc.source = @"yahoo";
        }else{//ebay
            dvc.kdArray = @[@"UCS"];
            dvc.source = @"ebay";
        }
        dvc.delegate = self;
        [self.navigationController pushViewController:dvc animated:YES];
}
- (void)reloadTableView{
    pageNumber = 1;
    [self.listArray removeAllObjects];
    [self.modelArrs removeAllObjects];
    [self requestOrderlist:pageNumber];
    self.allSeletedBtn.selected = NO;
}
- (void)haitaoSend:(HaitaoSendCell *)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    NewSendDetailViewController * dvc = [[NewSendDetailViewController alloc]init];
    dvc.id_arr = @[self.listArray[indexPath.row][@"num_id"]];
    dvc.isNew = YES;
    if ([self.listArray[indexPath.row][@"currency"]isEqualToString:@"円"]) {//yahoo
        dvc.kdArray = @[@"EMS",@"SAL",@"海运"];//132
        dvc.source = @"yahoo";
    }else{//ebay
        dvc.kdArray = @[@"UCS"];
        dvc.source = @"ebay";
    }
    dvc.delegate = self;
    [self.navigationController pushViewController:dvc animated:YES];
    
}
- (void)haitaoOldPage:(HaitaoSendCell *)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    WebViewController * wvc = [[WebViewController alloc]init];
    wvc.webUrl =[NSString stringWithFormat:@"%@/index/order_bid/getyahoo?url=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"new_sdxurl"],self.listArray[indexPath.row][@"source_url"]];
    [self.navigationController pushViewController:wvc animated:YES];
}
- (void)haitaoSendScreen:(NSInteger)time{
    if (time == 1) {
        order = @"1";
    }else{
        order = @"2";
    }
    pageNumber = 1;
    [self.listArray removeAllObjects];
    [self requestOrderlist:pageNumber];
}
@end
