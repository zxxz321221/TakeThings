//
//  BalanceViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/3.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "BalanceViewController.h"
#import "BalanceCell.h"
#import "BillDetailViewController.h"
#import "CashViewController.h"
#import "NewCashViewController.h"
#import "RechargeViewController.h"
#import "PayPassWordView.h"
#import "AuthenticationViewController.h"
#import "UIViewController+YINNav.h"
@interface BalanceViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,PayPassWordViewDelegate,UIScrollViewDelegate,NewCashDelegate,RechargeDelegate>
{
    BOOL isBill;//默认no
    BOOL isTime;//默认NO  yes弹出
    NSString *yearStr;
    NSString *monthStr;
    NSDictionary * userInfo;
    NSInteger pageNum;
    NSString * reType;//列表筛选  空 全部 s收入 z支出
    NSString * reTime;//列表筛选 默认为空不筛选
    float fl;
}
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) UIView * headerView;
@property (nonatomic , strong) UIView * headerV;
@property (nonatomic , strong) UIImageView * imageView;
@property (nonatomic , strong) UILabel * currentL;//当前余额（RMB）
@property (nonatomic , strong) UIButton * eyesBtn;
@property (nonatomic , strong) UILabel * balanceL;
@property (nonatomic , strong) UIButton * refundBtn;//退款
@property (nonatomic , strong) UIButton * rechargeBtn;//充值
@property (nonatomic , strong) UILabel * mmmLabel;//账单明细前面的小块
@property (nonatomic , strong) UILabel * billL;//账单标题

@property (nonatomic , strong) UIButton * allBillBtn;
@property (nonatomic , strong) UIImageView * billImg;
@property (nonatomic , strong) UIButton * timeBtn;
@property (nonatomic , strong) UIImageView * timeImg;

@property (nonatomic , strong) UIView * billView;
@property (nonatomic , strong) UIView * maskView;
@property (nonatomic , strong) UIButton * bill_all;
@property (nonatomic , strong) UIButton * bill_refund;
@property (nonatomic , strong) UIButton * bill_recharge;

@property (nonatomic , strong) UIView * pickView;

//pickerView 选择器
@property(strong , nonatomic) UIPickerView * pickerView;
@property (nonatomic , strong) NSMutableDictionary * dic;
@property (nonatomic , strong) NSMutableArray * pickerArray;
@property (nonatomic , strong) NSMutableArray * yearArray;
@property (nonatomic , strong) NSMutableArray * monthArray;

@property (nonatomic , strong) PayPassWordView * pView;

@property (nonatomic , strong) NSMutableArray * listArray;
@end
@implementation BalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    fl = 0.0;
    reType = @"";
    reTime = @"";
    pageNum = 0;
    self.y_navLineHidden = YES;
    isBill = NO;
    isTime = NO;
    [self setupUI];
    [self reloadB];
//    userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
//    if ([userInfo[@"w_remainappear"] isEqualToString:@"1"]) {
//        self.eyesBtn.selected = YES;
////        self.balanceL.text = userInfo[@"w_yk_tw"];
//    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    self.title = @"我的余额";
    
    [self currentData];
    
}
- (void)currentData{
    //获取当前时间日期
    NSDate *date=[NSDate date];
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"yyyy-MM"];
    NSString *dateStr;
    dateStr=[format1 stringFromDate:date];
    NSArray *array = [dateStr componentsSeparatedByString:@"-"]; //从字符A中分隔成2个元素的数组
    NSLog(@"%@",dateStr);
    for (int i=0; i<20; i++) {
        if (2012+i<=[array[0]intValue]) {
            [self.yearArray addObject:[NSString stringWithFormat:@"%d年",2012+i]];
        }
    }
