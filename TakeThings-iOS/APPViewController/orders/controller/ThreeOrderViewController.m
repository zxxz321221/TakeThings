//
//  ThreeOrderViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/7.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "ThreeOrderViewController.h"
#import "NoData.h"
#import "NewOrderCell2.h"
#import "NewOrderModel.h"
#import <MJExtension.h>
#import "NewOrderDetailViewController.h"
#import "WebViewController.h"
@interface ThreeOrderViewController ()<UITableViewDelegate,UITableViewDataSource,NoDataDelegate,NewOrderCell2Delegate,NewOrderDetailDelegate>
{
    NSInteger pageNumber;
    NSString * status_id;
    NSString * bid_mode;//竞价方式 默认0  1立即出价，2结标前出价
    NSString * order;//默认1委托单创建时间倒序，2结标时间倒序
    NSString * source;// 'yahoo','ebay'
    BOOL isEdit;
}
@property (nonatomic , strong) UIButton * jpBtn;
@property (nonatomic , strong) UIButton * usaBtn;
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) NSMutableArray * listArray;
@property (nonatomic , strong) NSMutableArray * modelArray;

@property (nonatomic , strong) NoData * nData;

@property (nonatomic , strong) UIView * bottomView;
@property (nonatomic , strong) UIButton * allSeletedBtn;
@end

