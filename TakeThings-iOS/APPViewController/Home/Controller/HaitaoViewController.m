//
//  HaitaoViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/7/29.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "HaitaoViewController.h"
#import "HaitaoModel.h"
#import "HaitaoCell1.h"
#import "HaitaoCell2.h"
#import "HaitaoCell3.h"
#import "UIView+SDAutoLayout.h"
#import <UITableView+SDAutoTableViewCellHeight.h>
#import "MJExtension.h"
#import "HelpDetailViewController.h"
@interface HaitaoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger numPage;
}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic , strong) NSMutableArray * listArray;
@property (nonatomic , strong) NSArray * modeArray;
@end

@implementation HaitaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [Unity getColor:@"#f0f0f0"];
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.title = @"海淘资讯";
}
- (void)createUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight)];
    self.tableView.backgroundColor = [Unity getColor:@"#f0f0f0"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = FALSE;
    self.tableView.showsHorizontalScrollIndicator = FALSE;
    [self.tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    //没有数据时不显示cell
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.estimatedRowHeight = 0;
    }
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //进行数据刷新操作
        [self.tableView.mj_footer resetNoMoreData];
        numPage = 1;
        [self requestHaitaoData:numPage];
    }];
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //进行数据刷新操作
        [self requestHaitaoMore:numPage];
    }];
    
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    /*
    //     普通版也可实现一步设置搞定高度自适应，不再推荐使用此套方法，具体参看“UITableView+SDAutoTableViewCellHeight”头文件
    //     [self.tableView startAutoCellHeightWithCellClasses:@[[DemoVC7Cell class], [DemoVC7Cell2 class]] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
    //     */
    return self.modeArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    Class currentClass = [HaitaoCell1 class];
    HaitaoCell1 *cell = nil;
    
    HaitaoModel * model = self.modeArray[indexPath.row];
    if ([model.pic_type isEqualToString:@"s"]) {
        currentClass = [HaitaoCell2 class];
    }
    if ([model.pic_type isEqualToString:@"b"]) {
        currentClass = [HaitaoCell3 class];
    }
    if (!cell) {
        cell = [[currentClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
    //不显示多余的空Cell
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    cell.model = model;
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HaitaoModel * model = self.modeArray[indexPath.row];
    Class currentClass = [HaitaoCell1 class];
    if ([model.pic_type isEqualToString:@"s"]) {
        currentClass = [HaitaoCell2 class];
    }
    if ([model.pic_type isEqualToString:@"b"]) {
        currentClass = [HaitaoCell3 class];
    }
    
    //因为cell高度不确定 tableview是总高度也不确定 因而写下下面这段代码(通过返回的每个cell高度想加 计算出 所有cell的总高度S 重新设置tableview的frame 充值 scrollView的contentSize高度)
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:currentClass contentViewWidth:[self cellContentViewWith]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HelpDetailViewController * hvc = [[HelpDetailViewController alloc]init];
    hvc.navTitle = self.listArray[indexPath.row][@"w_title"];
    hvc.htmlStr = self.listArray[indexPath.row][@"w_content"];
    hvc.flow = @"0";
    hvc.type = 99;
    [self.navigationController pushViewController:hvc animated:YES];
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
#pragma mark - 自定义footerView
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return [Unity countcoordinatesH:0];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footerView = [UIView new];
    return footerView;
}
- (void)requestHaitaoData:(NSInteger )page{
    NSDictionary * dic = @{@"type":@"1",@"page":[NSString stringWithFormat:@"%ld",(long)page]};
    
    [GZMrequest getWithURLString:[GZMUrl get_haitao_url] parameters:dic success:^(NSDictionary *data) {
        NSLog(@"%@",data);
        [self.tableView.mj_header endRefreshing];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            [self.listArray removeAllObjects];
            numPage = numPage+1;
            if ([data[@"data"] count]  < 10) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            for (int i=0; i<[data[@"data"] count]; i++) {
                [self.listArray addObject:data[@"data"][i]];
            }
            self.modeArray = [HaitaoModel mj_objectArrayWithKeyValuesArray:self.listArray];
            [self.tableView reloadData];
        }else{
            [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)requestHaitaoMore:(NSInteger )page{
    
    NSDictionary * dic = @{@"type":@"1",@"page":[NSString stringWithFormat:@"%ld",(long)page]};
    
    [GZMrequest getWithURLString:[GZMUrl get_haitao_url] parameters:dic success:^(NSDictionary *data) {
        NSLog(@"%@",data);
        
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            numPage = numPage+1;
            for (int i=0; i<[data[@"data"] count]; i++) {
                [self.listArray addObject:data[@"data"][i]];
            }
            self.modeArray = [HaitaoModel mj_objectArrayWithKeyValuesArray:self.listArray];
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
            if ([data[@"data"] count]  < 10) {
                
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
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
- (NSArray *)modeArray{
    if (!_modeArray) {
        _modeArray = [NSArray new];
    }
    return _modeArray;
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