//    NSLog(@"%@",yearArray);
    for (int i=0; i<self.yearArray.count; i++) {
        if ([self.yearArray[i]isEqualToString:@"2012年"]) {
            NSArray * arr = @[@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"];
            [self.dic setObject:arr forKey:self.yearArray[i]];
        }else if ([self.yearArray[i]isEqualToString:@"2019年"]){
            NSMutableArray * arr = [NSMutableArray new];
            for (int i=1; i<=[array[1]intValue]; i++) {
                [arr addObject:[NSString stringWithFormat:@"%d月",i]];
            }
            [self.dic setObject:arr forKey:self.yearArray[i]];
        }else{
            NSArray * arr = @[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"];
            [self.dic setObject:arr forKey:self.yearArray[i]];
        }
    }
//    NSLog(@"%@",self.dic);
    self.pickerArray = [[NSMutableArray alloc]initWithObjects:self.yearArray,self.dic[@"2012年"], nil];
    yearStr = @"2012年";
    monthStr = @"7月";
}
- (void)setupUI{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.billView];
    [self.view addSubview:self.pickView];
    
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT-NavBarHeight) style:UITableViewStylePlain];
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
        
        // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            //进行数据刷新操作
            pageNum = pageNum+1;
            [self requestData:reType WithTime:reTime];
        }];
        // 马上进入刷新状态
        [_tableView.mj_footer beginRefreshing];
    }
    return _tableView;
}
#pragma mark - tableView  搭理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return self.listArray.count;
    }
    //cell个数
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [Unity countcoordinatesH:80];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellidentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    BalanceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil) {
        cell = [[BalanceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configWithData:self.listArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    BillDetailViewController * bvc = [[BillDetailViewController alloc]init];
    bvc.dict = self.listArray[indexPath.row];
    [self.navigationController pushViewController:bvc animated:YES];
}

#pragma mark - 自定义headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.headerView;
    }
    return self.headerV;
}
//section 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return [Unity countcoordinatesH:225];
    }else{
        return [Unity countcoordinatesH:50];
    }
}

