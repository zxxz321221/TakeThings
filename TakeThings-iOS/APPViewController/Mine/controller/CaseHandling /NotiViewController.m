//
//  NotiViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/13.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "NotiViewController.h"
#import "NotiCell.h"
#import "NotiModel.h"
#import <MJExtension.h>
#import "DeliveryInfoViewController.h"
#import "Prompt.h"
#import "AppDelegate.h"
#import "WebViewController.h"
#import "OrderDetailViewController.h"
#import "NoData.h"
#import "NewYahooDetailViewController.h"
#import "NewEbayDetailViewController.h"
#define bottomH (IS_iPhoneX ? [Unity countcoordinatesH:70] : [Unity countcoordinatesH:50])
@interface NotiViewController ()<UITableViewDelegate,UITableViewDataSource,NotiCellDelegate,sendViewDelegate,NoDataDelegate>
{
    NSInteger pageNumber;
    NSString * area;//默认0 日本  1美国
    AppDelegate * myDelegate;
}
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) UIView * headerView;
@property (nonatomic , strong) UIButton * japanBtn;
@property (nonatomic , strong) UIButton * usaBtn;
@property (nonatomic , strong) UIView * bottomView;
@property (nonatomic , strong) UIButton * allSeletedBtn;

@property (nonatomic , strong) NSMutableArray * listArray;
@property (nonatomic , strong) NSMutableArray * modelArrs;//模型数组
@property (nonatomic , strong) Prompt * pView;
@property (nonatomic , strong) NoData * nData;
@end

@implementation NotiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    pageNumber = 1;
    area = @"0";
    self.view.backgroundColor = [Unity getColor:@"#f0f0f0"];
    [self creareUI];
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
        [_japanBtn setTitle:[NSString stringWithFormat:@"日本已发货(%@)",myDelegate.japan] forState:UIControlStateNormal];
        _japanBtn.layer.cornerRadius = _japanBtn.height/2;
        _japanBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        _japanBtn.layer.borderWidth = 1;
        _japanBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        [self changeColorButton:_japanBtn Title:@"日本已发货" Number:[NSString stringWithFormat:@"(%@)",myDelegate.japan] Read:YES];
    }
    return _japanBtn;
}
- (UIButton *)usaBtn{
    if (!_usaBtn) {
        _usaBtn = [[UIButton alloc]initWithFrame:CGRectMake(_japanBtn.right+[Unity countcoordinatesW:15], _japanBtn.top, _japanBtn.width, _japanBtn.height)];
        [_usaBtn addTarget:self action:@selector(usaClick) forControlEvents:UIControlEventTouchUpInside];
        [_usaBtn setTitle:[NSString stringWithFormat:@"美国已发货(%@)",myDelegate.usa] forState:UIControlStateNormal];
        _usaBtn.layer.cornerRadius = _usaBtn.height/2;
        _usaBtn.layer.borderColor = [Unity getColor:@"f0f0f0"].CGColor;
        _usaBtn.layer.borderWidth = 1;
        _usaBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _usaBtn.backgroundColor = [Unity getColor:@"f0f0f0"];
        [self changeColorButton:_usaBtn Title:@"美国已发货" Number:[NSString stringWithFormat:@"(%@)",myDelegate.usa] Read:NO];
    }
    return _usaBtn;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _headerView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-[Unity countcoordinatesH:90]-bottomH)];
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
            [self requestOrderlist:pageNumber WithG:area];
        }];
        // 马上进入刷新状态
        [_tableView.mj_footer beginRefreshing];
    }
    return _tableView;
}



