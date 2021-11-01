//
//  NewCouponsViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/10/8.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "NewCouponsViewController.h"
#import "NewCouponsCell.h"
@interface NewCouponsViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UIScrollViewDelegate>
{
    NSString *yearStr;
    NSString *monthStr;
    BOOL isBill;//默认no
    BOOL isTime;//默认NO  yes弹出
    float fl;
    NSString * reType;//列表筛选  空 全部 s收入 z支出
}
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) UIView * headerView;
@property (nonatomic , strong) UIView * twoView;
@property (nonatomic , strong) UIImageView * imageView;
@property (nonatomic , strong) UILabel * rulesL;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UILabel * banlanceL;

@property (nonatomic , strong) UILabel * mmmLabel;//明细前面的小块
@property (nonatomic , strong) UILabel * couponsL;//标题
//@property (nonatomic , strong) UIButton * allBtn;//全部明细
//@property (nonatomic , strong) UIButton * timeBtn;//时间选择器

@property (nonatomic , strong) NSMutableArray * yearArray;
@property (nonatomic , strong) NSMutableArray * pickerArray;
@property (nonatomic , strong) NSMutableDictionary * dic;

@property (nonatomic , strong) UIView * maskView;
@property (nonatomic , strong) UIView * billView;
@property (nonatomic , strong) UIView * pickView;
@property(strong , nonatomic) UIPickerView * pickerView;

@property (nonatomic , strong) UIButton * bill_all;
@property (nonatomic , strong) UIButton * bill_refund;
@property (nonatomic , strong) UIButton * bill_recharge;

@property (nonatomic , strong) UIButton * allBillBtn;
@property (nonatomic , strong) UIImageView * billImg;
@property (nonatomic , strong) UIButton * timeBtn;
@property (nonatomic , strong) UIImageView * timeImg;
@end

@implementation NewCouponsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.title = @"回馈金";
    [self currentData];
}
- (void)setupUI{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.billView];
    [self.view addSubview:self.pickView];
    
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
//        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            //进行数据刷新操作
//            pageNum = pageNum+1;
//            [self requestData:reType WithTime:reTime];
//        }];
        // 马上进入刷新状态
