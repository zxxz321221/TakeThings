//
//  PrecelDetailViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/25.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "PrecelDetailViewController.h"
#import "AddressViewController.h"
#import "PrecelDetailCell1.h"
#import "PrecelAddressCell.h"
#import "SupplementCell.h"
#import "PrecelSendInfoCell.h"
#import "SendCostCell.h"
#import "SumPriceCell.h"
#import "ProgressCell.h"
#import "NewYahooDetailViewController.h"
#import "NewEbayDetailViewController.h"
#import "ServiceViewController.h"
#import "PrecelPayDetailViewController.h"
#import "KdPostalViewController.h"
#import "KdJapanViewController.h"
@interface PrecelDetailViewController ()<UITableViewDelegate,UITableViewDataSource,PrecellAddressDelegate,AddressViewDelegate,PrecelSendInfoCellDelegate>
{
    NSInteger btnType;//1立即支付 2确认收货 3联系客服 4删除包裹
}
@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) UILabel * precelNum;//包裹编号
@property (nonatomic , strong) UILabel * statusL;//包裹状态
@property (nonatomic , strong) UILabel * goodsNum;//包裹商品个数

@property (nonatomic , strong) UIView * bottomView;//底部按钮view
@property (nonatomic , strong) UILabel * textLbale;//底部文字状态
@property (nonatomic , strong) UIButton * backBtn;//退回通知
@property (nonatomic , strong) UIButton * unBtn;//多功能按钮
@end

