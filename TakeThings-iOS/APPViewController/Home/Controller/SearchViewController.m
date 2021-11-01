//
//  SearchViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/15.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchCell.h"
#import "GoodsListViewController.h"
#import "EbayGoodsListViewController.h"
#import "UIViewController+YINNav.h"
@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,SearchCellDelegate>
{
    NSString * localeIndex;//0 原文 1 中文
    NSInteger source;//0 雅虎 5易贝  默认雅虎
}
@property (nonatomic , strong) UIView * navView;
@property (nonatomic , strong) UIView * searchView;
@property (nonatomic , strong) UITextField * searchText;
@property (nonatomic , strong) UIButton * searchBtn;
@property (nonatomic , strong) UIButton * originalBtn;
@property (nonatomic , strong) UIButton * ChineseBtn;
@property (nonatomic , strong) UILabel * originalL;//原文下方指示线
@property (nonatomic , strong) UILabel * chineseL;//中文下方指示线

@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) NSMutableArray * hotSearchArr;
@property (nonatomic , strong) NSMutableArray * historySearchArr;

@property (nonatomic , strong) AroundAnimation * aAnimation;
@property (nonatomic , strong) alertView * altView;

@property (nonatomic , strong) UIView * headerView;
@property (nonatomic , strong) UIButton * yahooBtn;
@property (nonatomic , strong) UIButton * ebayBtn;
@property (nonatomic , strong) UILabel * btnLine;
@property (nonatomic , strong) UIButton * goback;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    source = 0;
//    self. y_navLineHidden = YES;
    self.y_navBarBgColor = [Unity getColor:@"aa112d"];
    [self requestData];
    [self creareUI];
}
- (void)creareUI{
//    [self.navigationController.view addSubview:self.searchView];
//    [self.navigationController.view addSubview:self.searchBtn];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
}
- (UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight)];
        _navView.backgroundColor = [Unity getColor:@"aa112d"];
        [_navView addSubview:self.searchView];
        [_navView addSubview:self.searchBtn];
        [_navView addSubview:self.goback];
    }
    return _navView;
}
- (UIButton *)goback{
    if (!_goback) {
        _goback = [[UIButton alloc]initWithFrame:CGRectMake(12, NavBarHeight-44+12, 13, 20)];
        [_goback setBackgroundImage:[UIImage imageNamed:@"back_w"] forState:UIControlStateNormal];
        [_goback addTarget:self action:@selector(gobackClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goback;
}
- (void)gobackClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, [Unity countcoordinatesH:60])];
        _headerView.backgroundColor = [Unity getColor:@"aa112d"];
        UIImageView * imageView = [Unity imageviewAddsuperview_superView:_headerView _subViewFrame:CGRectMake(0, [Unity countcoordinatesH:50], SCREEN_WIDTH, [Unity countcoordinatesH:10]) _imageName:@"search_h" _backgroundColor:nil];
        [_headerView addSubview:self.yahooBtn];
        [_headerView addSubview:self.ebayBtn];
        [_headerView addSubview:self.btnLine];
    }
    return _headerView;
}
- (UIButton *)yahooBtn{
    if (!_yahooBtn) {
        _yahooBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-[Unity widthOfString:@"日本雅虎" OfFontSize:FontSize(16) OfHeight:[Unity countcoordinatesH:20]])/2, [Unity countcoordinatesH:10], [Unity widthOfString:@"日本雅虎" OfFontSize:FontSize(16) OfHeight:[Unity countcoordinatesH:20]], [Unity countcoordinatesH:20])];
        [_yahooBtn addTarget:self action:@selector(yahooClick) forControlEvents:UIControlEventTouchUpInside];
        [_yahooBtn setTitle:@"日本雅虎" forState:UIControlStateNormal];
        [_yahooBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_yahooBtn setTitleColor:[Unity getColor:@"ffb5c3"] forState:UIControlStateSelected];
        _yahooBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
        _yahooBtn.selected = YES;
    }
    return _yahooBtn;
}
- (UIButton *)ebayBtn{
    if (!_ebayBtn) {
        _ebayBtn = [[UIButton alloc]initWithFrame:CGRectMake(_yahooBtn.left+SCREEN_WIDTH/2, [Unity countcoordinatesH:10], _yahooBtn.width, [Unity countcoordinatesH:20])];
        [_ebayBtn addTarget:self action:@selector(ebayClick) forControlEvents:UIControlEventTouchUpInside];
        [_ebayBtn setTitle:@"美国易贝" forState:UIControlStateNormal];
        [_ebayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_ebayBtn setTitleColor:[Unity getColor:@"ffb5c3"] forState:UIControlStateSelected];
        _ebayBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _ebayBtn;
}
- (UILabel *)btnLine{
    if (!_btnLine) {
        _btnLine = [[UILabel alloc]initWithFrame:CGRectMake(_yahooBtn.left, _yahooBtn.bottom+[Unity countcoordinatesH:8], _yahooBtn.width, [Unity countcoordinatesH:1.5])];
        _btnLine.backgroundColor = [Unity getColor:@"ffb5c3"];
    }
    return _btnLine;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:60]+NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-[Unity countcoordinatesH:50]-NavBarHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
         if(@available(iOS 11.0, *)){
             _tableView.estimatedRowHeight = 0;
             
         }
        _tableView.separatorStyle = NO;//隐藏 tableView.separatorStyle = YES；
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (UIView *)searchView{
    if (_searchView == nil) {
        _searchView = [[UIView alloc]initWithFrame:CGRectMake(40, NavBarHeight-44, SCREEN_WIDTH-100, 37)];
        //        _searchView.backgroundColor = [UIColor yellowColor];
        UIImageView * searchImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 15, 20)];
        searchImgView.image = [UIImage imageNamed:@"home_search"];
        [_searchView addSubview:searchImgView];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, _searchView.width, 2)];
        line.backgroundColor = [Unity getColor:@"#ffb5c3"];
        [_searchView addSubview:line];
        
        [_searchView addSubview:self.searchText];
        [_searchView addSubview:self.originalBtn];
        [_searchView addSubview:self.ChineseBtn];
        
        _originalL = [[UILabel alloc]initWithFrame:CGRectMake(_originalBtn.left, _originalBtn.bottom+5, _originalBtn.width, 2)];
        [_searchView addSubview:self.originalL];
        _chineseL = [[UILabel alloc]initWithFrame:CGRectMake(_ChineseBtn.left, _ChineseBtn.bottom+5, _ChineseBtn.width, 2)];
        
        [_searchView addSubview:self.chineseL];
        if ([self.local isEqualToString:@"1"]) {
            _originalL.backgroundColor = [UIColor clearColor];
            _chineseL.backgroundColor = [Unity getColor:@"#ffffff"];
        }else{
            _originalL.backgroundColor = [Unity getColor:@"#ffffff"];
            _chineseL.backgroundColor = [UIColor clearColor];
        }
        localeIndex = self.local;
    }
    
    return _searchView;
}
- (UIButton *)searchBtn{
    if (_searchBtn ==nil) {
        _searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(_searchView.right+5, _searchView.top+7, 50, 30)];
        _searchBtn.backgroundColor = [Unity getColor:@"#ffffff"];
        _searchBtn.layer.cornerRadius = 15;
        [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        [_searchBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}
- (void)searchClick{
    if ([self.searchText.text isEqualToString:@""]) {
        return;
    }
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    if (!userInfo) {
        //获取当前时间
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSDate *datenow = [NSDate date];
        NSString *currentTimeString = [formatter stringFromDate:datenow];
        NSMutableDictionary * dic = [NSMutableDictionary new];
        [dic setObject:currentTimeString forKey:@"addtime"];
        [dic setObject:self.searchText.text forKey:@"word"];
        NSMutableArray * arr = [NSMutableArray new];
        arr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"historyS"] mutableCopy];
        if (arr == nil) {
            arr = [NSMutableArray new];
        }
        [arr addObject:dic];
        [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"historyS"];
    }
//    [self removeRepeat:self.searchText.text];

    NSMutableDictionary * dic = [NSMutableDictionary new];
    [dic setObject:self.searchText.text forKey:@"word"];
    [self.historySearchArr insertObject:dic atIndex:0];//在指定下标处插入元素
    NSInteger arrCount = self.historySearchArr.count;
    NSMutableArray * arr = [NSMutableArray new];
    for (int i=0; i<self.historySearchArr.count; i++) {
        
        if (self.historySearchArr.count == 0) {
            [arr addObject:self.historySearchArr[i]];
        }else{
            int o=0;
            for (int j=0; j<arr.count; j++) {
                
                if ([[arr[j]objectForKey:@"word"]isEqualToString:[self.historySearchArr[i]objectForKey:@"word"]]) {
                    o++;
                }
            }
            if (o == 0) {
                [arr addObject:self.historySearchArr[i]];
            }
        }
    }
    [self.historySearchArr removeAllObjects];
    self.historySearchArr = arr;
    NSLog(@"关键字 %@",arr);
    [self.tableView reloadData];
    
    if (source == 0) {//yahoo
        GoodsListViewController * gvc = [[GoodsListViewController alloc]init];
        gvc.isSearch = YES;
        gvc.locale = localeIndex;
        gvc.keyWord = self.searchText.text;
        gvc.platform = [NSString stringWithFormat:@"%ld",(long)source];
        [self.navigationController pushViewController:gvc animated:YES];
    }else{//ebay
        EbayGoodsListViewController * gvc = [[EbayGoodsListViewController alloc]init];
        gvc.isSearch = YES;
        gvc.locale = localeIndex;
        gvc.keyWord = self.searchText.text;
        gvc.platform = [NSString stringWithFormat:@"%ld",(long)source];
        [self.navigationController pushViewController:gvc animated:YES];
    }
    
}
- (UITextField *)searchText{
    if (_searchText == nil) {
        _searchText = [[UITextField alloc]initWithFrame:CGRectMake(25, 10, _searchView.width-25-85, 20)];
//        _searchText.placeholder = @"直接搜索关键词/粘贴商品网址";
        _searchText.textColor = [Unity getColor:@"#ffffff"];
        _searchText.font = [UIFont systemFontOfSize:FontSize(12)];
//        [_searchText  setValue:[Unity getColor:@"#d58896"]forKeyPath:@"_placeholderLabel.textColor"];
//        [_searchText  setValue:[UIFont  boldSystemFontOfSize:13]forKeyPath:@"_placeholderLabel.font"];
        _searchText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"直接搜索关键词/粘贴商品网址" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[Unity getColor:@"#d58896"]}]; ///新的实现
    }
    return _searchText;
}
- (UIButton *)originalBtn{
    if (_originalBtn == nil) {
        _originalBtn = [[UIButton alloc]initWithFrame:CGRectMake(_searchView.width-85, 10, 40, 20)];
        [_originalBtn setTitle:@"原文" forState:UIControlStateNormal];
        _originalBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        [_originalBtn setTitleColor:[Unity getColor:@"#f0f0f0"] forState:UIControlStateNormal];
        [_originalBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateSelected];
        [_originalBtn addTarget:self  action:@selector(originalClick) forControlEvents:UIControlEventTouchUpInside];
        if ([self.local isEqualToString:@"0"]) {
            _originalBtn.selected = YES;
        }
        
    }
    return _originalBtn;
}
- (UIButton *)ChineseBtn{
    if (_ChineseBtn == nil) {
        _ChineseBtn = [[UIButton alloc]initWithFrame:CGRectMake(_searchView.width-40, 10, 40, 20)];
        [_ChineseBtn setTitle:@"中文" forState:UIControlStateNormal];
        _ChineseBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        [_ChineseBtn setTitleColor:[Unity getColor:@"#f0f0f0"] forState:UIControlStateNormal];
        [_ChineseBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateSelected];
        [_ChineseBtn addTarget:self  action:@selector(chineseClick) forControlEvents:UIControlEventTouchUpInside];
        if ([self.local isEqualToString:@"1"]) {
            _ChineseBtn.selected = YES;
        }
    }
    return _ChineseBtn;
}
- (void)originalClick{
    localeIndex = @"0";
    self.originalBtn.selected = YES;
    self.ChineseBtn.selected = NO;
    _chineseL.backgroundColor = [UIColor clearColor];
    _originalL.backgroundColor = [Unity getColor:@"#ffffff"];
}
- (void)chineseClick{
    localeIndex = @"1";
    self.originalBtn.selected = NO;
    self.ChineseBtn.selected = YES;
    _chineseL.backgroundColor = [Unity getColor:@"#ffffff"];
    _originalL.backgroundColor = [UIColor clearColor];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
//    _searchView.hidden=NO;
//    _searchBtn.hidden = NO;
//    NSArray * myArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"historySearch"];
//    self.historySearchArr  = [NSMutableArray arrayWithArray:myArray];
    
//    [self addLeftBarButtonWithImage:[UIImage imageNamed:@"back_w"] action:@selector(goback)];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    _searchView.hidden= YES;
//    _searchBtn.hidden = YES;
    [self.searchText resignFirstResponder];//结束聚焦
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (CGFloat)tableView:(UITableView * )tableView heightForRowAtIndexPath:(NSIndexPath * )indexPath {
    if (indexPath.section == 0) {
        return [Unity countcoordinatesH:170];
    }else{
        return [Unity countcoordinatesH:300];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [Unity countcoordinatesH:40];
}
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:40])];
    if (section == 0) {
        UILabel * title = [Unity lableViewAddsuperview_superView:view _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], 200, [Unity countcoordinatesH:20]) _string:@"热门搜索" _lableFont:[UIFont systemFontOfSize:17] _lableTxtColor:[Unity getColor:@"#333333"] _textAlignment:NSTextAlignmentLeft];
        title.backgroundColor = [UIColor clearColor];
        return view;
    }else{
        UILabel * title = [Unity lableViewAddsuperview_superView:view _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], 200, [Unity countcoordinatesH:20]) _string:@"历史搜索" _lableFont:[UIFont systemFontOfSize:17] _lableTxtColor:[Unity getColor:@"#333333"] _textAlignment:NSTextAlignmentLeft];
        UIButton * clearBtn = [Unity buttonAddsuperview_superView:view _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:30], title.top, [Unity countcoordinatesW:20], title.height) _tag:self _action:@selector(clear_search) _string:@"" _imageName:@"clear_search"];
        return view;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SearchCell class])];
    if (cell == nil) {
        cell = [[SearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([SearchCell class])];
    }
    //清楚cell的缓存
    NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
    for (UIView *subview in subviews) {
        [subview removeFromSuperview];
    }
    
    if (indexPath.section == 0) {
        [cell configDatasource:self.hotSearchArr];
    }else{
        [cell configDatasource:self.historySearchArr];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
}
- (void)clear_search{
//    [self.historySearchArr removeAllObjects];
//    NSArray *myArray = [self.historySearchArr copy];
//    [[NSUserDefaults standardUserDefaults] setObject:myArray forKey:@"historySearch"];
//    [self.tableView reloadData];
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSString * customer;
    if (userInfo) {
        //已登录
        customer = [userInfo objectForKey:@"member_id"];
        [self.aAnimation startAround];
        NSDictionary *params = @{@"customer":customer};
        [GZMrequest postWithURLString:[GZMUrl get_deleteSearch_url]parameters:params success:^(NSDictionary *data) {
            [self.aAnimation stopAround];
            if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
                [self.historySearchArr removeAllObjects];
                [self.tableView reloadData];
                [WHToast showMessage:@"历史记录删除成功" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            }else{
                [self.altView showAlertView];
                self.altView.msgL.text = [data objectForKey:@"msg"];
            }
        } failure:^(NSError *error) {
            [self.aAnimation stopAround];
            [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }];
    }else{
        //未登录
        customer = @"";
    }
   
}
- (NSMutableArray *)hotSearchArr{
    if (_hotSearchArr == nil) {
        _hotSearchArr = [NSMutableArray array];
    }
    return _hotSearchArr;
}
- (NSMutableArray *)historySearchArr{
    if (_historySearchArr == nil) {
        _historySearchArr = [NSMutableArray array];
    }
    return _historySearchArr;
}
#pragma mark - SearchCell 事件
- (void)searchKeywords:(NSString *)str WithTag:(NSInteger)tag{
    self.searchText.text = str;
    [self searchClick];
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
- (void)requestData{
    [self.aAnimation startAround];
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSString * customer;
    if (userInfo) {
        //已登录
        customer = [userInfo objectForKey:@"member_id"];
    }else{
        //未登录
        customer = @"";
    }
    [self.hotSearchArr removeAllObjects];
    [self.historySearchArr removeAllObjects];
    NSDictionary *params = @{@"customer":customer};
    [GZMrequest getWithURLString:[GZMUrl get_searchhistory_url] parameters:params success:^(NSDictionary *data) {
        [self.aAnimation stopAround];
        NSLog(@"%@",data);
        
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            self.hotSearchArr = [data[@"data"][@"hot"] mutableCopy];
//            [self removeRepeat:data[@"data"][@"history"]];
            [self getSorting:data[@"data"][@"history"]];
            [self.tableView reloadData];
        }else{
            [self.altView showAlertView];
            self.altView.msgL.text = [data objectForKey:@"msg"];
        }
    } failure:^(NSError *error) {
        [self.aAnimation stopAround];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)getSorting:(NSArray *)arr{
    NSMutableArray * arr1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"historyS"];
    NSMutableArray * array = [NSMutableArray new];
    array = [arr mutableCopy];
    for (int i=0; i<arr1.count; i++) {
        [array addObject:arr1[i]];
    }
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"addtime" ascending:YES];
    NSMutableArray *sortDescriptors = [[NSMutableArray alloc] initWithObjects:&sorter count:1];
    NSArray *sortArray = [array sortedArrayUsingDescriptors:sortDescriptors];
 
    
    NSInteger arrCount = sortArray.count;
    [self.historySearchArr removeAllObjects];
    [array removeAllObjects];
    for (int i = arrCount-1; i>=0; i--) {
        [array addObject:sortArray[i]];
    }
    NSLog(@"排序后 = %@",array);
    
    //去重
    for (int i=0; i<array.count; i++) {
        
        if (self.historySearchArr.count == 0) {
            [self.historySearchArr addObject:array[i]];
        }else{
            int o=0;
            for (int j=0; j<self.historySearchArr.count; j++) {
                
                if ([[self.historySearchArr[j]objectForKey:@"word"]isEqualToString:[array[i]objectForKey:@"word"]]) {
                    o++;
                }
            }
            if (o == 0) {
                [self.historySearchArr addObject:array[i]];
            }
        }
    }
}
- (void)addLeftBarButtonWithImage:(UIImage *)image action:(SEL)action
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    view.backgroundColor = [UIColor clearColor];
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.frame = CGRectMake(0, 0, 44, 44);
    [firstButton setImage:image forState:UIControlStateNormal];
    [firstButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    firstButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0, 5 * SCREEN_WIDTH / 375.0, 0, 0)];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:firstButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}
