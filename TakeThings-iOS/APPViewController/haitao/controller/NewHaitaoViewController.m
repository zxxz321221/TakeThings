//
//  NewHaitaoViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/11.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "NewHaitaoViewController.h"

#import "HaitaoTost.h"
#import "NewHaitaoCell1.h"
#import "NewHaitaoCell2.h"
#import "NewHaitaoCell3.h"
#import "NewHaitaoCell4.h"
#import "NewHaitaoCell5.h"
#import "NewHaitaoCell6.h"
#import "ConfirmInfoViewController.h"

@interface NewHaitaoViewController ()<UITableViewDelegate,UITableViewDataSource,NewHaitaoCell1Delegate,NewHaitaoCell6Delegate,NewHaitaoCell3Delegate>
{
    NSInteger cellNum;//显示cell的个数
    BOOL isAdd;//默认no   没有添加商品     yes添加商品
    NSInteger add_num;//添加的商品数量 已序列为单位
    NSInteger sum;//数量总计
    NSString * safe_traffic;//运输保险 0 未投保 1已投保
    NSString * fraud_safe;//购物保障 0未投保 1已投保
    
    
}
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) UIView * bottomView;

@property (nonatomic , strong) UILabel * navLine;

@property (nonatomic , strong) UILabel * line0;

@property (nonatomic , strong) HaitaoTost * hView;

@property (nonatomic , strong) UILabel * line1;
@property (nonatomic , strong) UIButton * cancelBtn;
@property (nonatomic , strong) UIButton * confirmBtn;

@property (nonatomic , strong) NSMutableArray * listArray;

@end

