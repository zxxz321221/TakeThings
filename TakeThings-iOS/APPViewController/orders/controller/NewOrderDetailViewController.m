//
//  NewOrderDetailViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/13.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "NewOrderDetailViewController.h"
#import "AddressViewController.h"
#import "OrderDetailCell0.h"//商品信息
#import "OrderDetailCell2.h"//代拍费用
#import "OrderDetailCell3.h"//补充费用
#import "OrderDetailCell4.h"//寄送信息
#import "OrderDetailCell5.h"//总金额
#import "OrderDetailCell6.h"//包裹cell
#import "ProgressCell.h"
#import "WebViewController.h"
#import "PrecelDetailViewController.h"
#import "ServiceViewController.h"
#import "AddPlaceView.h"
#import "OrderPayViewController.h"
#import "OrderInfoViewController.h"
#import "NewSendDetailViewController.h"
#import "KdPostalViewController.h"
#import "KdJapanViewController.h"
@interface NewOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,OrderDetailCell4Delegate,AddressViewDelegate,OrderDetailCell6Delegate,AddPlaceViewDelegate,OrderInfoDelegate,NewSendDelegate>
{
    NSInteger status1;// 默认1（1:砍单  2:客服）
    NSInteger status2;// 默认1（1:加价  2:定金支付  3:委托单结算  4：通知发货 5：删除委托单）
    NSString * addID;
    NSString * tbPrice;//投标价格
    NSInteger sectionNum;
    BOOL tanhao;
}
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) NSMutableArray * arrList;//包裹数组
@property (nonatomic , strong) NSMutableArray * djList;//section 0 定金数组
//section ==0
@property (nonatomic , strong) UILabel * numberL;
@property (nonatomic , strong) UILabel * statusL;
@property (nonatomic , strong) UILabel * line0;
@property (nonatomic , strong) UIImageView * icon;//商品图片
@property (nonatomic , strong) UILabel * goodsTitle;//商品标题
@property (nonatomic , strong) UILabel * goodsNum;//竞拍商品数量
@property (nonatomic , strong) UILabel * placeLabel;//商品价格
@property (nonatomic , strong) UILabel * offerL;//出价竞标
@property (nonatomic , strong) UILabel * line1;
@property (nonatomic , strong) UILabel * descri;//中文描述
@property (nonatomic , strong) UILabel * descriL;
@property (nonatomic , strong) UILabel * accountL;//出价账号文字
@property (nonatomic , strong) UILabel * account;//出价账号
@property (nonatomic , strong) UILabel * entrustTimeL;//委托时间
@property (nonatomic , strong) UILabel * entrustTime;
@property (nonatomic , strong) UILabel * endOfTimeL;//结标时间
@property (nonatomic , strong) UILabel * endOfTime;
@property (nonatomic , strong) UILabel * bidPlaceL;//投标价格
@property (nonatomic , strong) UILabel * bidPlace;

//包裹 header
@property (nonatomic , strong) UILabel * bgLine;
@property (nonatomic , strong) UILabel * bgTitle;
@property (nonatomic , strong) UILabel * bgNum;
@property (nonatomic , strong) UIImageView * bgImg;

//bottomView
@property (nonatomic , strong) UIView * bottomView;
@property (nonatomic , strong) UIButton * olgBtn;//原始页面
@property (nonatomic , strong) UIButton * serviceBtn;//客服
@property (nonatomic , strong) UIButton * otherBtn;//其他按钮

@property (nonatomic , strong) NSDictionary * bid_infoDic;//其他信息

@property (nonatomic ,strong) NSMutableArray * jdList;
@property (nonatomic , strong) AddPlaceView * pView;
@end

