//
//  ConfirmInfoViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/14.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "ConfirmInfoViewController.h"
#import "ConfirmCell1.h"
#import "ConfirmCell2.h"
#import "ConfirmCell3.h"
#import "ConfirmCell4.h"
#import "HomeViewController.h"
#import "SendView.h"
#import "ShooseGJViewController.h"
@interface ConfirmInfoViewController ()<UITableViewDelegate,UITableViewDataSource,SendViewDelegate,ConfirmCell4Delegate>
{
    NSInteger cellNum;//cell个数
    NSString * lack_channel;//失败后途径，1续订同批其他商品，2取消同批订单，3电话通知
}
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) UIView * bottomView;
@property (nonatomic , strong) UILabel * line1;
@property (nonatomic , strong) UIButton * sendBtn;
@property (nonatomic , strong) UIButton * popBtn;
@property (nonatomic , strong) UIButton * cancelBtn;

@property (nonatomic , strong) SendView * sView;

@property (nonatomic , strong) NSDictionary * rateDic;
@end

@implementation ConfirmInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    lack_channel = @"1";
    cellNum = self.dataList.count+3;
    [self createUI];
    [self haitaoRateSelete];
}
- (void)createUI{
    if ([self.source isEqualToString:@"yahoo"]) {
         self.title = @"海淘询价单(日本)";
    }else{
         self.title = @"海淘询价单(美国)";
    }
//    [self.view addSubview:self.navLine];
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
        return [Unity countcoordinatesH:30];
    }else if (indexPath.row == cellNum-2){//预付款
        return [Unity countcoordinatesH:230];
    }else if (indexPath.row == cellNum-1){//备注
        return [Unity countcoordinatesH:120];
    }else{//添加的商品
        return [Unity countcoordinatesH:155];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        ConfirmCell1 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ConfirmCell1 class])];
        if (cell == nil) {
            cell = [[ConfirmCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ConfirmCell1 class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == cellNum-2){
        ConfirmCell3 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ConfirmCell3 class])];
            if (cell == nil) {
                cell = [[ConfirmCell3 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ConfirmCell3 class])];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWithData:self.rateDic];
        //    cell.delegate = self;
            return cell;
    }else if (indexPath.row == cellNum-1){
        ConfirmCell4 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ConfirmCell4 class])];
            if (cell == nil) {
                cell = [[ConfirmCell4 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ConfirmCell4 class])];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell configWithSource:self.source];
        cell.delegate = self;
        return cell;
    }else{//添加的商品
        ConfirmCell2 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ConfirmCell2 class])];
        if (cell == nil) {
            cell = [[ConfirmCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ConfirmCell2 class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWithData:self.dataList[indexPath.row-1] WithIndex:indexPath.row WithSource:self.source];
        return cell;
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
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NavBarHeight-bottomH, SCREEN_WIDTH, bottomH)];
        [_bottomView addSubview:self.line1];
        [_bottomView addSubview:self.sendBtn];
        [_bottomView addSubview:self.popBtn];
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
- (UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:90], [Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:35])];
        [_sendBtn addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
        _sendBtn.backgroundColor = [Unity getColor:@"aa112d"];
        [_sendBtn setTitle:@"送出委托单" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
        _sendBtn.layer.cornerRadius = _sendBtn.height/2;
    }
    return _sendBtn;
}
- (UIButton *)popBtn{
    if (!_popBtn) {
        _popBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:180], [Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:35])];
        [_popBtn addTarget:self action:@selector(popClick) forControlEvents:UIControlEventTouchUpInside];
        [_popBtn setTitle:@"返回修改" forState:UIControlStateNormal];
        [_popBtn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
        _popBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
        _popBtn.layer.cornerRadius = _popBtn.height/2;
        _popBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        _popBtn.layer.borderWidth =1;
    }
    return _popBtn;
}
- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:250], [Unity countcoordinatesH:10], [Unity countcoordinatesW:60], [Unity countcoordinatesH:35])];
        [_cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
        _cancelBtn.layer.cornerRadius = _cancelBtn.height/2;
        _cancelBtn.layer.borderColor = LabelColor9.CGColor;
        _cancelBtn.layer.borderWidth =1;
    }
    return _cancelBtn;
}
- (void)sendClick{
    //确认送出委托单
    NSLog(@"%@",self.dataList);
    NSMutableDictionary * dic = [NSMutableDictionary new];
//    NSMutableArray * arr = [NSMutableArray new];
    for (int i=0; i<self.dataList.count; i++) {
        [dic setValue:self.dataList[i][@"link"] forKey:[NSString stringWithFormat:@"agent_arr[%d][source_url]",i]];
        [dic setValue:self.dataList[i][@"gid"] forKey:[NSString stringWithFormat:@"agent_arr[%d][goods_code]",i]];
        [dic setValue:self.dataList[i][@"name"] forKey:[NSString stringWithFormat:@"agent_arr[%d][goods_name]",i]];
        [dic setValue:self.dataList[i][@"num"] forKey:[NSString stringWithFormat:@"agent_arr[%d][goods_num]",i]];
        [dic setValue:self.dataList[i][@"param"] forKey:[NSString stringWithFormat:@"agent_arr[%d][goods_specs]",i]];
        [dic setValue:self.dataList[i][@"price"] forKey:[NSString stringWithFormat:@"agent_arr[%d][goods_price]",i]];
    }
    
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    [dic setValue:userInfo[@"w_email"] forKey:@"user"];
    [dic setValue:lack_channel forKey:@"lack_channel"];
    [dic setValue:self.fraud_safe forKey:@"fraud_safe"];
    [dic setValue:self.safe_traffic forKey:@"safe_traffic"];
    if ([self.source isEqualToString:@"yahoo"]) {
        [dic setValue:@"円" forKey:@"currency"];
    }else{
        [dic setValue:@"USD" forKey:@"currency"];
    }
    [dic setValue:@"1" forKey:@"order_category_id"];
//    NSDictionary * param = @{@"user":userInfo[@"w_email"],@"lack_channel":lack_channel,@"fraud_safe":self.fraud_safe,@"safe_traffic":self.safe_traffic,@"agent_arr":arr};
    [Unity showanimate];
    [GZMrequest postWithURLString:[GZMUrl get_haitao_send_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([data[@"status"] intValue] == 0) {
            [self.sView showSendView];
        }else{
            [WHToast showMessage:data[@"mes"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)popClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)cancelClick{
    HomeViewController * home = nil;

        for (UIViewController * VC in self.navigationController.viewControllers) {

            if ([VC isKindOfClass:[HomeViewController class]]) {

                home = (HomeViewController *)VC;

            }

        }
    [self.navigationController popToViewController:home animated:YES];
}
- (SendView *)sView{
    if (!_sView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _sView = [SendView setSendView:window];
        _sView.delegate = self;
    }
    return _sView;
}
- (void)popHome{
    [self cancelClick];
}
- (void)popOrderPage{
     ShooseGJViewController * svc = nil;

         for (UIViewController * VC in self.navigationController.viewControllers) {

             if ([VC isKindOfClass:[ShooseGJViewController class]]) {

                 svc = (ShooseGJViewController *)VC;

             }

         }
     [self.navigationController popToViewController:svc animated:YES];
}
//confirmcell4 dialing
- (void)get_lack_channel:(NSString *)channel{
    lack_channel = channel;
}
- (void)haitaoRateSelete{
    NSMutableDictionary * dic = [NSMutableDictionary new];
    if ([self.source isEqualToString:@"yahoo"]) {
        [dic setValue:@"円" forKey:@"currency"];
    }else{
        [dic setValue:@"USD" forKey:@"currency"];
    }
    float sum = 0.0;
    for (int i=0; i<self.dataList.count; i++) {
        sum = sum+[self.dataList[i][@"num"] intValue]*[self.dataList[i][@"price"] floatValue];
    }
    [dic setValue:[NSString stringWithFormat:@"%.2f",sum] forKey:@"goods_price"];
    [dic setValue:self.fraud_safe forKey:@"fraud_safe"];
//    [Unity showanimate];
    [GZMrequest postWithURLString:[GZMUrl get_haitaoRateSelete_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([data[@"status"] intValue] ==0) {
            NSMutableDictionary * dict = [NSMutableDictionary new];
            dict = [data[@"data"] mutableCopy];
            [dict setValue:[NSString stringWithFormat:@"%.2f",sum] forKey:@"goods_price"];
            if ([self.source isEqualToString:@"yahoo"]) {
                [dict setValue:@"円" forKey:@"currency"];
            }else{
                [dict setValue:@"美元" forKey:@"currency"];
            }
            self.rateDic = [dict copy];
            
            //一个cell刷新
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:cellNum-2 inSection:0];

            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }

    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (NSDictionary *)rateDic{
    if (!_rateDic) {
        _rateDic = [NSDictionary new];
    }
    return _rateDic;
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
