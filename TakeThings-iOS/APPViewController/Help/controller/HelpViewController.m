//
//  HelpViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/29.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "HelpViewController.h"
#import "HelpCell.h"
#import "HelpPageCell.h"
#import "HelpPageViewController.h"
#import "ActivityWebViewController.h"
#import "HelpDetailViewController.h"
#import "ServiceViewController.h"
//#import "ServiceHotlineViewController.h"
#define tableViewH     (IS_iPhoneX ? [Unity countcoordinatesH:90] : [Unity countcoordinatesH:80])
@interface HelpViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    BOOL isActive; //yes编辑状态 no退出编辑状态 默认no
    NSString * keyWord;
}
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic ,strong) UIView * bottomView;

@property (nonatomic , strong) UIView * maskView;

@property (nonatomic , strong) UITextField * searchText;
@property (nonatomic , strong) UIView * searchView;
@property (nonatomic , strong) UIImageView * searchIcon;
@property (nonatomic , strong) UIButton * cancelBtn;

@property (nonatomic , strong) NSMutableArray * listArray;//通过关键字搜索到的数据源
@property (nonatomic , strong) NSMutableArray * dataSource;//搜索到的所有j数据源

@property (nonatomic , strong) alertView * altView;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    keyWord= @"";
    isActive = NO;

    [self creareUI];
    
}
- (void)viewWillAppear:(BOOL)animate{
    [super viewWillAppear:animate];
    self.title = @"帮助中心";
}
- (void)creareUI{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.maskView];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT-NavBarHeight-tableViewH) style:UITableViewStyleGrouped];
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
        
        //        _tableView.scrollEnabled=NO;
        //隐藏tableViewCell下划线 隐藏所有分割线
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;

        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //进行数据刷新操作
            [self requestHelp];
        }];
        
        // 马上进入刷新状态
        [_tableView.mj_header beginRefreshing];
        
    }
    return _tableView;
}
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.tableView.bottom, SCREEN_WIDTH, tableViewH)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        line.backgroundColor = [Unity getColor:@"#e0e0e0"];
        [_bottomView addSubview:line];
        NSArray * arr = @[@{@"title":@"咨询电话",@"time":@"(周一至周五9:00-18:00)",@"icon":@"help_phone"},@{@"title":@"在线客服",@"time":@"(9:00-23:30)",@"icon":@"help_kf"}];
        for (int i=0; i<2; i++) {
            UIButton * btn = [Unity buttonAddsuperview_superView:_bottomView _subViewFrame:CGRectMake(i*(SCREEN_WIDTH/2), 0, SCREEN_WIDTH/2, tableViewH) _tag:self _action:@selector(bottomClick:) _string:@"" _imageName:@""];
            btn.tag = 2000+i;
            UIImageView * icon = [Unity imageviewAddsuperview_superView:btn _subViewFrame:CGRectMake((btn.width-[Unity countcoordinatesH:30])/2, [Unity countcoordinatesH:5], [Unity countcoordinatesH:30], [Unity countcoordinatesH:30]) _imageName:[arr[i]objectForKey:@"icon"] _backgroundColor:nil];
            UILabel * name = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake(0, icon.bottom+[Unity countcoordinatesH:5], btn.width, [Unity countcoordinatesH:20]) _string:[arr[i]objectForKey:@"title"] _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:[Unity getColor:@"#333333"] _textAlignment:NSTextAlignmentCenter];
            UILabel * time = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake(0, name.bottom, name.width, name.height) _string:[arr[i]objectForKey:@"time"] _lableFont:[UIFont systemFontOfSize:12] _lableTxtColor:[Unity getColor:@"#999999"] _textAlignment:NSTextAlignmentCenter];
        }
    }
    return _bottomView;
}
- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, NavBarHeight+60, SCREEN_WIDTH, SCREEN_HEIGHT-(NavBarHeight+60))];
        _maskView.backgroundColor = [UIColor whiteColor];
        _maskView.alpha = 0.5;
        _maskView.hidden=YES;
    }
    return _maskView;
}

