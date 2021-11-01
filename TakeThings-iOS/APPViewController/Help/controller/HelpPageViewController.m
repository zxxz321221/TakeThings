
//
//  HelpPageViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/29.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "HelpPageViewController.h"
#import "HelpPageCell.h"
#import "HelpDetailViewController.h"
#import "ActivityWebViewController.h"
#import "ServiceViewController.h"
@interface HelpPageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL isHidden;  //o默认yes   tableview 底部按钮 在数据加载出来之前隐藏掉
}
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) alertView * altView;
@property (nonatomic , strong) NSMutableArray * listArray;
@end

@implementation HelpPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isHidden = YES;
    [self creareUI];
//    [self requestHelpSearch];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = self.navTitle;
}
- (void)creareUI{
    [self.view addSubview:self.tableView];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT-NavBarHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        if (@available(iOS 11,*)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        //隐藏tableViewCell下划线 隐藏所有分割线
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //进行数据刷新操作
            [self requestHelpSearch];
        }];
        
        // 马上进入刷新状态
        [_tableView.mj_header beginRefreshing];
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
    return [Unity countcoordinatesH:50];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    HelpPageCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (cell == nil) {
        cell = [[HelpPageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configWithTitle:self.listArray[indexPath.row][@"title"] WithKeyword:@"" WithSearch:NO];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HelpDetailViewController * hvc = [[HelpDetailViewController alloc]init];
    hvc.navTitle = self.listArray[indexPath.row][@"title"];
    hvc.htmlStr = self.listArray[indexPath.row][@"content"];
    hvc.flow = self.listArray[indexPath.row][@"flow"];
    [self.navigationController pushViewController:hvc animated:YES];
}
#pragma mark - 自定义headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * header = [UIView new];
    header.backgroundColor = [Unity getColor:@"#ffffff"];
    return header;
}
//section 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

#pragma mark - 自定义footerView
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (isHidden) {
        return 0.1;
    }else{
        return [Unity countcoordinatesH:60];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [UIView new];
    if (!isHidden) {
        footer.backgroundColor = [Unity getColor:@"#ffffff"];
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        line.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [footer addSubview:line];
        
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, line.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        [btn addTarget:self action:@selector(footerClick) forControlEvents:UIControlEventTouchUpInside];
        
        [footer addSubview:btn];
        UIImageView * imageView = [Unity imageviewAddsuperview_superView:btn _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:18], [Unity countcoordinatesW:14], [Unity countcoordinatesW:14]) _imageName:@"help_footer" _backgroundColor:nil];
        UILabel * label = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake(imageView.right+[Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:200], [Unity countcoordinatesH:20]) _string:@"其它问题可在线联系客服" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
        UIImageView * back = [Unity imageviewAddsuperview_superView:btn _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:15], [Unity countcoordinatesH:20], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10]) _imageName:@"go" _backgroundColor:nil];
        back.backgroundColor = [UIColor clearColor];
    }
    return footer;
}
- (void)footerClick{
    ServiceViewController * svc = [[ServiceViewController alloc]init];
    svc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:svc animated:YES];
//    NSLog(@"footerView 在线联系客服");
//    ActivityWebViewController *webService = [[ActivityWebViewController alloc]init];
//    // 获得当前iPhone使用的语言
//    NSString* currentLanguage = NSLocalizedString(@"GlobalBuyer_Nativelanguage", nil);
//    NSLog(@"当前使用的语言：%@",currentLanguage);
//    if ([currentLanguage isEqualToString:@"zh-Hans-US"]) {
//        webService.href = @"http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html";
//    }else if([currentLanguage isEqualToString:@"zh-Hant"]){
//        webService.href = @"http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html";
//    }else if([currentLanguage isEqualToString:@"en"]){
//        webService.href = @"http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html";
//    }else{
//        webService.href = @"http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html";
//    }
//    webService.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:webService animated:YES];
}
- (void)requestHelpSearch{
//    [Unity showanimate];
    NSDictionary * dic = @{@"parent":self.num};
    [GZMrequest getWithURLString:[GZMUrl get_helpList2_url] parameters:dic success:^(NSDictionary *data) {
//        [Unity hiddenanimate];
        [self.tableView.mj_header endRefreshing];
        NSLog(@"帮助中心2级列表=%@",data);
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            isHidden = NO;
            [self.listArray removeAllObjects];
            for (int i=0; i<[data[@"data"] count]; i++) {
                [self.listArray addObject:data[@"data"][i]];
            }
            [self.tableView reloadData];
        }else{
            [self.altView showAlertView];
            self.altView.msgL.text = [data objectForKey:@"msg"];
        }
    } failure:^(NSError *error) {
//        [Unity hiddenanimate];
        [self.tableView.mj_header endRefreshing];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (alertView *)altView{
    if (_altView == nil) {
        _altView = [alertView setAlertView:self.view];
    }
    return _altView;
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
