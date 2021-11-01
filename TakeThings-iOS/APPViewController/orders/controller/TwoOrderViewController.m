//
//  TwoOrderViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/7.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "TwoOrderViewController.h"
#import "NoData.h"
#import "NewOrderCell1.h"
#import "OrderInfoViewController.h"
#import "NewOrderDetailViewController.h"
#import "NewYahooDetailViewController.h"
#import "NewEbayDetailViewController.h"
#import "PrecelDetailViewController.h"
#import "NewSendDetailViewController.h"
@interface TwoOrderViewController ()<UITableViewDelegate,UITableViewDataSource,NoDataDelegate,NewOrderCell1Delegate,OrderInfoDelegate,NewSendDelegate,NewOrderDetailDelegate>
{
    NSInteger pageNumber;
    NSString * status_id;
    NSString * bid_mode;//竞价方式 默认0  1立即出价，2结标前出价
    NSString * order;//默认1委托单创建时间倒序，2结标时间倒序
    NSString * source;// 'yahoo','ebay'
    NSString * add_return;//退款成功 默认0
}
@property (nonatomic , strong) UIButton * jpBtn;
@property (nonatomic , strong) UIButton * usaBtn;
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) NSMutableArray * listArray;

@property (nonatomic , strong) NoData * nData;
@end