#pragma mark - tableView  搭理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!isActive) {
        return self.dataSource.count;
    }
    return self.listArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [Unity countcoordinatesH:50];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    if (!isActive) {
        HelpCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (cell == nil) {
            cell = [[HelpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWithIcon:[NSString stringWithFormat:@"%@%@/ios/2x%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"],self.dataSource[indexPath.row][@"src"],self.dataSource[indexPath.row][@"end"]] WithTitle:[self.dataSource[indexPath.row]objectForKey:@"name"]];
        return cell;
    }else{
        HelpPageCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (cell == nil) {
            cell = [[HelpPageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWithTitle:self.listArray[indexPath.row][@"title"] WithKeyword:keyWord WithSearch:YES];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!isActive) {
        HelpPageViewController * hvc = [[HelpPageViewController alloc]init];
        hvc.navTitle = self.dataSource[indexPath.row][@"name"];
        hvc.num = self.dataSource[indexPath.row][@"id"];
        [self.navigationController pushViewController:hvc animated:YES];
    }else{
        NSLog(@"id  == %@",self.listArray[indexPath.row][@"id"]);
        HelpDetailViewController * hvc = [[HelpDetailViewController alloc]init];
        hvc.navTitle = self.listArray[indexPath.row][@"title"];
        hvc.flow = self.listArray[indexPath.row][@"flow"];
        hvc.htmlStr = self.listArray[indexPath.row][@"content"];
        [self.navigationController pushViewController:hvc animated:YES];
    }
}

#pragma mark - 自定义headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * header = [UIView new];
    header.backgroundColor = [Unity getColor:@"#ffffff"];
    [header addSubview:self.cancelBtn];
    [header addSubview:self.searchText];
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:49], SCREEN_WIDTH, [Unity countcoordinatesH:1])];
    line.backgroundColor = [Unity getColor:@"#f0f0f0"];
    [header addSubview:line];
    return header;
}
//section 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return [Unity countcoordinatesH:50];
}

