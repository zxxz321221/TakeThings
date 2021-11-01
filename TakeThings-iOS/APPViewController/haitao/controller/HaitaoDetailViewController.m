//
//  HaitaoDetailViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/18.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "HaitaoDetailViewController.h"
#import "HaitaoDetailCell1.h"
#import "HaitaoDetailCell2.h"
#import "HaitaoDetailCell3.h"
#import "HaitaoDetailCell4.h"
#import "HaitaoDetailCell5.h"
#import "ProgressCell.h"
#import "WebViewController.h"
#import "ServiceViewController.h"
#import "HaitaoPaymentViewController.h"
#import "NewSendDetailViewController.h"
#import "KdPostalViewController.h"
#import "KdJapanViewController.h"
#import "PrecelDetailViewController.h"
@interface HaitaoDetailViewController ()<UITableViewDelegate,UITableViewDataSource,HaitaoPaymentDelegate,NewSendDelegate,HaitaoDetailCell5lDelegate>
{
    NSInteger sectionNum;//section个数 默认3
    NSInteger tap;//1 前2个状态 2有包裹  3没有包裹  没有日本代拍
    NSInteger cellNum;//section个数  默认4个
    NSInteger twoIndex;//取消委托0 联系客服1
    NSInteger threeIndex;//联系客服0 立即支付1 通知发货2 包裹详情3 删除委托单4
}
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) UIView * bottomView;//底部按钮view

@property (nonatomic , strong) UILabel * sumNumL;//商品总件数

@property (nonatomic , strong) NSDictionary * dataDic;

@property (nonatomic , strong) UIButton * oneBtn;//原始页面
@property (nonatomic , strong) UIButton * twoBtn;//取消委托0 联系客服1
@property (nonatomic , strong) UIButton * threeBtn;//联系客服0 立即支付1 委托详情2 通知发货3 包裹详情4 删除委托单5

@property (nonatomic , strong) NSMutableArray * jdList;
@property (nonatomic , strong) NSMutableArray * bgList;//包裹
@end

