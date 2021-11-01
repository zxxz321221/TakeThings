//
//  WebPageViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/17.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "WebPageViewController.h"
#import "GoodsListViewController.h"
#import "UIViewController+YINNav.h"
@interface WebPageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * arr;
}
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) AroundAnimation * aAnimation;
@property (nonatomic , strong) alertView * altView;

@property (nonatomic , strong) NSMutableArray * sectionTitles;
@property (nonatomic , strong) NSMutableArray * contentsArray;
@end

@implementation WebPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arr = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    self.y_navBarBgColor = [Unity getColor:@"aa112d"];
//    [self readySource];
    
    [self.view addSubview:self.tableView];
    
//    [self requestBrand];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-TabBarHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = FALSE;
        _tableView.showsHorizontalScrollIndicator = FALSE;
        [_tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //进行数据刷新操作
            [self requestBrand];
        }];
        // 马上进入刷新状态
        [self.tableView.mj_header beginRefreshing];
    }
    return _tableView;
}
#pragma mark - UITableViewDelegate && UITableViewDataSource
//多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionTitles.count;
}
//每个分区多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.contentsArray[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    
    cell.textLabel.text = self.contentsArray[indexPath.section][indexPath.row][@"w_title"];
    cell.textLabel.textColor = LabelColor3;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",self.contentsArray[indexPath.section][indexPath.row][@"w_title"]);
    GoodsListViewController * gvc = [[GoodsListViewController alloc]init];
    gvc.hidesBottomBarWhenPushed = YES;
    gvc.pageIndex =1;
    gvc.isSearch = NO;
    gvc.platform = @"0";
    gvc.brandId = self.contentsArray[indexPath.section][indexPath.row][@"w_title"];
    [self.navigationController pushViewController:gvc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [Unity countcoordinatesH:50];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [Unity countcoordinatesH:30];
}

// 每个分区的页眉
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sectionTitles objectAtIndex:section];//组头
}
// 索引目录
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionTitles;
}
// 点击目录
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    // 获取所点目录对应的indexPath值
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    
    // 让table滚动到对应的indexPath位置
    [tableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    return index;
}
//右侧索引字体和大小
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    for (UIView *view in [tableView subviews]) {
        if ([view isKindOfClass:[NSClassFromString(@"UITableViewIndex") class]]) {
            // 设置字体大小
            [view setValue:[UIFont fontWithName:@"Thonburi" size:16] forKey:@"_font"];
            
            //设置view的大小
            view.bounds = CGRectMake(0, 0, 30, SCREEN_HEIGHT-NavBarHeight-TabBarHeight);
            [view setBackgroundColor:[UIColor clearColor]];
            //单单设置其中一个是无效的
        }
    }
    
}
- (void)requestBrand{
//    [self.aAnimation startAround];
    [GZMrequest getWithURLString:[GZMUrl get_brand_url] parameters:nil success:^(NSDictionary *data) {
//        [self.aAnimation stopAround];
//        NSLog(@"品牌列表%@",data);
        [self.tableView.mj_header endRefreshing];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            [self.sectionTitles removeAllObjects];
            [self.contentsArray removeAllObjects];
            [self.tableView.mj_header endRefreshing];
            NSArray *arrKeys = [data[@"data"] allKeys];
            NSMutableArray * mutableArray = [self sorting:arrKeys];
//            NSLog(@"arrkeys  %@",arrKeys);
            for (int i=0; i<mutableArray.count; i++) {
                int j=[mutableArray[i] intValue];
                [self.sectionTitles addObject:self->arr[j]];
            }
            
            for (int i=0; i<[data[@"data"] count]; i++) {
                NSMutableArray * mArr = [NSMutableArray new];
                for (int j=0; j<[data[@"data"][mutableArray[i]] count]; j++) {
                    [mArr addObject:data[@"data"][mutableArray[i]][j]];
                }
                [self.contentsArray addObject:mArr];
            }
            [self.tableView reloadData];
        }else{
            [self.altView showAlertView];
            self.altView.msgL.text = [data objectForKey:@"msg"];
        }
    } failure:^(NSError *error) {
//        [self.aAnimation stopAround];
        [self.tableView.mj_header endRefreshing];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (AroundAnimation *)aAnimation{
    if (!_aAnimation) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _aAnimation = [AroundAnimation AroundAnimationViewSetView:window];
    }
    return _aAnimation;
}
- (alertView *)altView{
    if (_altView == nil) {
        _altView = [alertView setAlertView:self.view];
    }
    return _altView;
}
- (NSMutableArray *)sectionTitles{
    if (!_sectionTitles) {
        _sectionTitles = [NSMutableArray new];
    }
    return _sectionTitles;
}
- (NSMutableArray * )contentsArray{
    if (!_contentsArray) {
        _contentsArray = [NSMutableArray new];
    }
    return _contentsArray;
}
//数组排序
- (NSMutableArray *)sorting:(NSArray *)arr1{
    
    NSMutableArray *priceArray = [arr1 mutableCopy];
    
    [priceArray sortUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2)
     {
         if ([obj1 integerValue] < [obj2 integerValue]){
             return NSOrderedAscending;
         }else{
             return NSOrderedDescending;
         }
     }];
//    NSLog(@"排序 %@",priceArray);
    return priceArray;
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
