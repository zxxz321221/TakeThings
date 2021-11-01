//
//  EntrustViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/27.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "EntrustViewController.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "EntrustHeaderCell.h"
#import "EntrustTwoCell.h"
#import "EntrustFooterCell.h"
#import "EntrustView.h"
#import "HelpDetailViewController.h"
#import "WebTwoViewController.h"
#import "AddressViewController.h"
#import "LoginViewController.h"
#import "HelpDetailViewController.h"
#import "Agreenment.h"
#import "MarginViewController.h"
#import "HackView.h"
@interface EntrustViewController ()<UITableViewDelegate,UITableViewDataSource,EntrustViewDelegate,EntrustHeaderCellDelegate,EntrustTwoCellDelegate,EntrustFooterCellDelegate,AddressViewDelegate,AgreenmentDelegate,HackViewDelegate>
{
    BOOL isMargin;//yes 已交保证金  no未交保证金   默认no
    NSInteger index;//默认地址所在数组下标 默认0
    NSString * addressID;
    BOOL isCont;//yes 已阅读 no未阅读
    NSString * inputPlace;//竞拍金额
    NSString * shipNum;//投标数量
    NSString * bidway;//出价方式  投标方式1立即出价，2结标前出价
    NSString * smsNoti;//是否短信通知 短信提醒，0无，1有
    NSString * shipins;//诈骗理赔保险 默认 0(不保)   选中传1
    NSString * trType;//运输方式  默认空
    NSString * get_name;//         : 会员姓名
    NSString * get_address;//      : 收货地址
    NSString * get_postal;//       : 收货邮编，例116033
    NSString * get_phone;//        : 收货电话，例13555993310
    
    NSString * _descriText;//中文描述
}
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) UIButton * continueBtn;

@property (nonatomic , strong) EntrustView * eView;
@property (nonatomic , strong) AroundAnimation * aAnimation;

@property (nonatomic , strong) NSMutableArray * listArray;

@property (nonatomic , strong) Agreenment * aView;
@property (nonatomic , strong) HackView * hView;

@end