#pragma mark - 自定义footerView
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [UIView new];
    
    return footer;
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:225])];
        
        [_headerView addSubview:self.imageView];
        [_headerView addSubview:self.refundBtn];
        [_headerView addSubview:self.rechargeBtn];
    }
    return _headerView;
}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:8], [Unity countcoordinatesW:300], [Unity countcoordinatesH:147])];
        _imageView.image = [UIImage imageNamed:@"balance_back"];
        _imageView.userInteractionEnabled = YES;
        [_imageView addSubview:self.currentL];
        [_imageView addSubview:self.eyesBtn];
        [_imageView addSubview:self.balanceL];
    }
    return _imageView;
}
- (UILabel *)currentL{
    if (!_currentL) {
        _currentL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:45], [Unity countcoordinatesW:200], [Unity countcoordinatesH:15])];
        _currentL.text = @"当前余额(RMB)";
        _currentL.textColor = [UIColor whiteColor];
        _currentL.textAlignment = NSTextAlignmentLeft;
        _currentL.font = [UIFont systemFontOfSize:FontSize(14)];
        [_currentL sizeToFit];
    }
    return _currentL;
}
- (UIButton *)eyesBtn{
    if (!_eyesBtn) {
        _eyesBtn = [[UIButton alloc]initWithFrame:CGRectMake(_currentL.right+[Unity countcoordinatesW:10], _currentL.top+[Unity countcoordinatesH:1], [Unity countcoordinatesW:15], [Unity countcoordinatesH:13])];
        [_eyesBtn addTarget:self action:@selector(eyesClick) forControlEvents:UIControlEventTouchUpInside];
        [_eyesBtn setBackgroundImage:[UIImage imageNamed:@"隐藏"] forState:UIControlStateNormal];
        [_eyesBtn setBackgroundImage:[UIImage imageNamed:@"显示"] forState:UIControlStateSelected];
        if ([userInfo[@"w_remainappear"] isEqualToString:@"1"]) {
            _eyesBtn.selected = YES;
        }
    }
    return _eyesBtn;
}
- (UILabel *)balanceL{
    if (!_balanceL) {
        _balanceL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _currentL.bottom+[Unity countcoordinatesH:15], _imageView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:60])];
        _balanceL.text = @"****";
        _balanceL.textColor = [UIColor whiteColor];
        _balanceL.textAlignment = NSTextAlignmentLeft;
        _balanceL.font = [UIFont systemFontOfSize:FontSize(55)];
        if ([userInfo[@"w_remainappear"] isEqualToString:@"1"]) {
            NSLog(@"sss=%@",userInfo);
            _balanceL.text = userInfo[@"w_yk_tw"];
        }
    }
    return _balanceL;
}
- (UIButton *)refundBtn{
    if (!_refundBtn) {
        _refundBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _imageView.bottom+[Unity countcoordinatesH:15], (SCREEN_WIDTH-[Unity countcoordinatesW:30])/2, [Unity countcoordinatesH:40])];
        [_refundBtn addTarget:self action:@selector(refundClick) forControlEvents:UIControlEventTouchUpInside];
        _refundBtn.layer.borderWidth = 1;
        _refundBtn.layer.borderColor = [Unity getColor:@"#aa112d"].CGColor;
        _refundBtn.layer.cornerRadius = _refundBtn.height/2;
        [_refundBtn setTitle:@"退款" forState:UIControlStateNormal];
        [_refundBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        _refundBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _refundBtn;
}
- (UIButton *)rechargeBtn{
    if (!_rechargeBtn) {
        _rechargeBtn = [[UIButton alloc]initWithFrame:CGRectMake(_refundBtn.right+[Unity countcoordinatesW:10], _refundBtn.top, _refundBtn.width, _refundBtn.height)];
        [_rechargeBtn addTarget:self action:@selector(rechargeClick) forControlEvents:UIControlEventTouchUpInside];
        _rechargeBtn.backgroundColor = [Unity getColor:@"#aa112d"];
        [_rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
        [_rechargeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rechargeBtn.layer.cornerRadius = _rechargeBtn.height/2;
        _rechargeBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _rechargeBtn;
}
- (UIView *)headerV{
    if (!_headerV) {
        _headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        _headerV.backgroundColor = [UIColor whiteColor];
        [_headerV addSubview:self.mmmLabel];
        [_headerV addSubview:self.billL];
        [_headerV addSubview:self.allBillBtn];
        [_headerV addSubview:self.billImg];
        [_headerV addSubview:self.timeBtn];
        [_headerV addSubview:self.timeImg];
    }
    return _headerV;
}
- (UILabel *)mmmLabel{
    if (!_mmmLabel) {
        _mmmLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:20], [Unity countcoordinatesW:3], [Unity countcoordinatesH:10])];
        _mmmLabel.backgroundColor = [Unity getColor:@"#aa112d"];
    }
    return _mmmLabel;
}
- (UILabel *)billL{
    if (!_billL) {
        _billL = [[UILabel alloc]initWithFrame:CGRectMake(_mmmLabel.right+[Unity countcoordinatesW:5], [Unity countcoordinatesH:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _billL.text = @"账单明细";
        _billL.textColor = LabelColor3;
        _billL.textAlignment = NSTextAlignmentLeft;
        _billL.font = [UIFont systemFontOfSize:FontSize(17)];
//        [_billL sizeToFit];
    }
    return _billL;
}
- (UIButton *)allBillBtn{
    if (!_allBillBtn) {
        CGFloat W = [Unity widthOfString:@"全部账单" OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:20]];
        _allBillBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-W*2-[Unity countcoordinatesW:47],0, W, [Unity countcoordinatesH:50])];
        [_allBillBtn addTarget:self action:@selector(allbillClick) forControlEvents:UIControlEventTouchUpInside];
        [_allBillBtn setTitle:@"全部账单" forState:UIControlStateNormal];
        [_allBillBtn setTitleColor: LabelColor3 forState:UIControlStateNormal];
        _allBillBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _allBillBtn;
}
- (UIImageView *)billImg{
    if (!_billImg) {
        _billImg = [[UIImageView alloc]initWithFrame:CGRectMake(_allBillBtn.right+[Unity countcoordinatesW:5], [Unity countcoordinatesH:23.5], [Unity countcoordinatesW:6], [Unity countcoordinatesH:3])];
        _billImg.image = [UIImage imageNamed:@"下三角"];
    }
    return _billImg;
}
- (UIButton *)timeBtn{
    if (!_timeBtn) {
        _timeBtn = [[UIButton alloc]initWithFrame:CGRectMake(_billImg.right+[Unity countcoordinatesW:15], _allBillBtn.top, _allBillBtn.width, _allBillBtn.height)];
        [_timeBtn addTarget:self action:@selector(timeClick) forControlEvents:UIControlEventTouchUpInside];
        [_timeBtn setTitle:@"选择时间" forState:UIControlStateNormal];
        [_timeBtn setTitleColor: LabelColor3 forState:UIControlStateNormal];
        _timeBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _timeBtn;
}
- (UIImageView *)timeImg{
    if (!_timeImg) {
        _timeImg = [[UIImageView alloc]initWithFrame:CGRectMake(_timeBtn.right+[Unity countcoordinatesW:5], [Unity countcoordinatesH:23.5], [Unity countcoordinatesW:6], [Unity countcoordinatesH:3])];
        _timeImg.image = [UIImage imageNamed:@"下三角"];
    }
    return _timeImg;
}

#pragma mark  ----
- (void)eyesClick{
    userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSString * status;
    if (self.eyesBtn.selected) {
        self.eyesBtn.selected = NO;
        self.balanceL.text = @"****";
        status = @"0";
    }else{
        self.eyesBtn.selected = YES;
        self.balanceL.text = userInfo[@"w_yk_tw"];
        status = @"1";
    }
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    [Unity showanimate];
    NSDictionary *params = @{@"customer":userInfo[@"member_id"],@"status":status};
    [GZMrequest postWithURLString:[GZMUrl get_blanceShow_url] parameters:params success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            NSMutableDictionary * dic = [NSMutableDictionary new];
            dic = [userInfo mutableCopy];
            [dic setObject:status forKey:@"w_remainappear"];
            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"userInfo"];
        }else{
            [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}

- (void)refundClick{
    if ([userInfo[@"pay_password"] isEqualToString:@""]) {
        [self.pView showPayPasswordView];
        return;
    }
    NewCashViewController * cvc = [[NewCashViewController alloc]init];
    cvc.delegate = self;
    cvc.balance = userInfo[@"w_yk_tw"];
    [self.navigationController pushViewController:cvc animated:YES];
}
- (void)rechargeClick{
    RechargeViewController * rvc = [[RechargeViewController alloc]init];
    rvc.delegate = self;
    [self.navigationController pushViewController:rvc animated:YES];
//    [WHToast showMessage:@"暂未开通,敬请期待" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
}
- (void)allbillClick{
//    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] animated:YES scrollPosition:UITableViewScrollPositionTop];
    self.maskView.frame = CGRectMake(0, [Unity countcoordinatesH:275]-fl, SCREEN_WIDTH, SCREEN_HEIGHT-([Unity countcoordinatesH:275]-fl)-NavBarHeight);
    self.tableView.scrollEnabled  = NO;
    if (isBill) {
        self.billImg.image = [UIImage imageNamed:@"下三角"];
        isBill = NO;
    }else{
        self.billImg.image = [UIImage imageNamed:@"上三角"];
        self.timeImg.image = [UIImage imageNamed:@"下三角"];
        isTime = NO;
        isBill = YES;
    }
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.5];
}
- (void)delayMethod{
    if (self.pickView.hidden == NO) {
        self.pickView.frame = CGRectMake(0, [Unity countcoordinatesH:275]-fl, SCREEN_WIDTH, 0);
        self.pickView.hidden = YES;
    }
    if (self.billView.hidden == NO) {
        isBill = NO;
        self.billImg.image = [UIImage imageNamed:@"下三角"];
//        self.billView.frame = CGRectMake(0, [Unity countcoordinatesH:50], SCREEN_WIDTH, 0);
        self.billView.hidden = YES;
        self.maskView.frame = CGRectMake(0, 0, 0, 0);
        self.maskView.hidden = YES;
        self.tableView.scrollEnabled = YES;
    }else{
        [UIView animateWithDuration:0.1 animations:^{
            [self.billView setFrame:CGRectMake(0, [Unity countcoordinatesH:275]-fl, SCREEN_WIDTH,[Unity countcoordinatesH:55])];
        }completion:nil];
        _billView.hidden = NO;
        self.maskView.hidden = NO;
//        self.maskView.frame = CGRectMake(0, [Unity countcoordinatesH:50], SCREEN_WIDTH, SCREEN_HEIGHT-[Unity countcoordinatesH:50]-NavBarHeight);
    }
}
- (void)timeClick{
    self.maskView.frame = CGRectMake(0, [Unity countcoordinatesH:275]-fl, SCREEN_WIDTH, SCREEN_HEIGHT-([Unity countcoordinatesH:275]-fl)-NavBarHeight);
//    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] animated:YES scrollPosition:UITableViewScrollPositionTop];
    if (isTime) {
        self.timeImg.image = [UIImage imageNamed:@"下三角"];
        isTime = NO;
    }else{
        self.billImg.image = [UIImage imageNamed:@"下三角"];
        isBill = NO;
        self.timeImg.image = [UIImage imageNamed:@"上三角"];
        isTime = YES;
    }
    [self performSelector:@selector(delayMethod1) withObject:nil afterDelay:0.5];
}
- (void)delayMethod1{
    if (self.billView.hidden == NO) {
        self.billView.frame = CGRectMake(0, [Unity countcoordinatesH:275]-fl, SCREEN_WIDTH, 0);
        self.billView.hidden = YES;
    }
    if (self.pickView.hidden == NO) {
        //111
//        [self aaa];
//        [self.timeBtn setTitle:[NSString stringWithFormat:@"%@%@",yearStr,monthStr] forState:UIControlStateNormal];
        isTime = NO;
        self.timeImg.image = [UIImage imageNamed:@"下三角"];
        self.pickView.frame = CGRectMake(0, [Unity countcoordinatesH:275]-fl, SCREEN_WIDTH, 0);
        self.pickView.hidden = YES;
        self.maskView.frame = CGRectMake(0, 0, 0, 0);
        self.maskView.hidden = YES;
        self.tableView.scrollEnabled = YES;
    }else{
        [UIView animateWithDuration:0.1 animations:^{
            [self.pickView setFrame:CGRectMake(0, [Unity countcoordinatesH:275]-fl, SCREEN_WIDTH,[Unity countcoordinatesH:150])];
        }completion:nil];
        self.pickView.hidden = NO;
        self.maskView.hidden = NO;
//        self.maskView.frame = CGRectMake(0, [Unity countcoordinatesH:50], SCREEN_WIDTH, SCREEN_HEIGHT-[Unity countcoordinatesH:50]-NavBarHeight);
    }
    
}
- (UIView *)billView{
    if (!_billView) {
        _billView = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:275], SCREEN_WIDTH, 0)];
        _billView.backgroundColor = [UIColor whiteColor];
        _billView.hidden = YES;
        [_billView addSubview:self.bill_all];
        [_billView addSubview:self.bill_refund];
        [_billView addSubview:self.bill_recharge];
    }
    return _billView;
}
- (UIButton *)bill_all{
    if (!_bill_all) {
        _bill_all = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_bill_all addTarget:self action:@selector(bill_allClick) forControlEvents:UIControlEventTouchUpInside];
        [_bill_all setTitle:@"全部账单" forState:UIControlStateNormal];
        [_bill_all setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        _bill_all.layer.borderWidth = 1;
        _bill_all.layer.borderColor = [Unity getColor:@"#aa112d"].CGColor;
        _bill_all.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _bill_all.layer.cornerRadius = _bill_all.height/2;
    }
    return _bill_all;
}
- (UIButton *)bill_refund{
    if (!_bill_refund) {
        _bill_refund = [[UIButton alloc]initWithFrame:CGRectMake(_bill_all.right+[Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_bill_refund addTarget:self action:@selector(bill_refundClick) forControlEvents:UIControlEventTouchUpInside];
        [_bill_refund setTitle:@"收入" forState:UIControlStateNormal];
        [_bill_refund setTitleColor:LabelColor6 forState:UIControlStateNormal];
        _bill_refund.layer.borderWidth = 1;
        _bill_refund.layer.borderColor = LabelColor6.CGColor;
        _bill_refund.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _bill_refund.layer.cornerRadius = _bill_refund.height/2;
    }
    return _bill_refund;
}
- (UIButton *)bill_recharge{
    if (!_bill_recharge) {
        _bill_recharge = [[UIButton alloc]initWithFrame:CGRectMake(_bill_refund.right+[Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_bill_recharge addTarget:self action:@selector(bill_rechargeClick) forControlEvents:UIControlEventTouchUpInside];
        [_bill_recharge setTitle:@"支出" forState:UIControlStateNormal];
        [_bill_recharge setTitleColor:LabelColor6 forState:UIControlStateNormal];
        _bill_recharge.layer.borderWidth = 1;
        _bill_recharge.layer.borderColor = LabelColor6.CGColor;
        _bill_recharge.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _bill_recharge.layer.cornerRadius = _bill_recharge.height/2;
    }
    return _bill_recharge;
}
#pragma mark pickView--
- (UIView *)pickView{
    if (!_pickView) {
        _pickView = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:275], SCREEN_WIDTH, 0)];
        _pickView.backgroundColor = [UIColor whiteColor];
        [_pickView addSubview:self.pickerView];
        _pickView.hidden = YES;
    }
    return _pickView;
}


- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc]init];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.3;
        _maskView.hidden=YES;
        UITapGestureRecognizer *singleTap =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskAction)];
        singleTap.numberOfTapsRequired = 1; //点击次数
        singleTap.numberOfTouchesRequired = 1; //点击手指数
        [_maskView addGestureRecognizer:singleTap];
    }
    return _maskView;
}
- (void)maskAction{
    
    if (isBill) {
        isBill = NO;
        self.billImg.image = [UIImage imageNamed:@"下三角"];
        self.billView.frame = CGRectMake(0, [Unity countcoordinatesH:275]-fl, SCREEN_WIDTH, 0);
        self.billView.hidden = YES;
    }
    if (isTime) {
        [self aaa];
//        [self.timeBtn setTitle:[NSString stringWithFormat:@"%@%@",yearStr,monthStr] forState:UIControlStateNormal];
        isTime = NO;
        self.timeImg.image = [UIImage imageNamed:@"下三角"];
        self.pickView.frame = CGRectMake(0, [Unity countcoordinatesH:275]-fl, SCREEN_WIDTH, 0);
        self.pickView.hidden = YES;

    }
    self.maskView.frame = CGRectMake(0, 0, 0, 0);
    self.maskView.hidden = YES;
    self.tableView.scrollEnabled = YES;
}
#pragma mark pickerView选择器 初始化 代理方法
- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:125])];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}
// 返回的列显示的数量。

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
//每一列组件的行高度

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return [Unity countcoordinatesH:25];
}
//返回行数在每个组件(每一列)

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray * tmpArray = self.pickerArray[component];
    return tmpArray.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 100;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    NSArray * tmpArray = self.pickerArray[component];
    return [tmpArray objectAtIndex:row];
}
//选中选择器元素（未拨动的部分为未选择状态）
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    //    [myTextField setText:[pickerArray objectAtIndex:row]];
    NSArray * tmpArray = self.pickerArray[component];
    switch (component) {
        case 0:
            if (![yearStr isEqualToString:tmpArray[row]]) {
                self.pickerArray = [[NSMutableArray alloc]initWithObjects:self.yearArray,self.dic[tmpArray[row]], nil];
                [self.pickerView reloadComponent:1];
                [self.pickerView selectRow:0 inComponent:1 animated:YES];
            }
            
            yearStr = tmpArray[row];
            if ([yearStr isEqualToString:@"2012年"]) {
                monthStr = @"7月";
            }else{
                monthStr = @"1月";
            }
            break;
        case 1:
            monthStr = tmpArray[row];
            break;
        default:
            break;
    }
    
    
    NSString * tmpTitleStr = [NSString stringWithFormat:@"%@ %@",yearStr,monthStr];
    NSLog(@"%@",tmpTitleStr);
    //    [myTimeButton setTitle:tmpTitleStr forState:(UIControlStateNormal)];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *myView = [UILabel new];
    myView.font = [UIFont systemFontOfSize:FontSize(14)];
    myView.backgroundColor = [UIColor clearColor];
    myView.textAlignment = NSTextAlignmentCenter;
    myView.text = self.pickerArray[component][row];
    return myView;
}
- (NSMutableArray *)pickerArray{
    if (!_pickerArray) {
        _pickerArray = [NSMutableArray new];
    }
    return _pickerArray;
}
- (NSMutableArray *)yearArray{
    if (!_yearArray) {
        _yearArray = [NSMutableArray new];
    }
    return _yearArray;
}
- (NSMutableDictionary *)dic{
    if (!_dic) {
        _dic = [NSMutableDictionary new];
    }
    return _dic;
}
- (void)aaa{
    NSString *str1 = [yearStr substringToIndex:4];//截取掉下标5之前的字符串(不包括)
//    NSLog(@"nian %@",str1);
    NSString *str2 = [str1 substringFromIndex:2];//截取掉下标3之后的字符串（包括）
//    NSLog(@"%@",str2);
    NSString * str3 = [monthStr substringToIndex:monthStr.length-1];
//    NSLog(@"%@",str3);
    if (str3.length == 1) {
        str3 = [NSString stringWithFormat:@"0%@",str3];
    }
//    NSLog(@"%@",str3);
    [self.timeBtn setTitle:[NSString stringWithFormat:@"%@-%@",str2,str3] forState:UIControlStateNormal];
    reTime = [NSString stringWithFormat:@"%@-%@",str1,str3];
    pageNum = 1;
    [self.listArray removeAllObjects];
    [self requestData:reType WithTime:reTime];
}




