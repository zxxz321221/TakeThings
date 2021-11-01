//
//  MessagePageOneViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/24.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "MessagePageOneViewController.h"
#import "MsgModel.h"
#import "MessageCell1.h"
#import "MessageCell2.h"
#import "MessageCell3.h"
#import "UIView+SDAutoLayout.h"
#import <UITableView+SDAutoTableViewCellHeight.h>
#import <MJExtension.h>
@interface MessagePageOneViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger  page;
}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic , strong) NSMutableArray *listArray;
@property (nonatomic , strong) NSMutableArray * modelArray;

@end

@implementation MessagePageOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [Unity getColor:@"#f0f0f0"];
    [self createUI];
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
        page = 1;
        [self requestMessageList:page WithType:@"up"];
    }];
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page = page+1;
        [self requestMessageList:page WithType:@"down"];
    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    /*
    //     普通版也可实现一步设置搞定高度自适应，不再推荐使用此套方法，具体参看“UITableView+SDAutoTableViewCellHeight”头文件
    //     [self.tableView startAutoCellHeightWithCellClasses:@[[DemoVC7Cell class], [DemoVC7Cell2 class]] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
    //     */
    return self.modelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    Class currentClass = [MessageCell1 class];
    MessageCell1 *cell = nil;
    
    MsgModel * model = self.modelArray[indexPath.row];
    if (model.image_type == 1) {
        currentClass = [MessageCell2 class];
    }
    if (model.image_type == 2) {
        currentClass = [MessageCell3 class];
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
    MsgModel * model = self.modelArray[indexPath.row];
    Class currentClass = [MessageCell1 class];
    
    if (model.image_type == 1) {
        currentClass = [MessageCell2 class];
        return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:currentClass contentViewWidth:[self cellContentViewWith]];
    }
    if (model.image_type == 2) {
        currentClass = [MessageCell3 class];
        return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:currentClass contentViewWidth:[self cellContentViewWith]];
    }
    //因为cell高度不确定 tableview是总高度也不确定 因而写下下面这段代码(通过返回的每个cell高度想加 计算出 所有cell的总高度S 重新设置tableview的frame 充值 scrollView的contentSize高度)
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:currentClass contentViewWidth:[self cellContentViewWith]];
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
    
    return [Unity countcoordinatesH:20];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footerView = [UIView new];
    footerView.backgroundColor = [Unity getColor:@"#f0f0f0"];
    return footerView;
}
- (NSMutableArray * )listArray{
    if (!_listArray) {
        _listArray = [NSMutableArray new];
    }
    return _listArray;
}
- (NSMutableArray * )modelArray{
    if (!_modelArray) {
        _modelArray = [NSMutableArray new];
    }
    return _modelArray;
}
- (void)requestMessageList:(NSInteger)pageNum WithType:(NSString *)type{
    NSDictionary * info = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"page":[NSString stringWithFormat:@"%ld",(long)pageNum],@"user":info[@"member_id"],@"type":@"1",@"tag":[Unity getLanguage]};
//    NSLog(@"%@",dic);
    [GZMrequest getWithURLString:[GZMUrl get_messageList_url] parameters:dic success:^(NSDictionary *data) {
        if ([data[@"status"] intValue] ==1) {
            if ([type isEqualToString:@"up"]) {
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer resetNoMoreData];
                [self.listArray removeAllObjects];
                for (int i=0; i<[data[@"data"][@"data"] count]; i++) {
//                    NSLog(@"字典 %@",data[@"data"][@"data"][i]);
                    [self.listArray addObject:data[@"data"][@"data"][i]];
                }
                [self.modelArray removeAllObjects];
                self.modelArray = [MsgModel mj_objectArrayWithKeyValuesArray:self.listArray];
                [self.tableView reloadData];
            }else{
                [self.tableView.mj_footer endRefreshing];
                if ([data[@"data"][@"data"] count] < 12) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    [WHToast showMessage:@"没有更多数据了" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
                }
                for (int i=0; i<[data[@"data"][@"data"] count]; i++) {
//                    NSLog(@"字典 %@",data[@"data"][@"data"][i]);
                    [self.listArray addObject:data[@"data"][@"data"][i]];
                }
                [self.modelArray removeAllObjects];
                self.modelArray = [MsgModel mj_objectArrayWithKeyValuesArray:self.listArray];
                [self.tableView reloadData];
            }
            
        }else{
            [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
        
    } failure:^(NSError *error) {
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
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
