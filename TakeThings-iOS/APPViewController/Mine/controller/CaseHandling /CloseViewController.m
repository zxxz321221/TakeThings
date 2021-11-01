//
//  CloseViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/13.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "CloseViewController.h"
#import "CloseCell.h"
#import <MJExtension.h>
#import "CloseModel.h"
#import "OrderDetailViewController.h"
#import "NoData.h"
#import "NewYahooDetailViewController.h"
#import "NewEbayDetailViewController.h"
#define bottomH (IS_iPhoneX ? [Unity countcoordinatesH:70] : [Unity countcoordinatesH:50])
@interface CloseViewController ()<UITableViewDelegate,UITableViewDataSource,CloseCellDelegate,NoDataDelegate>
{
    BOOL isAction;//默认no  yes管理状态
    NSInteger pageNumber;
}
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) UIView * bottomView;
@property (nonatomic , strong) NSMutableArray * listArray;
@property (nonatomic , strong) UIButton * allSeletedBtn;
@property (nonatomic , strong) NSMutableArray * modelArray;
@property (nonatomic , strong) NoData * nData;

@end

@implementation CloseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pageNumber = 1;
    isAction = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adminClick:) name:@"admin" object:nil];
    self.view.backgroundColor = [Unity getColor:@"#f0f0f0"];
    [self creareUI];
}
- (void)creareUI{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
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
    
    return self.modelArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [Unity countcoordinatesH:325];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CloseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CloseCell class])];
    if (cell == nil) {
        cell = [[CloseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CloseCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (isAction) {
        [cell configIsAction:YES];
    }else{
        [cell configIsAction:NO];
    }
    cell.model = self.modelArray[indexPath.row];
    cell.delegate = self;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return bottomH;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [UIView new];
    
    return footer;
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
- (void)allisSeleted:(BOOL)isSeleted{
    if (isSeleted) {
        for (CloseModel * model in self.modelArray)
        {
            model.isSelect = YES;
        }
        for (int i=0;i<self.listArray.count; i++) {
            NSMutableDictionary * dic = [self.listArray[i] mutableCopy];
            [dic setObject:@"1" forKey:@"isSelect"];
            [self.listArray replaceObjectAtIndex:i withObject:dic];
        }
    }else{
        for (CloseModel * model in self.modelArray)
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
- (void)adminClick:(NSNotification *)notification{
    NSString * index = notification.object;
    if ([index isEqualToString:@"0"]) {
        self.bottomView.hidden = YES;
        isAction = NO;
        [self.tableView reloadData];
    }else{
        self.bottomView.hidden=NO;
        isAction = YES;
        [self.tableView reloadData];
    }
}
- (void)requestOrderlist:(NSInteger )page{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"customer":userInfo[@"member_id"],@"status":@"finish",@"page":[NSString stringWithFormat:@"%ld",(long)page]};
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
                NSMutableDictionary * dict = [NSMutableDictionary new];
                [dict setObject:data[@"data"][i][@"w_lsh"] forKey:@"w_lsh"];
                NSDictionary *dd =data[@"data"][i];
                if([[dd allKeys] containsObject:@"w_imgsrc"]){
                    [dict setObject:data[@"data"][i][@"w_imgsrc"] forKey:@"w_imgsrc"];
                }else{
                    [dict setObject:@"" forKey:@"w_imgsrc"];
                }
                [dict setObject:data[@"data"][i][@"w_object"] forKey:@"w_object"];
                [dict setObject:data[@"data"][i][@"w_cc"] forKey:@"w_cc"];
                [dict setObject:data[@"data"][i][@"w_total_tw"] forKey:@"w_total_tw"];
                [dict setObject:data[@"data"][i][@"w_tbsl"] forKey:@"w_tbsl"];
                [dict setObject:data[@"data"][i][@"w_overtime"] forKey:@"w_overtime"];
                [dict setObject:data[@"data"][i][@"w_ordertime"] forKey:@"w_ordertime"];
                [dict setObject:data[@"data"][i][@"w_maxpay_jp"] forKey:@"w_maxpay_jp"];
                [dict setObject:data[@"data"][i][@"id"] forKey:@"numId"];
                [dict setObject:@"0" forKey:@"isSelect"];
                [self.listArray addObject:dict];
            }
            if (self.listArray.count == 0) {
                self.nData.imageView.image = [UIImage imageNamed:@"nodata"];
                self.nData.msgLabel.text = @"您还没有相关委托单，快去挑选吧~";
                [self.nData.homeBtn setTitle:@"逛逛首页" forState:UIControlStateNormal];
                [self.nData showNoData];
            }else{
                [self.nData hiddenNoData];
            }
            [self.modelArray removeAllObjects];
            self.modelArray = [CloseModel mj_objectArrayWithKeyValuesArray:self.listArray];
            [self.tableView reloadData];
            [self isallSelectAllPrice];
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
- (NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = [NSMutableArray new];
    }
    return _modelArray;
}
/**
 *  cell的代理方法
 *
 *  @param cell     cell可以拿到indexpath
 *  @param selectBt 选中按钮
 */
- (void)closeCellDelegate:(CloseCell *)cell WithSelectButton:(UIButton *)selectBt
{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    NSLog(@"indexpath%@",indexPath);
    CloseModel * model = self.modelArray[indexPath.row];
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
    for (CloseModel * model in self.modelArray)
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
- (void)detail:(CloseCell *)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    NSLog(@"%ld",(long)indexPath.row);
    OrderDetailViewController * ovc = [[OrderDetailViewController alloc]init];
    NSLog(@"%@",self.listArray[indexPath.row][@"numId"]);
    ovc.order = self.listArray[indexPath.row][@"numId"];
    ovc.finish = @"1";
    [self.navigationController pushViewController:ovc animated:YES];
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
- (void)goodsDetail:(CloseCell *)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if ([self.listArray[indexPath.row][@"w_cc"] isEqualToString:@"0"]) {
        NewYahooDetailViewController * nvc = [[NewYahooDetailViewController alloc]init];
        nvc.item = self.listArray[indexPath.row][@"w_lsh"];
        nvc.platform = self.listArray[indexPath.row][@"w_cc"];
        [self.navigationController pushViewController:nvc animated:YES];
    }else{
        NewEbayDetailViewController * nvc = [[NewEbayDetailViewController alloc]init];
        nvc.item = self.listArray[indexPath.row][@"w_lsh"];
        nvc.platform = self.listArray[indexPath.row][@"w_cc"];
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
