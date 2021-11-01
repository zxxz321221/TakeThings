//
//  PrecelPayDetailViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/24.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "PrecelPayDetailViewController.h"
#import "PayCell.h"
#import "PayCell0.h"
#import "BankListViewController.h"
@interface PrecelPayDetailViewController ()<UITableViewDelegate,UITableViewDataSource,PayCellDelegate,PayCell0Delegate,bankNameDelegate>
{
    BOOL isAn;//默认NO   yes展开
    BOOL isCard;//yes  借记卡 NO 信用卡
    
    NSString * _name;//姓名
    NSString * _bankCard;//银行卡号
    NSString * _idCard;//身份证号
    NSString * _mobile;//手机号
    NSString * _bankName;//银行名称(借记卡)
    NSString * _bankCode;//银行名称缩写（借记卡）
    NSString * _bankName0;//银行名称(信用卡)
    NSString * _bankCode0;//银行名称缩写（信用卡）
    NSString * _Valid;//有效期
    NSString * _code;//验证码 借记卡
    NSString * _code0;//验证码 信用卡
    NSString * _payment_id;//支付用id  借记卡
    NSString * _payment_id0;//支付用id  信用卡
    NSString * _safeCode;//安全码
}
@property (nonatomic , strong) UITableView * tableView;
/*
 列表属性
 */
@property (nonatomic , strong) UILabel * wlbzT;//物流保障
@property (nonatomic , strong) UILabel * wlbzL;//
@property (nonatomic , strong) UILabel * gjyfT;//国际运费
@property (nonatomic , strong) UILabel * gjyfL;//
@property (nonatomic , strong) UILabel * bzfyT;//包装费用
@property (nonatomic , strong) UILabel * bzfyL;//
@property (nonatomic , strong) UILabel * ccfyT;//仓储费用
@property (nonatomic , strong) UILabel * ccfyL;//
@property (nonatomic , strong) UILabel * ddyfT;//日本（美国）当地运费
@property (nonatomic , strong) UILabel * ddyfL;//
@property (nonatomic , strong) UILabel * thyfT;//上次退回运费
@property (nonatomic , strong) UILabel * thyfL;//
@property (nonatomic , strong) UILabel * zsfT;//总税费
@property (nonatomic , strong) UILabel * zsfL;//
@property (nonatomic , strong) UILabel * fwfT;//服务费
@property (nonatomic , strong) UILabel * fwfL;//
@property (nonatomic , strong) UILabel * hlT;//汇率
@property (nonatomic , strong) UILabel * hlL;//
@property (nonatomic , strong) UILabel * xjT;//小计
@property (nonatomic , strong) UILabel * xjL;//
@property (nonatomic , strong) UIView * line0;//横线
@property (nonatomic , strong) UIView * blockV;
@property (nonatomic , strong) UILabel * sumT;//总金额
@property (nonatomic , strong) UILabel * sumL;//
@property (nonatomic , strong) UILabel * markT;//注释
@property (nonatomic , strong) UIView * line1;//横线
@property (nonatomic , strong) UIView * blockV1;
@property (nonatomic , strong) UILabel * payT;//支付方式
@property (nonatomic , strong) UIButton * payType;//
@property (nonatomic , strong) UILabel * payTypeT;//

@property (nonatomic , strong) UIButton * payType1;//
@property (nonatomic , strong) UILabel * payTypeT1;//
@property (nonatomic , strong) UIView * bottomView;//底部View
@property (nonatomic , strong) UIButton * confirmPay;
@end