@implementation ThreeOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView:) name:@"OrderlList2" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelDelete) name:@"cancelDelete" object:nil];
    isEdit = NO;
    pageNumber = 0;
    source = @"yahoo";
    order = @"2";
    bid_mode = @"0";
    status_id = @"80,90,100,220";
    self.view.backgroundColor = [Unity getColor:@"f0f0f0"];
    [self.view addSubview:self.jpBtn];
    [self.view addSubview:self.usaBtn];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
}
- (void)refreshTableView:(NSNotification *)notification {
    order = [NSString stringWithFormat:@"%d",[notification.object[@"time"] intValue]+1];
    if ([notification.object[@"status"] intValue] == 0) {
        status_id = @"80,90,100,220";
        
    }else if ([notification.object[@"status"] intValue] == 1){
        status_id = @"80";
        
    }else if ([notification.object[@"status"] intValue] == 2){
        status_id = @"90";
        
    }else if ([notification.object[@"status"] intValue] == 3){
        status_id = @"100";
        
    }else{
        status_id = @"220";
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
/**
 取消删除通知
 */
- (void)cancelDelete{
    isEdit = NO;
    self.bottomView.hidden = YES;
    [self.tableView reloadData];
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
    if (isEdit == NO) {
        if ([self.listArray[indexPath.row][@"advance_rate"] floatValue] > 0) {//预付款商品
            return [Unity countcoordinatesH:362];
        }
        return [Unity countcoordinatesH:342];
    }else{
        if ([self.listArray[indexPath.row][@"advance_rate"] floatValue] > 0) {//预付款商品
            return [Unity countcoordinatesH:317];
        }
        return [Unity countcoordinatesH:297];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellidentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    NewOrderCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil) {
        cell = [[NewOrderCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [cell configWithData:self.listArray[indexPath.row]];
    cell.model = self.modelArray[indexPath.row];
    [cell configIsAction:isEdit];
   
    cell.delegate = self;
    
    //添加长按手势
//    UILongPressGestureRecognizer * longPressGesture =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(cellLongPress:)];
//
//    longPressGesture.minimumPressDuration=1.5f;//设置长按 时间
//    [cell addGestureRecognizer:longPressGesture];
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewOrderDetailViewController * nvc = [[NewOrderDetailViewController alloc]init];
    nvc.delegate = self;
    nvc.dataDic = self.listArray[indexPath.row];
    nvc.orderId = self.listArray[indexPath.row][@"orderID"];
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
#pragma mark  cell长按手势处理
- (void)cellLongPress:(UILongPressGestureRecognizer *)lpGR{
    
    if (lpGR.state == UIGestureRecognizerStateBegan) {//手势开始
//        CGPoint point = [lpGR locationInView:self.tableView];
//        NSIndexPath *currentIndexPath = [self.tableView indexPathForRowAtPoint:point]; // 可以获取我们在哪个cell上长按
        isEdit = YES;
        [self.tableView reloadData];
        self.bottomView.hidden = NO;
        [self.delegate confirmDelete];
    }
}
#pragma mark --nodatadelegate--
- (void)pushHome{
    self.tabBarController.selectedIndex =0;
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark - bottomView 创建
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-bottomH-NavBarHeight-[Unity countcoordinatesW:40], SCREEN_WIDTH, bottomH)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        line.backgroundColor = [Unity getColor:@"#e0e0e0"];
        [_bottomView addSubview:line];
        
        [_bottomView addSubview:self.allSeletedBtn];
        
        UIButton * delete = [Unity buttonAddsuperview_superView:_bottomView _subViewFrame:CGRectMake(self.allSeletedBtn.right+[Unity countcoordinatesW:10], [Unity countcoordinatesH:7], [Unity countcoordinatesW:210], [Unity countcoordinatesH:35]) _tag:self _action:@selector(deleteClick) _string:@"删除" _imageName:@""];
        delete.backgroundColor = [Unity getColor:@"#aa112d"];
        delete.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        [delete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        delete.layer.cornerRadius = delete.height/2;
        
        _bottomView.hidden = YES;
    }
    return _bottomView;
}
- (UIButton *)allSeletedBtn{
    if (!_allSeletedBtn) {
        _allSeletedBtn = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:80], [Unity countcoordinatesH:50])];
        [_allSeletedBtn addTarget:self action:@selector(allSeletedClick) forControlEvents:UIControlEventTouchUpInside];
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
- (void)allisSeleted:(BOOL)isSeleted{
    if (isSeleted) {
        for (NewOrderModel * model in self.modelArray)
        {
            model.isSelect = YES;
        }
        for (int i=0;i<self.listArray.count; i++) {
            NSMutableDictionary * dic = [self.listArray[i] mutableCopy];
            [dic setObject:@"1" forKey:@"isSelect"];
            [self.listArray replaceObjectAtIndex:i withObject:dic];
        }
    }else{
        for (NewOrderModel * model in self.modelArray)
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
#pragma mark ---顶部 日本 美国竞拍按钮事件---

- (void)jpbtnClick{
    if ([source isEqualToString:@"yahoo"]) {
        return;
    }
    source = @"yahoo";
    _jpBtn.selected = YES;
    _jpBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
    _usaBtn.selected = NO;
    _usaBtn.layer.borderColor = LabelColor9.CGColor;
    

    [self.tableView.mj_header beginRefreshing];
    if (self.bottomView.hidden == NO) {
        self.bottomView.hidden = YES;
        self.allSeletedBtn.selected = NO;
        isEdit = NO;
        [self.delegate cancelDelete];
    }
}
- (void)usabtnClick{
    if ([source isEqualToString:@"ebay"]) {
        return;
    }
    source = @"ebay";
    _jpBtn.selected = NO;
    _jpBtn.layer.borderColor = LabelColor9.CGColor;
    _usaBtn.selected = YES;
    _usaBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
    

    [self.tableView.mj_header beginRefreshing];
    if (self.bottomView.hidden == NO) {
        self.bottomView.hidden = YES;
        self.allSeletedBtn.selected = NO;
        isEdit = NO;
        [self.delegate cancelDelete];
    }
}
- (void)requestOrderlist:(NSInteger)page{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSString * url = [NSString stringWithFormat:@"%@?user=%@&order_bid_status_id=%@&bid_mode=%@&order=%@&page=%@&os=1&source=%@",[GZMUrl get_newOrderList_url],userInfo[@"w_email"],status_id,bid_mode,order,[NSString stringWithFormat:@"%ld",(long)page],source];
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
//            [self.listArray addObject:data[@"data"][i]];
            NSMutableDictionary * dic = [NSMutableDictionary new];
            [dic setObject:data[@"data"][i][@"advance_rate"] forKey:@"advance_rate"];
            [dic setObject:data[@"data"][i][@"add_amount_all"] forKey:@"add_amount_all"];
            [dic setObject:data[@"data"][i][@"order_code"] forKey:@"order_code"];
            [dic setObject:data[@"data"][i][@"status_name"] forKey:@"status_name"];
            [dic setObject:data[@"data"][i][@"goods_name"] forKey:@"goods_name"];
            [dic setObject:data[@"data"][i][@"order_bid_status_id"] forKey:@"status_id"];
//            NSArray * arr = [data[@"data"][i][@"goods_img"] allKeys];
            [dic setObject:[Unity get_image:data[@"data"][i][@"goods_img"]] forKey:@"goods_img"];
            [dic setObject:data[@"data"][i][@"bid_num"] forKey:@"bid_num"];
            [dic setObject:data[@"data"][i][@"over_price"] forKey:@"over_price"];
            [dic setObject:data[@"data"][i][@"currency"] forKey:@"currency"];
            [dic setObject:data[@"data"][i][@"over_time_ch"] forKey:@"over_time_ch"];
            [dic setObject:data[@"data"][i][@"create_time"] forKey:@"create_time"];
            [dic setObject:data[@"data"][i][@"bid_mode"] forKey:@"bid_mode"];
            [dic setObject:data[@"data"][i][@"id"] forKey:@"orderID"];
            [dic setObject:data[@"data"][i][@"bid_account"] forKey:@"bid_account"];
            [dic setObject:data[@"data"][i][@"w_signal"] forKey:@"w_signal"];
            [dic setObject:data[@"data"][i][@"price_user"] forKey:@"price_user"];
            [dic setObject:data[@"data"][i][@"goods_url"] forKey:@"goods_url"];
            [dic setObject:@"0" forKey:@"isSelect"];
            [self.listArray addObject:dic];
        }
        if (self.listArray.count == 0) {
            self.nData.imageView.image = [UIImage imageNamed:@"nodata"];
            self.nData.msgLabel.text = @"您还没有相关包裹，快去挑选吧~";
            [self.nData.homeBtn setTitle:@"逛逛首页" forState:UIControlStateNormal];
            [self.nData showNoData];
        }else{
            [self.nData hiddenNoData];
        }
        [self.modelArray removeAllObjects];
        self.modelArray = [NewOrderModel mj_objectArrayWithKeyValuesArray:self.listArray];
        [self.tableView reloadData];
        [self isallSelectAllPrice];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = [NSMutableArray new];
    }
    return _modelArray;
}
/**
 *  遍历所有是否全选
 */
- (void)isallSelectAllPrice
{
    NSInteger count = 0;
    for (NewOrderModel * model in self.modelArray)
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
    if (count == self.modelArray.count) {
        self.allSeletedBtn.selected = YES;
    }else{
        self.allSeletedBtn.selected = NO;
    }
}
#pragma mark newOrderCell1Delegate
//商品详情
//- (void)goodsDetail:(NewOrderCell1 *)cell{
//    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
//}
//- (void)goodsSettlement:(NewOrderCell1 *)cell WithTag:(NSInteger)tag{
//    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
//    if (tag == 1) {//委托单结算
//
//    }else if (tag == 2){//委托单详情
//
//    }else if (tag == 3){//通知发货
//
//    }else{//包裹详情
//
//    }
//}
- (void)acloseCellDelegate:(NewOrderCell2 *)cell WithSelectButton:(UIButton *)selectBtn{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    NSLog(@"indexpath%@",indexPath);
    NewOrderModel * model = self.modelArray[indexPath.row];
    model.isSelect = !selectBtn.selected;
    
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
- (void)orderDelete:(NewOrderCell2 *)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary * dic = @{@"order_id":self.listArray[indexPath.row][@"orderID"]};
    [Unity showanimate];
    [GZMrequest getWithURLString:[GZMUrl get_newOrderDelete_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([data[@"status"] intValue] == 0) {
//            [self delegateOrder:self.listArray[indexPath.row][@"orderID"]];
            [self.listArray removeAllObjects];
            [self.modelArray removeAllObjects];
            pageNumber = 1;
            [self requestOrderlist:pageNumber];
        }
        [WHToast showMessage:data[@"mes"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)orderOld:(NewOrderCell2 *)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    WebViewController * wvc = [[WebViewController alloc]init];
    wvc.webUrl = [NSString stringWithFormat:@"%@/index/order_bid/getyahoo?url=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"new_sdxurl"],self.listArray[indexPath.row][@"goods_url"]];
    [self.navigationController pushViewController:wvc animated:YES];
}
//在原有的数据里 删除对应的id
- (void)delegateOrder:(NSString *)bid_id{
//    for (int i=0; i<self.listArray.count; i++) {
//        if ([self.listArray[i][@"orderID"] intValue] == [bid_id intValue]) {
//            [self.listArray removeObjectAtIndex:i];
//            [self.modelArray removeObjectAtIndex:i];
//            return;
//        }
//    }
//    [self.tableView reloadData];
}
- (void)successJiesuan{//删除
    pageNumber = 1;
    [self.listArray removeAllObjects];
    [self requestOrderlist:pageNumber];
}
@end