#pragma mark   =====点击全部账单弹出的view按钮事件
- (void)bill_allClick{
    if ([reType isEqualToString:@""]) {
        [self maskAction];
        return;
    }
    reType = @"";
    [self.allBillBtn setTitle:@"全部账单" forState:UIControlStateNormal];
    [self.bill_all setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
    self.bill_all.layer.borderColor = [Unity getColor:@"#aa112d"].CGColor;
    [self.bill_refund setTitleColor:LabelColor6 forState:UIControlStateNormal];
    self.bill_refund.layer.borderColor = LabelColor6.CGColor;
    [self.bill_recharge setTitleColor:LabelColor6 forState:UIControlStateNormal];
    self.bill_recharge.layer.borderColor = LabelColor6.CGColor;
    [self maskAction];
    pageNum = 1;
    [self.listArray removeAllObjects];
    [self requestData:reType WithTime:reTime];
    
}
- (void)bill_refundClick{
    if ([reType isEqualToString:@"s"]) {
        [self maskAction];
        return;
    }
    reType = @"s";
    [self.allBillBtn setTitle:@"收入" forState:UIControlStateNormal];
    [self.bill_all setTitleColor:LabelColor6 forState:UIControlStateNormal];
    self.bill_all.layer.borderColor = LabelColor6.CGColor;
    [self.bill_refund setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
    self.bill_refund.layer.borderColor = [Unity getColor:@"#aa112d"].CGColor;
    [self.bill_recharge setTitleColor:LabelColor6 forState:UIControlStateNormal];
    self.bill_recharge.layer.borderColor = LabelColor6.CGColor;
    [self maskAction];
    pageNum = 1;
    [self.listArray removeAllObjects];
    [self requestData:reType WithTime:reTime];
}
- (void)bill_rechargeClick{
    if ([reType isEqualToString:@"z"]) {
        [self maskAction];
        return;
    }
    reType = @"z";
    [self.allBillBtn setTitle:@"支出" forState:UIControlStateNormal];
    [self.bill_all setTitleColor:LabelColor6 forState:UIControlStateNormal];
    self.bill_all.layer.borderColor = LabelColor6.CGColor;
    [self.bill_refund setTitleColor:LabelColor6 forState:UIControlStateNormal];
    self.bill_refund.layer.borderColor = LabelColor6.CGColor;
    [self.bill_recharge setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
    self.bill_recharge.layer.borderColor = [Unity getColor:@"#aa112d"].CGColor;
    [self maskAction];
    pageNum = 1;
    [self.listArray removeAllObjects];
    [self requestData:reType WithTime:reTime];
}
- (PayPassWordView *)pView{
    if (!_pView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _pView = [PayPassWordView setPayPassWordView:window];
        _pView.delegate = self;
    }
    return _pView;
}
- (void)set{
    NSLog(@"去设置");
    AuthenticationViewController * avc = [[AuthenticationViewController alloc]init];
    [self.navigationController pushViewController:avc animated:YES];
}
- (void)requestData:(NSString *)type WithTime:(NSString *)time{
    NSDictionary * dic = [NSDictionary new];
    if ([type isEqualToString:@""] && [time isEqualToString:@""]) {
        dic = @{@"customer":userInfo[@"member_id"],@"page":[NSString stringWithFormat:@"%ld",(long)pageNum]};
    }else if ([type isEqualToString:@""] && ![time isEqualToString:@""]){
        dic = @{@"customer":userInfo[@"member_id"],@"page":[NSString stringWithFormat:@"%ld",(long)pageNum],@"date":time};
    }else if (![type isEqualToString:@""] && [time isEqualToString:@""]){
        dic = @{@"customer":userInfo[@"member_id"],@"page":[NSString stringWithFormat:@"%ld",(long)pageNum],@"type":type};
    }else{
        dic = @{@"customer":userInfo[@"member_id"],@"page":[NSString stringWithFormat:@"%ld",(long)pageNum],@"type":type,@"date":time};
    }
    NSLog(@"余额列表请求参数%@",dic);
    [Unity showanimate];
    [GZMrequest getWithURLString:[GZMUrl get_balanceList_url] parameters:dic success:^(NSDictionary *data) {
        NSLog(@"余额列表%@",data);
        [Unity hiddenanimate];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            [self.tableView.mj_footer endRefreshing];
            if ([data[@"data"] count]  < 10) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            for (int i=0; i<[data[@"data"] count]; i++) {
                [self.listArray addObject:data[@"data"][i]];
            }
            [self.tableView reloadData];            
        }else{
            [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y >=[Unity countcoordinatesH:225]) {
        fl = [Unity countcoordinatesH:225];
    }else{
        fl = scrollView.contentOffset.y;
    }
//    NSLog(@"%f",[Unity countcoordinatesH:275]-fl);
    self.billView.frame = CGRectMake(0, [Unity countcoordinatesH:275]-fl, SCREEN_WIDTH, 0);
    self.pickView.frame = CGRectMake(0, [Unity countcoordinatesH:275]-fl, SCREEN_WIDTH, 0);
}
#pragma newcash daili
- (void)reloadBalance{
    userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
//    dispatch_async(dispatch_get_main_queue(), ^{
        if ([userInfo[@"w_remainappear"] isEqualToString:@"1"]) {
            _balanceL.text = userInfo[@"w_yk_tw"];
        }
//    });
    
    reType = @"";
    reTime = @"";
    pageNum = 1;
    [self.listArray removeAllObjects];
    [self requestData:reType WithTime:reTime];
}
- (void)rechargeSuccReload{
    userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
//    dispatch_async(dispatch_get_main_queue(), ^{
        if ([userInfo[@"w_remainappear"] isEqualToString:@"1"]) {
            _balanceL.text = userInfo[@"w_yk_tw"];
        }
//    });
    
    reType = @"";
    reTime = @"";
    pageNum = 1;
    [self.listArray removeAllObjects];
    [self requestData:reType WithTime:reTime];
}
- (void)reloadB{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"customer":userInfo[@"member_id"]};
    [GZMrequest getWithURLString:[GZMUrl get_statusCount_url] parameters:dic success:^(NSDictionary *data) {
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            if ([data[@"data"][@"remainappear"] isEqualToString:@"0"]) {
                self.balanceL.text = @"****";
            }else{
                self.balanceL.text = data[@"data"][@"remain"];
            }
            NSMutableDictionary * dicc = [userInfo mutableCopy];
            [dicc setObject:data[@"data"][@"remain"] forKey:@"w_yk_tw"];
            [dicc setObject:data[@"data"][@"remainappear"] forKey:@"w_remainappear"];
            [[NSUserDefaults standardUserDefaults] setObject:dicc forKey:@"userInfo"];
        }
    } failure:^(NSError *error) {
//        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
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
