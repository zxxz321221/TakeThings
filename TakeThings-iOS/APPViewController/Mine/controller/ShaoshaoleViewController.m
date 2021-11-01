//
//  ShaoshaoleViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/9/20.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "ShaoshaoleViewController.h"
#import "SslCell.h"
#import "NoData.h"
#import "NewYahooDetailViewController.h"
#import "NewEbayDetailViewController.h"
@interface ShaoshaoleViewController ()<UITableViewDelegate,UITableViewDataSource,NoDataDelegate,sslCellDelegate>
{
    NSInteger pageIndex;
}
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) NSMutableArray * listArray;
@property (nonatomic , strong) NoData * nData;
@end

@implementation ShaoshaoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"捎捎乐";
    self.view.backgroundColor = [Unity getColor:@"f0f0f0"];
    [self.view addSubview:self.tableView];
}
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
        _tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
            [_tableView.mj_header beginRefreshing];
            pageIndex =1;
            [self requestList:pageIndex type:@"up"];
        }];
        // 马上进入刷新状态
        [_tableView.mj_header beginRefreshing];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [_tableView.mj_footer beginRefreshing];
            [self requestList:pageIndex type:@"down"];
        }];
        
    }
    return _tableView;
}
#pragma mark - tableView  搭理方法
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.listArray[indexPath.row][@"status"] intValue] == 3) {
        return [Unity countcoordinatesH:260];
    }
    return [Unity countcoordinatesH:240];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SslCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SslCell class])];
    if (cell == nil) {
        cell = [[SslCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([SslCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
//    [cell confitWithData:self.listArray[indexPath.row]];
    NSNumber * his = [NSNumber numberWithInteger:[self.listArray[indexPath.row][@"user_price"] integerValue]];
    NSNumber * ints = [NSNumber numberWithInteger:[self.listArray[indexPath.row][@"user_point"] integerValue]];
    [cell configWithGoodId:self.listArray[indexPath.row][@"auction_id"] WithStatus:[self.listArray[indexPath.row][@"status"] intValue] WithImage:self.listArray[indexPath.row][@"goods_img"] WithGoodName:self.listArray[indexPath.row][@"goods_name"] WithGoodPrice:self.listArray[indexPath.row][@"old_price"] WithGuessPrice:[his stringValue] WithJifen:[ints stringValue] WithSource:self.listArray[indexPath.row][@"type"] WithUser_confirm:[self.listArray[indexPath.row][@"user_confirm"] intValue] WithNeed_confirm:[self.listArray[indexPath.row][@"need_confirm"] intValue]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}
- (void)requestList:(NSInteger)page type:(NSString *)Type{
    NSDictionary * info = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"user":info[@"w_email"],@"page":[NSString stringWithFormat:@"%ld",(long)page]};
    
    [GZMrequest postWithURLString:[GZMUrl get_sshaoleList_url] parameters:dic success:^(NSDictionary *data) {
        if ([Type isEqualToString:@"up"]) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer resetNoMoreData];
            [self.listArray removeAllObjects];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        if ([data[@"list"][@"data"] count] < 15) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            [WHToast showMessage:@"没有更多数据" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
        for (int i=0; i<[data[@"list"][@"data"] count]; i++) {
            [self.listArray addObject:data[@"list"][@"data"][i]];
        }
        if (self.listArray.count == 0) {
            self.nData.imageView.image = [UIImage imageNamed:@"nodata"];
            self.nData.msgLabel.text = @"您还没有竞猜委托单，快去挑选吧~";
            [self.nData.homeBtn setTitle:@"逛逛首页" forState:UIControlStateNormal];
            [self.nData showNoData];
        }else{
            [self.nData hiddenNoData];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        [WHToast showMessage:@"请求失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [NSMutableArray new];
    }
    return _listArray;
}
- (NoData *)nData{
    if (!_nData) {
        _nData = [NoData setNoData:self.view];
        _nData.delegate = self;
    }
    return _nData;
}
- (void)confirm:(NSString *)goodId{
    NSDictionary * info = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"user":info[@"w_email"],@"auction_id":goodId};
    
    [Unity showanimate];
    [GZMrequest postWithURLString:[GZMUrl get_confirmGuess_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([data[@"status"] intValue] == 0) {//确认成功  改变数组中状态  刷新tableview
            for (int i=0; i<self.listArray.count; i++) {
                if ([self.listArray[0][@"auction_id"] isEqualToString:goodId]) {
                    NSMutableDictionary * dict = [self.listArray[i] mutableCopy];
                    [dict setObject:@"1" forKey:@"user_confirm"];
                    [self.listArray replaceObjectAtIndex:i withObject:dict];
                }
            }
            [self.tableView reloadData];
        }
        [WHToast showMessage:data[@"mes"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"请求失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)goodDetail:(NSString *)goodId WithType:(NSString *)type{
    if ([type isEqualToString:@"yahoo"]) {
        NewYahooDetailViewController * yvc = [[NewYahooDetailViewController alloc]init];
        yvc.platform = @"0";
        yvc.item = goodId;
        [self.navigationController pushViewController:yvc animated:YES];
    }else{
        NewEbayDetailViewController * yvc = [[NewEbayDetailViewController alloc]init];
        yvc.platform = @"5";
        yvc.item = goodId;
        [self.navigationController pushViewController:yvc animated:YES];
    }
}
- (void)pushHome{
    self.tabBarController.selectedIndex =0;
    [self.navigationController popViewControllerAnimated:NO];
}


@end
