//
//  OrderInfoViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/13.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "OrderInfoViewController.h"
#import "PayCell.h"
#import "PayCell0.h"
#import "BankListViewController.h"
@interface OrderInfoViewController ()<UITableViewDelegate,UITableViewDataSource,PayCellDelegate,PayCell0Delegate,bankNameDelegate>
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
@property (nonatomic , strong) UIView * bottomView;//底部View
@property (nonatomic , strong) UIButton * confirmPay;
@property (nonatomic , strong) UIImageView * icon;//商品图片
@property (nonatomic , strong) UILabel * goodsTitle;//商品标题
@property (nonatomic , strong) UILabel * goodsNum;//竞拍商品数量
@property (nonatomic , strong) UILabel * placeLabel;//商品价格
@property (nonatomic , strong) UILabel * line;
@property (nonatomic , strong) UILabel * bidPlaceL;//得标价
@property (nonatomic , strong) UILabel * bidPlace;
@property (nonatomic , strong) UILabel * bankCostL;//银行手续费
@property (nonatomic , strong) UILabel * bankCost;
@property (nonatomic , strong) UILabel * feeL;//海外处理费
@property (nonatomic , strong) UILabel * fee;
@property (nonatomic , strong) UILabel * zplpL;//诈骗理赔
@property (nonatomic , strong) UILabel * zplp;
@property (nonatomic , strong) UILabel * oemFeeL;//代工费
@property (nonatomic , strong) UILabel * oemFee;
@property (nonatomic , strong) UILabel * line1;

@property (nonatomic , strong) UILabel * coupons;//优惠券
@property (nonatomic , strong) UIButton * couponsBtn;
@property (nonatomic , strong) UILabel * line2;
@property (nonatomic , strong) UILabel * sumL;//合计
@property (nonatomic , strong) UILabel * sum;

@property (nonatomic , strong) UIView * line3;//横线
@property (nonatomic , strong) UIView * blockV1;
@property (nonatomic , strong) UILabel * payT;//支付方式
@property (nonatomic , strong) UIButton * payType;//
@property (nonatomic , strong) UILabel * payTypeT;//
@property (nonatomic , strong) UIButton * payType1;//
@property (nonatomic , strong) UILabel * payTypeT1;//
@end

@implementation OrderInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"委托单信息";
    self.y_navLine.backgroundColor = [Unity getColor:@"e0e0e0"];
    isAn = NO;
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
        cell.isType = YES;
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
        cell.isType = YES;
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
    return [Unity countcoordinatesH:407];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerView = [[UIView alloc]init];
    [headerView addSubview:self.icon];
    [headerView addSubview:self.goodsTitle];
    [headerView addSubview:self.goodsNum];
    [headerView addSubview:self.placeLabel];
    [headerView addSubview:self.line];
    [headerView addSubview:self.bidPlaceL];
    [headerView addSubview:self.bidPlace];
    [headerView addSubview:self.bankCostL];
    [headerView addSubview:self.bankCost];
    [headerView addSubview:self.feeL];
    [headerView addSubview:self.fee];
    [headerView addSubview:self.zplpL];
    [headerView addSubview:self.zplp];
    [headerView addSubview:self.oemFeeL];
    [headerView addSubview:self.oemFee];
    [headerView addSubview:self.line1];
    [headerView addSubview:self.coupons];
    [headerView addSubview:self.couponsBtn];
    [headerView addSubview:self.line2];
    [headerView addSubview:self.sumL];
    [headerView addSubview:self.sum];
    [headerView addSubview:self.line3];
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
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:70])];
        //添加边框
        CALayer * layer = [_icon layer];
        layer.borderColor = [[Unity getColor:@"#e0e0e0"] CGColor];
        layer.borderWidth = 1.0f;
        _icon.contentMode = UIViewContentModeScaleAspectFit;
        
