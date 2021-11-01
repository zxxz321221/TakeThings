//
//  SearchResultsViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/24.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "SearchResultsViewController.h"
#import "NewOneCell.h"
#import "NewTwoCell.h"
#import "NoData.h"
#import "AddressViewController.h"
#import "KdPostalViewController.h"
#import "KdJapanViewController.h"
#import "PrecelPayDetailViewController.h"
#import "PrecelDetailViewController.h"
@interface SearchResultsViewController ()<UITableViewDelegate,UITableViewDataSource,NoDataDelegate,NewOneCellDelegate,NewTwoCellDelegate,AddressViewDelegate,PrecelPayDelegate,PrecelDetailDelegate>
{
    NSInteger pageNumber;
    NSInteger updataIndex;//记录点击修改地址的 item
}
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) NSMutableArray * listArray;

@property (nonatomic , strong) NoData * nData;

@end

@implementation SearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索包裹";
    self.view.backgroundColor = [Unity getColor:@"#f0f0f0"];
    NSLog(@"%@",self.keyWord);
    pageNumber = 0;
    [self.view addSubview:self.tableView];
}
#pragma mark 初始化
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight)];
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
    NSDictionary * dic = @{@"user":userInfo[@"w_email"],@"page":[NSString stringWithFormat:@"%ld",(long)page],@"order_transport_status_id":@"140,150,160,170,180,190,200,210,212,220",@"keyword":self.keyWord,@"os":@"1"};
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
            self.nData.msgLabel.text = @"您还没有相关委托单，快去挑选吧~";
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
// 1 立即支付 2 包裹详情 3 确认收货
// 1 修改地址 2 物流查询 3 退运
- (void)OneLogisticClick:(NewOneCell *)cell WithTag:(NSInteger)tag{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (tag == 1) {//修改地址
        updataIndex = indexPath.row;
        AddressViewController * avc = [[AddressViewController alloc]init];
        avc.page = 3;
        avc.delegate = self;
        [self.navigationController pushViewController:avc animated:YES];
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
        [self alertViewController:indexPath.row];
    }
}
- (void)OneUniversalClick:(NewOneCell *)cell WithTag:(NSInteger)tag{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (tag == 1) {//立即支付
        PrecelPayDetailViewController * pvc = [[PrecelPayDetailViewController alloc]init];
        pvc.dataDic = self.listArray[indexPath.row];
        pvc.delegate = self;
        [self.navigationController pushViewController:pvc animated:YES];
    }else if (tag == 2){//包裹详情
        PrecelDetailViewController * pvc = [[PrecelDetailViewController alloc]init];
//        pvc.dataDic = self.listArray[indexPath.row];
        pvc.bg_id = self.listArray[indexPath.row][@"id"];
        [self.navigationController pushViewController:pvc animated:YES];
    }else{//确认收货
        [self greceive_confirm_url:self.listArray[indexPath.row][@"id"]];
    }
}
- (void)TwoLogisticClick:(NewTwoCell *)cell WithTag:(NSInteger)tag{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (tag == 1) {//修改地址
        updataIndex = indexPath.row;
        AddressViewController * avc = [[AddressViewController alloc]init];
        avc.page = 3;
        avc.delegate = self;
        [self.navigationController pushViewController:avc animated:YES];
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
        [self alertViewController:indexPath.row];
    }
}
- (void)TwoUniversalClick:(NewTwoCell *)cell WithTag:(NSInteger)tag{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (tag == 1) {//立即支付
        PrecelPayDetailViewController * pvc = [[PrecelPayDetailViewController alloc]init];
        pvc.dataDic = self.listArray[indexPath.row];
        pvc.delegate = self;
        [self.navigationController pushViewController:pvc animated:YES];
    }else if (tag == 2){//包裹详情
        PrecelDetailViewController * pvc = [[PrecelDetailViewController alloc]init];
//        pvc.dataDic = self.listArray[indexPath.row];
        pvc.bg_id = self.listArray[indexPath.row][@"id"];
        [self.navigationController pushViewController:pvc animated:YES];
    }else{//确认收货
        [self greceive_confirm_url:self.listArray[indexPath.row][@"id"]];
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
#pragma mark  ---修改地址delegate---
- (void)EntrustAddress:(NSMutableArray *)list WithIndexPath:(NSInteger )indexpath{
    NSLog(@"%@",list[indexpath]);
    NSDictionary * info = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"login_token":info[@"token"],@"user":info[@"w_email"],@"get_name":list[indexpath][@"w_name"],@"get_address":[NSString stringWithFormat:@"%@ %@",list[indexpath][@"w_address"],list[indexpath][@"w_address_detail"]],@"get_postal":list[indexpath][@"postal"],@"get_phone":list[indexpath][@"w_mobile"],@"user_remark":list[indexpath][@"w_other"],@"os":@"1"};
    [Unity showanimate];
    [GZMrequest postWithURLString:[NSString stringWithFormat:@"%@?id=%@",[GZMUrl get_updateInfo_url],self.listArray[updataIndex][@"id"]] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([data[@"status"] intValue] ==0) {
            pageNumber = 1;
            [self.listArray removeAllObjects];
            [self requestOrderlist:pageNumber];
        }
        [WHToast showMessage:data[@"mes"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
//alert
- (void)alertViewController:(NSInteger)indexRow{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示!" message:@"当您的快递在运送过程中，因为一些特殊情况而发生退运时（如：清关受阻，商品限制等），您可以点击这里通知系统，以便我们为您提供后续的相关服务。" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self requestBack_confirm:indexRow];
    }];
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)requestBack_confirm:(NSInteger)indexRow{
    NSDictionary * info = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"user":info[@"w_email"],@"login_token":info[@"token"],@"transport_id":self.listArray[indexRow][@"id"],@"os":@"1"};
    [Unity showanimate];
    [GZMrequest postWithURLString:[GZMUrl get_back_confirm_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([data[@"status"] intValue] == 0) {
            pageNumber = 1;
            [self.listArray removeAllObjects];
            [self requestOrderlist:pageNumber];
        }
        [WHToast showMessage:data[@"mes"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
//支付完成刷新页面
- (void)loadList{
    pageNumber = 1;
    [self.listArray removeAllObjects];
    [self requestOrderlist:pageNumber];
}
//确认收货以后刷新页面
- (void)detailLoadList{
    pageNumber = 1;
    [self.listArray removeAllObjects];
    [self requestOrderlist:pageNumber];
}
/**
    确认收货
 */
- (void)greceive_confirm_url:(NSString *)tid{
    NSDictionary * info = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"login_token":info[@"token"],@"user":info[@"w_email"],@"transport_id":tid,@"os":@"1"};
    [Unity showanimate];
    [GZMrequest postWithURLString:[GZMUrl get_receive_confirm_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([data[@"status"] intValue] == 0) {
            //收货成功  当前页面刷新
            pageNumber = 1;
            [self.listArray removeAllObjects];
            [self requestOrderlist:pageNumber];
            //发通知第三个页面刷新
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sendNoti" object:nil];
        }
        [WHToast showMessage:data[@"mes"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
@end