@implementation NewOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    sectionNum = 5;
    status1 = 1;
    status2 = 1;
    self.view.backgroundColor = [Unity getColor:@"f0f0f0"];
    self.title = @"委托单详情";
    tanhao = NO;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
    [self reuqestOrderDetail];
}
#pragma mark bottomView
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NavBarHeight-[Unity countcoordinatesH:55], SCREEN_WIDTH, [Unity countcoordinatesH:55])];
        _bottomView.backgroundColor = [UIColor whiteColor];
        UILabel * line = [Unity lableViewAddsuperview_superView:_bottomView _subViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentLeft];
        line.backgroundColor = [Unity getColor:@"e0e0e0"];
        
        [_bottomView addSubview:self.otherBtn];
        [_bottomView addSubview:self.serviceBtn];
        [_bottomView addSubview:self.olgBtn];
    }
    return _bottomView;
}
- (UIButton *)otherBtn{
    if (!_otherBtn) {
        _otherBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:80], [Unity countcoordinatesH:10], [Unity countcoordinatesH:70], [Unity countcoordinatesH:30])];
        [_otherBtn addTarget:self action:@selector(otherClick) forControlEvents:UIControlEventTouchUpInside];
        _otherBtn.backgroundColor = [Unity getColor:@"aa112d"];
        [_otherBtn setTitle:@"加价" forState:UIControlStateNormal];
        [_otherBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _otherBtn.layer.cornerRadius = _otherBtn.height/2;
        _otherBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _otherBtn;
}
- (UIButton *)serviceBtn{
    if (!_serviceBtn) {
        _serviceBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_serviceBtn addTarget:self action:@selector(cutClick) forControlEvents:UIControlEventTouchUpInside];
        [_serviceBtn setTitle:@"砍单" forState:UIControlStateNormal];
        [_serviceBtn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
        _serviceBtn.layer.cornerRadius = _serviceBtn.height/2;
        _serviceBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _serviceBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        _serviceBtn.layer.borderWidth = 1;
    }
    return _serviceBtn;
}
- (UIButton *)olgBtn{
    if (!_olgBtn) {
        _olgBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:240], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_olgBtn addTarget:self action:@selector(oldClick) forControlEvents:UIControlEventTouchUpInside];
        [_olgBtn setTitle:@"原始页面" forState:UIControlStateNormal];
        [_olgBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        _olgBtn.layer.cornerRadius = _olgBtn.height/2;
        _olgBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _olgBtn.layer.borderColor = LabelColor9.CGColor;
        _olgBtn.layer.borderWidth = 1;
    }
    return _olgBtn;
}
#pragma mark 初始化
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-[Unity countcoordinatesH:55]) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate=self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = FALSE;
        _tableView.showsHorizontalScrollIndicator = FALSE;
        [_tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        //没有数据时不显示cell
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        if (@available(iOS 11.0, *)) {
            //方式刷新tableview抖动
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}
#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.arrList.count ==0) {
        return 5;
    }else{
        return 6+self.arrList.count;//默认6个 有几个包裹加几个section  indexpath。section5 开始
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.arrList.count ==0) {
        return 1;
    }else{
        if (section == 0) {
            if (self.djList.count != 0) {
                return 1;
            }else{
                return 0;
            }
        }else if (section == 1 || section == 2 || section == 3 || section == 4 || section == 6+self.arrList.count-1 ){
            return 1;
        }else{
            if ([self.arrList[section-5][@"isAn"] intValue] == 1) {
                return 1;
            }
            return 0;
        }
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.arrList.count == 0) {
        if (indexPath.section == 0) {
            return self.djList.count*[Unity countcoordinatesH:25]+[Unity countcoordinatesH:5];
        }else if (indexPath.section == 1){
            return self.jdList.count*[Unity countcoordinatesH:25]+[Unity countcoordinatesH:10];
        }else if (indexPath.section == 2){
            return [Unity countcoordinatesH:200];
        }else if (indexPath.section == 3){
            return [Unity countcoordinatesH:130];
        }else{//总金额
            return [Unity countcoordinatesH:40];
        }
    }else{
        if (indexPath.section == 0) {
            return self.djList.count*[Unity countcoordinatesH:25]+[Unity countcoordinatesH:5];
        }else if (indexPath.section == 1){
            return self.jdList.count*[Unity countcoordinatesH:25]+[Unity countcoordinatesH:10];
        }else if (indexPath.section == 2){
            return [Unity countcoordinatesH:200];
        }else if (indexPath.section == 3){
            return [Unity countcoordinatesH:130];
        }else if (indexPath.section == 4){
            return [Unity countcoordinatesH:160];
        }else if (indexPath.section == 6+self.arrList.count-1){//总金额
            return [Unity countcoordinatesH:40];
        }
        return [Unity countcoordinatesH:125];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.arrList.count ==0) {
        if (indexPath.section ==0) {
                OrderDetailCell0 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailCell0 class])];
                    if (cell == nil) {
                        cell = [[OrderDetailCell0 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderDetailCell0 class])];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    [cell configArr:self.djList];
                    return cell;
            }else if (indexPath.section == 1){
                ProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProgressCell class])];
                    if (cell == nil) {
                        cell = [[ProgressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ProgressCell class])];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //            [cell configWithData:self.bid_infoDic];
                cell.tanhao = tanhao;
                [cell configProgressArr:self.jdList];
                    return cell;
            }else if (indexPath.section == 2){
                OrderDetailCell2 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailCell2 class])];
                    if (cell == nil) {
                        cell = [[OrderDetailCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderDetailCell2 class])];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    [cell configWithData:self.bid_infoDic];
                    return cell;
            }else if (indexPath.section == 3){
                OrderDetailCell3 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailCell3 class])];
                if (cell == nil) {
                    cell = [[OrderDetailCell3 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderDetailCell3 class])];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell configWithData:self.bid_infoDic];
                return cell;
            }else{
                OrderDetailCell5 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailCell5 class])];
                if (cell == nil) {
                    cell = [[OrderDetailCell5 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderDetailCell5 class])];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                float sum = ([self.bid_infoDic[@"cost_local_freight"] floatValue] + [self.bid_infoDic[@"cost_excise"] floatValue])*[self.bid_infoDic[@"exchange_rate"] floatValue]+([self.bid_infoDic[@"cost_bank_remitt"] floatValue]+[self.bid_infoDic[@"cost_process"] floatValue] + [self.bid_infoDic[@"cost_fraud_safe"] floatValue]) * [self.bid_infoDic[@"exchange_rate"] floatValue] + [self.bid_infoDic[@"cost_foundry"] floatValue]+[self.bid_infoDic[@"over_price"] floatValue]*[self.bid_infoDic[@"exchange_rate"] floatValue];
                cell.placeL.text = [NSString stringWithFormat:@"%.2fRMB",sum];
                return cell;
            }
    }else{
        if (indexPath.section ==0) {
                OrderDetailCell0 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailCell0 class])];
                    if (cell == nil) {
                        cell = [[OrderDetailCell0 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderDetailCell0 class])];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    [cell configArr:self.djList];
                    return cell;
            }else if (indexPath.section == 1){
                ProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProgressCell class])];
                    if (cell == nil) {
                        cell = [[ProgressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ProgressCell class])];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //            [cell configWithData:self.bid_infoDic];
                cell.tanhao = tanhao;
                [cell configProgressArr:self.jdList];
                    return cell;
            }else if (indexPath.section == 2){
                OrderDetailCell2 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailCell2 class])];
                    if (cell == nil) {
                        cell = [[OrderDetailCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderDetailCell2 class])];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    [cell configWithData:self.bid_infoDic];
                    return cell;
            }else if (indexPath.section == 3){
                OrderDetailCell3 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailCell3 class])];
                if (cell == nil) {
                    cell = [[OrderDetailCell3 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderDetailCell3 class])];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell configWithData:self.bid_infoDic];
                return cell;
            }else if (indexPath.section == 4){
                OrderDetailCell4 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailCell4 class])];
                if (cell == nil) {
                    cell = [[OrderDetailCell4 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderDetailCell4 class])];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell configName:self.bid_infoDic[@"get_name"] WithMobile:self.bid_infoDic[@"get_phone"] WithAddress:self.bid_infoDic[@"get_address"] WithMark:self.bid_infoDic[@"user_remark"] WithStatus:[self.bid_infoDic[@"order_bid_status_id"] intValue]];
                cell.delegate = self;
                return cell;
            }else if (indexPath.section == 6+self.arrList.count-1){
                OrderDetailCell5 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailCell5 class])];
                if (cell == nil) {
                    cell = [[OrderDetailCell5 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderDetailCell5 class])];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                float sum = ([self.bid_infoDic[@"cost_local_freight"] floatValue] + [self.bid_infoDic[@"cost_excise"] floatValue])*[self.bid_infoDic[@"exchange_rate"] floatValue]+([self.bid_infoDic[@"cost_bank_remitt"] floatValue]+[self.bid_infoDic[@"cost_process"] floatValue] + [self.bid_infoDic[@"cost_fraud_safe"] floatValue]) * [self.bid_infoDic[@"exchange_rate"] floatValue] + [self.bid_infoDic[@"cost_foundry"] floatValue]+[self.bid_infoDic[@"over_price"] floatValue]*[self.bid_infoDic[@"exchange_rate"] floatValue];
                cell.placeL.text = [NSString stringWithFormat:@"%.2fRMB",sum];
                return cell;
            }else{//包裹
                OrderDetailCell6 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailCell6 class])];
                if (cell == nil) {
                    cell = [[OrderDetailCell6 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([OrderDetailCell6 class])];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell configWithData:self.arrList[indexPath.section-5]];
                cell.delegate = self;
                return cell;
            }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.arrList.count == 0) {
        if (section == 0) {//顶部商品 图片等
            return [Unity countcoordinatesH:261];
        }else if (section == 1){//进度条上面section
            return [Unity countcoordinatesH:10];
        }else if (section == 2){//日本代拍费用
            return [Unity countcoordinatesH:10];
        }else if (section == 3){//补充费用
            return [Unity countcoordinatesH:10];
        }else{//总金额
            return [Unity countcoordinatesH:10];
        }
    }
    if (section == 0) {//顶部商品 图片等
        return [Unity countcoordinatesH:261];
    }else if (section == 1){//进度条上面section
        return [Unity countcoordinatesH:10];
    }else if (section == 2){//日本代拍费用
        return [Unity countcoordinatesH:10];
    }else if (section == 3){//补充费用
        return [Unity countcoordinatesH:10];
    }else if (section == 4){//地址
        return [Unity countcoordinatesH:10];
    }else if (section == 6+self.arrList.count-1){//总金额
        return [Unity countcoordinatesH:10];
    }else{//包裹的header高度
        return [Unity countcoordinatesH:40];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [UIView new];
    if (self.arrList.count ==0) {
        if (section == 0) {//顶部商品 图片等
            header.backgroundColor = [UIColor whiteColor];
            [header addSubview:self.numberL];
            [header addSubview:self.statusL];
            [header addSubview:self.line0];
            [header addSubview:self.icon];
            [header addSubview:self.goodsTitle];
            [header addSubview:self.goodsNum];
            [header addSubview:self.offerL];
            [header addSubview:self.placeLabel];
            [header addSubview:self.line1];
            [header addSubview:self.descri];
            [header addSubview:self.descriL];
            [header addSubview:self.accountL];
            [header addSubview:self.account];
            [header addSubview:self.entrustTimeL];
            [header addSubview:self.entrustTime];
            [header addSubview:self.endOfTimeL];
            [header addSubview:self.endOfTime];
            [header addSubview:self.bidPlaceL];
            [header addSubview:self.bidPlace];
        }else if (section == 1){//进度条上面section
            header.backgroundColor = [Unity getColor:@"f0f0f0"];
        }else if (section == 2){//日本代拍费用
            header.backgroundColor = [Unity getColor:@"f0f0f0"];
        }else if (section == 3){//补充费用
            header.backgroundColor = [Unity getColor:@"f0f0f0"];
        }else{//总金额
            header.backgroundColor = [Unity getColor:@"f0f0f0"];
        }
    }else{
        if (section == 0) {//顶部商品 图片等
            header.backgroundColor = [UIColor whiteColor];
            [header addSubview:self.numberL];
            [header addSubview:self.statusL];
            [header addSubview:self.line0];
            [header addSubview:self.icon];
            [header addSubview:self.goodsTitle];
            [header addSubview:self.goodsNum];
            [header addSubview:self.offerL];
            [header addSubview:self.placeLabel];
            [header addSubview:self.line1];
            [header addSubview:self.descri];
            [header addSubview:self.descriL];
            [header addSubview:self.accountL];
            [header addSubview:self.account];
            [header addSubview:self.entrustTimeL];
            [header addSubview:self.entrustTime];
            [header addSubview:self.endOfTimeL];
            [header addSubview:self.endOfTime];
            [header addSubview:self.bidPlaceL];
            [header addSubview:self.bidPlace];
        }else if (section == 1){//进度条上面section
            header.backgroundColor = [Unity getColor:@"f0f0f0"];
        }else if (section == 2){//日本代拍费用
            header.backgroundColor = [Unity getColor:@"f0f0f0"];
        }else if (section == 3){//补充费用
            header.backgroundColor = [Unity getColor:@"f0f0f0"];
        }else if (section == 4){//地址
            header.backgroundColor = [Unity getColor:@"f0f0f0"];
        }else if (section == 6+self.arrList.count-1){//总金额
            header.backgroundColor = [Unity getColor:@"f0f0f0"];
        }else{//包裹的header高度
            header.backgroundColor = [UIColor whiteColor];
            self.bgTitle = [Unity lableViewAddsuperview_superView:header _subViewFrame:CGRectMake([Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:100], [Unity countcoordinatesH:40]) _string:[NSString stringWithFormat:@"包裹%ld",section-4] _lableFont:[UIFont systemFontOfSize:FontSize(17)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
            self.bgImg = [Unity imageviewAddsuperview_superView:header _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:22], [Unity countcoordinatesH:17.5], [Unity countcoordinatesW:12], [Unity countcoordinatesH:5]) _imageName:self.arrList[section-5][@"img"] _backgroundColor:nil];
            self.bgLine = [Unity lableViewAddsuperview_superView:header _subViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentRight];
            self.bgLine.backgroundColor = [Unity getColor:@"e0e0e0"];
            header.tag = section;
            // 为header的点击事件
            [header addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTap:)]];
        }
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
/**
 数组 初始化
 */
