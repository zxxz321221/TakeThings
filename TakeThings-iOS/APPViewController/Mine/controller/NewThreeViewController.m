//
//  NewThreeViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/11/28.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "NewThreeViewController.h"
#import "NewOneCell.h"
#import "NewTwoCell.h"
#import "NoData.h"
#import "PrecelDetailViewController.h"
#import "KdJapanViewController.h"
#import "KdPostalViewController.h"
@interface NewThreeViewController ()<UITableViewDelegate,UITableViewDataSource,NoDataDelegate,NewOneCellDelegate,NewTwoCellDelegate,PrecelDetailDelegate>
{
    NSInteger pageNumber;
    NSString * sort;//时间排序 默认1 通知发货 倒序 2 发货时间倒序 3 分别发货创建正序 4 发货正序
    NSString * status_id;//默认 212 220
}
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) NSMutableArray * listArray;

@property (nonatomic , strong) NoData * nData;

@end

@implementation NewThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    sort = @"1";
    status_id = @"212,220";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendNotiClick) name:@"sendNoti" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView:) name:@"precelList2" object:nil];
    self.view.backgroundColor = [Unity getColor:@"#f0f0f0"];
    pageNumber = 0;
    [self.view addSubview:self.tableView];
}
- (void)refreshTableView:(NSNotification *)notification {
    if ([notification.object[@"time"] intValue] == 0) {
        sort = @"3";
    }else if ([notification.object[@"time"] intValue] == 1){
        sort = @"1";
    }else if ([notification.object[@"time"] intValue] == 2){
        sort = @"4";
    }else{
        sort = @"2";
    }
    if ([notification.object[@"status"] intValue] == 0) {
        status_id = @"212,220";
    }else if ([notification.object[@"status"] intValue] == 1){
        status_id = @"220";
    }else{
        status_id = @"212";
    }
    pageNumber = 1;
    [self.listArray removeAllObjects];
    [self requestOrderlist:pageNumber];
}
- (void)sendNotiClick{
    pageNumber = 1;
    [self.listArray removeAllObjects];
    [self requestOrderlist:pageNumber];
}
#pragma mark 初始化
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-[Unity countcoordinatesH:40])];
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
    }
    return _tableView;
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
    if ([self.listArray[indexPath.row][@"order_count"] intValue] == 1) {
        return [Unity countcoordinatesH:232];
    }else{
        return [Unity countcoordinatesH:222];
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellidentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    if ([self.listArray[indexPath.row][@"order_count"] intValue] == 1) {
        NewOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
            if (cell == nil) {
                cell = [[NewOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell configWithData:self.listArray[indexPath.row]];
        cell.delegate = self;
            return cell;
    }else{
        NewTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
            if (cell == nil) {
                cell = [[NewTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell configWithData:self.listArray[indexPath.row]];
        cell.delegate = self;
            return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PrecelDetailViewController * pvc = [[PrecelDetailViewController alloc]init];
//    pvc.dataDic = self.listArray[indexPath.row];
    pvc.bg_id = self.listArray[indexPath.row][@"id"];
    pvc.delegate = self;
    [self.navigationController pushViewController:pvc animated:YES];
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
#pragma mark --列表请求--
- (void)requestOrderlist:(NSInteger)page{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"user":userInfo[@"w_email"],@"page":[NSString stringWithFormat:@"%ld",(long)page],@"order_transport_status_id":status_id,@"order":sort,@"os":@"1"};
    [GZMrequest getWithURLString:[GZMUrl get_transport_List_url] parameters:dic success:^(NSDictionary *data) {
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
        [self.tableView.mj_footer endRefreshing];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
#pragma mark --cell底部按钮点击事件--
- (void)OneLogisticClick:(NewOneCell *)cell WithTag:(NSInteger)tag{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (tag == 1) {//修改地址
        NSLog(@"修改地址");
    }else if (tag == 2){//物流查询
        if ([self.listArray[indexPath.row][@"currency"] isEqualToString:@"円"]) {
            if ([self.listArray[indexPath.row][@"traffic_type"] intValue] == 5) {//空港
                KdPostalViewController * kvc = [[KdPostalViewController alloc]init];
                kvc.kd_id = self.listArray[indexPath.row][@"traffic_num"];
                [self.navigationController pushViewController:kvc animated:YES];
            }else{
                KdJapanViewController * kvc = [[KdJapanViewController alloc]init];
                kvc.kd_id = self.listArray[indexPath.row][@"traffic_num"];
                [self.navigationController pushViewController:kvc animated:YES];
            }
        }else{//美国usc
            KdJapanViewController * kvc = [[KdJapanViewController alloc]init];
            kvc.kd_id = self.listArray[indexPath.row][@"traffic_num"];
            kvc.kd_url = @"123";
            [self.navigationController pushViewController:kvc animated:YES];
        }
    }else{//退运
        NSLog(@"退运");
    }
}
- (void)OneUniversalClick:(NewOneCell *)cell WithTag:(NSInteger)tag{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (tag == 1) {//立即支付
        NSLog(@"立即支付");
    }else if (tag == 2){//包裹详情
        PrecelDetailViewController * pvc = [[PrecelDetailViewController alloc]init];
//        pvc.dataDic = self.listArray[indexPath.row];
        pvc.bg_id = self.listArray[indexPath.row][@"id"];
        pvc.delegate = self;
        [self.navigationController pushViewController:pvc animated:YES];
    }else{//确认收货
        NSLog(@"确认收货");
    }
}
- (void)TwoLogisticClick:(NewTwoCell *)cell WithTag:(NSInteger)tag{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (tag == 1) {//修改地址
        NSLog(@"修改地址");
    }else if (tag == 2){//物流查询
        if ([self.listArray[indexPath.row][@"currency"] isEqualToString:@"円"]) {
            if ([self.listArray[indexPath.row][@"traffic_type"] intValue] == 5) {//空港
                KdPostalViewController * kvc = [[KdPostalViewController alloc]init];
                kvc.kd_id = self.listArray[indexPath.row][@"traffic_num"];
                [self.navigationController pushViewController:kvc animated:YES];
            }else{
                KdJapanViewController * kvc = [[KdJapanViewController alloc]init];
                kvc.kd_id = self.listArray[indexPath.row][@"traffic_num"];
                [self.navigationController pushViewController:kvc animated:YES];
            }
        }else{//美国usc
            KdJapanViewController * kvc = [[KdJapanViewController alloc]init];
            kvc.kd_id = self.listArray[indexPath.row][@"traffic_num"];
            kvc.kd_url = @"123";
            [self.navigationController pushViewController:kvc animated:YES];
        }
    }else{//退运
        NSLog(@"退运");
    }
}
- (void)TwoUniversalClick:(NewTwoCell *)cell WithTag:(NSInteger)tag{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (tag == 1) {//立即支付
        NSLog(@"立即支付");
    }else if (tag == 2){//包裹详情
        PrecelDetailViewController * pvc = [[PrecelDetailViewController alloc]init];
//        pvc.dataDic = self.listArray[indexPath.row];
        pvc.bg_id = self.listArray[indexPath.row][@"id"];
        pvc.delegate = self;
        [self.navigationController pushViewController:pvc animated:YES];
    }else{//确认收货
        NSLog(@"确认收货");
    }
}
- (void)OneSeleteLogistics:(NSString *)num WithCell:(NewOneCell *)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
//    NSArray *array = [num componentsSeparatedByString:@" "];
    if ([self.listArray[indexPath.row][@"currency"] isEqualToString:@"円"]) {
        if ([self.listArray[indexPath.row][@"traffic_type"] intValue] == 5) {//空港
            KdPostalViewController * kvc = [[KdPostalViewController alloc]init];
            kvc.kd_id = self.listArray[indexPath.row][@"traffic_num"];
            [self.navigationController pushViewController:kvc animated:YES];
        }else{
            KdJapanViewController * kvc = [[KdJapanViewController alloc]init];
            kvc.kd_id = self.listArray[indexPath.row][@"traffic_num"];
            [self.navigationController pushViewController:kvc animated:YES];
        }
    }else{//美国usc
        KdJapanViewController * kvc = [[KdJapanViewController alloc]init];
        kvc.kd_id = self.listArray[indexPath.row][@"traffic_num"];
        kvc.kd_url = @"123";
        [self.navigationController pushViewController:kvc animated:YES];
    }
}
- (void)TwoSeleteLogistics:(NSString *)num WithCell:(NewTwoCell *)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if ([self.listArray[indexPath.row][@"currency"] isEqualToString:@"円"]) {
        if ([self.listArray[indexPath.row][@"traffic_type"] intValue] == 5) {//空港
            KdPostalViewController * kvc = [[KdPostalViewController alloc]init];
            kvc.kd_id = self.listArray[indexPath.row][@"traffic_num"];
            [self.navigationController pushViewController:kvc animated:YES];
        }else{
            KdJapanViewController * kvc = [[KdJapanViewController alloc]init];
            kvc.kd_id = self.listArray[indexPath.row][@"traffic_num"];
            [self.navigationController pushViewController:kvc animated:YES];
        }
    }else{//美国usc
        KdJapanViewController * kvc = [[KdJapanViewController alloc]init];
        kvc.kd_id = self.listArray[indexPath.row][@"traffic_num"];
        kvc.kd_url = @"123";
        [self.navigationController pushViewController:kvc animated:YES];
    }
}
/**
 precelDetailDelegate
 */
- (void)detailLoadList{
    pageNumber = 1;
    [self.listArray removeAllObjects];
    [self requestOrderlist:pageNumber];
}
@end