- (void)yahooClick{
    self.yahooBtn.selected = YES;
    self.ebayBtn.selected = NO;
    self.btnLine.frame = CGRectMake(self.yahooBtn.left, self.yahooBtn.bottom+[Unity countcoordinatesH:8], self.yahooBtn.width, [Unity countcoordinatesH:1.5]);
    source = 0;
}
- (void)ebayClick{
    self.yahooBtn.selected=NO;
    self.ebayBtn.selected = YES;
    self.btnLine.frame = CGRectMake(self.ebayBtn.left, self.yahooBtn.bottom+[Unity countcoordinatesH:8], self.yahooBtn.width, [Unity countcoordinatesH:1.5]);
    source = 5;
}
//去重
- (void)removeRepeat:(NSArray *)arr1{
//    NSLog(@"arr1 = %@",arr1);
//    [self.historySearchArr removeAllObjects];
    
    NSInteger arrCount = arr1.count;
    NSMutableArray * arr = [NSMutableArray new];
    for (int i=arrCount-1; i>=0; i--) {
        [arr addObject:arr1[i]];
    }
    for (int i=0; i<arr.count; i++) {
        
        if (self.historySearchArr.count == 0) {
            [self.historySearchArr addObject:arr[i]];
        }else{
            int o=0;
            for (int j=0; j<self.historySearchArr.count; j++) {
                
                if ([[self.historySearchArr[j]objectForKey:@"word"]isEqualToString:[arr[i]objectForKey:@"word"]]) {
                    o++;
                }
            }
            if (o == 0) {
                [self.historySearchArr addObject:arr[i]];
            }
        }
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