@implementation PrecelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataDic = [Unity nullDicToDic:self.dataDic];//处理字典中的null
    
    self.title = @"包裹详情";
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
    [self loadUI];
    
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
        [_bottomView addSubview:self.textLbale];
        [_bottomView addSubview:self.backBtn];
        [_bottomView addSubview:self.unBtn];
    }
    return _bottomView;
}
- (UILabel *)textLbale{
    if (!_textLbale) {
        _textLbale = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:90], [Unity countcoordinatesH:35])];
        _textLbale.textColor = LabelColor6;
        _textLbale.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _textLbale;
}
- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:180], _textLbale.top, [Unity countcoordinatesW:80], _textLbale.height)];
        [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.layer.borderColor = LabelColor9.CGColor;
        _backBtn.layer.borderWidth = 1;
        _backBtn.layer.cornerRadius = _backBtn.height/2;
        [_backBtn setTitle:@"退回通知" forState:UIControlStateNormal];
        [_backBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        _backBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _backBtn.hidden = YES;
    }
    return _backBtn;
}
- (UIButton *)unBtn{
    if (!_unBtn) {
        _unBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:90], _textLbale.top, [Unity countcoordinatesW:80], _textLbale.height)];
        [_unBtn addTarget:self action:@selector(unBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _unBtn.backgroundColor = [Unity getColor:@"aa112d"];
        _unBtn.layer.cornerRadius = _backBtn.height/2;
        [_unBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        [_unBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _unBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _unBtn;
}
#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.dataDic.count != 0) {
        return 7;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return [self.dataDic[@"bid_list"] count];
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [Unity countcoordinatesW:111];
    }else if (indexPath.section == 1){
        if ([self.dataDic[@"traffic_type"] intValue] ==5) {//空港 5个
            return [Unity countcoordinatesW:135];
        }else{
            if ([self.dataDic[@"order_transport_status_id"] intValue] == 212 || [self.dataDic[@"order_transport_status_id"] intValue] == 210 ||
                [self.dataDic[@"order_transport_status_id"] intValue] == 200) {//转运 6个
                return [Unity countcoordinatesW:160];
            }else{//4个
                return [Unity countcoordinatesW:110];
            }
        }
    }else if (indexPath.section == 2){
        return [Unity countcoordinatesW:120];
    }else if (indexPath.section == 3){
        return [Unity countcoordinatesW:135];
    }else if (indexPath.section == 4){
        if ([self.dataDic[@"order_transport_status_id"] intValue] != 212) {
            return [Unity countcoordinatesW:160];
        }
        return [Unity countcoordinatesW:195];
    }else if (indexPath.section == 5){
        return [Unity countcoordinatesW:255];
    }
    return [Unity countcoordinatesW:70];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        PrecelDetailCell1 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PrecelDetailCell1 class])];
        if (cell == nil) {
            cell = [[PrecelDetailCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PrecelDetailCell1 class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configData:self.dataDic[@"bid_list"][indexPath.row] WithKd:[self.dataDic[@"traffic_type"] intValue]];
        //    cell.delegate = self;
        return cell;
    }else if (indexPath.section == 1){
        ProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProgressCell class])];
        if (cell == nil) {
            cell = [[ProgressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ProgressCell class])];
        }
        NSArray * arr = [self get_proArr];
        [cell configProgressArr:arr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2){
        PrecelAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PrecelAddressCell class])];
        if (cell == nil) {
            cell = [[PrecelAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PrecelAddressCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configName:self.dataDic[@"get_name"] WithMobile:self.dataDic[@"get_phone"] WithAddress:self.dataDic[@"get_address"] WithMark:self.dataDic[@"user_remark"] WithStatus:[self.dataDic[@"order_transport_status_id"] intValue]];
        cell.delegate = self;
        return cell;
    }else if (indexPath.section == 3){
        SupplementCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SupplementCell class])];
        if (cell == nil) {
            cell = [[SupplementCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([SupplementCell class])];
            }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configData:self.dataDic];
        return cell;
    }else if (indexPath.section == 4){
        PrecelSendInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PrecelSendInfoCell class])];
        if (cell == nil) {
            cell = [[PrecelSendInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PrecelSendInfoCell class])];
            }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configData:self.dataDic];
        cell.delegate = self;
        return cell;
    }else if (indexPath.section == 5){
        SendCostCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SendCostCell class])];
        if (cell == nil) {
            cell = [[SendCostCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([SendCostCell class])];
            }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray * arr =[self get_array];
        float xj = ([self.dataDic[@"price_weight"] floatValue]+[self.dataDic[@"price_packing"] floatValue]+[self.dataDic[@"price_warehouse"] floatValue]+[self.dataDic[@"price_return"] floatValue] +  [self.dataDic[@"price_service"] floatValue])*[self.dataDic[@"exchange_rate"] floatValue] +[self.dataDic[@"price_safe_traffic"] floatValue];
        [cell configArr:arr WithPrice:[NSString stringWithFormat:@"%.2f",xj] WithRate:self.dataDic[@"exchange_rate"]];
        return cell;
    }else{
        SumPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SumPriceCell class])];
        if (cell == nil) {
            cell = [[SumPriceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([SumPriceCell class])];
            }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configPrice:self.dataDic];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        if ([self.dataDic[@"currency"] isEqualToString:@"円"]) {//日本
            NewYahooDetailViewController * nvc = [[NewYahooDetailViewController alloc]init];
            nvc.item = self.dataDic[@"bid_list"][indexPath.row][@"auction_id"];
            nvc.platform = @"0";
            [self.navigationController pushViewController:nvc animated:YES];
        }else{//美国
            NewEbayDetailViewController * nvc = [[NewEbayDetailViewController alloc]init];
            nvc.item = self.dataDic[@"bid_list"][indexPath.row][@"auction_id"];
            nvc.platform = @"5";
            [self.navigationController pushViewController:nvc animated:YES];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [Unity countcoordinatesH:81];
    }
    return [Unity countcoordinatesH:10];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * header = [UIView new];
    header.backgroundColor = [Unity getColor:@"f0f0f0"];
    if (section == 0) {
        [header addSubview:self.precelNum];
        [header addSubview:self.statusL];
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:40], SCREEN_WIDTH, [Unity countcoordinatesH:41])];
        view.backgroundColor = [UIColor whiteColor];
        [header addSubview:view];
        
        UILabel * label = [Unity lableViewAddsuperview_superView:view _subViewFrame:CGRectMake([Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:200], [Unity countcoordinatesH:40]) _string:@"包裹商品" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, label.bottom, SCREEN_WIDTH, 1)];
        line.backgroundColor = [Unity getColor:@"f0f0f0"];
        [view addSubview:line];
        [view addSubview:self.goodsNum];
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

