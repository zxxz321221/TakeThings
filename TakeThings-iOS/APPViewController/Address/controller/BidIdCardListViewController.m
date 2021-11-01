//
//  BidIdCardListViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/3.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "BidIdCardListViewController.h"
#import "BidCardCell.h"
#import "BidIdCardViewController.h"
#import "UIViewController+YINNav.h"
@interface BidIdCardListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) NSMutableArray * listArray;
@property (nonatomic , strong) UIButton * upload;
@end

@implementation BidIdCardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    if (![userInfo[@"back"] isEqualToString:@""]) {
        NSDictionary * dic = @{@"name":userInfo[@"name"],@"num":userInfo[@"num"]};
        [self.listArray addObject:dic];
    }
    self.y_navLineHidden = YES;
    [self setupUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"身份证绑定";
    self.view.backgroundColor = [Unity getColor:@"#f0f0f0"];
}
- (void)setupUI{
    [self.view addSubview:self.tableView];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT-NavBarHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
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
        
    }
    return _tableView;
}
#pragma mark - tableView  搭理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;//cell个数
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [Unity countcoordinatesH:115];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BidCardCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BidCardCell class])];
    if (cell == nil) {
        cell = [[BidCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([BidCardCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configWithName:self.listArray[indexPath.row][@"name"] WithIdCardNum:self.listArray[indexPath.row][@"num"]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //点击事件
    [self.delegate selectRealName];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 自定义headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}
//section 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

#pragma mark - 自定义footerView
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return [Unity countcoordinatesH:70];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [UIView new];
    
    [footer addSubview:self.upload];
    
    return footer;
}
- (UIButton *)upload{
    if (!_upload) {
        _upload = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        [_upload addTarget:self action:@selector(uploadClick) forControlEvents:UIControlEventTouchUpInside];
        [_upload setTitle:@"重新上传身份证" forState:UIControlStateNormal];
        _upload.backgroundColor = [Unity getColor:@"#aa112d"];
        [_upload setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _upload.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
        _upload.layer.cornerRadius = _upload.height/2;
    }
    return _upload;
}
- (void)uploadClick{
    BidIdCardViewController * bvc = [[BidIdCardViewController alloc]init];
    bvc.isEdit=self.isEdit;
    bvc.addressDic = self.addressDic;
    [self.navigationController pushViewController:bvc animated:YES];
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