#pragma  mark 顶部2个按钮事件处理
- (void)japanClick{
    if ([area isEqualToString:@"0"]) {
        return;
    }
    [self changeColorButton:self.japanBtn Title:@"日本已发货" Number:[NSString stringWithFormat:@"(%@)",myDelegate.japan] Read:YES];
    [self changeColorButton:self.usaBtn Title:@"美国已发货" Number:[NSString stringWithFormat:@"(%@)",myDelegate.usa] Read:NO];
    self.japanBtn.backgroundColor = [UIColor whiteColor];
    self.japanBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
    self.usaBtn.backgroundColor = [Unity getColor:@"f0f0f0"];
    self.usaBtn.layer.borderColor = [Unity getColor:@"f0f0f0"].CGColor;
    pageNumber = 1;
    area = @"0";
    [self.listArray removeAllObjects];
    [self requestOrderlist:pageNumber WithG:area];
    self.allSeletedBtn.selected = NO;
}
- (void)usaClick{
    if ([area isEqualToString:@"1"]) {
        return;
    }
//    [self.usaBtn setTitle:@"123" forState:UIControlStateNormal];
    [self changeColorButton:self.japanBtn Title:@"日本已发货" Number:[NSString stringWithFormat:@"(%@)",myDelegate.japan] Read:NO];
    [self changeColorButton:self.usaBtn Title:@"美国已发货" Number:[NSString stringWithFormat:@"(%@)",myDelegate.usa] Read:YES];
    self.japanBtn.backgroundColor = [Unity getColor:@"f0f0f0"];
    self.japanBtn.layer.borderColor = [Unity getColor:@"f0f0f0"].CGColor;
    self.usaBtn.backgroundColor = [UIColor whiteColor];
    self.usaBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
    pageNumber = 1;
    area = @"1";
    [self.listArray removeAllObjects];
    [self requestOrderlist:pageNumber WithG:area];
    self.allSeletedBtn.selected = NO;
}
- (void)changeColorButton:(UIButton *)btn Title:(NSString *)title Number:(NSString *)number Read:(BOOL)read{
    if (read) {
        //先设置按钮文字 不然会崩溃
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:btn.currentTitle];
        [attString addAttribute:(NSString*)NSForegroundColorAttributeName value:LabelColor3 range:[btn.currentTitle rangeOfString:btn.currentTitle]];
        [attString addAttribute:(NSString*)NSForegroundColorAttributeName value:[Unity getColor:@"aa112d"] range:[btn.currentTitle rangeOfString:number]];
        [btn setAttributedTitle:attString forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    }else{
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:btn.currentTitle];
        [attString addAttribute:(NSString*)NSForegroundColorAttributeName value:LabelColor9 range:[btn.currentTitle rangeOfString:btn.currentTitle]];
        [attString addAttribute:(NSString*)NSForegroundColorAttributeName value:[Unity getColor:@"aa112d"] range:[btn.currentTitle rangeOfString:number]];
        [btn setAttributedTitle:attString forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    }
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
        
        UIButton * delete = [Unity buttonAddsuperview_superView:_bottomView _subViewFrame:CGRectMake(self.allSeletedBtn.right+[Unity countcoordinatesW:10], [Unity countcoordinatesH:7], [Unity countcoordinatesW:210], [Unity countcoordinatesH:35]) _tag:self _action:@selector(fahuoClick) _string:@"发货" _imageName:@""];
        delete.backgroundColor = [Unity getColor:@"#aa112d"];
        delete.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        [delete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        delete.layer.cornerRadius = delete.height/2;
    }
    return _bottomView;
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
#pragma mark - tableView  搭理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.modelArrs.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [Unity countcoordinatesH:345];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NotiCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NotiCell class])];
    if (cell == nil) {
        cell = [[NotiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([NotiCell class])];
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
- (Prompt *)pView{
    if (!_pView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _pView = [Prompt setPrompt:window];
    }
    return _pView;
}
- (void)oriPage:(NotiCell *)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    WebViewController * wvc = [[WebViewController alloc]init];
    wvc.webUrl = [NSString stringWithFormat:@"%@/index/order_bid/getyahoo?url=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"new_sdxurl"],self.listArray[indexPath.row][@"w_link"]];
    [self.navigationController pushViewController:wvc animated:YES];
}
- (void)detail:(NotiCell *)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    OrderDetailViewController * ovc = [[OrderDetailViewController alloc]init];
    ovc.order = self.listArray[indexPath.row][@"numId"];
    ovc.finish = @"";
    [self.navigationController pushViewController:ovc animated:YES];
}
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
    //判断多件商品同事发货  是否来自同一个仓库
    NSInteger receive = 0;
    BOOL isFh = YES;
    for (int i=0; i<array.count; i++) {
        if (i == 0) {
            receive = [array[i][@"w_receive_place"] intValue];
            isFh = YES;
        }else{
            if (receive == [array[i][@"w_receive_place"] intValue]) {
                isFh = YES;
            }else{
                isFh = NO;
            }
        }
    }
    if (isFh) {
        DeliveryInfoViewController * dvc = [[DeliveryInfoViewController alloc]init];
        dvc.listArr = array;
        if ([array[0][@"w_cc"]isEqualToString:@"0"]) {//yahoo
            if ([array[0][@"w_receive_place"] intValue] == 0) {//福冈
                dvc.kdArray = @[@"EMS",@"SAL",@"海运"];//132
            }else{//千叶
                dvc.kdArray = @[@"EMS",@"SAL",@"海运",@"空港快线"];//132
            }
        }else{//ebay
            dvc.kdArray = @[@"USC"];
        }
        
        dvc.delegate = self;
        [self.navigationController pushViewController:dvc animated:YES];
    }else{
        [self.pView showPrompt];
    }
}

//删除功能
- (NSMutableArray *)modelArrs{
    if (!_modelArrs) {
        _modelArrs = [NSMutableArray new];
    }
    return _modelArrs;
}
/**
 *  cell的代理方法
 *
 *  @param cell     cell可以拿到indexpath
 *  @param selectBt 选中按钮
 */
- (void)shoppingCellDelegate:(NotiCell *)cell WithSelectButton:(UIButton *)selectBt
{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    NSLog(@"indexpath%@",indexPath);
    NotiModel * model = self.modelArrs[indexPath.row];
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
        for (NotiModel * model in self.modelArrs)
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
        for (NotiModel * model in self.modelArrs)
        {
            model.isSelect = YES;
        }
        for (int i=0;i<self.listArray.count; i++) {
            NSMutableDictionary * dic = [self.listArray[i] mutableCopy];
            [dic setObject:@"1" forKey:@"isSelect"];
            [self.listArray replaceObjectAtIndex:i withObject:dic];
        }
    }else{
        for (NotiModel * model in self.modelArrs)
        {
            model.isSelect = NO;
        }
        for (int i=0;i<self.listArray.count; i++) {
            NSMutableDictionary * dic = [self.listArray[i] mutableCopy];
            [dic setObject:@"0" forKey:@"isSelect"];
            [self.listArray replaceObjectAtIndex:i withObject:dic];
        }
    }
    NSLog(@"234  %@",self.listArray);
    [self.tableView reloadData];
}
- (void)requestOrderlist:(NSInteger)page WithG:(NSString *)areag{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"customer":userInfo[@"member_id"],@"status":@"notice",@"page":[NSString stringWithFormat:@"%ld",(long)page],@"area":areag};
    NSLog(@"通知请求%@",dic);
    [GZMrequest getWithURLString:[GZMUrl get_ordermanager_url] parameters:dic success:^(NSDictionary *data) {
        NSLog(@"案件处理tongzhifahuo  = %@",data);
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            [self.tableView.mj_footer endRefreshing];
            pageNumber = pageNumber+1;
            if ([data[@"data"] count] <10) {
                //显示没有更多数据
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            for (int i=0; i<[data[@"data"] count]; i++) {
                NSMutableDictionary * dic = [NSMutableDictionary new];
                [dic setObject:data[@"data"][i][@"id"] forKey:@"numId"];
                [dic setObject:data[@"data"][i][@"w_lsh"] forKey:@"w_lsh"];
                [dic setObject:data[@"data"][i][@"w_jpnid"] forKey:@"w_jpnid"];
                [dic setObject:data[@"data"][i][@"w_object"] forKey:@"w_object"];
                [dic setObject:data[@"data"][i][@"w_tbsl"] forKey:@"w_tbsl"];
                [dic setObject:data[@"data"][i][@"w_imgsrc"] forKey:@"w_imgsrc"];
                [dic setObject:data[@"data"][i][@"w_kgs"] forKey:@"w_kgs"];
                [dic setObject:data[@"data"][i][@"dhsj"] forKey:@"dhsj"];
                [dic setObject:data[@"data"][i][@"w_total_tw"] forKey:@"w_total_tw"];
                [dic setObject:data[@"data"][i][@"w_jbj_jp"] forKey:@"w_jbj_jp"];
                [dic setObject:data[@"data"][i][@"w_cc"] forKey:@"w_cc"];
                [dic setObject:data[@"data"][i][@"w_link"] forKey:@"w_link"];
                [dic setObject:data[@"data"][i][@"w_sj_jp"] forKey:@"w_sj_jp"];//消费税
                [dic setObject:data[@"data"][i][@"w_yz_jp"] forKey:@"w_yz_jp"];//运费
                [dic setObject:data[@"data"][i][@"w_receive_place"] forKey:@"w_receive_place"];//仓库
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
            self.modelArrs = [NotiModel mj_objectArrayWithKeyValuesArray:self.listArray];
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
- (void)senViewBack:(NSInteger)num{

    if ([area isEqualToString:@"0"]) {
        area = @"100";
        NSInteger jap = [myDelegate.japan intValue];
        myDelegate.japan = [NSString stringWithFormat:@"%ld",jap-num];
        NSLog(@"jap = %@",myDelegate.japan);
        [self.japanBtn setTitle:[NSString stringWithFormat:@"日本已发货(%@)",myDelegate.japan] forState:UIControlStateNormal];
        [self japanClick];
    }else{
        area = @"";
        NSInteger usa = [myDelegate.usa intValue];
        myDelegate.usa = [NSString stringWithFormat:@"%ld",usa-num];
        NSLog(@"jap = %@",myDelegate.usa);
        [self.usaBtn setTitle:[NSString stringWithFormat:@"美国已发货(%@)",myDelegate.usa] forState:UIControlStateNormal];
        [self usaClick];
    }

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
- (void)goodsDetail:(NotiCell *)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if ([self.listArray[indexPath.row][@"w_cc"] isEqualToString:@"0"]) {
        NewYahooDetailViewController * nvc = [[NewYahooDetailViewController alloc]init];
        nvc.item = self.listArray[indexPath.row][@"w_jpnid"];
        nvc.platform = self.listArray[indexPath.row][@"w_cc"];
        [self.navigationController pushViewController:nvc animated:YES];
    }else{
        NewEbayDetailViewController * nvc = [[NewEbayDetailViewController alloc]init];
        nvc.item = self.listArray[indexPath.row][@"w_jpnid"];
        nvc.platform = self.listArray[indexPath.row][@"w_cc"];
        [self.navigationController pushViewController:nvc animated:YES];
    }
}
@end