//        [_tableView.mj_footer beginRefreshing];
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
        return 10;
    }
    //cell个数
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [Unity countcoordinatesH:55];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellidentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    NewCouponsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil) {
        cell = [[NewCouponsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [cell configWithData:self.listArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];

}

#pragma mark - 自定义headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.headerView;
    }
    return self.twoView;
}
//section 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return [Unity countcoordinatesH:135];
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
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:135])];
        
        [_headerView addSubview:self.imageView];
    }
    return _headerView;
}
- (UIView *)twoView{
    if (!_twoView) {
        _twoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        _twoView.backgroundColor = [UIColor whiteColor];
        [_twoView addSubview:self.mmmLabel];
        [_twoView addSubview:self.couponsL];
//        [_twoView addSubview:self.allBtn];
//        [_twoView addSubview:self.timeBtn];
        [_twoView addSubview:self.allBillBtn];
        [_twoView addSubview:self.billImg];
        [_twoView addSubview:self.timeBtn];
        [_twoView addSubview:self.timeImg];

    }
    return _twoView;
}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:115])];
        _imageView.image = [UIImage imageNamed:@"coupons"];
        
        [_imageView addSubview:self.rulesL];
        [_imageView addSubview:self.titleL];
        [_imageView addSubview:self.banlanceL];
    }
    return _imageView;
}
- (UILabel *)rulesL{
    if (!_rulesL) {
        _rulesL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:200], [Unity countcoordinatesH:5], [Unity countcoordinatesW:90], [Unity countcoordinatesH:15])];
        _rulesL.text = @"回馈金规则";
        _rulesL.textAlignment = NSTextAlignmentRight;
        _rulesL.font = [UIFont systemFontOfSize:FontSize(12)];
        _rulesL.textColor = [Unity getColor:@"E5CFA4"];
    }
    return _rulesL;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _rulesL.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:90], [Unity countcoordinatesH:15])];
        _titleL.text = @"当前回馈金";
        _titleL.textAlignment = NSTextAlignmentLeft;
        _titleL.font = [UIFont systemFontOfSize:FontSize(14)];
        _titleL.textColor = [Unity getColor:@"E5CFA4"];
    }
    return _titleL;
}
- (UILabel *)banlanceL{
    if (!_banlanceL) {
        _banlanceL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _titleL.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:150], [Unity countcoordinatesH:40])];
        _banlanceL.textAlignment = NSTextAlignmentLeft;
        _banlanceL.textColor = [Unity getColor:@"E5CFA4"];
        //文字大小不规则显示
        NSString * str1 = @"0RMB";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:str1];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:36] range:NSMakeRange(0, str1.length -3)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(str1.length -3, 3)];
        _banlanceL.attributedText = str;
    }
    return _banlanceL;
}
- (UILabel *)mmmLabel{
    if (!_mmmLabel) {
        _mmmLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:20], [Unity countcoordinatesW:3], [Unity countcoordinatesH:10])];
        _mmmLabel.backgroundColor = [Unity getColor:@"#aa112d"];
    }
    return _mmmLabel;
}
- (UILabel *)couponsL{
    if (!_couponsL) {
        _couponsL = [[UILabel alloc]initWithFrame:CGRectMake(_mmmLabel.right+[Unity countcoordinatesW:5], [Unity countcoordinatesH:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _couponsL.text = @"回馈金明细";
        _couponsL.textColor = LabelColor3;
        _couponsL.textAlignment = NSTextAlignmentLeft;
        _couponsL.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _couponsL;
}
- (UIButton *)allBillBtn{
    if (!_allBillBtn) {
        CGFloat W = [Unity widthOfString:@"全部明细" OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:20]];
        _allBillBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-W*2-[Unity countcoordinatesW:47],0, W, [Unity countcoordinatesH:50])];
        [_allBillBtn addTarget:self action:@selector(allbillClick) forControlEvents:UIControlEventTouchUpInside];
        [_allBillBtn setTitle:@"全部明细" forState:UIControlStateNormal];
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
- (UIView *)billView{
    if (!_billView) {
        _billView = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:185], SCREEN_WIDTH, 0)];
        _billView.backgroundColor = [UIColor whiteColor];
        _billView.hidden = YES;
        [_billView addSubview:self.bill_all];
        [_billView addSubview:self.bill_refund];
        [_billView addSubview:self.bill_recharge];
    }
    return _billView;
}
- (UIView *)pickView{
    if (!_pickView) {
        _pickView = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:185], SCREEN_WIDTH, 0)];
        _pickView.backgroundColor = [UIColor whiteColor];
        [_pickView addSubview:self.pickerView];
        _pickView.hidden = YES;
    }
    return _pickView;
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
//        self.allBtn.selected = NO;
//        [self.allBillBtn setImage:[UIImage imageNamed:@"下三角"] forState:UIControlStateNormal];
        self.billImg.image = [UIImage imageNamed:@"下三角"];
        self.billView.frame = CGRectMake(0, [Unity countcoordinatesH:185]-fl, SCREEN_WIDTH, 0);
        self.billView.hidden = YES;
    }
    if (isTime) {
        [self aaa];
        isTime = NO;
//        self.timeBtn.selected = NO;
        self.timeImg.image = [UIImage imageNamed:@"下三角"];
        self.pickView.frame = CGRectMake(0, [Unity countcoordinatesH:185]-fl, SCREEN_WIDTH, 0);
        self.pickView.hidden = YES;

    }
    self.maskView.frame = CGRectMake(0, 0, 0, 0);
    self.maskView.hidden = YES;
    self.tableView.scrollEnabled = YES;
}
- (void)aaa{
    NSString *str1 = [yearStr substringToIndex:4];//截取掉下标5之前的字符串(不包括)
    NSString *str2 = [str1 substringFromIndex:2];//截取掉下标3之后的字符串（包括）
    NSString * str3 = [monthStr substringToIndex:monthStr.length-1];
    if (str3.length == 1) {
        str3 = [NSString stringWithFormat:@"0%@",str3];
    }
    [self.timeBtn setTitle:[NSString stringWithFormat:@"%@-%@",str2,str3] forState:UIControlStateNormal];
    
//    reTime = [NSString stringWithFormat:@"%@-%@",str1,str3];
//    pageNum = 1;
//    [self.listArray removeAllObjects];
//    [self requestData:reType WithTime:reTime];
}
- (void)allbillClick{
    //    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] animated:YES scrollPosition:UITableViewScrollPositionTop];
    self.maskView.frame = CGRectMake(0, [Unity countcoordinatesH:185]-fl, SCREEN_WIDTH, SCREEN_HEIGHT-([Unity countcoordinatesH:185]-fl)-NavBarHeight);
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
- (void)timeClick{
    self.maskView.frame = CGRectMake(0, [Unity countcoordinatesH:185]-fl, SCREEN_WIDTH, SCREEN_HEIGHT-([Unity countcoordinatesH:185]-fl)-NavBarHeight);
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
- (void)delayMethod{
    if (self.pickView.hidden == NO) {
        self.pickView.frame = CGRectMake(0, [Unity countcoordinatesH:185]-fl, SCREEN_WIDTH, 0);
        self.pickView.hidden = YES;
    }
    if (self.billView.hidden == NO) {
        isBill = NO;
//        self.allBtn.selected = NO;
        [self.allBillBtn setImage:[UIImage imageNamed:@"下三角"] forState:UIControlStateNormal];
        self.billView.hidden = YES;
        self.maskView.frame = CGRectMake(0, 0, 0, 0);
        self.maskView.hidden = YES;
        self.tableView.scrollEnabled = YES;
    }else{
        [UIView animateWithDuration:0.1 animations:^{
            [self.billView setFrame:CGRectMake(0, [Unity countcoordinatesH:185]-fl, SCREEN_WIDTH,[Unity countcoordinatesH:55])];
        }completion:nil];
        self.billView.hidden = NO;
        self.maskView.hidden = NO;
    }
}
- (void)delayMethod1{
    if (self.billView.hidden == NO) {
        self.billView.frame = CGRectMake(0, [Unity countcoordinatesH:185]-fl, SCREEN_WIDTH, 0);
        self.billView.hidden = YES;
    }
    if (self.pickView.hidden == NO) {
        isTime = NO;
        self.timeBtn.selected = NO;
        self.pickView.frame = CGRectMake(0, [Unity countcoordinatesH:185]-fl, SCREEN_WIDTH, 0);
        self.pickView.hidden = YES;
        self.maskView.frame = CGRectMake(0, 0, 0, 0);
        self.maskView.hidden = YES;
        self.tableView.scrollEnabled = YES;
    }else{
        [UIView animateWithDuration:0.1 animations:^{
            [self.pickView setFrame:CGRectMake(0, [Unity countcoordinatesH:185]-fl, SCREEN_WIDTH,[Unity countcoordinatesH:150])];
        }completion:nil];
        self.pickView.hidden = NO;
        self.maskView.hidden = NO;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    NSLog(@"%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y >=[Unity countcoordinatesH:135]) {
        fl = [Unity countcoordinatesH:135];
    }else{
        fl = scrollView.contentOffset.y;
    }
    self.billView.frame = CGRectMake(0, [Unity countcoordinatesH:185]-fl, SCREEN_WIDTH, 0);
    self.pickView.frame = CGRectMake(0, [Unity countcoordinatesH:185]-fl, SCREEN_WIDTH, 0);
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
- (UIButton *)bill_all{
    if (!_bill_all) {
        _bill_all = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_bill_all addTarget:self action:@selector(bill_allClick) forControlEvents:UIControlEventTouchUpInside];
        [_bill_all setTitle:@"全部明细" forState:UIControlStateNormal];
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
#pragma mark   =====点击全部账单弹出的view按钮事件
- (void)bill_allClick{
    if (reType == nil) {
        [self maskAction];
        return;
    }
    reType = nil;
    [self.allBillBtn setTitle:@"全部明细" forState:UIControlStateNormal];
    [self.bill_all setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
    self.bill_all.layer.borderColor = [Unity getColor:@"#aa112d"].CGColor;
    [self.bill_refund setTitleColor:LabelColor6 forState:UIControlStateNormal];
    self.bill_refund.layer.borderColor = LabelColor6.CGColor;
    [self.bill_recharge setTitleColor:LabelColor6 forState:UIControlStateNormal];
    self.bill_recharge.layer.borderColor = LabelColor6.CGColor;
    [self maskAction];
//    pageNum = 1;
//    [self.listArray removeAllObjects];
//    [self requestData:reType WithTime:reTime];
    
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
//    pageNum = 1;
//    [self.listArray removeAllObjects];
//    [self requestData:reType WithTime:reTime];
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
//    pageNum = 1;
//    [self.listArray removeAllObjects];
//    [self requestData:reType WithTime:reTime];
}
- (NSMutableArray *)yearArray{
    if (!_yearArray) {
        _yearArray = [NSMutableArray new];
    }
    return _yearArray;
}
- (NSMutableArray *)pickerArray{
    if (!_pickerArray) {
        _pickerArray = [NSMutableArray new];
    }
    return _pickerArray;
}
- (NSMutableDictionary *)dic{
    if (!_dic) {
        _dic = [NSMutableDictionary new];
    }
    return _dic;
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