- (NSMutableArray *)arrList{
    if (!_arrList) {
        _arrList = [NSMutableArray new];
    }
    return _arrList;
}
- (NSMutableArray *)djList{
    if (!_djList) {
        _djList = [NSMutableArray new];
    }
    return _djList;
}
- (NSDictionary *)bid_infoDic{
    if (!_bid_infoDic) {
        _bid_infoDic = [NSDictionary new];
    }
    return _bid_infoDic;
}

#pragma mark    section==0
- (UILabel *)numberL{
    if (!_numberL) {
        _numberL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:170], [Unity countcoordinatesH:40])];
//        _numberL.text = [NSString stringWithFormat:@"案件编号 %@",self.bid_infoDic[@"order_code"]];
        _numberL.textColor = LabelColor3;
        _numberL.font = [UIFont systemFontOfSize:FontSize(14)];
        _numberL.textAlignment = NSTextAlignmentLeft;
    }
    return _numberL;
}
- (UILabel *)statusL{
    if (!_statusL) {
        _statusL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:120], _numberL.top, [Unity countcoordinatesW:110], _numberL.height)];
//        _statusL.text = self.bid_infoDic[@"status_name"];
        _statusL.textColor = [Unity getColor:@"aa112d"];
        _statusL.font = [UIFont systemFontOfSize:FontSize(14)];
        _statusL.textAlignment = NSTextAlignmentRight;
    }
    return _statusL;
}
- (UILabel *)line0{
    if (!_line0) {
        _line0 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _numberL.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:10], 1)];
        _line0.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line0;
}
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line0.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:70])];
        //添加边框
        CALayer * layer = [_icon layer];
        layer.borderColor = [[Unity getColor:@"#e0e0e0"] CGColor];
        layer.borderWidth = 1.0f;
        _icon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _icon;
}
- (UILabel *)goodsTitle{
    if (!_goodsTitle) {
        _goodsTitle = [[UILabel alloc]initWithFrame:CGRectMake(_icon.right+[Unity countcoordinatesW:5], _icon.top, SCREEN_WIDTH-[Unity countcoordinatesW:125], [Unity countcoordinatesH:40])];
        _goodsTitle.numberOfLines = 0;
        _goodsTitle.textColor = LabelColor3;
        _goodsTitle.font = [UIFont systemFontOfSize:FontSize(14)];
        _goodsTitle.textAlignment = NSTextAlignmentLeft;
//        _goodsTitle.text = self.bid_infoDic[@"goods_name"];
    }
    return _goodsTitle;
}
- (UILabel *)goodsNum{
    if (!_goodsNum) {
        _goodsNum = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitle.right+[Unity countcoordinatesW:10], _goodsTitle.top+[Unity countcoordinatesH:5], [Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
//        _goodsNum.text = [NSString stringWithFormat:@"x%@",self.bid_infoDic[@"bid_num"]];
        _goodsNum.textColor = LabelColor6;
        _goodsNum.font = [UIFont systemFontOfSize:FontSize(12)];
        _goodsNum.textAlignment = NSTextAlignmentRight;
    }
    return _goodsNum;
}
- (UILabel *)offerL{
    if (!_offerL) {
        _offerL = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitle.left, _goodsTitle.bottom+[Unity countcoordinatesH:7], [Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
//        _offerL.text =@"xxx";
        _offerL.backgroundColor = [Unity getColor:@"#f6e7ea"];
        _offerL.textColor = [Unity getColor:@"#aa112d"];
        _offerL.textAlignment = NSTextAlignmentCenter;
        _offerL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _offerL;
}
- (UILabel *)placeLabel{
    if (!_placeLabel) {
        _placeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitle.left, _goodsTitle.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:95], [Unity countcoordinatesH:20])];
//        _placeLabel.text = [NSString stringWithFormat:@"%@%@",self.dataDic[@"over_price"],self.dataDic[@"currency"]];
        _placeLabel.textColor = LabelColor6;
        _placeLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _placeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _placeLabel;
}
- (UILabel *)line1{
    if (!_line1) {
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _icon.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:10], 1)];
        _line1.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line1;
}
- (UILabel *)descri{
    if (!_descri) {
        _descri = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line1.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:80], [Unity countcoordinatesH:25])];
        _descri.textColor = LabelColor3;
        _descri.text = @"中文描述";
        _descri.textAlignment = NSTextAlignmentLeft;
        _descri.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _descri;
}
- (UILabel *)descriL{
    if (!_descriL) {
        _descriL = [[UILabel alloc]initWithFrame:CGRectMake(_descri.right, _descri.top, SCREEN_WIDTH-[Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _descriL.textColor = LabelColor6;
        _descriL.textAlignment = NSTextAlignmentRight;
        _descriL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _descriL;
}
- (UILabel *)accountL{
    if (!_accountL) {
        _accountL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _descri.bottom, [Unity countcoordinatesW:80], [Unity countcoordinatesH:25])];
        _accountL.textColor = LabelColor3;
        _accountL.text = @"出价账号";
        _accountL.textAlignment = NSTextAlignmentLeft;
        _accountL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _accountL;
}
- (UILabel *)account{
    if (!_account) {
        _account = [[UILabel alloc]initWithFrame:CGRectMake(_accountL.right, _accountL.top, SCREEN_WIDTH-[Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _account.textColor = LabelColor6;
        _account.textAlignment = NSTextAlignmentRight;
        _account.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _account;
}
- (UILabel *)entrustTimeL{
    if (!_entrustTimeL) {
        _entrustTimeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _accountL.bottom, [Unity countcoordinatesW:80], [Unity countcoordinatesH:25])];
        _entrustTimeL.textColor = LabelColor3;
        _entrustTimeL.text = @"委托时间";
        _entrustTimeL.textAlignment = NSTextAlignmentLeft;
        _entrustTimeL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _entrustTimeL;
}
- (UILabel *)entrustTime{
    if (!_entrustTime) {
        _entrustTime = [[UILabel alloc]initWithFrame:CGRectMake(_entrustTimeL.right, _entrustTimeL.top, SCREEN_WIDTH-[Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _entrustTime.textColor = LabelColor6;
//        _entrustTime.text = self.bid_infoDic[@"create_time"];
        _entrustTime.textAlignment = NSTextAlignmentRight;
        _entrustTime.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _entrustTime;
}
- (UILabel *)endOfTimeL{
    if (!_endOfTimeL) {
        _endOfTimeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _entrustTimeL.bottom, [Unity countcoordinatesW:80], [Unity countcoordinatesH:25])];
        _endOfTimeL.textColor = LabelColor3;
        _endOfTimeL.text = @"结束时间";
        _endOfTimeL.textAlignment = NSTextAlignmentLeft;
        _endOfTimeL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _endOfTimeL;
}
- (UILabel *)endOfTime{
    if (!_endOfTime) {
        _endOfTime = [[UILabel alloc]initWithFrame:CGRectMake(_endOfTimeL.right, _endOfTimeL.top, SCREEN_WIDTH-[Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _endOfTime.textColor = LabelColor6;
        _endOfTime.text = self.dataDic[@"over_time_ch"];
        _endOfTime.textAlignment = NSTextAlignmentRight;
        _endOfTime.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _endOfTime;
}
- (UILabel *)bidPlaceL{
    if (!_bidPlaceL) {
        _bidPlaceL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _endOfTimeL.bottom, [Unity countcoordinatesW:80], [Unity countcoordinatesH:25])];
        _bidPlaceL.textColor = LabelColor3;
        _bidPlaceL.text = @"投标价格";
        _bidPlaceL.textAlignment = NSTextAlignmentLeft;
        _bidPlaceL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _bidPlaceL;
}
- (UILabel *)bidPlace{
    if (!_bidPlace) {
        _bidPlace = [[UILabel alloc]initWithFrame:CGRectMake(_bidPlaceL.right, _bidPlaceL.top, SCREEN_WIDTH-[Unity countcoordinatesW:100], [Unity countcoordinatesH:25])];
        _bidPlace.textColor = [Unity getColor:@"aa112d"];
//        _bidPlace.text = [NSString stringWithFormat:@"%@%@",self.dataDic[@"price_user"],self.bid_infoDic[@"currency"]];
        _bidPlace.textAlignment = NSTextAlignmentRight;
        _bidPlace.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _bidPlace;
}
#pragma mark  ---------编辑数据---------
- (void)editData:(NSDictionary *)dic WithArrList:(NSArray *)arr{
    if (self.page == 1) {
        if ([dic[@"advance_rate"] floatValue] > 0) {//有定金
            NSMutableDictionary * dict = [NSMutableDictionary new];
            if ([dic[@"order_bid_status_id"] intValue] <= 30) {//待支付定金
                [dict setValue:@"定金(待支付)" forKey:@"title"];
            }else if ([dic[@"order_bid_status_id"] intValue] < 110){//已支付定金
                [dict setValue:@"定金(已支付)" forKey:@"title"];
            }else{//已退回定金
                [dict setValue:@"定金(已退回)" forKey:@"title"];
            }
            [dict setValue:dic[@"add_amount_all"] forKey:@"place"];
            [dict setValue:dic[@"currency"] forKey:@"currency"];
            [self.djList addObject:dict];
        }
    }else{
        if ([dic[@"advance_rate"] floatValue] > 0) {//有定金
            NSMutableDictionary * dict = [NSMutableDictionary new];
            if ([dic[@"order_bid_status_id"] intValue] <= 30) {//待支付定金
                [dict setValue:@"定金(待支付)" forKey:@"title"];
            }else if ([dic[@"order_bid_status_id"] intValue] < 110){//已支付定金
                [dict setValue:@"定金(已支付)" forKey:@"title"];
            }else{//已退回定金
                [dict setValue:@"定金(已退回)" forKey:@"title"];
            }
            [dict setValue:dic[@"add_amount_all"] forKey:@"place"];
            [dict setValue:dic[@"currency"] forKey:@"currency"];
            [self.djList addObject:dict];
        }
        NSMutableDictionary * dict = [NSMutableDictionary new];
        [dict setValue:@"结标价格" forKey:@"title"];
        [dict setValue:self.dataDic[@"over_price"] forKey:@"place"];
        [dict setValue:dic[@"currency"] forKey:@"currency"];
        [self.djList addObject:dict];
    }
    for (int i=0; i < arr.count; i++) {
        NSMutableDictionary * dict = [NSMutableDictionary new];
        dict = [arr[i] mutableCopy];
        [dict setValue:@"0" forKey:@"isAn"];
        [dict setValue:@"下拉" forKey:@"img"];
        [self.arrList addObject:dict];
    }
    
    [self.tableView reloadData];
}


#pragma mark  cell4 delegate

- (void)seleteAddress{
    AddressViewController * avc = [[AddressViewController alloc]init];
    avc.page = 4;
    avc.delegate = self;
    [self.navigationController pushViewController:avc animated:YES];
}
- (void)EntrustAddress:(NSMutableArray *)list WithIndexPath:(NSInteger )indexpath{
    NSLog(@"%@",list[indexpath]);
    NSMutableDictionary * dict = [self.bid_infoDic mutableCopy];
    [dict setValue:list[indexpath][@"w_name"] forKey:@"get_name"];
    [dict setValue:[NSString stringWithFormat:@"%@ %@",list[indexpath][@"w_address"],list[indexpath][@"w_address_detail"]] forKey:@"get_address"];
    [dict setValue:list[indexpath][@"w_mobile"] forKey:@"get_phone"];
    [dict setValue:list[indexpath][@"w_other"] forKey:@"user_remark"];
    [dict setValue:list[indexpath][@"postal"] forKey:@"get_postal"];
    self.bid_infoDic = [dict copy];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:4];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark  ----header手势   编号手势---
- (void)headerTap:(UITapGestureRecognizer *)header{
    NSLog(@"%ld",header.view.tag-5);
    
    NSMutableArray * arr = [NSMutableArray new];
    for (int i=0 ; i<self.arrList.count; i++) {
        if (i==header.view.tag-5) {
            NSMutableDictionary * dic = [NSMutableDictionary new];
            dic = [self.arrList[i] mutableCopy];
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
            dic = [self.arrList[i] mutableCopy];
            dic = [Unity nullDicToDic:dic];
            [arr addObject:dic];
        }
    }
    self.arrList = arr;
    [self.tableView reloadData];
}
/**
 委托单详情
 */
- (void)reuqestOrderDetail{
    NSDictionary *dic = @{@"id":self.orderId,@"os":@"1"};
    [Unity showanimate];
    [GZMrequest getWithURLString:[GZMUrl get_newOrderDetail_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        NSLog(@"%@",data);
        if ([data[@"status"] intValue] == 0) {
            tbPrice = data[@"orderBidAdd"][@"price_user"];
            self.bid_infoDic = [Unity nullDicToDic:data[@"bid_info"]];
            [self editData:self.bid_infoDic WithArrList: data[@"order_transport_list"]];
            [self editBtnFrame:data[@"bid_info"][@"order_bid_status_id"]];
            [self editJDList:data];
            [self reloadHeaderView];
        }else{
            [WHToast showMessage:data[@"mes"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

/**
 编辑按钮底部frame
 */
- (void)editBtnFrame:(NSString *)status_id{
    NSInteger status = [status_id intValue];
    if (status == 40) {
        status1 = 1;
        status2 = 1;
        self.otherBtn.hidden = NO;
        self.serviceBtn.hidden = NO;
        self.olgBtn.hidden = NO;
        self.otherBtn.frame = CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:80], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
        [self.otherBtn setTitle:@"加价" forState:UIControlStateNormal];
        self.serviceBtn.frame = CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
        [self.serviceBtn setTitle:@"砍单" forState:UIControlStateNormal];
        self.olgBtn.frame = CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:240], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
    }else if (status == 10 || status == 50 || status == 60 || status == 70 || status == 120 || status == 123 || status == 125 || status == 127 || status == 140){
        status1 = 2;//联系客服
        self.otherBtn.hidden = YES;
        self.serviceBtn.hidden = NO;
        self.serviceBtn.frame = CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:80], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
        [self.serviceBtn setTitle:@"联系客服" forState:UIControlStateNormal];
        self.olgBtn.frame = CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
    }else if (status == 30){
        status2 = 2;
        self.serviceBtn.hidden = YES;
        self.otherBtn.hidden = NO;
        self.otherBtn.frame = CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:80], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
        [self.otherBtn setTitle:@"定金付款" forState:UIControlStateNormal];
        self.olgBtn.frame = CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
    }else if (status == 115){
        status2 = 3;
        self.serviceBtn.hidden = YES;
        self.otherBtn.hidden = NO;
        self.otherBtn.frame = CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:80], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
        [self.otherBtn setTitle:@"委托单结算" forState:UIControlStateNormal];
        self.olgBtn.frame = CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
    }else if (status == 130){
        status1 = 2;//联系客服
        status2 = 4;
        self.otherBtn.hidden = NO;
        self.serviceBtn.hidden = NO;
        self.olgBtn.hidden = NO;
        self.otherBtn.frame = CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:80], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
        [self.otherBtn setTitle:@"通知发货" forState:UIControlStateNormal];
        self.serviceBtn.frame = CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
        [self.serviceBtn setTitle:@"联系客服" forState:UIControlStateNormal];
        self.olgBtn.frame = CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:240], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
    }else{
        status1 = 2;//联系客服
        status2 = 5;
        self.otherBtn.hidden = YES;
        self.serviceBtn.hidden = NO;
        self.olgBtn.hidden = NO;
//        self.otherBtn.frame = CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:80], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
//        [self.otherBtn setTitle:@"删除委托单" forState:UIControlStateNormal];
        self.serviceBtn.frame = CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:80], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
        [self.serviceBtn setTitle:@"联系客服" forState:UIControlStateNormal];
        self.olgBtn.frame = CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30]);
    }
}
/**
 底部按钮事件
 */
- (void)oldClick{//原始页面
    WebViewController * wvc = [[WebViewController alloc]init];
    wvc.webUrl = [NSString stringWithFormat:@"%@/index/order_bid/getyahoo?url=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"new_sdxurl"],self.oldUrl];
    [self.navigationController pushViewController:wvc animated:YES];
}
/**
数据请求回来  刷新headerView上的ui
 */
- (void)reloadHeaderView{

    _numberL.text = [NSString stringWithFormat:@"案件编号 %@",self.bid_infoDic[@"order_code"]];

    _statusL.text = self.bid_infoDic[@"status_name"];

    if ([self.bid_infoDic[@"goods_img"] isKindOfClass:[NSArray class]]) {
        [_icon sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"Loading"]];
    }else{
        NSDictionary * dic = [Unity dictionaryWithJsonString:self.bid_infoDic[@"goods_img"]];
        NSArray * arr = [dic allKeys];
        [_icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic[arr[0]]]] placeholderImage:[UIImage imageNamed:@"Loading"]];
    }

    _goodsTitle.text = self.bid_infoDic[@"goods_name"];

    _goodsNum.text = [NSString stringWithFormat:@"x%@",self.bid_infoDic[@"bid_num"]];

    NSString * sta = @"";
            if ([self.bid_infoDic[@"bid_mode"] intValue] == 2) {//结标前出价
                  sta = @"结标前出价";
            }else{//立即出价
                sta = @"立即出价";
            }
            _offerL.frame = CGRectMake(_goodsTitle.left, _goodsTitle.bottom+[Unity countcoordinatesH:7], 20+[Unity widthOfString:sta OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:20]], [Unity countcoordinatesH:20]);
            _offerL.layer.cornerRadius = [Unity countcoordinatesH:10];
            _offerL.layer.masksToBounds = YES;
            _offerL.text = sta;

    _placeLabel.text = [NSString stringWithFormat:@"%@%@",self.dataDic[@"over_price"],self.dataDic[@"currency"]];

    if ([self.bid_infoDic[@"bid_account"] isEqualToString:@""]) {
                _account.text = @"";
            }else{
                if ([self.bid_infoDic[@"currency"] isEqualToString:@"円"]) {
                    _account.text = [NSString stringWithFormat:@"%@/雅虎显示%@",self.bid_infoDic[@"bid_account"],self.bid_infoDic[@"w_signal"]];
                }else{
                    _account.text = [NSString stringWithFormat:@"%@/易贝显示%@",self.bid_infoDic[@"bid_account"],self.bid_infoDic[@"w_signal"]];
                }
            }

    _entrustTime.text = self.bid_infoDic[@"create_time"];

    _bidPlace.text = [NSString stringWithFormat:@"%@%@",self.dataDic[@"price_user"],self.bid_infoDic[@"currency"]];
    _descriL.text = self.dataDic[@"describe_chinese"];
}
- (NSString *)get_statusName:(NSString *)status_id{
    NSInteger status = [status_id intValue];
    switch (status) {
        case 10:
            return @"委托单审核中";
            break;
        case 30:
            return @"定金待支付";
            break;
        case 40:
            return @"";
            break;
        case 50:
            return @"";
            break;
        case 60:
            return @"";
            break;
        case 70:
            return @"";
            break;
        case 80:
            return @"";
            break;
        case 90:
            return @"";
            break;
        case 100:
            return @"";
            break;
        case 115:
            return @"";
            break;
        case 120:
            return @"";
            break;
        case 123:
            return @"";
            break;
        case 125:
            return @"";
            break;
        case 127:
            return @"";
            break;
        case 130:
            return @"";
            break;
        case 140:
            return @"";
            break;
        case 220:
            return @"";
            break;
        
            
        default:
            return @"人工审核";
            break;
    }
}
#pragma mark  ----orderCell6Delegate---
- (void)bgDetail:(NSString *)bg_id{
    PrecelDetailViewController * pvc = [[PrecelDetailViewController alloc]init];
    pvc.bg_id = bg_id;
    [self.navigationController pushViewController:pvc animated:YES];
}
- (void)editJDList:(NSDictionary *)dic{
    NSArray * arr = [NSArray new];
    NSArray * arr1 = [NSArray new];
    NSDictionary * noNullDic = [NSDictionary new];
    noNullDic = [[Unity nullDicToDic:dic[@"bid_info"]] copy];
    if ([dic[@"bid_info"][@"order_bid_status_id"] intValue]>= 50 && [dic[@"bid_info"][@"order_bid_status_id"] intValue]<= 70) {//竞价中！
        tanhao = YES;
        if ([dic[@"bid_info"][@"advance_rate"] intValue] ==0) {//不需要定金
            
            arr = @[@"委托单审核中",@"竞价中",@"已得标",@"已付款",@"海外已收货",@"海外已发货",@"已收货"];
            arr1 = @[noNullDic[@"create_time"],noNullDic[@"add_payment_time"],noNullDic[@"bid_success_time"],noNullDic[@"payment_time"],noNullDic[@"warehouse_get_time"],@"",@""];
        }else{//需要定金
            arr = @[@"委托单审核中",@"定金已支付",@"竞价中",@"已得标",@"已付款",@"定金已退回",@"海外已收货",@"海外已发货",@"已收货"];
            arr1 = @[noNullDic[@"create_time"],noNullDic[@"add_payment_time"],noNullDic[@"add_payment_time"],noNullDic[@"bid_success_time"],noNullDic[@"payment_time"],noNullDic[@"add_return_time"],noNullDic[@"warehouse_get_time"],@"",@""];
        }
    }else if ([dic[@"bid_info"][@"order_bid_status_id"] intValue]>= 80 && [dic[@"bid_info"][@"order_bid_status_id"] intValue]<= 100){//已结束
        if ([dic[@"bid_info"][@"advance_rate"] intValue] ==0) {//不需要定金
            arr = @[@"委托单审核中",@"竞价中",@"已结束"];
            arr1 = @[noNullDic[@"create_time"],noNullDic[@"add_payment_time"],@""];
        }else{//需要定金
            arr = @[@"委托单审核中",@"定金已支付",@"竞价中",@"定金已退回",@"已结束"];
            arr1 = @[noNullDic[@"create_time"],noNullDic[@"add_payment_time"],noNullDic[@"add_payment_time"],noNullDic[@"add_return_time"],@""];
        }
    }else{
        if ([dic[@"bid_info"][@"advance_rate"] intValue] ==0) {//不需要定金
            arr = @[@"委托单审核中",@"竞价中",@"已得标",@"已付款",@"海外已收货"];
            arr1 = @[noNullDic[@"create_time"],noNullDic[@"add_payment_time"],noNullDic[@"bid_success_time"],noNullDic[@"payment_time"],noNullDic[@"warehouse_get_time"]];
            //判断是否有退运记录
            NSDictionary * dict = [self get_jindu:dic[@"transport_back_list"] WithNameArr:arr WithTimeArr:arr1];
            arr = dict[@"nameArr"];
            arr1 = dict[@"timeArr"];
        }else{//需要定金
            arr = @[@"委托单审核中",@"定金已支付",@"竞价中",@"已得标",@"已付款",@"定金已退回",@"海外已收货"];
            arr1 = @[noNullDic[@"create_time"],noNullDic[@"add_payment_time"],noNullDic[@"add_payment_time"],noNullDic[@"bid_success_time"],noNullDic[@"payment_time"],noNullDic[@"add_return_time"],noNullDic[@"warehouse_get_time"]];
            //判断是否有退运记录
            //判断是否有退运记录
            NSDictionary * dict = [self get_jindu:dic[@"transport_back_list"] WithNameArr:arr WithTimeArr:arr1];
            arr = dict[@"nameArr"];
            arr1 = dict[@"timeArr"];
        }
    }
    
    for (int i=0; i<arr.count; i++) {
        NSMutableDictionary * dic = [NSMutableDictionary new];
        [dic setValue:arr1[i] forKey:@"time"];
        [dic setValue:arr[i] forKey:@"title"];
        [self.jdList addObject:dic];
    }

}
- (NSDictionary *)get_jindu:(NSArray *)arr WithNameArr:(NSArray *)nameArr WithTimeArr:(NSArray *)timeArr{
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
- (NSMutableArray *)jdList{
    if (!_jdList) {
        _jdList = [NSMutableArray new];
    }
    return _jdList;
}
- (void)cutClick{
    if (status1 == 1) {
        if ([self.bid_infoDic[@"cut_able"] intValue] == 1) {//可以砍单
            [self cutOrderId:self.bid_infoDic[@"id"]];
        }else{//不可以砍单
            [WHToast showMessage:@"当前委托单无法砍单" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    }else{
        ServiceViewController * svc = [[ServiceViewController alloc]init];
        [self.navigationController pushViewController:svc animated:YES];
    }
}
- (void)cutOrderId:(NSString *)orderId{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"login_token":userInfo[@"token"],@"user":userInfo[@"w_email"],@"bid_id":orderId};
    [Unity showanimate];
    [GZMrequest postWithURLString:[GZMUrl get_newCut_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([data[@"status"] intValue] == 0) {
            [self.navigationController popViewControllerAnimated:YES];
            [self.delegate successCut:orderId];
        }
        [WHToast showMessage:data[@"mes"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)otherClick{
    //status2;// 默认1（1:加价  2:定金支付  3:委托单结算  4：通知发货 5：删除委托单）
    if (status2 ==1) {
        [self requestBidAddShow:self.bid_infoDic[@"id"] WithMyPlace:tbPrice WithCurrency:self.bid_infoDic[@"currency"]];
    }else if (status2 ==2){
        OrderPayViewController * ovc = [[OrderPayViewController alloc]init];
        NSMutableDictionary * dic = [NSMutableDictionary new];
        dic = [self.bid_infoDic mutableCopy];
        [dic setObject:tbPrice forKey:@"price_user"];
        ovc.dataDic = [dic copy];
        [self.navigationController pushViewController:ovc animated:YES];
    }else if (status2 ==3){
        OrderInfoViewController * ovc = [[OrderInfoViewController alloc]init];
        ovc.dataDic = self.bid_infoDic;
        ovc.delegate = self;
        [self.navigationController pushViewController:ovc animated:YES];
    }else if (status2 == 4){
        NSString * ss;
        NewSendDetailViewController * svc = [[NewSendDetailViewController alloc]init];
        if ([self.bid_infoDic[@"currency"] isEqualToString:@"円"]) {
            svc.kdArray = @[@"EMS",@"SAL",@"海运"];
            ss=@"yahoo";
        }else{
            svc.kdArray = @[@"UCS"];
            ss=@"ebay";
        }
        svc.id_arr = @[self.bid_infoDic[@"id"]];
        svc.source = ss;
        svc.delegate = self;
        [self.navigationController  pushViewController:svc animated:YES];
    }else{
        if ([self.bid_infoDic[@"cut_able"] intValue] == 1) {//可以砍单
            [self cutOrderId:self.bid_infoDic[@"id"]];
        }else{//不可以砍单
            [WHToast showMessage:@"当前委托单无法砍单" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    }
}
/**
 创建加价单前显示
 */
- (void)requestBidAddShow:(NSString *)bid_id WithMyPlace:(NSString *)price WithCurrency:(NSString *)currency{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"user":userInfo[@"w_email"],@"login_token":userInfo[@"token"],@"bid_id":bid_id};
    [GZMrequest postWithURLString:[GZMUrl get_bid_add_show_url] parameters:dic success:^(NSDictionary *data) {
        if ([data[@"status"] intValue] ==0) {
            addID = bid_id;
            self.pView.number.text = data[@"info"][@"order_code"];
            self.pView.goodsName.text = data[@"info"][@"goods_name"];
            self.pView.bidPrice.text = [NSString stringWithFormat:@"%@%@",price,currency];
            self.pView.currentPrice.text =[NSString stringWithFormat:@"%@%@",data[@"info"][@"over_price"],currency];
            self.pView.markL.text = [NSString stringWithFormat:@"(出价增额:%@%@,您当前最低压出%.2f%@)",data[@"info"][@"add_min"],currency,[data[@"info"][@"over_price"] floatValue]+[data[@"info"][@"add_min"] floatValue],currency];
            
            self.pView.rate = data[@"info"][@"exchange_rate"];
            self.pView.currencyL.text = currency;
            [self.pView showAddPlaceView];
        }else{
            [WHToast showMessage:data[@"mes"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (AddPlaceView *)pView{
    if (!_pView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _pView = [AddPlaceView setAddPlaceView:window];
        _pView.delegate = self;
    }
    return _pView;
}
/**
 addplaceView delegate
 */
- (void)confirmPrice:(NSString *)price{
    if (price.length ==0) {
        [WHToast showMessage:@"请输入最新价格" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        return;
    }
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"user":userInfo[@"w_email"],@"login_token":userInfo[@"token"],@"bid_id":addID,@"price_user":price};
    [Unity showanimate];
    [GZMrequest postWithURLString:[GZMUrl get_bid_add_create_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([data[@"status"] intValue] ==0) {
            //加价成功返回上一页刷新
            [self.delegate successAddPlace];
            [self.navigationController popViewControllerAnimated:YES];
        }
        [WHToast showMessage:data[@"mes"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
//orderInfo代理
- (void)loadTwoPage{
    [self.delegate successJiesuan];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)reloadTableView{
    [self.delegate successJiesuan];
    [self.navigationController popViewControllerAnimated:YES];
}

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


