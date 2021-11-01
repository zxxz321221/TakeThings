//
//  AddressViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/31.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressCell.h"
#import "Add_addressViewController.h"
#import "NoData.h"
@interface AddressViewController ()<UITableViewDelegate,UITableViewDataSource,AddressCellDelegate,addressSaveDelegate,NoDataDelegate>

@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) UIButton * addressBtn;

@property (nonatomic , strong) alertView * altView;

@property (nonatomic , strong) NSMutableArray * listArray;

@property (nonatomic , strong) UIImageView * noRecode;
@property (nonatomic , strong) NoData * nData;
@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
//    [self selectAddress];
//    [self.view addSubview:self.noRecode];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [Unity getColor:@"#f0f0f0"];
    self.title = @"收货地址";
}
- (void)createUI{
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
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //进行数据刷新操作
            [self selectAddress];
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
    return self.listArray.count;//cell个数
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [Unity countcoordinatesH:151];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AddressCell class])];
    if (cell == nil) {
        cell = [[AddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([AddressCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    [cell configWithAddressData:self.listArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.page == 0) {
        [self.delegate EntrustAddress:self.listArray WithIndexPath:indexPath.row];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (self.page == 1){
        [self.delegate EntrustAddress:self.listArray WithIndexPath:indexPath.row];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (self.page == 3){
        [self.delegate EntrustAddress:self.listArray WithIndexPath:indexPath.row];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (self.page == 4){
        [self.delegate EntrustAddress:self.listArray WithIndexPath:indexPath.row];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        return;
    }
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
    
    [footer addSubview:self.addressBtn];
    
    return footer;
}

- (UIButton *)addressBtn{
    if (!_addressBtn) {
        _addressBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        [_addressBtn addTarget:self action:@selector(AddressClick) forControlEvents:UIControlEventTouchUpInside];
        [_addressBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
        [_addressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addressBtn.layer.cornerRadius = _addressBtn.height/2;
        _addressBtn.backgroundColor = [Unity getColor:@"#aa112d"];
        _addressBtn.hidden= YES;
    }
    return _addressBtn;
}
- (void)AddressClick{
    Add_addressViewController * avc = [[Add_addressViewController alloc]init];
    avc.delegate = self;
    avc.isEdit = NO;
    [self.navigationController pushViewController:avc animated:YES];
}

#pragma mark addressCell代理
- (void)defaultCellDelegate:(AddressCell *_Nullable)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
     NSLog(@"%ld",(long)indexPath.row);
    [self setDefault:indexPath.row];
}
- (void)editCellDelegate:(AddressCell *_Nullable)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
     NSLog(@"%ld",(long)indexPath.row);
    Add_addressViewController * avc = [[Add_addressViewController alloc]init];
    avc.delegate = self;
    avc.addressDic = self.listArray[indexPath.row];
    avc.isEdit = YES;
    [self.navigationController pushViewController:avc animated:YES];
}
- (void)deleteCellDelegate:(AddressCell *_Nullable)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    NSLog(@"%ld",(long)indexPath.row);
    [self deleteAddressIndexPath:indexPath.row];
}
- (void)selectAddress{
    [self.listArray removeAllObjects];
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSLog(@"%@",[userInfo objectForKey:@"member_id"]);
    NSDictionary * dic = @{@"customer":[userInfo objectForKey:@"member_id"]};
//    [Unity showanimate];
    [GZMrequest getWithURLString:[GZMUrl get_selectAddress_url] parameters:dic success:^(NSDictionary *data) {
        NSLog(@"查询收货地址信息 %@",data);
//        [Unity hiddenanimate];
        [self.tableView.mj_header endRefreshing];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            
            for (int i=0; i<[data[@"data"] count]; i++) {
                [self.listArray addObject:data[@"data"][i]];
            }
            [self.tableView reloadData];
            if (self.listArray.count == 0) {
                self.addressBtn.hidden=YES;
                self.nData.imageView.image = [UIImage imageNamed:@"noaddress"];
                self.nData.msgLabel.text = @"您还没有收货地址哦，添加一个吧~";
                [self.nData.homeBtn setTitle:@"新建地址" forState:UIControlStateNormal];
                [self.nData showNoData];
            }else{
                self.addressBtn.hidden = NO;
                [self.nData hiddenNoData];
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
//删除收货地址
- (void)deleteAddressIndexPath:(NSInteger)index{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
//    NSLog(@"%@",[userInfo objectForKey:@"member_id"]);
    NSDictionary * dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"id":self.listArray[index][@"id"]};
    [Unity showanimate];
    [GZMrequest postWithURLString:[GZMUrl get_deleteAddress_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            [self.listArray removeObjectAtIndex:index];
            [self.tableView reloadData];
            [WHToast showMessage:@"删除成功" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            if (self.listArray.count == 0) {
                self.addressBtn.hidden=YES;
                self.nData.imageView.image = [UIImage imageNamed:@"noaddress"];
                self.nData.msgLabel.text = @"您还没有收货地址哦，添加一个吧~";
                [self.nData.homeBtn setTitle:@"新建地址" forState:UIControlStateNormal];
                [self.nData showNoData];
            }else{
                self.addressBtn.hidden = NO;
                [self.nData hiddenNoData];
            }
        }else{
            [self.altView showAlertView];
            self.altView.msgL.text = [data objectForKey:@"msg"];
        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
//设置默认地址
- (void)setDefault:(NSInteger)index{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSLog(@"%@",[userInfo objectForKey:@"member_id"]);
    NSDictionary * dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"id":self.listArray[index][@"id"]};
    [Unity showanimate];
    [GZMrequest postWithURLString:[GZMUrl get_setDefaultAddress_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            for (int i=0; i<self.listArray.count; i++) {
                NSMutableDictionary * dic = [NSMutableDictionary new];
                if (i==index) {
                    dic = [self.listArray[i] mutableCopy];
                    [dic setObject:@"1" forKey:@"if_default"];
                    [self.listArray replaceObjectAtIndex:i withObject:dic];
                }else{
                    dic = [self.listArray[i] mutableCopy];
                    [dic setObject:@"0" forKey:@"if_default"];
                    [self.listArray replaceObjectAtIndex:i withObject:dic];
                }
                [self.tableView reloadData];
            }
            NSLog(@"设置成功后 %@",self.listArray);
            [WHToast showMessage:@"设置成功" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            
        }else{
            [self.altView showAlertView];
            self.altView.msgL.text = [data objectForKey:@"msg"];
        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [NSMutableArray new];
    }
    return _listArray;
}
- (void)loadAddress{
    [self selectAddress];
}
- (UIImageView *)noRecode{
    if (!_noRecode) {
        _noRecode = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-[Unity countcoordinatesW:150])/2, (SCREEN_HEIGHT-NavBarHeight-[Unity countcoordinatesH:168])/2, [Unity countcoordinatesW:150], [Unity countcoordinatesH:168])];
        _noRecode.image = [UIImage imageNamed:@"norecord"];
    }
    return _noRecode;
}
- (NoData *)nData{
    if (!_nData) {
        _nData = [NoData setNoData:self.view];
        _nData.delegate = self;
    }
    return _nData;
}
- (void)pushHome{
    Add_addressViewController * avc = [[Add_addressViewController alloc]init];
    avc.delegate = self;
    avc.isEdit = NO;
    [self.navigationController pushViewController:avc animated:YES];
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