#pragma mark ---tableViewHeader 上控件初始化---
- (UILabel *)precelNum{
    if (!_precelNum) {
        _precelNum = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:200], [Unity countcoordinatesH:40])];
        _precelNum.text = [NSString stringWithFormat:@"包裹编号 %@",self.dataDic[@"order_code"]];
        _precelNum.textColor = LabelColor3;
        _precelNum.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _precelNum;
}
- (UILabel *)statusL{
    if (!_statusL) {
        _statusL = [[UILabel alloc]initWithFrame:CGRectMake(_precelNum.right, 0, [Unity countcoordinatesW:100], [Unity countcoordinatesH:40])];
        _statusL.text = self.dataDic[@"status_name"];
        _statusL.textColor = [Unity getColor:@"aa112d"];
        _statusL.font = [UIFont systemFontOfSize:FontSize(14)];
        _statusL.textAlignment = NSTextAlignmentRight;
    }
    return _statusL;
}
- (UILabel *)goodsNum{
    if (!_goodsNum) {
        _goodsNum = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:60], 0, [Unity countcoordinatesW:50], [Unity countcoordinatesH:40])];
//        _goodsNum.text = [NSString stringWithFormat:@"x%@",self.dataDic[@"bid_count"]];
        _goodsNum.textColor = LabelColor3;
        _goodsNum.font = [UIFont systemFontOfSize:FontSize(14)];
        _goodsNum.textAlignment = NSTextAlignmentRight;
    }
    return _goodsNum;
}

#pragma mark  ---PrecelAddressDelegate---
- (void)seleteAddress{
    AddressViewController * avc = [[AddressViewController alloc]init];
    avc.page = 4;
    avc.delegate = self;
    [self.navigationController pushViewController:avc animated:YES];
}
- (void)EntrustAddress:(NSMutableArray *)list WithIndexPath:(NSInteger )indexpath{
    NSLog(@"%@",list[indexpath]);
    NSMutableDictionary * dict = [self.dataDic mutableCopy];
    [dict setValue:list[indexpath][@"w_name"] forKey:@"get_name"];
    [dict setValue:[NSString stringWithFormat:@"%@ %@",list[indexpath][@"w_address"],list[indexpath][@"w_address_detail"]] forKey:@"get_address"];
    [dict setValue:list[indexpath][@"w_mobile"] forKey:@"get_phone"];
    [dict setValue:list[indexpath][@"w_other"] forKey:@"user_remark"];
    [dict setValue:list[indexpath][@"postal"] forKey:@"get_postal"];
    self.dataDic = [dict copy];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}