@implementation EntrustViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    if ([userInfo[@"w_coins"] floatValue]>0) {
        isMargin = YES;
    }else{
        isMargin = NO;
    }
    _descriText = @"";
    shipNum = @"1";
    inputPlace= @"";
    addressID = @"";
    bidway = @"2";
    smsNoti = @"1";
    shipins = @"0";
    trType = nil; //福冈0 千叶1
    index = 0;
    
    [self createUI];
    [self requestAddress];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"委托单";
    
}
- (void)createUI{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.continueBtn];
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-[Unity countcoordinatesH:50]) style:UITableViewStyleGrouped];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = NO;//隐藏 tableView.separatorStyle = YES；
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionFooterHeight  = 0.1;
    }
    return _tableView;
}
- (UIButton *)continueBtn{
    if (!_continueBtn) {
        _continueBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _tableView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        [_continueBtn addTarget:self action:@selector(continueClick) forControlEvents:UIControlEventTouchUpInside];
        _continueBtn.backgroundColor = [Unity getColor:@"aa112d"];
        [_continueBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_continueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _continueBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
//        _continueBtn.userInteractionEnabled = NO;
    }
    return _continueBtn;
}

- (HackView *)hView{
    if (!_hView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _hView = [HackView setHackView:window withTitle:@"得标(含税)为通知发货最终申报价格"];
        _hView.delegate = self;
    }
    return _hView;
}

#pragma mark - tableView  搭理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [Unity countcoordinatesH:380];
    }else if (indexPath.section == 1){
        return [Unity countcoordinatesH:220];
    }else{
        //快递运输方式是活的  不一定是多少个 初始化没有   后期请求回来后赋值高度   如下实例 默认3个
        return [Unity countcoordinatesH:400]+3*[Unity countcoordinatesH:15]+2*[Unity countcoordinatesH:10];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        EntrustHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EntrustHeaderCell class])];
        if (cell == nil) {
            cell = [[EntrustHeaderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([EntrustHeaderCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell configWithGoodsName:self.goodsTitle WithPrice:self.price WithEndTime:self.endTime WithImageUrl:self.imageUrl WithIncrement:self.increment WithPlatform:self.platform WithBidorbuy:self.bidorbuy];
        return cell;
    }else if (indexPath.section == 1){
        EntrustTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EntrustTwoCell class])];
        if (cell == nil) {
            cell = [[EntrustTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([EntrustTwoCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }else{
        EntrustFooterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EntrustFooterCell class])];
        if (cell == nil) {
            cell = [[EntrustFooterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([EntrustFooterCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray * arr = [NSArray new];
        if ([self.platform isEqualToString:@"0"]) {
            arr= @[@"  泓睿仓（邮局运输）"];//@"  千叶仓（邮局运输/空港快线）",
        }else{
            arr = @[@"  UCS快递"];
        }
        if (self.listArray.count == 0) {
            [cell configWithArr:arr WithAddress:nil WithString:self.platform];
        }else{
            addressID = self.listArray[index][@"id"];
            get_name = self.listArray[index][@"w_name"];
            get_address = [NSString stringWithFormat:@"%@ %@ %@",self.listArray[index][@"w_address"],self.listArray[index][@"w_address_detail"],self.listArray[index][@"w_other"]];
            get_postal = self.listArray[index][@"postal"];
            get_phone = self.listArray[index][@"w_mobile"];
            [cell configWithArr:arr WithAddress:self.listArray[index] WithString:self.platform];
        }
        //下面代码是因为 委托合同点同意的时候刷新尾部cell  如果已选中仓库 设置默认选项 否则无
        if (trType != nil) {
            [cell configWithTrType:trType];
        }
        if (isCont) {
            [cell entrustSeleted];
        }
        cell.delegate = self;
        return cell;
    }

}
#pragma mark - 自定义headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [UIView new];
    if (section == 0) {
        if (!isMargin) {
            NSString *label_text2 = @"您目前尚未缴纳保证金，可体验购买，但系统不会分配雅虎账号，请缴纳保证金后重新购买。去缴纳保证金";
            NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
            [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(12)] range:NSMakeRange(0, label_text2.length)];
            [attributedString2 addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"#ff8400"] range:NSMakeRange(0, 41)];
            [attributedString2 addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"#4a90e2"] range:NSMakeRange(41, 6)];
            
            UILabel *ybLabel2 = [[UILabel alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
            ybLabel2.backgroundColor = [UIColor whiteColor];
            ybLabel2.numberOfLines = 2;
            ybLabel2.attributedText = attributedString2;
            [header addSubview:ybLabel2];
            // block 回调
            [ybLabel2 yb_addAttributeTapActionWithStrings:@[@"去缴纳保证金"] tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {
                MarginViewController * mvc = [[MarginViewController alloc]init];
                [self.navigationController pushViewController:mvc animated:YES];
            }];
        }
    }
    return header;
    
}
//section 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        if (!isMargin) {
            return [Unity countcoordinatesH:60];
        }else{
            return 0.1;
        }
    }else{
        return 0.1;
    }
}

- (EntrustView *)eView{
    if (!_eView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _eView = [EntrustView setEntrustView:window];
        _eView.delegate = self;
    }
    return _eView;
}

- (void)continueClick{
    if ([inputPlace isEqualToString:@""]) {
        NSLog(@"金额没填");
        [UIView animateWithDuration:0.5 animations:^{
            [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
        }completion:nil];
        //        [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"huoqujiaodian" object:nil];
        return;
    }
    if ([addressID isEqualToString:@""]){
        NSLog(@"收货地址");
        [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height) animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shanyishan" object:nil];
        return;
    }
    if (trType == nil) {
        [WHToast showMessage:@"请选择仓库" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        return;
    }
    if (!isCont){
        NSLog(@"公告委托合同");
        [self weituohetong];
        return;
    }
    if (isMargin == NO) {
        [self.eView showEntrustView];
    }else{
//        [self know];
        [self.hView showHackView];
    }

     
}

- (void)cancelCase{
     [self know];
}
- (void)weituohetong{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"contract11" ofType:@"txt"];
    NSString *content = [self readFile:path];
    NSLog(@"%@",content);
    NSString * string;
    string=[content stringByReplacingOccurrencesOfString:@"src=\""withString:@"src=\"http://shaogood.com.hk"];
    [self.aView showAgView];
    self.aView.titleL.text = @"公告委托合同书";
    [self.aView.webView loadHTMLString:string baseURL:nil];
}
//读取文件
-(NSString *)readFile:(NSString *)path{
    NSError *error = nil;
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);//将错误信息输出来
    }
    else{
        NSLog(@"%@",str);
    }
    return str;
}
- (void)know{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSString * source;
    if ([self.platform isEqualToString:@"0"]) {
        source = @"yahoo";
    }else{
        source = @"ebay";
    }
    if ([_descriText isEqualToString:@""]) {
        _descriText = [self.goodsTitle substringWithRange:NSMakeRange(0,10)];
    }
//    NSDictionary *params = @{@"source":source,@"auction_id":self.goodId,@"user":userInfo[@"w_email"],@"fraud_safe":shipins,@"price_user":inputPlace,@"bid_num":shipNum,@"describe_chinese":_descriText,@"bid_mode":bidway,@"send_mes":smsNoti,@"login_token":userInfo[@"token"],@"warehouse_id":trType,@"order_category_id":@"1",@"get_name":@"",@"get_address":@"",@"get_postal":@"",@"get_phone":@""};

    NSDictionary *params1 = @{
        @"platform":self.platform,
        @"item":self.goodId,
        @"qty":shipNum,
        @"address":addressID,
        @"maxpirce":inputPlace,
        @"type":bidway,
        @"customer":userInfo[@"member_id"],
        @"zplp":shipins,
        @"shlp":@"",
        @"mytoken":@"o2fw50sf25sd0cgfs23ew7c5",
        @"callme":smsNoti,
        @"receive_place":@"11",
       };
    //@"get_name":get_name,@"get_address":get_address,@"get_postal":get_postal,@"get_phone":get_phone
    NSLog(@"%@",params1);
    [self.aAnimation startAround];
    [GZMrequest postWithURLString:[GZMUrl get_createCase_url]parameters:params1 success:^(NSDictionary *data) {
        NSLog(@"创建委托单%@",data);
        [self.aAnimation stopAround];
        if ([data[@"status"] intValue] ==0) {
            [WHToast showMessage:data[@"mes"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [WHToast showMessage:data[@"mes"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [self.aAnimation stopAround];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)update{
    MarginViewController * mvc = [[MarginViewController alloc]init];
    [self.navigationController pushViewController:mvc animated:YES];
}
- (void)incrementBtn{
    [self helpNumber:@"116"];
}
- (void)whBtn{
    [self helpNumber:@"131"];
}
- (void)goodsButton{
    [self helpNumber:@"129"];
}
- (void)sdxxieyi{
    [self helpNumber:@"29"];
}
- (void)helpNumber:(NSString *)num{
    WebTwoViewController * wtc = [[WebTwoViewController alloc]init];
    wtc.num = num;
    [self.navigationController pushViewController:wtc animated:YES];
}
- (void)editAddress{
    NSLog(@"点击了 地址栏");
    AddressViewController * avc = [[AddressViewController alloc]init];
    avc.page = 0;
    avc.delegate = self;
    [self.navigationController pushViewController:avc animated:YES];
}
- (void)requestAddress{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
//    NSLog(@"%@",[userInfo objectForKey:@"member_id"]);
    NSDictionary * dic = @{@"customer":[userInfo objectForKey:@"member_id"]};
    [self.aAnimation startAround];
    [GZMrequest getWithURLString:[GZMUrl get_selectAddress_url] parameters:dic success:^(NSDictionary *data) {
        NSLog(@"查询收货地址信息 %@",data);
        [self.aAnimation stopAround];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            if ([data[@"data"] count] ==0) {
                return ;
            }else{
                for (int i=0; i<[data[@"data"] count]; i++) {
                    [self.listArray addObject:data[@"data"][i]];
                }
                for (int i=0; i<self.listArray.count; i++) {
                    if ([self.listArray[i][@"if_default"]isEqualToString:@"1"]) {
                        index = i;
                        break ;
                    }
                }
                [self.tableView reloadData];
            }
        }else{
            [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [self.aAnimation stopAround];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (AroundAnimation *)aAnimation{
    if (!_aAnimation) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _aAnimation = [AroundAnimation AroundAnimationViewSetView:window];
    }
    return _aAnimation;
}
- (NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [NSMutableArray new];
    }
    return _listArray;
}
- (void)EntrustAddress:(NSMutableArray *)list WithIndexPath:(NSInteger )indexpath{
    [self.listArray removeAllObjects];
    self.listArray = list;
    index = indexpath;
    addressID = self.listArray[index][@"id"];
    get_name = self.listArray[index][@"w_name"];
    get_address = [NSString stringWithFormat:@"%@ %@ %@",self.listArray[index][@"w_address"],self.listArray[index][@"w_address_detail"],self.listArray[index][@"w_other"]];
    get_postal = self.listArray[index][@"postal"];
    get_phone = self.listArray[index][@"w_mobile"];
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:2];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
     [self reloadBtn];
}
- (void)agreementClick:(BOOL)isContract{
    if (isContract) {
        [self weituohetong];
    }else{
        isCont = isContract;
    }
//    [self reloadBtn];
}
- (void)placeText:(NSString *)place{
    inputPlace = place;
//    [self reloadBtn];
}
- (void)descriText:(NSString *)descriText{
    _descriText = descriText;
}
- (void)reloadBtn{
    if ([inputPlace isEqualToString:@""] || [addressID isEqualToString:@""] || !isCont || [trType isEqualToString:@""]) {
        self.continueBtn.backgroundColor = [Unity getColor:@"cb6d7f"];
        self.continueBtn.userInteractionEnabled = NO;
        return;
    }else{
        self.continueBtn.backgroundColor = [Unity getColor:@"aa112d"];
//        CAGradientLayer *layerG = [CAGradientLayer layer];
//        layerG.colors=@[(__bridge id)[Unity getColor:@"#aa112d"].CGColor,(__bridge id)[Unity getColor:@"#e5294c"].CGColor];
//        layerG.startPoint = CGPointMake(0, 0.5);
//        layerG.endPoint = CGPointMake(1, 0.5);
//        layerG.frame = _continueBtn.bounds;
//        [self.continueBtn.layer addSublayer:layerG];
        self.continueBtn.userInteractionEnabled = YES;
    }
}
- (void)shipNum:(NSString *)num{
    shipNum = num;
}
- (void)bidWay:(NSString *)type{
    bidway = type;
}
- (void)smsNoti:(NSString *)sms{
    smsNoti = sms;
}
- (void)shipIns:(NSString *)ins{
    shipins = ins;
}
- (void)transportType:(NSInteger )type WithPlatform:(NSString *)platform{
    if ([platform isEqualToString:@"0"]) {
        if (type ==0) {
//            trType = @"3";
//        }else{
            trType = @"1";
        }
    }else{
        trType = @"2";
    }
    
}
- (Agreenment *)aView{
    if (!_aView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _aView = [Agreenment setAgreenment:window];
        _aView.delegate = self;
    }
    return _aView;
}



- (void)confirmAgreenment{
    isCont = YES;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexPath.section];
    [self.tableView reloadSections:indexSet withRowAnimation: UITableViewRowAnimationNone];
    
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
