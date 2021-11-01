//
//  HTThreeViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/17.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "HTThreeViewController.h"
#import "NoData.h"
#import "HaitaoListCell3.h"
#import "HaitaoDetailViewController.h"
#import "WebViewController.h"
@interface HTThreeViewController ()<NoDataDelegate,UITableViewDelegate,UITableViewDataSource,HaitaoListCell3lDelegate>
{
    NSInteger  pageNumber;
    NSString * order;//排序 1创建时间倒叙
    NSString * order_bid_status_id;
//    NSString * is_refund;//已退款
//    NSString * is_invalid;//已失效
//    NSString * is_cancel;//已取消
}
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) NSMutableArray * listArray;
@property (nonatomic , strong) NoData * nData;
@end

@implementation HTThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView:) name:@"haitaoList2" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(comfirmDelete) name:@"threeUpdate" object:nil];
    pageNumber = 0;
//    is_refund = @"1";
//    is_invalid = @"1";
//    is_cancel = @"1";
    order= @"1";
    order_bid_status_id = @"410,420,430,220";
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
//        is_refund = @"1";
//        is_invalid = @"1";
//        is_cancel = @"1";
        order_bid_status_id = @"410,420,430,220";
        
    }else if ([notification.object[@"status"] intValue] == 1){
//        is_refund = @"1";
//        is_invalid = @"0";
//        is_cancel = @"0";
        order_bid_status_id = @"430";
        
    }else if ([notification.object[@"status"] intValue] == 2){
//        is_refund = @"0";
//        is_invalid = @"1";
//        is_cancel = @"0";
        order_bid_status_id = @"420";
        
    }else if ([notification.object[@"status"] intValue] == 3){
//        is_refund = @"0";
//        is_invalid = @"0";
//        is_cancel = @"1";
        order_bid_status_id = @"410";
        
    }else{
//        is_refund = @"0";
//        is_invalid = @"0";
//        is_cancel = @"0";
        order_bid_status_id = @"220";
    }
    pageNumber = 1;
    [self.listArray removeAllObjects];
    [self requestOrderlist:pageNumber];
}
//从询价中删除商品成功  通知已结束页面刷新
- (void)comfirmDelete{
    [self loadNewData];
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
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    }
    return _tableView;
}
- (void)loadNewData{
    pageNumber = 1;
    [self.listArray removeAllObjects];
    [self requestOrderlist:pageNumber];
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
    HaitaoListCell3 *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil) {
        cell = [[HaitaoListCell3 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
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
#pragma mark - HaitaoListCell3Delegate
- (void)deleteOrder:(HaitaoListCell3 *)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary * dic = @{@"order_id":self.listArray[indexPath.row][@"id"]};
    [Unity showanimate];
    [GZMrequest getWithURLString:[GZMUrl get_haitaoDelete_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([data[@"status"] intValue] == 0) {
            [self.listArray removeAllObjects];
            pageNumber = 1;
            [self requestOrderlist:pageNumber];
        }
        [WHToast showMessage:data[@"mes"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}

- (void)oldPage1:(HaitaoListCell3 *)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    WebViewController * wvc = [[WebViewController alloc]init];
    wvc.webUrl =[NSString stringWithFormat:@"%@/index/order_bid/getyahoo?url=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"new_sdxurl"],self.listArray[indexPath.row][@"source_url"]];
    [self.navigationController pushViewController:wvc animated:YES];
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
@end
