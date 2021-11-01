//
//  ApatViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/7/12.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "ApatViewController.h"
#import "PatCell.h"
#import "PremiumView.h"
#import "HackView.h"
#import "WebViewController.h"
#import "NoData.h"
#import "NewYahooDetailViewController.h"
#import "NewEbayDetailViewController.h"
@interface ApatViewController ()<UITableViewDelegate,UITableViewDataSource,PatCellDelegate,PremiumViewDelegate,HackViewDelegate,NoDataDelegate>
{
    NSInteger pageNumber;
    NSString * wtdId;//委托单id
    NSInteger index;//当前cell
}
@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) PremiumView * pView;
@property (nonatomic , strong) HackView * hView;

@property (nonatomic , strong) AroundAnimation * aAnimation;
@property (nonatomic , strong) NSMutableArray * listArray;
@property (nonatomic , strong) NoData * nData;
@end

@implementation ApatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    wtdId = @"";
    index = 0;
    pageNumber = 1;
    self.view.backgroundColor = [Unity getColor:@"#f0f0f0"];
    [self creareUI];
}
- (void)creareUI{
    [self.view addSubview:self.tableView];
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
            //            page = page+1;
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
//    NSLog(@"geshu  %lu",(unsigned long)self.listArray.count);
    return self.listArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [Unity countcoordinatesH:365];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellId = [NSString stringWithFormat:@"ApatCell%ld",(long)indexPath.row];
    PatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[PatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
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
//加价
- (void)premium:(NSDictionary *)dic with:(PatCell *)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    index = indexPath.row;
    //    NSLog(@"---%@",dic);
    wtdId = dic[@"id"];
    self.pView.number.text = [NSString stringWithFormat:@"%@/%@",dic[@"id"],dic[@"w_jpnid"]];
    self.pView.goodsName.text = dic[@"w_object"];
    if ([dic[@"w_cc"] isEqualToString:@"0"]) {
        self.pView.bidPrice.text = [NSString stringWithFormat:@"%@円",dic[@"w_jbj_jp"]];
        self.pView.currentPrice.text = [NSString stringWithFormat:@"%@円",dic[@"w_maxpay_jp"]];
        NSString * ze = [Unity getSmallestUnitOfBid:dic[@"w_maxpay_jp"]];
        self.pView.markL.text = [NSString stringWithFormat:@"(出价增额:%@円,您当前最低压出%.2f円)",ze,[ze floatValue]+[dic[@"w_maxpay_jp"] floatValue]];
        self.pView.currencyL.text = @"円";
    }else{
        self.pView.bidPrice.text = [NSString stringWithFormat:@"%@美元",dic[@"w_jbj_jp"]];
        self.pView.currentPrice.text = [NSString stringWithFormat:@"%@美元",dic[@"w_maxpay_jp"]];
        NSString * ze = [Unity getSmallestUnitOfBid:dic[@"w_maxpay_jp"] WithCount:dic[@"w_tbsl"]];
        self.pView.markL.text = [NSString stringWithFormat:@"(出价增额:%@美元,您当前最低压出%.2f美元)",ze,[ze floatValue]+[dic[@"w_maxpay_jp"] floatValue]];
        self.pView.currencyL.text = @"美元";
    }
    self.pView.w_cc = dic[@"w_cc"];
    [self.pView showPremiumView];
}
- (void)updatePlace:(NSDictionary *)dic{
    NSString * str = [NSString stringWithFormat:@"%.2f",[dic[@"place"] floatValue]];
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    [self.aAnimation startAround];
    NSDictionary *params = @{@"agent":wtdId,@"customer":userInfo[@"member_id"],@"maxpirce":dic[@"place"],@"type":dic[@"type"],@"area":@"a",@"zplp":@"",@"shlp":@""};
    NSLog(@"%@",params);
    [GZMrequest postWithURLString:[GZMUrl get_updateCase_url]parameters:params success:^(NSDictionary *data) {
        NSLog(@"创建委加价%@",data);
        [self.aAnimation stopAround];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            NSDictionary * dict = self.listArray[index];
            NSMutableDictionary * dictt = [dict mutableCopy];
            [dictt setObject:str forKey:@"w_maxpay_jp"];
            [self.listArray replaceObjectAtIndex:index withObject:dictt];
            [self.tableView reloadData];
            
            [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }else{
            [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [self.aAnimation stopAround];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (PremiumView *)pView{
    if (!_pView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _pView = [PremiumView setPremiumView:window];
        _pView.delegate = self;
    }
    return _pView;
}
//砍单
- (void)bargain:(NSDictionary *)dic with:(PatCell *)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    index = indexPath.row;
    wtdId = dic[@"id"];
    [self.hView showHackView];
}
- (HackView *)hView{
    if (!_hView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _hView = [HackView setHackView:window withTitle:@"您确定要砍单吗?"];
        _hView.delegate = self;
    }
    return _hView;
}
- (void)cancelCase{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    [self.aAnimation startAround];
    NSDictionary *params = @{@"agent":wtdId,@"customer":userInfo[@"member_id"],@"area":@"a"};
    [GZMrequest postWithURLString:[GZMUrl get_cancelCase_url]parameters:params success:^(NSDictionary *data) {
        [self.aAnimation stopAround];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            [self.listArray removeObjectAtIndex:index];
            if (self.listArray.count == 0) {
                self.nData.imageView.image = [UIImage imageNamed:@"nodata"];
                self.nData.msgLabel.text = @"您还没有相关委托单，快去挑选吧~";
                [self.nData.homeBtn setTitle:@"逛逛首页" forState:UIControlStateNormal];
                [self.nData showNoData];
            }else{
                [self.nData hiddenNoData];
            }
            [self.tableView reloadData];
            
            [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }else{
            [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [self.aAnimation stopAround];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)requestOrderlist:(NSInteger)page{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"area":@"a",@"customer":userInfo[@"member_id"],@"status":@"1",@"page":[NSString stringWithFormat:@"%ld",(long)page]};
    [GZMrequest getWithURLString:[GZMUrl get_orderlist_url] parameters:dic success:^(NSDictionary *data) {
        NSLog(@"a区代拍中%@",data);
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
- (void)oriPage:(NSDictionary *)dic{
    NSLog(@"");
    WebViewController * wvc = [[WebViewController alloc]init];
    wvc.webUrl = [NSString stringWithFormat:@"%@/index/order_bid/getyahoo?url=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"new_sdxurl"],dic[@"w_link"]];
    [self.navigationController pushViewController:wvc animated:YES];
}
- (AroundAnimation *)aAnimation{
    if (!_aAnimation) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _aAnimation = [AroundAnimation AroundAnimationViewSetView:window];
    }
    return _aAnimation;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