@implementation PrecelPayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.y_navLine.backgroundColor = [Unity getColor:@"e0e0e0"];
    isAn = NO;
    self.title = @"支付详情";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
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
#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isAn) {
        return 1;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isCard) {
        return [Unity countcoordinatesH:200];
    }
    return [Unity countcoordinatesH:260];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isCard) {
        PayCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PayCell class])];
        if (cell == nil) {
            cell = [[PayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PayCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.order_id = self.dataDic[@"id"];
        cell.status = [self.dataDic[@"order_transport_status_id"] intValue];
        if (_bankName != nil) {
            cell.bankNameText.text = _bankName;
            cell.bankCode = _bankCode;
        }
        return cell;
    }else{
        PayCell0 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PayCell0 class])];
        if (cell == nil) {
            cell = [[PayCell0 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PayCell0 class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.order_id = self.dataDic[@"id"];
        cell.status = [self.dataDic[@"order_transport_status_id"] intValue];
        if (_bankName0 != nil) {
            cell.bankNameText.text = _bankName0;
            cell.bankCode = _bankCode0;
        }
        return cell;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [Unity countcoordinatesH:485];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerView = [[UIView alloc]init];
    [headerView addSubview:self.wlbzT];
    [headerView addSubview:self.wlbzL];
    [headerView addSubview:self.gjyfT];
    [headerView addSubview:self.gjyfL];
    [headerView addSubview:self.bzfyT];
    [headerView addSubview:self.bzfyL];
    [headerView addSubview:self.ccfyT];
    [headerView addSubview:self.ccfyL];
    [headerView addSubview:self.ddyfT];
    [headerView addSubview:self.ddyfL];
    [headerView addSubview:self.thyfT];
    [headerView addSubview:self.thyfL];
    [headerView addSubview:self.zsfT];
    [headerView addSubview:self.zsfL];
    [headerView addSubview:self.fwfT];
    [headerView addSubview:self.fwfL];
    [headerView addSubview:self.hlT];
    [headerView addSubview:self.hlL];
    [headerView addSubview:self.xjT];
    [headerView addSubview:self.xjL];
    [headerView addSubview:self.line0];
    [headerView addSubview:self.blockV];
    [headerView addSubview:self.sumT];
    [headerView addSubview:self.sumL];
    [headerView addSubview:self.markT];
    [headerView addSubview:self.line1];
    [headerView addSubview:self.blockV1];
    [headerView addSubview:self.payT];
    [headerView addSubview:self.payType];
    [headerView addSubview:self.payTypeT];
    [headerView addSubview:self.payType1];
    [headerView addSubview:self.payTypeT1];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [UIView new];
    return footer;
}
#pragma mark  ---headerView 上的控件创建---
- (UILabel *)wlbzT{
    if (!_wlbzT) {
        _wlbzT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], 100, [Unity countcoordinatesH:20])];
        _wlbzT.text = @"物流保障";
        _wlbzT.textColor = LabelColor3;
        _wlbzT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _wlbzT;
}
- (UILabel *)wlbzL{
    if (!_wlbzL) {
        _wlbzL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:200], _wlbzT.top, [Unity countcoordinatesW:190], _wlbzT.height)];
        _wlbzL.text = [NSString stringWithFormat:@"%@RMB",self.dataDic[@"price_safe_traffic"]];
        _wlbzL.textColor = LabelColor3;
        _wlbzL.font = [UIFont systemFontOfSize:FontSize(14)];
        _wlbzL.textAlignment = NSTextAlignmentRight;
    }
    return _wlbzL;
}
- (UILabel *)gjyfT{
    if (!_gjyfT) {
        _gjyfT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _wlbzT.bottom+[Unity countcoordinatesH:10], 100, [Unity countcoordinatesH:20])];
        _gjyfT.text = @"国际运费";
        _gjyfT.textColor = LabelColor3;
        _gjyfT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _gjyfT;
}
- (UILabel *)gjyfL{
    if (!_gjyfL) {
        _gjyfL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:200], _gjyfT.top, [Unity countcoordinatesW:190], _gjyfT.height)];
        _gjyfL.text = [NSString stringWithFormat:@"%@%@",self.dataDic[@"price_weight"],self.dataDic[@"currency"]];
        _gjyfL.textColor = LabelColor3;
        _gjyfL.font = [UIFont systemFontOfSize:FontSize(14)];
        _gjyfL.textAlignment = NSTextAlignmentRight;
    }
    return _gjyfL;
}
- (UILabel *)bzfyT{
    if (!_bzfyT) {
        _bzfyT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _gjyfT.bottom+[Unity countcoordinatesH:10], 100, [Unity countcoordinatesH:20])];
        _bzfyT.text = @"包装费用";
        _bzfyT.textColor = LabelColor3;
        _bzfyT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _bzfyT;
}
- (UILabel *)bzfyL{
    if (!_bzfyL) {
        _bzfyL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:200], _bzfyT.top, [Unity countcoordinatesW:190], _bzfyT.height)];
        _bzfyL.text = [NSString stringWithFormat:@"%@%@",self.dataDic[@"price_packing"],self.dataDic[@"currency"]];
        _bzfyL.textColor = LabelColor3;
        _bzfyL.font = [UIFont systemFontOfSize:FontSize(14)];
        _bzfyL.textAlignment = NSTextAlignmentRight;
    }
    return _bzfyL;
}
- (UILabel *)ccfyT{
    if (!_ccfyT) {
        _ccfyT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _bzfyT.bottom+[Unity countcoordinatesH:10], 100, [Unity countcoordinatesH:20])];
        _ccfyT.text = @"仓储费用";
        _ccfyT.textColor = LabelColor3;
        _ccfyT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _ccfyT;
}
- (UILabel *)ccfyL{
    if (!_ccfyL) {
        _ccfyL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:200], _ccfyT.top, [Unity countcoordinatesW:190], _ccfyT.height)];
        _ccfyL.text = [NSString stringWithFormat:@"%@%@",self.dataDic[@"price_warehouse"],self.dataDic[@"currency"]];
        _ccfyL.textColor = LabelColor3;
        _ccfyL.font = [UIFont systemFontOfSize:FontSize(14)];
        _ccfyL.textAlignment = NSTextAlignmentRight;
    }
    return _ccfyL;
}
- (UILabel *)ddyfT{
    if (!_ddyfT) {
        _ddyfT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _ccfyT.bottom+[Unity countcoordinatesH:10], 100, [Unity countcoordinatesH:20])];
        _ddyfT.text = @"当地运费";
        _ddyfT.textColor = LabelColor3;
        _ddyfT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _ddyfT;
}
- (UILabel *)ddyfL{
    if (!_ddyfL) {
        _ddyfL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:200], _ddyfT.top, [Unity countcoordinatesW:190], _ddyfT.height)];
        _ddyfL.text = [NSString stringWithFormat:@"%@%@",self.dataDic[@"cost_local_freight"],self.dataDic[@"currency"]];
        _ddyfL.textColor = LabelColor3;
        _ddyfL.font = [UIFont systemFontOfSize:FontSize(14)];
        _ddyfL.textAlignment = NSTextAlignmentRight;
    }
    return _ddyfL;
}
- (UILabel *)thyfT{
    if (!_thyfT) {
        _thyfT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _ddyfT.bottom+[Unity countcoordinatesH:10], 100, [Unity countcoordinatesH:20])];
        _thyfT.text = @"上次退回运费";
        _thyfT.textColor = LabelColor3;
        _thyfT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _thyfT;
}
- (UILabel *)thyfL{
    if (!_thyfL) {
        _thyfL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:200], _thyfT.top, [Unity countcoordinatesW:190], _thyfT.height)];
        _thyfL.text = [NSString stringWithFormat:@"%@%@",self.dataDic[@"price_return"],self.dataDic[@"currency"]];
        _thyfL.textColor = LabelColor3;
        _thyfL.font = [UIFont systemFontOfSize:FontSize(14)];
        _thyfL.textAlignment = NSTextAlignmentRight;
    }
    return _thyfL;
}
- (UILabel *)zsfT{
    if (!_zsfT) {
        _zsfT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _thyfT.bottom+[Unity countcoordinatesH:10], 100, [Unity countcoordinatesH:20])];
        _zsfT.text = @"总税费";
        _zsfT.textColor = LabelColor3;
        _zsfT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _zsfT;
}
- (UILabel *)zsfL{
    if (!_zsfL) {
        _zsfL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:200], _zsfT.top, [Unity countcoordinatesW:190], _zsfT.height)];
        _zsfL.textColor = LabelColor3;
        _zsfL.text = [NSString stringWithFormat:@"%@%@",self.dataDic[@"cost_excise"],self.dataDic[@"currency"]];
        _zsfL.font = [UIFont systemFontOfSize:FontSize(14)];
        _zsfL.textAlignment = NSTextAlignmentRight;
    }
    return _zsfL;
}
- (UILabel *)fwfT{
    if (!_fwfT) {
        _fwfT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _zsfT.bottom+[Unity countcoordinatesH:10], 100, [Unity countcoordinatesH:20])];
        _fwfT.text = @"海外处理费";
        _fwfT.textColor = LabelColor3;
        _fwfT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _fwfT;
}
- (UILabel *)fwfL{
    if (!_fwfL) {
        _fwfL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:200], _fwfT.top, [Unity countcoordinatesW:190], _fwfT.height)];
        _fwfL.text = [NSString stringWithFormat:@"%@%@",self.dataDic[@"cost_process"],self.dataDic[@"currency"]];
        _fwfL.textColor = LabelColor3;
        _fwfL.font = [UIFont systemFontOfSize:FontSize(14)];
        _fwfL.textAlignment = NSTextAlignmentRight;
    }
    return _fwfL;
}
- (UILabel *)hlT{
    if (!_hlT) {
        _hlT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _fwfT.bottom+[Unity countcoordinatesH:10], 100, [Unity countcoordinatesH:20])];
        _hlT.text = @"汇率";
        _hlT.textColor = LabelColor3;
        _hlT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _hlT;
}
- (UILabel *)hlL{
    if (!_hlL) {
        _hlL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:200], _hlT.top, [Unity countcoordinatesW:190], _hlT.height)];
        _hlL.text = self.dataDic[@"exchange_rate"];
        _hlL.textColor = LabelColor3;
        _hlL.font = [UIFont systemFontOfSize:FontSize(14)];
        _hlL.textAlignment = NSTextAlignmentRight;
    }
    return _hlL;
}
- (UILabel *)xjT{
    if (!_xjT) {
        _xjT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _hlT.bottom+[Unity countcoordinatesH:10], 100, [Unity countcoordinatesH:20])];
        _xjT.text = @"小计";
        _xjT.textColor = LabelColor3;
        _xjT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _xjT;
}
- (UILabel *)xjL{
    if (!_xjL) {
        _xjL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:200], _xjT.top, [Unity countcoordinatesW:190], _xjT.height)];
        _xjL.text = [NSString stringWithFormat:@"%@RMB",self.dataDic[@"price_true"]];
        _xjL.textColor = LabelColor3;
        _xjL.font = [UIFont systemFontOfSize:FontSize(14)];
        _xjL.textAlignment = NSTextAlignmentRight;
    }
    return _xjL;
}
- (UIView *)line0{
    if (!_line0) {
        _line0 = [[UIView alloc]initWithFrame:CGRectMake(0, _xjT.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, 1)];
        _line0.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return _line0;
}
- (UIView *)blockV{
    if (!_blockV) {
        _blockV = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:331], [Unity countcoordinatesW:3], [Unity countcoordinatesH:10])];
        _blockV.backgroundColor = [Unity getColor:@"aa112d"];
    }
    return _blockV;
}
- (UILabel *)sumT{
    if (!_sumT) {
        _sumT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:326], 100, [Unity countcoordinatesH:20])];
        _sumT.text = @"总金额";
        _sumT.textColor = LabelColor3;
        _sumT.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _sumT;
}
- (UILabel *)sumL{
    if (!_sumL) {
        _sumL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:200], _sumT.top, [Unity countcoordinatesW:190], _sumT.height)];
        _sumL.text = [NSString stringWithFormat:@"%@RMB",self.dataDic[@"price_true"]];
        _sumL.textColor = LabelColor3;
        _sumL.font = [UIFont systemFontOfSize:FontSize(17)];
        _sumL.textAlignment = NSTextAlignmentRight;
    }
    return _sumL;
}
- (UILabel *)markT{
    if (!_markT) {
        _markT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _sumT.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:15])];
        _markT.text = @"(含1%第三方支付手续费，退款时手续费不退回)";
        _markT.textColor = LabelColor6;
        _markT.font = [UIFont systemFontOfSize:FontSize(12)];
        _markT.textAlignment = NSTextAlignmentRight;
    }
    return _markT;
}
- (UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc]initWithFrame:CGRectMake(0, _markT.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        _line1.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return _line1;
}
- (UIView *)blockV1{
    if (!_blockV1) {
        _blockV1 = [[UIView alloc]initWithFrame:CGRectMake(0, _line1.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:3], [Unity countcoordinatesH:10])];
        _blockV1.backgroundColor = [Unity getColor:@"aa112d"];
    }
    return _blockV1;
}
- (UILabel *)payT{
    if (!_payT) {
        _payT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line1.bottom+[Unity countcoordinatesH:15], 100, [Unity countcoordinatesH:20])];
        _payT.text = @"支付方式";
        _payT.textColor = LabelColor3;
        _payT.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _payT;
}
- (UIButton *)payType{
    if (!_payType) {
        _payType = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:10], _payT.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:93], [Unity countcoordinatesH:20])];
        [_payType addTarget:self action:@selector(payTypeClick:) forControlEvents:UIControlEventTouchUpInside];
        [_payType setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_payType setBackgroundImage:[UIImage imageNamed:@"kj"] forState:UIControlStateNormal];
        _payType.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _payType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_payType setImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [_payType setImage:[UIImage imageNamed:@"zhong"] forState:UIControlStateSelected];
    }
    return _payType;
}
- (UILabel *)payTypeT{
    if (!_payTypeT) {
        _payTypeT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _payType.bottom+[Unity countcoordinatesH:4], [Unity countcoordinatesW:93], [Unity countcoordinatesH:20])];
        _payTypeT.text = @"借记卡";
        _payTypeT.textColor = LabelColor3;
        _payTypeT.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _payTypeT;
}
- (UIButton *)payType1{
    if (!_payType1) {
        _payType1 = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:113], _payT.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:93], [Unity countcoordinatesH:20])];
        [_payType1 addTarget:self action:@selector(payTypeClick1:) forControlEvents:UIControlEventTouchUpInside];
        [_payType1 setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_payType1 setBackgroundImage:[UIImage imageNamed:@"kj"] forState:UIControlStateNormal];
        _payType1.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _payType1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_payType1 setImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [_payType1 setImage:[UIImage imageNamed:@"zhong"] forState:UIControlStateSelected];
    }
    return _payType1;
}
- (UILabel *)payTypeT1{
    if (!_payTypeT1) {
        _payTypeT1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:113], _payType1.bottom+[Unity countcoordinatesH:4], [Unity countcoordinatesW:93], [Unity countcoordinatesH:20])];
        _payTypeT1.text = @"信用卡";
        _payTypeT1.textColor = LabelColor3;
        _payTypeT1.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _payTypeT1;
}
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-[Unity countcoordinatesH:60]-NavBarHeight, SCREEN_WIDTH, [Unity countcoordinatesH:60])];
        _bottomView.backgroundColor = [UIColor whiteColor];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        label.backgroundColor = [Unity getColor:@"f0f0f0"];
        [_bottomView addSubview:label];
        [_bottomView addSubview:self.confirmPay];
    }
    return _bottomView;
}
- (UIButton *)confirmPay{
    if (!_confirmPay) {
        _confirmPay = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-[Unity countcoordinatesW:120])/2, [Unity countcoordinatesH:10], [Unity countcoordinatesH:120], [Unity countcoordinatesH:35])];
        [_confirmPay addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
        _confirmPay.layer.cornerRadius = _confirmPay.height/2;
        _confirmPay.backgroundColor = [Unity getColor:@"aa112d"];
        [_confirmPay setTitle:@"支付" forState:UIControlStateNormal];
        [_confirmPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmPay.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _confirmPay;
}


#pragma mark  ---事件处理---
- (void)payTypeClick:(UIButton *)btn{
    if (!btn.selected) {
        self.payType.selected = YES;
        self.payType1.selected = NO;
        isAn = YES;
        isCard = YES;
        [self.tableView reloadData];
    }
}
- (void)payTypeClick1:(UIButton *)btn{
    if (!btn.selected) {
        self.payType1.selected = YES;
        self.payType.selected = NO;
        isAn = YES;
        isCard = NO;
        [self.tableView reloadData];
    }
}
#pragma mark ---PayCell中textField事实监听输入文本  借记卡---
- (void)inputBankNum:(NSString *)bankNum{
    _bankCard = bankNum;
}
- (void)inputIdNum:(NSString *)idNum{
    _idCard = idNum;
}
- (void)inputMobileNum:(NSString *)mobileNum{
    _mobile = mobileNum;
}
- (void)inputCodeNum:(NSString *)codeNum{
    _code = codeNum;
}
- (void)inputName:(NSString *)name{
    _name = name;
}
- (void)seleteBankName{
    BankListViewController * bvc = [[BankListViewController alloc]init];
    bvc.type = 0;
    bvc.delegate = self;
    [self.navigationController pushViewController:bvc animated:YES];
}
- (void)paymentNuf_id:(NSString *)nuf_id{
    _payment_id = nuf_id;
}
#pragma mark ---PayCell中textField事实监听输入文本  信用卡---
- (void)inputBankNum0:(NSString *)bankNum{
    _bankCard = bankNum;
}
- (void)inputIdNum0:(NSString *)idNum{
    _idCard = idNum;
}
- (void)inputMobileNum0:(NSString *)mobileNum{
    _mobile = mobileNum;
}
- (void)inputCodeNum0:(NSString *)codeNum{
    _code0 = codeNum;
}
- (void)inputName0:(NSString *)name{
    _name = name;
}
- (void)seleteBankName0{
    BankListViewController * bvc = [[BankListViewController alloc]init];
    bvc.type = 1;
    bvc.delegate = self;
    [self.navigationController pushViewController:bvc animated:YES];
}
- (void)inputVali0:(NSString *)vali{
    _Valid = vali;
}
- (void)paymentNuf_id0:(NSString *)nuf_id{
    _payment_id0 = nuf_id;
}
- (void)inputsafeCode0:(NSString *)code{
    _safeCode = code;
}
/**
 支付
 */
- (void)payClick{
    NSString * paymentumf_id;
    NSString * inputCode;
    if (isCard) {//借记卡
        if (_payment_id == nil) {
            [WHToast showMessage:@"请选请求验证码" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            return;
        }
        if (_code == nil) {
            [WHToast showMessage:@"请输入验证码" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            return;
        }
        paymentumf_id = _payment_id;
        inputCode = _code;
    }else{//信用卡
        if (_payment_id0 == nil) {
            [WHToast showMessage:@"请选请求验证码" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            return;
        }
        if (_code0 == nil) {
            [WHToast showMessage:@"请输入验证码" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            return;
        }
        paymentumf_id = _payment_id0;
        inputCode = _code0;
    }
    NSDictionary * info = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSDictionary *  dic = @{@"login_token":info[@"token"],@"user":info[@"w_email"],@"paymentumf_id":paymentumf_id,@"execute_verify":inputCode,@"os":@"1"};
    NSLog(@"%@",dic);
    [Unity showanimate];
    [GZMrequest postWithURLString:[GZMUrl get_execute_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([data[@"meta"][@"ret_code"] isEqualToString:@"0000"]) {
            [self.delegate loadList];
            [self.navigationController popViewControllerAnimated:YES];
        }
        [WHToast showMessage:data[@"meta"][@"ret_msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
/**
 bankNameDelegate
 */
- (void)bankNameClick:(NSDictionary *)dic WithType:(NSInteger)type{
    if (type == 0) {
        _bankCode = dic[@"code"];
        _bankName = dic[@"name_zh"];
    }else{
        _bankCode0 = dic[@"code"];
        _bankName0 = dic[@"name_zh"];
    }
    [self.tableView reloadData];
}
@end