@implementation HaitaoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"委托单详情";
    cellNum = 2;
    sectionNum = 3;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self requestDetail];
}
#pragma mark 初始化
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-[Unity countcoordinatesH:60]) style:UITableViewStyleGrouped];
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
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NavBarHeight-[Unity countcoordinatesH:60], SCREEN_WIDTH, [Unity countcoordinatesH:60])];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        line.backgroundColor = [Unity getColor:@"f0f0f0"];
        [_bottomView addSubview:line];
        [_bottomView addSubview:self.threeBtn];
        [_bottomView addSubview:self.twoBtn];
        [_bottomView addSubview:self.oneBtn];
    }
    return _bottomView;
}
- (UIButton *)threeBtn{
    if (!_threeBtn) {
        _threeBtn = [[UIButton alloc]initWithFrame:CGRectMake(_bottomView.width-[Unity countcoordinatesW:80], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_threeBtn addTarget:self action:@selector(threeClick) forControlEvents:UIControlEventTouchUpInside];
        _threeBtn.backgroundColor = [Unity getColor:@"aa112d"];
        [_threeBtn setTitle:@"联系客服" forState:UIControlStateNormal];
        [_threeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _threeBtn.layer.cornerRadius = _threeBtn.height/2;
        _threeBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _threeBtn;
}
- (UIButton *)twoBtn{
    if (!_twoBtn) {
        _twoBtn = [[UIButton alloc]initWithFrame:CGRectMake(_bottomView.width-[Unity countcoordinatesW:160], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_twoBtn addTarget:self action:@selector(twoClick) forControlEvents:UIControlEventTouchUpInside];
        [_twoBtn setTitle:@"取消委托" forState:UIControlStateNormal];
        [_twoBtn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
        _twoBtn.layer.cornerRadius = _twoBtn.height/2;
        _twoBtn.layer.borderWidth = 1;
        _twoBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        _twoBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _twoBtn;
}
- (UIButton *)oneBtn{
    if (!_oneBtn) {
        _oneBtn = [[UIButton alloc]initWithFrame:CGRectMake(_bottomView.width-[Unity countcoordinatesW:240], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_oneBtn addTarget:self action:@selector(oneClick) forControlEvents:UIControlEventTouchUpInside];
        [_oneBtn setTitle:@"原始页面" forState:UIControlStateNormal];
        [_oneBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        _oneBtn.layer.cornerRadius = _oneBtn.height/2;
        _oneBtn.layer.borderWidth =1;
        _oneBtn.layer.borderColor = LabelColor9.CGColor;
        _oneBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _oneBtn;
}
#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return cellNum;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section < 4) {
        return 1;
    }else{ //包裹
        if ([self.bgList[section-4][@"isAn"] intValue] == 1) {
            return 1;
        }
       return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [Unity countcoordinatesW:100];
    }else if (indexPath.section == 1){
        return self.jdList.count*[Unity countcoordinatesH:25]+[Unity countcoordinatesH:10];
    }else if (indexPath.section == 2){
        return [Unity countcoordinatesW:175];
    }else if (indexPath.section == 3){
        return [Unity countcoordinatesW:160];
    }else{
        return [Unity countcoordinatesW:110];
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HaitaoDetailCell1 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HaitaoDetailCell1 class])];
        if (cell == nil) {
            cell = [[HaitaoDetailCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HaitaoDetailCell1 class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWithData:self.dataDic];
        return cell;
    }else if (indexPath.section == 1){
        ProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProgressCell class])];
        if (cell == nil) {
            cell = [[ProgressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ProgressCell class])];
        }
        cell.tanhao = NO;
        [cell configProgressArr:self.jdList];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2){
        HaitaoDetailCell3 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HaitaoDetailCell3 class])];
        if (cell == nil) {
            cell = [[HaitaoDetailCell3 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HaitaoDetailCell3 class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWithData:self.dataDic];
        return cell;
    }else if (indexPath.section == 3){//代拍费用
        HaitaoDetailCell4 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HaitaoDetailCell4 class])];
        if (cell == nil) {
            cell = [[HaitaoDetailCell4 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HaitaoDetailCell4 class])];
            }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWithData:self.dataDic];
        return cell;
    }else{
        HaitaoDetailCell5 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HaitaoDetailCell5 class])];
        if (cell == nil) {
            cell = [[HaitaoDetailCell5 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HaitaoDetailCell5 class])];
            }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWithData:self.bgList[indexPath.section-4]];
        cell.delegate = self;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }else if (section == 1){
        return [Unity countcoordinatesH:40];
    }else if (section == 2 || section == 3){
        return [Unity countcoordinatesH:10];
    }else{
        return [Unity countcoordinatesH:40];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * header = [UIView new];
    if (section == 0) {
        
    }else if (section == 1){
        UILabel * sumL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], 0, 100, [Unity countcoordinatesH:35])];
        sumL.text = @"共计";
        sumL.textColor = LabelColor6;
        sumL.font = [UIFont systemFontOfSize:FontSize(14)];
        [header addSubview:sumL];
        self.sumNumL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:115], 0, [Unity countcoordinatesW:100], [Unity countcoordinatesH:35])];
        self.sumNumL.text = [NSString stringWithFormat:@"%@件",self.dataDic[@"goods_num"]];
        self.sumNumL.textColor = LabelColor6;
        self.sumNumL.font = [UIFont systemFontOfSize:FontSize(14)];
        self.sumNumL.textAlignment = NSTextAlignmentRight;
        [header addSubview:self.sumNumL];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, sumL.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        line.backgroundColor = [Unity getColor:@"f0f0f0"];
        [header addSubview:line];
    }else if (section == 2 || section == 3){
        header.backgroundColor = [Unity getColor:@"f0f0f0"];
    }else{
        UILabel * bgTitle = [Unity lableViewAddsuperview_superView:header _subViewFrame:CGRectMake([Unity countcoordinatesW:15], 0, [Unity countcoordinatesW:100], [Unity countcoordinatesH:40]) _string:[NSString stringWithFormat:@"包裹%ld",section-3] _lableFont:[UIFont systemFontOfSize:FontSize(17)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        UILabel * status = [Unity lableViewAddsuperview_superView:header _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:137], 0, [Unity countcoordinatesW:100], bgTitle.height) _string:self.bgList[section-4][@"order_code"] _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:[Unity getColor:@"aa112d"] _textAlignment:NSTextAlignmentRight];
        status.backgroundColor = [UIColor clearColor];
        UIImageView * bgImg = [Unity imageviewAddsuperview_superView:header _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:22], [Unity countcoordinatesH:17.5], [Unity countcoordinatesW:12], [Unity countcoordinatesH:5]) _imageName:self.bgList[section-4][@"img"] _backgroundColor:nil];
        bgImg.backgroundColor = [UIColor clearColor];
        UILabel * bgLine = [Unity lableViewAddsuperview_superView:header _subViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentRight];
        bgLine.backgroundColor = [Unity getColor:@"e0e0e0"];
        header.tag = section;
        // 为header的点击事件
        [header addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTap:)]];
    }
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [UIView new];
    return footer;
}
#pragma mark  ----header手势   编号手势---
- (void)headerTap:(UITapGestureRecognizer *)header{
    NSLog(@"%ld",header.view.tag-4);
    
    NSMutableArray * arr = [NSMutableArray new];
    for (int i=0 ; i<self.bgList.count; i++) {
        if (i==header.view.tag-4) {
            NSMutableDictionary * dic = [NSMutableDictionary new];
            dic = [self.bgList[i] mutableCopy];
            if ([dic[@"isAn"] intValue] ==0) {
                [dic setValue:@"1" forKey:@"isAn"];
                [dic setValue:@"上拉" forKey:@"img"];
            }else{
                [dic setValue:@"0" forKey:@"isAn"];
                [dic setValue:@"下拉" forKey:@"img"];
            }
            dic = [Unity nullDicToDic:dic];
            [arr addObject:dic];
        }else{
            NSMutableDictionary * dic = [NSMutableDictionary new];
            dic = [self.bgList[i] mutableCopy];
            dic = [Unity nullDicToDic:dic];
            [arr addObject:dic];
        }
    }
    self.bgList = arr;
    [self.tableView reloadData];
}
- (void)requestDetail{
    NSString * url = [NSString stringWithFormat:@"%@?id=%@",[GZMUrl get_haitaoDetail_url],self.haitaoId];
    [GZMrequest getWithURLString:url parameters:nil success:^(NSDictionary *data) {
        NSLog(@"%@",data);
        if ([data[@"status"] intValue] ==0) {
            self.dataDic = data[@"agent_info"];
            //判断状态 显示那些内容
            
            if ([self.dataDic[@"order_bid_status_id"] intValue] < 140) {
                cellNum = 2 ;
            }else{
                if ([self.dataDic[@"order_bid_status_id"] intValue] == 420 || [self.dataDic[@"order_bid_status_id"] intValue] == 410){
                   cellNum = 2 ;
                }else{
                    cellNum = 3 ;
                    if ([data[@"order_transport_list"] count] == 0) {
                        cellNum = 3 ;
                    }else{
                        [self editBGList:data[@"order_transport_list"]];
                        cellNum = 4+[data[@"order_transport_list"] count];
                    }
                }
            }
            
//            else if ([self.dataDic[@"order_agent_status_id"] intValue] == 140 || [self.dataDic[@"order_agent_status_id"] intValue] == 220){
//                //显示包裹 收货地址 代拍信息
//                cellNum = 5+[data[@"order_transport_list"] count];
//            }else{
//                cellNum = 2;
//            }
            [self editJDList:data];
            [self.tableView reloadData];
            [self reloadBtn];//更新底部按钮
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)editBGList:(NSArray *)arr{
    for (int i=0; i<arr.count; i++) {
        NSMutableDictionary * dic = [arr[i] mutableCopy];
        [dic setValue:@"下拉" forKey:@"img"];
        [dic setValue:@"0" forKey:@"isAn"];
        dic = [Unity nullDicToDic:dic];
        [self.bgList addObject:dic];
    }
}
- (void)editJDList:(NSDictionary *)dic{
    NSArray * arr = [NSArray new];
    NSArray * arr1 = [NSArray new];
    NSDictionary * noNullDic = [NSDictionary new];
    noNullDic = [[Unity nullDicToDic:dic[@"agent_info"]] copy];
    if ([dic[@"agent_info"][@"order_bid_status_id"] intValue] == 430) {//已退款
        arr = @[@"委托审核中",@"已报价",@"已付款",@"已退款"];
        arr1 = @[noNullDic[@"create_time"],noNullDic[@"examine_time"],noNullDic[@"payment_time"],@""];
            
    }else if ([dic[@"agent_info"][@"order_bid_status_id"] intValue] == 420){//已失效
        arr = @[@"委托审核中",@"已报价",@"已失效"];
        arr1 = @[noNullDic[@"create_time"],noNullDic[@"examine_time"],@""];
    }else if ([dic[@"agent_info"][@"order_bid_status_id"] intValue] == 410){//已取消
        arr = @[@"委托审核中",@"已取消"];
        arr1 = @[noNullDic[@"create_time"],@""];
    }else{
        arr = @[@"委托审核中",@"已报价",@"已付款",@"已采购",@"运输中",@"海外已收货"];
        arr1 = @[noNullDic[@"create_time"],noNullDic[@"examine_time"],noNullDic[@"payment_time"],noNullDic[@"remitt_time"],noNullDic[@"overseas_transport_time"],noNullDic[@"warehouse_get_time"]];
        //判断是否有退运记录
        NSDictionary * dict = [self get_jindu:dic[@"transport_back_list"] WithNameArr:arr WithTimeArr:arr1];
        arr = dict[@"nameArr"];
        arr1 = dict[@"timeArr"];
        
    }
    
    for (int i=0; i<arr.count; i++) {
        NSMutableDictionary * dic = [NSMutableDictionary new];
        [dic setValue:arr1[i] forKey:@"time"];
        [dic setValue:arr[i] forKey:@"title"];
        [self.jdList addObject:dic];
    }

}
- (NSMutableArray *)jdList{
    if (!_jdList) {
        _jdList = [NSMutableArray new];
    }
    return _jdList;
}
- (NSMutableArray *)bgList{
    if (!_bgList) {
        _bgList = [NSMutableArray new];
    }
    return _bgList;
}
- (NSDictionary *)get_jindu:(NSArray *)arr WithNameArr:(NSArray *)nameArr WithTimeArr:(NSArray *)timeArr{
    if (arr.count ==0) {
        NSMutableArray * aaa = [nameArr mutableCopy];
        NSMutableArray * bbb = [timeArr mutableCopy];
        [aaa addObject:@"海外已发货"];
        [aaa addObject:@"已收货"];
        [bbb addObject:@""];
        [bbb addObject:@""];
        NSMutableDictionary * ddd = [NSMutableDictionary new];
        [ddd setObject:aaa forKey:@"nameArr"];
        [ddd setObject:bbb forKey:@"timeArr"];
        return [ddd copy];
    }
    NSMutableDictionary * dicc = [NSMutableDictionary new];
    if (arr.count ==0) {
        NSLog(@"数位为空");
        [dicc setObject:nameArr forKey:@"nameArr"];
        [dicc setObject:timeArr forKey:@"timeArr"];
        return [dicc copy];
    }
    NSMutableArray * arr11 = [NSMutableArray new];
    for (int i=0; i<arr.count; i++) {
        [arr11 addObject:[NSString stringWithFormat:@"%lu",(unsigned long)[arr[i] count]]];
    }
    /** 降序 */
    NSArray *result4 = [arr11 sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj2 compare:obj1]; //降序排列
    }];
    //去重
    NSOrderedSet *orderSet = [NSOrderedSet orderedSetWithArray:result4];

    NSArray *newArray = orderSet.array;

    NSLog(@"%@",newArray);
    NSMutableArray * arr2 = [NSMutableArray new];
    for (int i=0; i<newArray.count; i++) {
        NSInteger count = [newArray[i] intValue];
        for (int j = 0; j<arr.count; j++) {
            if ([arr[j] count] == count) {
                [arr2 addObject:arr[j]];
            }
        }
    }
    
    NSLog(@"%@",arr2);
    //判断 一次判断每个数组里最后一个集合中的状态是否是收货  找没收货的
    NSArray * list = [NSArray new];
//    NSArray * arr3 = arr2[0];
    for (int i=0; i<arr2.count; i++) {
        NSInteger count = [arr2[i] count];
        if ([arr2[i][count-1][@"order_transport_status_id"] intValue] != 220) {
            list = arr2[i];
        }
    }
    //如果 没有没收货的 就取 第一个列表
    if (list.count == 0) {
        list = arr2[0];
    }
    
    
    if ([list[0][@"order_transport_status_id"] intValue] == 210 || [list[0][@"order_transport_status_id"] intValue] == 212 || [list[0][@"order_transport_status_id"] intValue] == 200) {//有退运进度
        NSMutableArray * array = [NSMutableArray new];
        array = [nameArr mutableCopy];
        NSMutableArray * array1 = [NSMutableArray new];
        array1 = [timeArr mutableCopy];
        if (list.count == 1) {
            [array addObject:@"海外已发货"];
            [array addObject:@"退运"];
            [array addObject:@"已退回到仓"];
            [array addObject:@"海外再次发货"];
            [array addObject:@"已发货"];
            [array1 addObject:@""];
            [array1 addObject:@""];
            [array1 addObject:@""];
            [array1 addObject:@""];
            [array1 addObject:@""];
        }else{
            for (int i=0; i<list.count; i++) {
                if (i == 0) {
                    [array addObject:@"海外已发货"];
                    [array addObject:@"退运"];
                    [array addObject:@"已退回到仓"];
                    [array addObject:@"海外再次发货"];
                    [array1 addObject:list[i][@"sendout_time"]];
                    [array1 addObject:list[i][@"back_confirm_time"]];
                    [array1 addObject:list[i][@"back_warehouse_time"]];
                    [array1 addObject:list[i][@"turn_order_time"]];
                }else if (i == list.count - 1){
                    [array addObject:@"退运"];
                    [array addObject:@"已退回到仓"];
                    [array addObject:@"海外再次发货"];
                    [array addObject:@"已收货"];
                    [array1 addObject:list[i][@"back_confirm_time"]];
                    [array1 addObject:list[i][@"back_warehouse_time"]];
                    [array1 addObject:list[i][@"turn_order_time"]];
                    [array1 addObject:list[i][@"receive_time"]];
                }else{
                    [array addObject:@"退运"];
                    [array addObject:@"已退回到仓"];
                    [array addObject:@"海外再次发货"];
                    [array1 addObject:list[i][@"back_confirm_time"]];
                    [array1 addObject:list[i][@"back_warehouse_time"]];
                    [array1 addObject:list[i][@"turn_order_time"]];
                }
            }
        }
        [dicc setObject:array forKey:@"nameArr"];
        [dicc setObject:array1 forKey:@"timeArr"];
    }else{//没有退运记录
        NSMutableArray * arr22 = [NSMutableArray new];
        NSMutableArray * arr33 = [NSMutableArray new];
        NSDictionary * dictt = [NSDictionary new];
        dictt = [Unity nullDicToDic:list[0]];
        arr22 = [nameArr mutableCopy];
        arr33 = [timeArr mutableCopy];
        [arr22 addObject:@"海外已发货"];
        [arr22 addObject:@"已收货"];
        [arr33 addObject:list[0][@"sendout_time"]];
        [arr33 addObject:list[0][@"receive_time"]];
        [dicc setObject:arr22 forKey:@"nameArr"];
        [dicc setObject:arr33 forKey:@"timeArr"];
    }
    return [dicc copy];
}
- (NSDictionary *)dataDic{
    if (!_dataDic) {
        _dataDic = [NSDictionary new];
    }
    return _dataDic;
}
- (void)reloadBtn{
//    NSInteger twoIndex;//取消委托0 联系客服1
//    NSInteger threeIndex;//联系客服0 立即支付1 委托详情2 通知发货3 包裹详情4 删除委托单5
    if ([self.dataDic[@"order_bid_status_id"] intValue] > 115 && [self.dataDic[@"order_bid_status_id"] intValue] < 130) {
        self.threeBtn.hidden = YES;
        self.twoBtn.frame = CGRectMake(_bottomView.width-[Unity countcoordinatesW:80], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
        self.oneBtn.frame = CGRectMake(_bottomView.width-[Unity countcoordinatesW:160], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
    }else{
        self.threeBtn.hidden = NO;
        self.threeBtn.frame = CGRectMake(_bottomView.width-[Unity countcoordinatesW:80], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
        self.twoBtn.frame = CGRectMake(_bottomView.width-[Unity countcoordinatesW:160], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
        self.oneBtn.frame = CGRectMake(_bottomView.width-[Unity countcoordinatesW:240], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
    }

    if ([self.dataDic[@"order_bid_status_id"] intValue]>115 &&[self.dataDic[@"order_bid_status_id"] intValue]<130) {//2个按钮
        self.oneBtn.frame = CGRectMake(_bottomView.width-[Unity countcoordinatesW:160], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
        self.twoBtn.frame = CGRectMake(_bottomView.width-[Unity countcoordinatesW:80], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
        self.threeBtn.hidden = YES;
    }else{
        self.threeBtn.hidden = NO;
        self.oneBtn.frame = CGRectMake(_bottomView.width-[Unity countcoordinatesW:240], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
        self.twoBtn.frame = CGRectMake(_bottomView.width-[Unity countcoordinatesW:160], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
        self.threeBtn.frame = CGRectMake(_bottomView.width-[Unity countcoordinatesW:80], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
    }
    if ([self.dataDic[@"order_bid_status_id"] intValue] == 10) {
        twoIndex = 0;
        threeIndex = 0;
        [self.threeBtn setTitle:@"联系客服" forState:UIControlStateNormal];
        [self.twoBtn setTitle:@"取消委托" forState:UIControlStateNormal];
    }else if ([self.dataDic[@"order_bid_status_id"] intValue] == 115){
        twoIndex = 0;
        threeIndex = 1;
        [self.threeBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        [self.twoBtn setTitle:@"取消委托" forState:UIControlStateNormal];
    }else if ([self.dataDic[@"order_bid_status_id"] intValue] < 130){
        twoIndex = 1;
//        threeIndex = 2;
//        [self.threeBtn setTitle:@"委托详情" forState:UIControlStateNormal];
        [self.twoBtn setTitle:@"联系客服" forState:UIControlStateNormal];
    }else if ([self.dataDic[@"order_bid_status_id"] intValue] == 130){
        twoIndex = 1;
        threeIndex = 2;
        [self.threeBtn setTitle:@"通知发货" forState:UIControlStateNormal];
        [self.twoBtn setTitle:@"联系客服" forState:UIControlStateNormal];
    }else if ([self.dataDic[@"order_bid_status_id"] intValue] == 140){
        twoIndex = 1;
        threeIndex = 3;
        [self.threeBtn setTitle:@"包裹详情" forState:UIControlStateNormal];
        [self.twoBtn setTitle:@"联系客服" forState:UIControlStateNormal];
    }else{
        twoIndex = 1;
        threeIndex = 4;
        [self.threeBtn setTitle:@"删除委托单" forState:UIControlStateNormal];
        [self.twoBtn setTitle:@"联系客服" forState:UIControlStateNormal];
    }
    
}
//原始页面
- (void)oneClick{
    WebViewController * wvc = [[WebViewController alloc]init];
    wvc.webUrl =[NSString stringWithFormat:@"%@/index/order_bid/getyahoo?url=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"new_sdxurl"],self.dataDic[@"source_url"]];
    [self.navigationController pushViewController:wvc animated:YES];
}
- (void)twoClick{
    if (twoIndex == 0) {//取消委托
        
    }else{ //联系客服
        ServiceViewController * svc = [[ServiceViewController alloc]init];
        [self.navigationController pushViewController:svc animated:YES];
    }
}
- (void)threeClick{
    if (threeIndex ==0) {//联系客服0
        ServiceViewController * svc = [[ServiceViewController alloc]init];
        [self.navigationController pushViewController:svc animated:YES];
    }else if (threeIndex == 1){ //立即支付1
        HaitaoPaymentViewController * hvc = [[HaitaoPaymentViewController alloc]init];
        hvc.dataDic = self.dataDic;
        hvc.delegate = self;
        [self.navigationController pushViewController:hvc animated:YES];
    }else if (threeIndex == 2){ //通知发货3
        NewSendDetailViewController * vc = [[NewSendDetailViewController alloc]init];
        if ([self.dataDic[@"currency"] isEqualToString:@"円"]) {
            vc.kdArray = @[@"EMS",@"SAL",@"海运"];
            vc.source = @"yahoo";
        }else{
            vc.kdArray = @[@"UCS"];
            vc.source = @"ebay";
        }
        vc.id_arr = @[self.dataDic[@"id"]];
        vc.isNew = YES;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (threeIndex == 3){ //包裹详情4
        PrecelDetailViewController * pvc = [[PrecelDetailViewController alloc]init];
        pvc.bg_id = self.bgList[0][@"id"];
        [self.navigationController pushViewController:pvc animated:YES];
    }else{ //删除委托单5
        NSDictionary * dic = @{@"order_id":self.dataDic[@"id"]};
        [Unity showanimate];
        [GZMrequest getWithURLString:[GZMUrl get_haitaoDelete_url] parameters:dic success:^(NSDictionary *data) {
            [Unity hiddenanimate];
            if ([data[@"status"] intValue] == 0) {
                [self.delegate updataList];
                [self.navigationController popViewControllerAnimated:YES];
            }
            [WHToast showMessage:data[@"mes"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        } failure:^(NSError *error) {
            [Unity hiddenanimate];
            [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }];
    }
}
//支付成功回调
- (void)reloadList{
    [self.delegate updataList];
    [self.navigationController popViewControllerAnimated:YES];
}
//发货成功回调
- (void)reloadTableView{
    [self.delegate updataList];
    [self.navigationController popViewControllerAnimated:YES];
}
//cell5 delegate
- (void)expressDynamic:(NSDictionary *)dic{
    if ([self.dataDic[@"currency"] isEqualToString:@"円"]) {
        if ([self.dataDic[@"traffic_type"] intValue] == 5) {//空港
            KdPostalViewController * kvc = [[KdPostalViewController alloc]init];
            kvc.kd_id = self.dataDic[@"traffic_num"];
            [self.navigationController pushViewController:kvc animated:YES];
        }else{
            KdJapanViewController * kvc = [[KdJapanViewController alloc]init];
            kvc.kd_id = self.dataDic[@"traffic_num"];
            [self.navigationController pushViewController:kvc animated:YES];
        }
    }else{//美国usc
        KdJapanViewController * kvc = [[KdJapanViewController alloc]init];
        kvc.kd_id = self.dataDic[@"traffic_num"];
        kvc.kd_url = @"123";
        [self.navigationController pushViewController:kvc animated:YES];
    }
}

@end