//        NSArray * arr = [self.dataDic[@"goods_img"] allKeys];
        [_icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[Unity get_image:self.dataDic[@"goods_img"]]]] placeholderImage:[UIImage imageNamed:@"Loading"]];
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
        _goodsTitle.text = self.dataDic[@"goods_name"];
    }
    return _goodsTitle;
}
- (UILabel *)goodsNum{
    if (!_goodsNum) {
        _goodsNum = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitle.right+[Unity countcoordinatesW:10], _goodsTitle.top+[Unity countcoordinatesH:5], [Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _goodsNum.textColor = LabelColor6;
        _goodsNum.font = [UIFont systemFontOfSize:FontSize(12)];
        _goodsNum.textAlignment = NSTextAlignmentRight;
        _goodsNum.text = [NSString stringWithFormat:@"x%@",self.dataDic[@"bid_num"]];
    }
    return _goodsNum;
}
- (UILabel *)placeLabel{
    if (!_placeLabel) {
        _placeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitle.left, _goodsTitle.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:95], [Unity countcoordinatesH:20])];
        _placeLabel.textColor = LabelColor6;
        _placeLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _placeLabel.textAlignment = NSTextAlignmentRight;
        _placeLabel.text = [NSString stringWithFormat:@"%@%@",self.dataDic[@"over_price"],self.dataDic[@"currency"]];
    }
    return _placeLabel;
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(0, _icon.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, 1)];
        _line.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line;
}
- (UILabel *)bidPlaceL{
    if (!_bidPlaceL) {
        _bidPlaceL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line.bottom+[Unity countcoordinatesH:5], 100, [Unity countcoordinatesH:25])];
        _bidPlaceL.text = @"得标价";
        _bidPlaceL.textColor = LabelColor6;
        _bidPlaceL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _bidPlaceL;
}
- (UILabel *)bidPlace{
    if (!_bidPlace) {
        _bidPlace = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:200], _bidPlaceL.top, [Unity countcoordinatesW:190], _bidPlaceL.height)];
        _bidPlace.text = [NSString stringWithFormat:@"%@%@",self.dataDic[@"over_price"],self.dataDic[@"currency"]];
        _bidPlace.textColor = LabelColor6;
        _bidPlace.font = [UIFont systemFontOfSize:FontSize(14)];
        _bidPlace.textAlignment = NSTextAlignmentRight;
    }
    return _bidPlace;
}
- (UILabel *)bankCostL{
    if (!_bankCostL) {
        _bankCostL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _bidPlaceL.bottom, 130, [Unity countcoordinatesH:25])];
        _bankCostL.text = @"银行汇款手续费";
        _bankCostL.textColor = LabelColor6;
        _bankCostL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _bankCostL;
}
- (UILabel *)bankCost{
    if (!_bankCost) {
        _bankCost = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:200], _bankCostL.top, [Unity countcoordinatesW:190], _bankCostL.height)];
        _bankCost.text = [NSString stringWithFormat:@"%@%@",self.dataDic[@"cost_bank_remitt"],self.dataDic[@"currency"]];
        _bankCost.textColor = LabelColor6;
        _bankCost.font = [UIFont systemFontOfSize:FontSize(14)];
        _bankCost.textAlignment = NSTextAlignmentRight;
    }
    return _bankCost;
}
- (UILabel *)feeL{
    if (!_feeL) {
        _feeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _bankCostL.bottom, 100, [Unity countcoordinatesH:25])];
        _feeL.text = @"海外处理费";
        _feeL.textColor = LabelColor6;
        _feeL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _feeL;
}
- (UILabel *)fee{
    if (!_fee) {
        _fee = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:200], _feeL.top, [Unity countcoordinatesW:190], _feeL.height)];
        _fee.text = [NSString stringWithFormat:@"%@%@",self.dataDic[@"cost_process"],self.dataDic[@"currency"]];
        _fee.textColor = LabelColor6;
        _fee.font = [UIFont systemFontOfSize:FontSize(14)];
        _fee.textAlignment = NSTextAlignmentRight;
    }
    return _fee;
}
- (UILabel *)zplpL{
    if (!_zplpL) {
        _zplpL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _feeL.bottom, 100, [Unity countcoordinatesH:25])];
        _zplpL.text = @"诈骗理赔";
        _zplpL.textColor = LabelColor6;
        _zplpL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _zplpL;
}
- (UILabel *)zplp{
    if (!_zplp) {
        _zplp = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:200], _zplpL.top, [Unity countcoordinatesW:190], _zplpL.height)];
        _zplp.text = [NSString stringWithFormat:@"%@%@",self.dataDic[@"cost_fraud_safe"],self.dataDic[@"currency"]];
        _zplp.textColor = LabelColor6;
        _zplp.font = [UIFont systemFontOfSize:FontSize(14)];
        _zplp.textAlignment = NSTextAlignmentRight;
    }
    return _zplp;
}
- (UILabel *)oemFeeL{
    if (!_oemFeeL) {
        _oemFeeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _zplp.bottom, 100, [Unity countcoordinatesH:25])];
        _oemFeeL.text = @"代工费";
        _oemFeeL.textColor = LabelColor6;
        _oemFeeL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _oemFeeL;
}
- (UILabel *)oemFee{
    if (!_oemFee) {
        _oemFee = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:200], _oemFeeL.top, [Unity countcoordinatesW:190], _oemFeeL.height)];
        _oemFee.text = [NSString stringWithFormat:@"%@RMB",self.dataDic[@"cost_foundry"]];
        _oemFee.textColor = LabelColor6;
        _oemFee.font = [UIFont systemFontOfSize:FontSize(14)];
        _oemFee.textAlignment = NSTextAlignmentRight;
    }
    return _oemFee;
}
- (UILabel *)line1{
    if (!_line1) {
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, _oemFeeL.bottom+[Unity countcoordinatesH:5], SCREEN_WIDTH, 1)];
        _line1.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line1;
}
- (UILabel *)coupons{
    if (!_coupons) {
        _coupons = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line1.bottom, 100, [Unity countcoordinatesH:40])];
        _coupons.text = @"优惠券";
        _coupons.textColor = LabelColor6;
        _coupons.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _coupons;
}
- (UIButton *)couponsBtn{
    if (!_couponsBtn) {
        _couponsBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:200], _line1.bottom, [Unity countcoordinatesW:190], [Unity countcoordinatesH:40])];
        [_couponsBtn setTitle:@"查看详情>" forState:UIControlStateNormal];
        [_couponsBtn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
        _couponsBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _couponsBtn.contentHorizontalAlignment = NSTextAlignmentRight;
    }
    return _couponsBtn;
}
- (UILabel *)line2{
    if (!_line2) {
        _line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, _coupons.bottom, SCREEN_WIDTH, 1)];
        _line2.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line2;
}
- (UILabel *)sumL{
    if (!_sumL) {
        _sumL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line2.bottom+[Unity countcoordinatesH:15], 100, [Unity countcoordinatesH:20])];
        _sumL.text = @"合计";
        _sumL.textColor = LabelColor3;
        _sumL.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _sumL;
}
- (UILabel *)sum{
    if (!_sum) {
        _sum = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:200], _sumL.top, [Unity countcoordinatesW:190], _sumL.height)];
        _sum.text = [NSString stringWithFormat:@"%@RMB",self.dataDic[@"price_true"]];
        _sum.textColor = [Unity getColor:@"aa112d"];
        _sum.font = [UIFont systemFontOfSize:FontSize(17)];
        _sum.textAlignment = NSTextAlignmentRight;
    }
    return _sum;
}
- (UIView *)line3{
    if (!_line3) {
        _line3 = [[UIView alloc]initWithFrame:CGRectMake(0, _sum.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        _line3.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return _line3;
}
- (UIView *)blockV1{
    if (!_blockV1) {
        _blockV1 = [[UIView alloc]initWithFrame:CGRectMake(0, _line3.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:3], [Unity countcoordinatesH:10])];
        _blockV1.backgroundColor = [Unity getColor:@"aa112d"];
    }
    return _blockV1;
}
- (UILabel *)payT{
    if (!_payT) {
        _payT = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line3.bottom+[Unity countcoordinatesH:15], 100, [Unity countcoordinatesH:20])];
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
        _confirmPay = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesH:20], [Unity countcoordinatesH:35])];
        [_confirmPay addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
        _confirmPay.layer.cornerRadius = _confirmPay.height/2;
        _confirmPay.backgroundColor = [Unity getColor:@"aa112d"];
        [_confirmPay setTitle:@"付款" forState:UIControlStateNormal];
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
            [self.delegate loadTwoPage];
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