- (NSArray *)get_array{
    NSArray * arr = @[[NSString stringWithFormat:@"%@%@",self.dataDic[@"price_weight"],self.dataDic[@"currency"]],[NSString stringWithFormat:@"%@%@",self.dataDic[@"price_packing"],self.dataDic[@"currency"]],[NSString stringWithFormat:@"%@RMB",self.dataDic[@"price_safe_traffic"]],[NSString stringWithFormat:@"%@%@",self.dataDic[@"price_warehouse"],self.dataDic[@"currency"]],[NSString stringWithFormat:@"%@%@",self.dataDic[@"price_return"],self.dataDic[@"currency"]],[NSString stringWithFormat:@"%@%@",self.dataDic[@"price_service"],self.dataDic[@"currency"]]];
    NSArray * array = @[@"国际运费",@"包材费用",@"物流保障",@"仓储费用",@"退运费用",@"服务费"];
    NSMutableArray * muArr = [NSMutableArray new];
    for (int i=0; i<arr.count; i++) {
        NSMutableDictionary * dic = [NSMutableDictionary new];
        [dic setValue:arr[i] forKey:@"content"];
        [dic setValue:array[i] forKey:@"title"];
        [muArr addObject:dic];
    }
    return [muArr copy];
}
- (NSArray *)get_proArr{
    NSArray * arr;
    NSArray * array;
    if ([self.dataDic[@"traffic_type"] intValue] ==5) {//空港 5个
        arr = @[self.dataDic[@"sendout_time"],self.dataDic[@"payment_time"],self.dataDic[@"warehouse_examine_time"],self.dataDic[@"payment_tariff_time"],self.dataDic[@"receive_time"]];
        array = @[@"确认发货",@"运费已支付",@"海外已发货",@"待付关税",@"已收货"];
    }else{
        if ([self.dataDic[@"order_transport_status_id"] intValue] == 212 || [self.dataDic[@"order_transport_status_id"] intValue] == 210 ||
            [self.dataDic[@"order_transport_status_id"] intValue] == 200) {//转运 6个
            arr = @[self.dataDic[@"sendout_time"],self.dataDic[@"payment_time"],self.dataDic[@"warehouse_examine_time"],self.dataDic[@"back_confirm_time"],self.dataDic[@"back_warehouse_time"],self.dataDic[@"turn_order_time"]];
            array = @[@"确认发货",@"运费已支付",@"海外已发货",@"确认回退",@"退回到仓",@"已转单"];
        }else{//4个
            arr = @[self.dataDic[@"sendout_time"],self.dataDic[@"payment_time"],self.dataDic[@"warehouse_examine_time"],self.dataDic[@"receive_time"]];
            array = @[@"确认发货",@"运费已支付",@"海外已发货",@"已收货"];
        }
    }
    NSMutableArray * muArr = [NSMutableArray new];
    for (int i=0; i<arr.count; i++) {
        NSMutableDictionary * dic = [NSMutableDictionary new];
        [dic setValue:arr[i] forKey:@"time"];
        [dic setValue:array[i] forKey:@"title"];
        [muArr addObject:dic];
    }
    return [muArr copy];
}