@implementation TwoOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView:) name:@"OrderlList1" object:nil];
    pageNumber = 0;
    source = @"yahoo";
    order = @"2";
    bid_mode = @"0";
    add_return = @"0";
    status_id = @"115,120,123,125,127,130,140";
    self.view.backgroundColor = [Unity getColor:@"f0f0f0"];
    [self.view addSubview:self.jpBtn];
    [self.view addSubview:self.usaBtn];
    [self.view addSubview:self.tableView];
}
- (void)refreshTableView:(NSNotification *)notification {
//    NSLog(@"%@",notification.object);
//    if ([notification.object[@"time"] intValue] == 0) {
//        order = @""
//    }else if ([notification.object[@"time"] intValue] == 1){
//        order = @"1";
//    }else if ([notification.object[@"time"] intValue] == 2){
//        order = @"4";
//    }else{
//        order = @"2";
//    }
    order = [NSString stringWithFormat:@"%d",[notification.object[@"time"] intValue]+1];
    if ([notification.object[@"status"] intValue] == 0) {
        status_id = @"115,120,123,125,127,130,140";
        
    }else if ([notification.object[@"status"] intValue] == 1){
        status_id = @"115";
        
    }else if ([notification.object[@"status"] intValue] == 2){
        status_id = @"120";
        
    }else if ([notification.object[@"status"] intValue] == 3){
        status_id = @"100,120";
        add_return = @"1";
        
    }else if ([notification.object[@"status"] intValue] == 4){
        status_id = @"123";
        
    }else if ([notification.object[@"status"] intValue] == 5){
        status_id = @"125";
        
    }else if ([notification.object[@"status"] intValue] == 6){
        status_id = @"127";
        
    }else{
        status_id = @"130";
    }
    
    if ([notification.object[@"type"] intValue] == 2) {
        bid_mode = @"0";
    }else if ([notification.object[@"type"] intValue] ==0){
        bid_mode = @"2";
    }else{
        bid_mode = @"1";
    }
    pageNumber = 1;
    [self.listArray removeAllObjects];
    [self requestOrderlist:pageNumber];
}
- (UIButton *)jpBtn{
    if (!_jpBtn) {
        _jpBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-[Unity countcoordinatesW:200])/3, [Unity countcoordinatesH:5], [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        [_jpBtn addTarget:self action:@selector(jpbtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_jpBtn setTitle:@"日本竞拍" forState:UIControlStateNormal];
        [_jpBtn setTitleColor:LabelColor9 forState:UIControlStateNormal];
        [_jpBtn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateSelected];
        _jpBtn.layer.cornerRadius = _jpBtn.height/2;
        _jpBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        _jpBtn.layer.borderWidth = 1;
        _jpBtn.selected = YES;
        _jpBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _jpBtn;
}
- (UIButton *)usaBtn{
    if (!_usaBtn) {
        _usaBtn = [[UIButton alloc]initWithFrame:CGRectMake(_jpBtn.right+(SCREEN_WIDTH-[Unity countcoordinatesW:200])/3, [Unity countcoordinatesH:5], [Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        [_usaBtn addTarget:self action:@selector(usabtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_usaBtn setTitle:@"美国竞拍" forState:UIControlStateNormal];
        [_usaBtn setTitleColor:LabelColor9 forState:UIControlStateNormal];
        [_usaBtn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateSelected];
        _usaBtn.layer.cornerRadius = _jpBtn.height/2;
        _usaBtn.layer.borderColor = LabelColor9.CGColor;
        _usaBtn.layer.borderWidth = 1;
        _usaBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _usaBtn;
}
#pragma mark 初始化
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:35], SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-[Unity countcoordinatesH:75])];
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
            pageNumber = pageNumber+1;
            [self requestOrderlist:pageNumber];
        }];
        // 马上进入刷新状态
        [_tableView.mj_footer beginRefreshing];
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    }
    return _tableView;
}
- (void)loadNewData{
    [self.listArray removeAllObjects];
    [self requestOrderlist:1];
}
- (NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [NSMutableArray new];
    }
    return _listArray;
}
#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.listArray[indexPath.row][@"advance_rate"] floatValue] > 0) {//预付款商品
        return [Unity countcoordinatesH:342];
    }
    return [Unity countcoordinatesH:312];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellidentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    NewOrderCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil) {
        cell = [[NewOrderCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configWithData:self.listArray[indexPath.row]];
    cell.delegate = self;
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewOrderDetailViewController * nvc = [[NewOrderDetailViewController alloc]init];
    nvc.delegate = self;
    nvc.dataDic = self.listArray[indexPath.row];
    nvc.orderId = self.listArray[indexPath.row][@"id"];
    nvc.oldUrl = self.listArray[indexPath.row][@"goods_url"];
    [self.navigationController pushViewController:nvc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [Unity countcoordinatesH:10];
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [UIView new];
    return footer;
}
- (NoData *)nData{
    if (!_nData) {
        _nData = [NoData setNoData:self.view];
        _nData.delegate = self;
    }
    return _nData;
}
#pragma mark --nodatadelegate--
- (void)pushHome{
    self.tabBarController.selectedIndex =0;
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark ---顶部 日本 美国竞拍按钮事件---

- (void)jpbtnClick{
    source = @"yahoo";
    _jpBtn.selected = YES;
    _jpBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
    _usaBtn.selected = NO;
    _usaBtn.layer.borderColor = LabelColor9.CGColor;
    
//    [self.listArray removeAllObjects];
//    pageNumber = 1;
//    [self requestOrderlist:pageNumber];

    [self.tableView.mj_header beginRefreshing];
}
- (void)usabtnClick{
    source = @"ebay";
    _jpBtn.selected = NO;
    _jpBtn.layer.borderColor = LabelColor9.CGColor;
    _usaBtn.selected = YES;
    _usaBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
    
//    [self.listArray removeAllObjects];
//    pageNumber = 1;
//    [self requestOrderlist:pageNumber];
    [self.tableView.mj_header beginRefreshing];
}
- (void)requestOrderlist:(NSInteger)page{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSString * url = [NSString stringWithFormat:@"%@?user=%@&order_bid_status_id=%@&bid_mode=%@&order=%@&page=%@&os=1&source=%@&add_return=%@",[GZMUrl get_newOrderList_url],userInfo[@"w_email"],status_id,bid_mode,order,[NSString stringWithFormat:@"%ld",(long)page],source,add_return];
    NSDictionary * dic = @{@"login_token":userInfo[@"token"]};
    [GZMrequest postWithURLString:url parameters:dic success:^(NSDictionary *data) {
        NSLog(@"%@",data);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([data[@"data"] count] <20) {
            //显示没有更多数据
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        for (int i=0; i<[data[@"data"] count]; i++) {
            [self.listArray addObject:data[@"data"][i]];
        }
        if (self.listArray.count == 0) {
            self.nData.imageView.image = [UIImage imageNamed:@"nodata"];
            self.nData.msgLabel.text = @"您还没有相关包裹，快去挑选吧~";
            [self.nData.homeBtn setTitle:@"逛逛首页" forState:UIControlStateNormal];
            [self.nData showNoData];
        }else{
            [self.nData hiddenNoData];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
#pragma mark newOrderCell1Delegate
//商品详情
- (void)goodsDetailT:(NewOrderCell1 *)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if ([self.listArray[indexPath.row][@"currency"] isEqualToString:@"円"]) {//日本
        NewYahooDetailViewController * nvc = [[NewYahooDetailViewController alloc]init];
        nvc.item = self.listArray[indexPath.row][@"auction_id"];
        nvc.platform = @"0";
        [self.navigationController pushViewController:nvc animated:YES];
    }else{
        NewEbayDetailViewController * nvc = [[NewEbayDetailViewController alloc]init];
        nvc.item = self.listArray[indexPath.row][@"auction_id"];
        nvc.platform = @"5";
        [self.navigationController pushViewController:nvc animated:YES];
    }
}
- (void)goodsSettlement:(NewOrderCell1 *)cell WithTag:(NSInteger)tag{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (tag == 1) {//委托单结算
        OrderInfoViewController * ovc = [[OrderInfoViewController alloc]init];
        ovc.delegate = self;
        ovc.dataDic = self.listArray[indexPath.row];
        ovc.delegate = self;
        [self.navigationController pushViewController:ovc animated:YES];
    }else if (tag == 2){//委托单详情
        NewOrderDetailViewController * nvc = [[NewOrderDetailViewController alloc]init];
        nvc.delegate = self;
        nvc.dataDic = self.listArray[indexPath.row];
        nvc.orderId = self.listArray[indexPath.row][@"id"];
        nvc.oldUrl = self.listArray[indexPath.row][@"goods_url"];
        [self.navigationController pushViewController:nvc animated:YES];
    }else if (tag == 3){//通知发货
        NewSendDetailViewController * svc = [[NewSendDetailViewController alloc]init];
        if ([self.listArray[indexPath.row][@"source"] isEqualToString:@"yahoo"]) {
            svc.kdArray = @[@"EMS",@"SAL",@"海运"];
        }else{
            svc.kdArray = @[@"UCS"];
        }
        svc.id_arr = @[self.listArray[indexPath.row][@"id"]];
        svc.source = self.listArray[indexPath.row][@"source"];
        svc.delegate = self;
        [self.navigationController  pushViewController:svc animated:YES];
    }else{//包裹详情
        PrecelDetailViewController * pvc = [[PrecelDetailViewController alloc]init];
        pvc.bg_id = self.listArray[indexPath.row][@"transport_id"];
        [self.navigationController pushViewController:pvc animated:YES];
    }
}
#pragma mark --orderInfoDelegate--
- (void)loadTwoPage{
    [self.listArray removeAllObjects];
    pageNumber = 1;
    [self requestOrderlist:pageNumber];
}
//发货详情代理
- (void)reloadTableView{
    pageNumber = 1;
    [self.listArray removeAllObjects];
    [self requestOrderlist:pageNumber];
}
- (void)successJiesuan{//结算成功刷新列表
    pageNumber = 1;
    [self.listArray removeAllObjects];
    [self requestOrderlist:pageNumber];
}
@end
