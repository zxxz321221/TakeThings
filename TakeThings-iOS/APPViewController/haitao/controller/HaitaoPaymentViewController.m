//
//  HaitaoPaymentViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/3/3.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "HaitaoPaymentViewController.h"
#import "HTPayCell1.h"//商品信息信
#import "HTPayCell2.h"//储蓄卡
#import "HTPayCell3.h"//信用卡
#import "BankListViewController.h"
@interface HaitaoPaymentViewController ()<UITableViewDelegate,UITableViewDataSource,HTPayCell1Delegate,HTPayCell2Delegate,HTPayCell3Delegate,bankNameDelegate>
{
    BOOL isAn;//yes展开  no关闭  默认no
    BOOL isCard;//yes 储蓄卡 no 信用卡
    //储蓄卡
    NSString * depositCardName;//持卡人姓名
    NSString * depositCardBankNum;//银行卡号
    NSString * depositCardIdNum;//身份证号
    NSString * depositCardMobile;//手机号
    NSString * depositCardBankName;//银行名称
    NSString * depositCardBankCode;//银行英文缩写
    NSString * depositCardCodeNum;//短信验证码
    NSString * depositCardPayment_id;
    //信用卡
    NSString * creditCardName;//持卡人姓名
    NSString * creditCardBankNum;//银行卡号
    NSString * creditCardIdNum;//身份证号
    NSString * creditCardMobile;//手机号
    NSString * creditCardBankName;//银行名称
    NSString * creditCardBankCode;//银行英文缩写
    NSString * creditCardCodeNum;//短信验证码
    NSString * creditCardValidity;//银行英文缩写
    NSString * creditCardSafetyCode;//安全码
    NSString * creditCardPayment_id;
    
}
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) UIView * bottomView;//底部View

@property (nonatomic , strong) UIButton * paymentBtn;
@end

@implementation HaitaoPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.y_navLine.backgroundColor = [Unity getColor:@"e0e0e0"];
    self.title = @"支付详情";
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
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-[Unity countcoordinatesH:60]-NavBarHeight, SCREEN_WIDTH, [Unity countcoordinatesH:60])];
        _bottomView.backgroundColor = [UIColor whiteColor];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        label.backgroundColor = [Unity getColor:@"f0f0f0"];
        [_bottomView addSubview:label];
        [_bottomView addSubview:self.paymentBtn];
    }
    return _bottomView;
}
- (UIButton *)paymentBtn{
    if (!_paymentBtn) {
        _paymentBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesH:30], [Unity countcoordinatesH:35])];
        [_paymentBtn addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
        _paymentBtn.layer.cornerRadius = _paymentBtn.height/2;
        _paymentBtn.backgroundColor = [Unity getColor:@"aa112d"];
        [_paymentBtn setTitle:@"支付" forState:UIControlStateNormal];
        [_paymentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _paymentBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _paymentBtn;
}
#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isAn) {
        return 2;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return [Unity countcoordinatesH:345];
    }else{
        if (isCard) {
            return [Unity countcoordinatesH:200];
        }
        return [Unity countcoordinatesH:260];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0 ) {
        HTPayCell1 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HTPayCell1 class])];
        if (cell == nil) {
            cell = [[HTPayCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HTPayCell1 class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell configWithData:self.dataDic];
        return cell;
    }else{
        if (isCard) {
            HTPayCell2 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HTPayCell2 class])];
            if (cell == nil) {
                cell = [[HTPayCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HTPayCell2 class])];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            cell.order_id = self.dataDic[@"id"];
            if (depositCardBankName != nil) {
                cell.bankNameText.text = depositCardBankName;
                cell.bankCode = depositCardBankCode;
            }
            return cell;
        }else{
            HTPayCell3 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HTPayCell3 class])];
            if (cell == nil) {
                cell = [[HTPayCell3 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HTPayCell3 class])];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            cell.order_id = self.dataDic[@"id"];
            if (creditCardBankName != nil) {
                cell.bankNameText.text = creditCardBankName;
                cell.bankCode = creditCardBankCode;
            }
            return cell;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