#pragma mark ---底部bottomView 按钮事件---
- (void)backBtnClick{
    [self alertViewController];
}
- (void)unBtnClick{
    if (btnType == 1) {//支付
        PrecelPayDetailViewController * pvc = [[PrecelPayDetailViewController alloc]init];
        pvc.dataDic = self.dataDic;
        [self.navigationController pushViewController:pvc animated:YES];
    }else if (btnType == 2){//确认收货
        [self greceive_confirm_url];
    }else if (btnType == 3){//联系客服
        ServiceViewController * svc = [[ServiceViewController alloc]init];
        [self.navigationController pushViewController:svc animated:YES];
    }else{//删除包裹
        [self precelDelete];
    }
    
}
- (void)precelDelete{
    NSDictionary * info = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"user":info[@"w_email"],@"login_token":info[@"token"],@"transport_id":self.dataDic[@"id"],@"os":@"1"};
    [Unity showanimate];
    [GZMrequest postWithURLString:[GZMUrl get_precelDelete_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([data[@"status"] intValue] == 0) {
            [self.delegate detailLoadList];
            [self.navigationController popViewControllerAnimated:YES];
        }
        [WHToast showMessage:data[@"mes"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)loadUI{
    switch ([self.dataDic[@"order_transport_status_id"] intValue]) {
        case 140:
        {
            self.textLbale.text = @"审核中";
            self.unBtn.backgroundColor = LabelColor9;
            self.unBtn.userInteractionEnabled = NO;
            btnType = 1;
            
        }
            break;
        case 150:
        {
            self.textLbale.text = @"确认中";
            self.unBtn.backgroundColor = LabelColor9;
            self.unBtn.userInteractionEnabled = NO;
            btnType = 1;
        }
            break;
        case 160:
        {
            self.textLbale.text = @"运费待支付";
            btnType = 1;
        }
            break;
        case 170:
        {
            self.textLbale.text = @"待发货";
            [self.unBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            self.unBtn.backgroundColor = LabelColor9;
            self.unBtn.userInteractionEnabled = NO;
            btnType = 2;
        }
            break;
        case 180:
        {
            self.textLbale.text = @"已发货";
            [self.unBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            self.backBtn.hidden = YES;
            btnType = 2;
        }
            break;
        case 190:
        {
            self.textLbale.text = @"关税待支付";
            btnType = 1;
        }
            break;
        case 200:
        {
            self.textLbale.text = @"已退运";
            [self.unBtn setTitle:@"联系客服" forState:UIControlStateNormal];
            btnType = 3;
        }
            break;
        case 210:
        {
            self.textLbale.text = @"已到仓";
            [self.unBtn setTitle:@"联系客服" forState:UIControlStateNormal];
            btnType = 3;
        }
            break;
        case 212:
        {
            self.textLbale.text = @"已转单";
            [self.unBtn setTitle:@"删除包裹" forState:UIControlStateNormal];
            btnType = 4;
        }
            break;
        case 220:
        {
            self.textLbale.text = @"已签收";
            [self.unBtn setTitle:@"删除包裹" forState:UIControlStateNormal];
            btnType = 4;
        }
            break;
            
        default:
            break;
    }
}
- (void)alertViewController{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示!" message:@"当您的快递在运送过程中，因为一些特殊情况而发生退运时（如：清关受阻，商品限制等），您可以点击这里通知系统，以便我们为您提供后续的相关服务。" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self requestBack_confirm];
    }];
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)requestBack_confirm{
    NSDictionary * info = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"user":info[@"w_email"],@"login_token":info[@"token"],@"transport_id":self.dataDic[@"id"],@"os":@"1"};
    [Unity showanimate];
    [GZMrequest postWithURLString:[GZMUrl get_back_confirm_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([data[@"status"] intValue] == 0) {
            //重新请求详情 刷新tableview
            [self requestDetail];
            //退回成功隐藏退回按钮
            self.backBtn.hidden = YES;
            _statusL.text = @"确认退回";
            //刷新前一页列表
            [self.delegate detailLoadList];
        }
        [WHToast showMessage:data[@"mes"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
//请求详情
- (void)requestDetail{
    NSDictionary * dic = @{@"id":self.bg_id,@"os":@"1"};
    [Unity showanimate];
    [GZMrequest getWithURLString:[GZMUrl get_precelDetail_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        NSLog(@"%@",data);
        self.goodsNum.text = [NSString stringWithFormat:@"x%@",data[@"order_list"][0][@"goods_num"]];
        NSMutableDictionary * dict = [NSMutableDictionary new];
        dict = [data[@"transport"] mutableCopy];
        [dict setValue:data[@"order_list"] forKey:@"bid_list"];
        self.dataDic = [Unity nullDicToDic: [dict copy]];
        [self.tableView reloadData];
        [self loadUI];
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
/**
    确认收货
 */
- (void)greceive_confirm_url{
    NSDictionary * info = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"login_token":info[@"token"],@"user":info[@"w_email"],@"transport_id":self.dataDic[@"id"],@"os":@"1"};
    [Unity showanimate];
    [GZMrequest postWithURLString:[GZMUrl get_receive_confirm_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([data[@"status"] intValue] == 0) {
            //重新请求详情 刷新tableview
            [self requestDetail];
            //退回成功隐藏退回按钮
            self.backBtn.hidden = YES;
            _statusL.text = @"已签收";
            //刷新前一页列表
            [self.delegate detailLoadList];
            //通知第三个页面刷新列表
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sendNoti" object:nil];
        }
        [WHToast showMessage:data[@"mes"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
/**
 快递动态事件
 */
- (void)expressQuery{
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