#pragma mark - 自定义footerView
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [UIView new];
    footer.backgroundColor = [Unity getColor:@"#ffffff"];
    return footer;
}
- (UITextField *)searchText{
    if (!_searchText) {
        _searchText = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:[Unity countcoordinatesH:30]], [Unity countcoordinatesH:30])];
        _searchText.backgroundColor = [Unity getColor:@"#f0f0f0"];
        _searchText.layer.cornerRadius = _searchText.height/2;
        _searchText.placeholder = @"有问题搜索一下~";
        _searchText.font = [UIFont systemFontOfSize:FontSize(12)];
        _searchText.returnKeyType = UIReturnKeySearch;//变为搜索按钮
        
        _searchText.delegate = self;//设置代理
        //缩进
        _searchText.leftViewMode = UITextFieldViewModeAlways;
        _searchText.leftView = self.searchView;
        [_searchText addTarget:self action:@selector(searchText:) forControlEvents:UIControlEventEditingChanged];
    }
    return _searchText;
}
- (UIView *)searchView{
    if (!_searchView) {
        _searchView = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:8], [Unity countcoordinatesW:27]+(self.searchText.width-[Unity widthOfString:@"有问题搜索一下~" OfFontSize:FontSize(12) OfHeight:[Unity countcoordinatesH:30]]-[Unity countcoordinatesW:27])/2, [Unity countcoordinatesH:14])];
        [_searchView addSubview:self.searchIcon];
    }
    return _searchView;
}
- (UIImageView *)searchIcon{
    if (!_searchIcon) {
        _searchIcon = [[UIImageView alloc]initWithFrame:CGRectMake(self.searchView.width-[Unity countcoordinatesW:17], 0, [Unity countcoordinatesW:12], [Unity countcoordinatesW:14])];
        _searchIcon.image = [UIImage imageNamed:@"help_search"];
    }
    return _searchIcon;
}
- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50-[Unity countcoordinatesW:20], [Unity countcoordinatesH:10], 50, [Unity countcoordinatesH:30])];
        [_cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[Unity getColor:@"#333333"] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _cancelBtn.hidden = YES;
    }
    return _cancelBtn;
}
- (void)cancelClick{
    [self.listArray removeAllObjects];
    self.searchText.text = @"";
    [self.searchText resignFirstResponder];
    self.cancelBtn.hidden = YES;
    [UITextField animateWithDuration:0.3 animations:^{
        [self.searchText setFrame:CGRectMake([Unity countcoordinatesW:20], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:[Unity countcoordinatesH:30]], [Unity countcoordinatesH:30])];
    } completion:nil];
    
    self.searchView.frame = CGRectMake(0, [Unity countcoordinatesH:8], [Unity countcoordinatesW:27]+(self.searchText.width-[Unity widthOfString:@"有问题搜索一下~" OfFontSize:FontSize(12) OfHeight:[Unity countcoordinatesH:30]]-[Unity countcoordinatesW:27])/2, [Unity countcoordinatesH:14]);
    self.searchIcon.frame = CGRectMake(self.searchView.width-[Unity countcoordinatesW:17], 0, [Unity countcoordinatesW:12], [Unity countcoordinatesW:14]);
    self.searchText.leftViewMode = UITextFieldViewModeAlways;
    self.searchText.leftView = self.searchView;
    
    self.tableView.frame = CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT-NavBarHeight-tableViewH);
    self.bottomView.hidden=NO;
    isActive = NO;
    [self.tableView reloadData];
}
- (void)bottomClick:(UIButton *)sender{
    if (sender.tag == 2000) {
//        ServiceHotlineViewController *serviceHotlineVC = [[ServiceHotlineViewController alloc]init];
//        serviceHotlineVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:serviceHotlineVC animated:YES];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"telprompt://400-688-5060"]];
    }else{
        [self Service];
    }
}
- (void)Service
{
    ServiceViewController * svc = [[ServiceViewController alloc]init];
    svc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:svc animated:YES];
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

    //    MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
    //    [chatViewManager pushMQChatViewControllerInViewController:self];
}
//搜索虚拟键盘响应

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    keyWord = textField.text;
    NSLog(@"点击了搜索%@",textField.text);
    [self.listArray removeAllObjects];
    [self helpSearch:textField.text];
    [self.searchText resignFirstResponder];
    
    return YES;
    
}
//文本输入框开始输入时调用

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //获取焦点 刷新leftView坐标跟searchIcon坐标
    [UITextField animateWithDuration:0.3 animations:^{
    [self.searchText setFrame:CGRectMake([Unity countcoordinatesW:20], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:[Unity countcoordinatesH:30]]-50, [Unity countcoordinatesH:30])];
    }completion:nil];
    self.cancelBtn.hidden = NO;
    self.searchView.frame = CGRectMake(0, [Unity countcoordinatesH:8], [Unity countcoordinatesW:27], [Unity countcoordinatesH:14]);
    self.searchIcon.frame = CGRectMake(self.searchView.width-[Unity countcoordinatesW:17], 0, [Unity countcoordinatesW:12], [Unity countcoordinatesW:14]);
    self.searchText.leftViewMode = UITextFieldViewModeAlways;
    self.searchText.leftView = self.searchView;
    NSLog(@"开始输入");
    //获取焦点是 tableview高度变 大 底部view隐藏
    self.tableView.frame = CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT-NavBarHeight);
    self.bottomView.hidden=YES;
    
    isActive = YES;
//    [self.listArray removeAllObjects];
    [self.tableView reloadData];
    
}
- (void)searchText:(UITextField *)textField{
    NSLog(@"%@",textField.text);
}
//文本输入框结束输入时调用

- (void)textFieldDidEndEditing:(UITextField *)textField{
    //失去焦点
}
- (NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [NSMutableArray new];
    }
    return _listArray;
}
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}
- (void)requestHelp{
//    [Unity showanimate];
    NSDictionary * dic = @{@"system":@"bate"};
    [GZMrequest getWithURLString:[GZMUrl get_helpList_url] parameters:dic success:^(NSDictionary *data) {
//        [Unity hiddenanimate];
        [self.tableView.mj_header endRefreshing];
        NSLog(@"%@",data);
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            [self.dataSource removeAllObjects];
            
            for (int i=0; i<[data[@"data"] count]; i++) {
                [self.dataSource addObject:data[@"data"][i]];
                
                [self.tableView reloadData];
            }
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
- (void)helpSearch:(NSString *)word{
    NSDictionary * dic = @{@"info":word};
    [Unity showanimate];
    [GZMrequest getWithURLString:[GZMUrl get_helpSearch_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            for (int i=0; i<[data[@"data"] count]; i++) {
                [self.listArray addObject:data[@"data"][i]];
            }
            [self.tableView reloadData];
        }else{
            [self.altView showAlertView];
            self.altView.msgL.text = [data objectForKey:@"msg"];
        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
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