//HTCell1Delegate
- (void)selectBank:(NSInteger)type{
    isAn = YES;
    if (type == 0) {//借记卡
        isCard = YES;
    }else{//信用卡
        isCard = NO;
    }
    
    [self.tableView reloadData];
}
//HTPayCell2Delegate
- (void)depositCardBankNum:(NSString *)bankNum{
    depositCardBankNum = bankNum;
}
- (void)depositCardIdNum:(NSString *)idNum{
    depositCardIdNum = idNum;
}
- (void)depositCardMobileNum:(NSString *)mobileNum{
    depositCardMobile = mobileNum;
}
- (void)depositCardCodeNum:(NSString *)codeNum{
    depositCardCodeNum = codeNum;
}
- (void)depositCardName:(NSString *)name{
    depositCardName = name;
}
- (void)depositCardseleteBankName{
    BankListViewController * bvc = [[BankListViewController alloc]init];
    bvc.type = 0;
    bvc.delegate = self;
    [self.navigationController pushViewController:bvc animated:YES];
}
- (void)depositCardpaymentNuf_id:(NSString *)nuf_id{
    depositCardPayment_id = nuf_id;
}
//HTPayCell3Delegate
- (void)creditCardBankNum:(NSString *)bankNum{
    creditCardBankNum = bankNum;
}
- (void)creditCardIdNum:(NSString *)idNum{
    creditCardIdNum = idNum;
}
- (void)creditCardMobileNum:(NSString *)mobileNum{
    creditCardMobile = mobileNum;
}
- (void)creditCardCodeNum:(NSString *)codeNum{
    creditCardCodeNum = codeNum;
}
- (void)creditCardName:(NSString *)name{
    creditCardName = name;
}
- (void)creditCardValidity:(NSString *)validity{
    creditCardValidity = validity;
}
- (void)creditCardSafetyCode:(NSString *)code{
    creditCardSafetyCode = code;
}
- (void)creditCardseleteBankName{
    BankListViewController * bvc = [[BankListViewController alloc]init];
    bvc.type = 1;
    bvc.delegate = self;
    [self.navigationController pushViewController:bvc animated:YES];
}
- (void)creditCardpaymentNuf_id:(NSString *)nuf_id{
    creditCardPayment_id = nuf_id;
}

/**
 bankNameDelegate
 */
- (void)bankNameClick:(NSDictionary *)dic WithType:(NSInteger)type{
    if (type == 0) {
        depositCardBankCode = dic[@"code"];
        depositCardBankName = dic[@"name_zh"];
    }else{
        creditCardBankCode = dic[@"code"];
        creditCardBankName = dic[@"name_zh"];
    }
    [self.tableView reloadData];
}
- (void)payClick{
    NSString * paymentumf_id;
    NSString * inputCode;
    if (isCard) {//借记卡
        if (depositCardPayment_id == nil) {
            [WHToast showMessage:@"请求验证码" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            return;
        }
        if (depositCardCodeNum == nil) {
            [WHToast showMessage:@"请输入验证码" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            return;
        }
        paymentumf_id = depositCardPayment_id;
        inputCode = depositCardCodeNum;
    }else{//信用卡
        if (creditCardPayment_id == nil) {
            [WHToast showMessage:@"请求验证码" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            return;
        }
        if (creditCardCodeNum == nil) {
            [WHToast showMessage:@"请输入验证码" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            return;
        }
        paymentumf_id = creditCardPayment_id;
        inputCode = creditCardCodeNum;
    }
    NSDictionary * info = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSDictionary *  dic = @{@"login_token":info[@"token"],@"user":info[@"w_email"],@"paymentumf_id":paymentumf_id,@"execute_verify":inputCode,@"os":@"1"};
    NSLog(@"%@",dic);
    [Unity showanimate];
    [GZMrequest postWithURLString:[GZMUrl get_execute_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([data[@"meta"][@"ret_code"] isEqualToString:@"0000"]) {
            [self.delegate reloadList];
            [self.navigationController popViewControllerAnimated:YES];
        }
        [WHToast showMessage:data[@"meta"][@"ret_msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
@end
