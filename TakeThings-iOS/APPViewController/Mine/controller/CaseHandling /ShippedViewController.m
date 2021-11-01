//
//  ShippedViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/13.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "ShippedViewController.h"
#import "ShippedCell.h"
#import "DifferView.h"
#import "WebViewController.h"
#import "OrderDetailViewController.h"
#import "NoData.h"
#import "NewYahooDetailViewController.h"
#import "NewEbayDetailViewController.h"
@interface ShippedViewController ()<UITableViewDelegate,UITableViewDataSource,ShippedCellDelegate,DifferViewDelegate,NoDataDelegate>
{
    NSInteger pageNumber;
}
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) NSMutableArray * listArray;
@property (nonatomic , strong) DifferView * dView;
@property (nonatomic , strong) NoData * nData;
@end

@implementation ShippedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pageNumber = 1;
    self.view.backgroundColor = [Unity getColor:@"#f0f0f0"];
    [self creareUI];
}
- (void)creareUI{
    [self.view addSubview:self.tableView];
    self.nData.imageView.image = [UIImage imageNamed:@"nodata"];
    self.nData.msgLabel.text = @"您还没有相关委托单，快去挑选吧~";
    [self.nData.homeBtn setTitle:@"逛逛首页" forState:UIControlStateNormal];
    [self.nData showNoData];
}
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
    
    return self.listArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [Unity countcoordinatesH:345];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShippedCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShippedCell class])];
    if (cell == nil) {
        cell = [[ShippedCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ShippedCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    [cell configWithData:self.listArray[indexPath.row]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [Unity countcoordinatesH:10];
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [UIView new];
    
    return footer;
}
- (void)oriPage:(NSDictionary *)dic{
    WebViewController * wvc = [[WebViewController alloc]init];
    wvc.webUrl = [NSString stringWithFormat:@"%@/index/order_bid/getyahoo?url=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"new_sdxurl"],dic[@"w_link"]];
    [self.navigationController pushViewController:wvc animated:YES];
}
- (void)handlePlace:(NSString *)place{
    NSLog(@"处理");
    self.dView.amount.text = [NSString stringWithFormat:@"%@RMB",place];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.dView.amount.text];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(12)] range:NSMakeRange(str.length-3, 3)];
    self.dView.amount.attributedText = str;
    self.dView.balance.text = @"账户余额：1300.00RMB";
//    self.dView.mark.hidden = NO;
//    self.dView.confirm.backgroundColor = LabelColor9;
//    self.dView.confirm.userInteractionEnabled = NO;
    [self.dView showDifferView];
}
- (void)detail:(NSDictionary *)dic{
    NSLog(@"明细");
    OrderDetailViewController * ovc = [[OrderDetailViewController alloc]init];
    ovc.order = dic[@"id"];
    ovc.finish = @"";
    [self.navigationController pushViewController:ovc animated:YES];
}
- (DifferView *)dView{
    if (!_dView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _dView = [DifferView setDifferView:window];
        _dView.delegate = self;
    }
    return _dView;
}
- (void)recharge{
    NSLog(@"充值");
}
- (void)confirm{
    NSLog(@"确认");
}
- (void)requestOrderlist:(NSInteger )page{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"customer":userInfo[@"member_id"],@"status":@"sent",@"page":[NSString stringWithFormat:@"%ld",(long)page]};
    [GZMrequest getWithURLString:[GZMUrl get_ordermanager_url] parameters:dic success:^(NSDictionary *data) {
        NSLog(@"案件处理%@",data);
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            [self.tableView.mj_footer endRefreshing];
            pageNumber = pageNumber+1;
            if ([data[@"data"] count] <10) {
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
        }else{
            [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
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
- (void)pushHome{
    self.tabBarController.selectedIndex =0;
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)goodsDetail:(NSDictionary *)dic{
    NSLog(@"%@",dic);
    if ([dic[@"w_cc"] isEqualToString:@"0"]) {
        NewYahooDetailViewController * nvc = [[NewYahooDetailViewController alloc]init];
        nvc.item = dic[@"w_jpnid"];
        nvc.platform = dic[@"w_cc"];
        [self.navigationController pushViewController:nvc animated:YES];
    }else{
        NewEbayDetailViewController * nvc = [[NewEbayDetailViewController alloc]init];
        nvc.item = dic[@"w_jpnid"];
        nvc.platform = dic[@"w_cc"];
        [self.navigationController pushViewController:nvc animated:YES];
    }
}
@end