@implementation NewHaitaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    safe_traffic = @"0";
    fraud_safe = @"0";
    cellNum = 5;
    sum = 0;
    isAdd = NO;
    [self createUI];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.hView showHaitaoView];
}
- (void)createUI{
    if ([self.source isEqualToString:@"yahoo"]) {
         self.title = @"海淘询价单(日本)";
    }else{
         self.title = @"海淘询价单(美国)";
    }
    [self.view addSubview:self.navLine];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];

}
#pragma mark 初始化
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-bottomH)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate=self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = FALSE;
        _tableView.showsHorizontalScrollIndicator = FALSE;
        [_tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        //没有数据时不显示cell
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}
#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return cellNum;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row ==0) {
        return [Unity countcoordinatesH:226];
    }else if (indexPath.row ==1){//商品列表标题
        return [Unity countcoordinatesH:40];
    }else if (indexPath.row == cellNum-2){//总计
        if (isAdd) {
            return [Unity countcoordinatesH:30];
        }else{
            return 0.1;
        }
    }else if (indexPath.row == cellNum-1){//海淘费用  区分日本和美国
        if ([self.source isEqualToString:@"yahoo"]) {//日本
            return [Unity countcoordinatesH:131];
        }else{//美国
            return [Unity countcoordinatesH:186];
        }
    }else{//添加的商品
        if (isAdd) {//已添加商品
            return [Unity countcoordinatesH:165];//序列数量
        }else{//未添加商品
            return [Unity countcoordinatesH:25];
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        NewHaitaoCell1 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NewHaitaoCell1 class])];
        if (cell == nil) {
            cell = [[NewHaitaoCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([NewHaitaoCell1 class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWithSource:self.source WithSum:sum];
        cell.delegate = self;
        return cell;
    }else if (indexPath.row == 1){
        NewHaitaoCell2 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NewHaitaoCell2 class])];
            if (cell == nil) {
                cell = [[NewHaitaoCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([NewHaitaoCell2 class])];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //    cell.delegate = self;
            return cell;
    }else if (indexPath.row == cellNum-2){
        NewHaitaoCell5 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NewHaitaoCell5 class])];
            if (cell == nil) {
                cell = [[NewHaitaoCell5 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([NewHaitaoCell5 class])];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWithIsAdd:isAdd WithNum:sum];
        //    cell.delegate = self;
            return cell;
    }else if (indexPath.row == cellNum-1){
        NewHaitaoCell3 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NewHaitaoCell3 class])];
            if (cell == nil) {
                cell = [[NewHaitaoCell3 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([NewHaitaoCell3 class])];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWithSource:self.source];
        cell.delegate = self;
        return cell;
    }else{//添加的商品
        if (isAdd) {//已添加商品
            NewHaitaoCell6 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NewHaitaoCell6 class])];
            if (cell == nil) {
                cell = [[NewHaitaoCell6 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([NewHaitaoCell6 class])];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell configWithData:self.listArray[indexPath.row-2] WithNum:indexPath.row-1 WithSumNum:sum];
            cell.delegate = self;
            return cell;
        }else{//未添加商品
            NewHaitaoCell4 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NewHaitaoCell4 class])];
                if (cell == nil) {
                    cell = [[NewHaitaoCell4 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([NewHaitaoCell4 class])];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
        }
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [Unity countcoordinatesH:10];
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [UIView new];
    return footer;
}
#pragma mark ---UI初始化---
- (UILabel *)navLine{
    if (!_navLine) {
        _navLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        _navLine.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return _navLine;
}

- (HaitaoTost *)hView{
    if (!_hView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _hView = [HaitaoTost setHaitaoTost:window];
    }
    return _hView;
}
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NavBarHeight-bottomH, SCREEN_WIDTH, bottomH)];
        [_bottomView addSubview:self.line1];
        [_bottomView addSubview:self.confirmBtn];
        [_bottomView addSubview:self.cancelBtn];
    }
    return _bottomView;
}
- (UILabel *)line1{
    if (!_line1) {
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        _line1.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return _line1;
}
- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:90], [Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:35])];
        [_confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = [Unity getColor:@"aa112d"];
        _confirmBtn.layer.cornerRadius = _confirmBtn.height/2;
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _confirmBtn;
}
- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:180], [Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:35])];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        _cancelBtn.layer.cornerRadius = _cancelBtn.height/2;
        _cancelBtn.layer.borderWidth =1;
        _cancelBtn.layer.borderColor = LabelColor3.CGColor;
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _cancelBtn;
}
- (NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [NSMutableArray new];
    }
    return _listArray;
}
- (void)addGoodsWithName:(NSString *)name WithLink:(NSString *)link WithParam:(NSString *)param WithGid:(NSString *)gid WithPrice:(NSString *)price WithNum:(NSString *)num{
    isAdd = YES;
    NSDictionary * dic = [NSDictionary new];
    dic = @{@"name":name,@"link":link,@"param":param,@"gid":gid,@"price":price,@"num":num,@"ggg":[self get_generateNum]};
    [self.listArray addObject:dic];
    add_num = self.listArray.count;
    cellNum = 4+add_num;
    sum = sum+[num intValue];
    [self.tableView reloadData];
}
- (void)goodsDelete:(NSString *)ggg{
    for (int i=0; i<self.listArray.count; i++) {
        if ([self.listArray[i][@"ggg"] isEqualToString:ggg]) {
            sum = sum-[self.listArray[i][@"num"] intValue];
            [self.listArray removeObjectAtIndex:i];
        }
    }
    add_num = self.listArray.count;
    cellNum = 4+add_num;
    if (self.listArray.count ==0) {
        cellNum = 5;
        add_num = 0;
        sum = 0;
        isAdd = NO;
    }
    [self.tableView reloadData];
}
- (void)updateWithName:(NSString *)name WithLink:(NSString *)link WithParam:(NSString *)param WithGid:(NSString *)gid WithPrice:(NSString *)price WithNum:(NSString *)num WithGgg:(nonnull NSString *)ggg WithCell:(NewHaitaoCell6 *)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary * dic = @{@"name":name,@"link":link,@"param":param,@"gid":gid,@"price":price,@"num":num,@"ggg":ggg};
     [self.listArray replaceObjectAtIndex:indexPath.row-2 withObject:dic];
    [WHToast showMessage:@"修改成功" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
    NSLog(@"%@",self.listArray);
}
- (NSString *)get_generateNum{
    NSArray * arr = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"a",@"b",@"c",@"d",@"e", nil];//存放十个数，以备随机取
    NSMutableString * getStr = [[NSMutableString alloc] initWithCapacity:5];
    NSMutableString * str = [[NSMutableString alloc]initWithCapacity:6];//申请内存空间，一定要写，要不没有效果，我自己总是吃这个亏
    for (int i = 0; i<6; i++) {
        NSInteger index = arc4random()%([arr count]-1);//循环六次，得到一个随机数，作为下标值取数组里面的数放到一个可变字符串里，在存放到自身定义的可变字符串
        getStr = arr[index];
        str = (NSMutableString *)[str stringByAppendingString:getStr];
    }
    return str;
}
- (void)confirmClick{
    if (self.listArray.count ==0) {
        [WHToast showMessage:@"请添加海淘商品" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
        return;
    }
    ConfirmInfoViewController * cvc = [[ConfirmInfoViewController alloc]init];
    cvc.dataList = self.listArray;
    cvc.source = self.source;
    cvc.fraud_safe = fraud_safe;
    cvc.safe_traffic = safe_traffic;
    [self.navigationController pushViewController:cvc animated:YES];
}

//haitaocell3 代理
- (void)get_fraud_safe:(NSString *)ins{
//    NSLog(@"%@",ins);
    fraud_safe = ins;
}
- (void)get_safe_traffic:(NSString *)traffic{
//    NSLog(@"%@",traffic);
    safe_traffic = traffic;
}
@end
