//
//  InfomationOneViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/7/19.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "InfomationOneViewController.h"
#import "HelpPageCell.h"
@interface InfomationOneViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger pageNum;
}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic , strong) NSMutableArray * listArray;
@end

@implementation InfomationOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pageNum = 0;
    [self createUI];
}
- (void)createUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-[Unity countcoordinatesH:40]) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
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
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [_tableView.mj_footer beginRefreshing];
        pageNum = pageNum+1;
        [self requestNoticeData];
        
    }];
    // 马上进入刷新状态
    [_tableView.mj_footer beginRefreshing];

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [UIView new];

    return view;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.listArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [Unity countcoordinatesH:50];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HelpPageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HelpPageCell class])];
    if (cell == nil) {
        cell = [[HelpPageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HelpPageCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configWithTitle:self.listArray[indexPath.row][@"w_title"] WithKeyword:@"" WithSearch:NO];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate cellSelect:self.listArray[indexPath.row]];
}
- (void)requestNoticeData{
    NSDictionary * dic = @{@"type":@"2",@"page":[NSString stringWithFormat:@"%ld",(long)pageNum]};
    [GZMrequest getWithURLString:[GZMUrl get_notice_url] parameters:dic success:^(NSDictionary *data) {
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
//            NSLog(@"%@",data[@"data"]);
            for (int i=0; i<[data[@"data"] count]; i++) {
                [self.listArray addObject:data[@"data"][i]];
            }
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
            if ([data[@"data"] count]  < 10) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [NSMutableArray new];
    }
    return _listArray;
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
