//
//  HTOneViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/17.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "HTOneViewController.h"
#import "NoData.h"
#import "HaitaoListCell1.h"
#import "ServiceViewController.h"
#import "HaitaoDetailViewController.h"
#import "HaitaoPaymentViewController.h"
@interface HTOneViewController ()<NoDataDelegate,UITableViewDelegate,UITableViewDataSource,HaitaoListCell1lDelegate,HaitaoPaymentDelegate>
{
    NSInteger  pageNumber;
    NSString * order;//排序 1创建时间倒叙
    NSString * order_bid_status_id;
}
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) NSMutableArray * listArray;
@property (nonatomic , strong) NoData * nData;
@end

@implementation HTOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView:) name:@"haitaoList0" object:nil];
    pageNumber = 0;
    order = @"1";
    order_bid_status_id = @"10,115";
    self.view.backgroundColor = [Unity getColor:@"f0f0f0"];
    [self.view addSubview:self.tableView];
}
- (void)refreshTableView:(NSNotification *)notification {
    if ([notification.object[@"time"] intValue] == 1) {
        order = @"1";
    }else{
        order = @"2";
    }
    if ([notification.object[@"status"] intValue] == 0) {
        order_bid_status_id = @"10,115";
        
    }else if ([notification.object[@"status"] intValue] == 1){
        order_bid_status_id = @"10";
        
    }else if ([notification.object[@"status"] intValue] == 2){
        order_bid_status_id = @"30";
        
    }else{
        order_bid_status_id = @"115";
    }
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
         //马上进入刷新状态
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
    
    return [Unity countcoordinatesH:257];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellidentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    HaitaoListCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil) {
        cell = [[HaitaoListCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configWithData:self.listArray[indexPath.row]];
    cell.delegate = self;
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HaitaoDetailViewController * nvc = [[HaitaoDetailViewController alloc]init];
//    nvc.delegate = self;
//    nvc.dataDic = self.listArray[indexPath.row];
//    nvc.orderId = self.listArray[indexPath.row][@"id"];
//    nvc.oldUrl = self.listArray[indexPath.row][@"goods_url"];
//    nvc.page = 1;
    nvc.haitaoId = self.listArray[indexPath.row][@"id"];
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


#pragma mark - HaitaoListCell1Delegate
- (void)cancel:(HaitaoListCell1 *)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary * dic = @{@"order_id":self.listArray[indexPath.row][@"id"]};
    [GZMrequest getWithURLString:[GZMUrl get_haitaoCancel_url] parameters:dic success:^(NSDictionary *data) {
        NSLog(@"%@",data);
        if ([data[@"status"] intValue] == 0) {
            //删除成功刷新  询价列表和已结束列表
            pageNumber = 1;
            [self.listArray removeAllObjects];
            [self requestOrderlist:pageNumber];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"threeUpdate" object:nil];
        }
        [WHToast showMessage:data[@"mes"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    } failure:^(NSError *error) {
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)onlineService{
    ServiceViewController * svc = [[ServiceViewController alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
}
- (void)payment:(HaitaoListCell1 *)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    HaitaoPaymentViewController * hvc = [[HaitaoPaymentViewController alloc]init];
    hvc.dataDic = self.listArray[indexPath.row];
    hvc.delegate = self;
    [self.navigationController pushViewController:hvc animated:YES];

}
- (void)requestOrderlist:(NSInteger)page{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"login_token":userInfo[@"token"],@"user":userInfo[@"w_email"],@"order":order,@"page":[NSString stringWithFormat:@"%ld",(long)page],@"order_bid_status_id":order_bid_status_id};
    [GZMrequest postWithURLString:[GZMUrl get_haitaoList_url] parameters:dic success:^(NSDictionary *data) {
        NSLog(@"%@",data);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([data[@"data"] count] <10) {
            //显示没有更多数据
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        for (int i=0; i<[data[@"data"] count]; i++) {
            [self.listArray addObject:data[@"data"][i]];
        }
        if (self.listArray.count == 0) {
            self.nData.imageView.image = [UIImage imageNamed:@"nodata"];
            self.nData.msgLabel.text = @"您还没有相关委托，快去挑选吧~";
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
/*
支付成功 返回刷新列表
*/
- (void)reloadList{
    [self.listArray removeAllObjects];
    [self requestOrderlist:1];
}
@end
