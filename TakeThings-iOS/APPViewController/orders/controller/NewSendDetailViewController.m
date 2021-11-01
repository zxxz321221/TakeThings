//
//  NewSendDetailViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/9.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "NewSendDetailViewController.h"
#import "NewDeliveryInfoCell.h"
#import "PackagingCell.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "WebTwoViewController.h"
#import "AddressViewController.h"
#define bottomH (IS_iPhoneX ? [Unity countcoordinatesH:70] : [Unity countcoordinatesH:50])
@interface NewSendDetailViewController ()<UITableViewDelegate,UITableViewDataSource,PackagingCellDelegate,AddressViewDelegate,NewDeliveryInfoCellDelegate>
{
    BOOL isAn;//默认 no    yes展开
    BOOL isBuyIns;//购买运输保险  yes购买
    BOOL isBuyPack;//购买包装  默认no
    float cellH;
    NSString * addressId;
    NSInteger index;//默认地址所在数组下标 默认0
    NSInteger btnIndex;//国际运输方式选择
    NSString * transport;
    NSString * goods_name;
    NSString * goods_address;
    NSString * goods_postal;
    NSString * goods_phone;
}
@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) UIView * addressView;
@property (nonatomic , strong) UILabel * nameL;
@property (nonatomic , strong) UILabel * mobileL;
@property (nonatomic , strong) UILabel * addressName;

@property (nonatomic , strong) NSMutableArray * expressArr;//运输方式数组
@property (nonatomic , strong) UIView * expressView;
@property (nonatomic , strong) UILabel * exMark;//国际运输方式  下方提示语

@property (nonatomic , strong) UIView * otherView;//附加项目
@property (nonatomic , strong) UIButton * otherBtn1;
@property (nonatomic , strong) UIButton * otherWh1;
@property (nonatomic , strong) UIButton * otherBtn2;
@property (nonatomic , strong) UIButton * otherBtn3;
@property (nonatomic , strong) UIButton * otherWh2;

@property (nonatomic , strong) UIView * packView;//加强包装view
@property (nonatomic , strong) UIButton * packBtn1;
@property (nonatomic , strong) UIButton * packBtn2;

@property (nonatomic , strong) UIView * markView;//提示


@property (nonatomic , strong) UIView * bottomView;//顶部view
@property (nonatomic , strong) UIButton * confirm;;

@property (nonatomic , strong) NSMutableDictionary * placeDic;//商品价值集合
@property (nonatomic , strong) AroundAnimation * aAnimation;
@property (nonatomic , strong) NSMutableArray * addressArr;

@property (nonatomic , strong) UIButton * seletedBtn;

@property (nonatomic , strong) NSMutableArray * listArray;
@end

@implementation NewSendDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    index = 0;
    isBuyIns = NO;
    isBuyPack =NO;
    isAn = NO;
    cellH = 0.01;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    //下方2行代码 只是为了计算cell高度    并无他用
    NSArray * arr = @[@"泡沫",@"木板",@"塑料泡",@"纸箱",@"塑料泡",@"泡沫",@"木板",@"纸箱"];
    [self jisuancellgaodu:arr];
    //国际运输方式 暂时写死
    [self gjysfs];
    if (self.isNew) {
        [self requestDetailNew];
    }else{
        [self requestDetail];
    }
    
}
- (void)gjysfs{
    NSArray * arr = self.kdArray;
    
    self.expressArr  = [arr mutableCopy];
    if (arr.count != 1) {
        self.expressView.frame = CGRectMake(0, [Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:80]+(self.expressArr.count-1)*[Unity countcoordinatesH:25]);
        self.exMark.frame = CGRectMake([Unity countcoordinatesW:10], self.expressView.height-[Unity countcoordinatesH:35], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:15]);
    }else{
        self.expressView.frame = CGRectMake(0, [Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:55]+(self.expressArr.count-1)*[Unity countcoordinatesH:25]);
        self.exMark.hidden = YES;
    }
    for (int i=0; i<arr.count;i++) {
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:100], [Unity countcoordinatesH:20]+i*[Unity countcoordinatesH:25], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15])];
        btn.tag = 1000+i;
        [btn addTarget:self action:@selector(allSeletedClick:) forControlEvents:UIControlEventTouchUpInside];
        //        _allSeletedBtn.backgroundColor = [UIColor yellowColor];
        [btn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"  %@",arr[i]] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
        [btn sizeToFit];
        if (i == 0) {
            btn.selected = YES;
            btnIndex=0;
            transport = @"1";
            self.seletedBtn = btn;
        }
        [_expressView addSubview:btn];
    }
    [self.tableView reloadData];
}
- (void)jisuancellgaodu:(NSArray *)arr{
    CGFloat w = [Unity countcoordinatesW:100];//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = [Unity countcoordinatesH:5];//用来控制button距离父视图的高
    CGFloat lastBtnY = 0;
    for (int i = 0; i < arr.count; i++) {//创建button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = i+1000;
        button.backgroundColor = [Unity getColor:@"f0f0f0"];
        //设置边框颜色
        button.layer.cornerRadius = 12.5f;
        [button setTitleColor:LabelColor6 forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:FontSize(12)];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button sizeToFit];
        CGFloat length = button.frame.size.width;
        //设置button的frame
        button.frame = CGRectMake(10 + w, h, length + 15 , 25);// 距离屏幕左右边距各10,
        //当button的位置超出屏幕边缘时换行
        if(20 + w + length + 15 > SCREEN_WIDTH){
            w = [Unity countcoordinatesW:100]; //换行时将w置为0
            h = h + button.frame.size.height + 10;//距离父视图也变化
            button.frame = CGRectMake(10 + w, h, length + 15, 25);//重设button的frame
        }
        if (length + 20 > SCREEN_WIDTH - 20) {
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 8)];// 设置button的title距离边框有一定的间隙,显示不下的字会省略
            button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, SCREEN_WIDTH - 20, 25);//重设button的frame
            
        }
        w = button.frame.size.width + button.frame.origin.x;//重新赋值
        if (i==arr.count-1) {
            lastBtnY=button.frame.origin.y;
        }
        //        self.btn = button;
        if (i == arr.count-1) {
            cellH = button.bottom+[Unity countcoordinatesH:10];
            NSLog(@"----%f",cellH);
            
        }
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [Unity getColor:@"f0f0f0"];
    self.title = @"发货信息";
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-bottomH) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        self.extendedLayoutIncludesOpaqueBars = YES;
        
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        //去除所有cell分割线
        [_tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}


#pragma mark  tableViewDelegate
//section个数
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView{
    return 6;
}
//section高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else if (section == 1){
        return [Unity countcoordinatesH:100];
    }else if (section == 2){
        if (self.expressArr.count<=1 || self.expressArr ==nil) {
            return [Unity countcoordinatesH:65];
        }else{
            return [Unity countcoordinatesH:90]+(self.expressArr.count-1)*[Unity countcoordinatesH:25];
        }
    }else if (section == 3){
        return [Unity countcoordinatesH:105];
    }else if (section == 4){
        return [Unity countcoordinatesH:55];
    }else {
        if ([self.source isEqualToString:@"yahoo"]) {
            return [Unity countcoordinatesH:125];
        }else{
            return [Unity countcoordinatesH:45];
        }
    }
}
//sectionview
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]init];
    if (section == 0) {
        
    }else if(section == 1){
        [view addSubview:self.addressView];
    }else if (section == 2){
        [view  addSubview:self.expressView];
    }else if (section == 3){
        [view  addSubview:self.otherView];
    }else if (section == 4){
        [view addSubview:self.packView];
    }else{
        [view addSubview:self.markView];
    }
    return view;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return self.listArray.count;
    }else if (section == 4){
//        if (isAn) {  //打开cell返回数组的count
//            //        NSArray *array = [NSArray arrayWithArray:dataArray[section]];
//            return 1;
//        }else{
            return 0;
//        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [Unity countcoordinatesH:290];
    }else if (indexPath.section == 4){
        return cellH;
    }else {
        return 0.01;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NewDeliveryInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NewDeliveryInfoCell class])];
        if (cell == nil) {
            cell = [[NewDeliveryInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([NewDeliveryInfoCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWithData:self.listArray[indexPath.row] WithIsNew:self.isNew];
        cell.delegate = self;
        return cell;
    }else if (indexPath.section == 4){
        PackagingCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PackagingCell class])];
        if (cell == nil) {
            cell = [[PackagingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PackagingCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        NSArray * arr = @[@"泡沫",@"木板",@"塑料泡",@"纸箱",@"塑料泡",@"泡沫",@"木板",@"纸箱"];
        [cell configWithPackBtnArr:arr];
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
#pragma mark addressView
- (UIView *)addressView{
    if (!_addressView) {
        _addressView = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:90])];
        _addressView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *singleTap =
        
        [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addressClick:)];
        
        [_addressView addGestureRecognizer:singleTap];
        
        UILabel * label  = [Unity lableViewAddsuperview_superView:_addressView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:90], [Unity countcoordinatesH:15]) _string:@"收件人" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
        [_addressView addSubview:self.nameL];
        [_addressView addSubview:self.mobileL];
        UILabel * addressL = [Unity lableViewAddsuperview_superView:_addressView _subViewFrame:CGRectMake(label.left, label.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:90], [Unity countcoordinatesH:15]) _string:@"收货地址" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        addressL.backgroundColor = [UIColor clearColor];
        [_addressView addSubview:self.addressName];
        UIImageView * imageView = [Unity imageviewAddsuperview_superView:_addressView _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:17.5], [Unity countcoordinatesH:30], [Unity countcoordinatesW:7.5], [Unity countcoordinatesH:15]) _imageName:@"go" _backgroundColor:nil];
        imageView.backgroundColor = [UIColor clearColor];
    }
    return _addressView;
}
- (UILabel *)nameL{
    if (!_nameL) {
        _nameL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:100], [Unity countcoordinatesH:15], [Unity countcoordinatesW:70], [Unity countcoordinatesH:15])];
        _nameL.text = @"请输入收件人";
        _nameL.textColor = LabelColor6;
        _nameL.textAlignment = NSTextAlignmentLeft;
        _nameL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _nameL;
}
- (UILabel *)mobileL{
    if (!_mobileL) {
        _mobileL = [[UILabel alloc]initWithFrame:CGRectMake(_nameL.right, [Unity countcoordinatesH:15], [Unity countcoordinatesW:120], [Unity countcoordinatesH:15])];
        _mobileL.text = @"";
        _mobileL.textColor = LabelColor6;
        _mobileL.textAlignment = NSTextAlignmentRight;
        _mobileL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _mobileL;
}
- (UILabel *)addressName{
    if (!_addressName) {
        _addressName = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:100], _nameL.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:190], [Unity countcoordinatesH:30])];
        _addressName.text = @"请输入收货地址";
        _addressName.textColor = LabelColor6;
        _addressName.textAlignment = NSTextAlignmentLeft;
        _addressName.font = [UIFont systemFontOfSize:FontSize(14)];
        _addressName.numberOfLines = 0;
    }
    return _addressName;
}
#pragma mark expressView
- (UIView *)expressView{
    if (!_expressView) {
        _expressView = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:80])];
        _expressView.backgroundColor = [UIColor whiteColor];
        UILabel * label = [Unity lableViewAddsuperview_superView:_expressView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:20], [Unity countcoordinatesW:90], [Unity countcoordinatesH:15]) _string:@"国际运输方式:" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
        [_expressView addSubview:self.exMark];
    }
    return _expressView;
}
- (UILabel *)exMark{
    if (!_exMark) {
        _exMark = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:45], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:15])];
        _exMark.text = @"日本案件，预估运费4200円，运输时间7~14天";
        _exMark.textColor = LabelColor9;
        _exMark.textAlignment = NSTextAlignmentLeft;
        _exMark.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _exMark;
}

#pragma mark 附加项目
- (UIView *)otherView{
    if (!_otherView) {
        _otherView = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:95])];
        _otherView.backgroundColor = [UIColor whiteColor];
        UILabel * label = [Unity lableViewAddsuperview_superView:_otherView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:20], [Unity countcoordinatesW:90], [Unity countcoordinatesH:15]) _string:@"附加项目:" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
        
        [_otherView addSubview:self.otherBtn1];
        [_otherView addSubview:self.otherWh1];
        [_otherView addSubview:self.otherBtn2];
        [_otherView addSubview:self.otherBtn3];
        [_otherView addSubview:self.otherWh2];
    }
    return _otherView;
}
- (UIButton *)otherBtn1{
    if (!_otherBtn1) {
        _otherBtn1 = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:100], [Unity countcoordinatesH:20], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15])];
        [_otherBtn1 addTarget:self action:@selector(otherbtn1Click) forControlEvents:UIControlEventTouchUpInside];
        [_otherBtn1 setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_otherBtn1 setTitle:@"  购买运输保险费用说明" forState:UIControlStateNormal];
        _otherBtn1.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _otherBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_otherBtn1 setImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [_otherBtn1 setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"  购买运输保险费用说明"];
        [str addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"aa112d"] range:NSMakeRange(str.length-4,4)];
        _otherBtn1.titleLabel.attributedText = str;
        [_otherBtn1 setAttributedTitle:str forState:UIControlStateNormal];
        [_otherBtn1 sizeToFit];
    }
    return _otherBtn1;
}
- (UIButton *)otherWh1{
    if (!_otherWh1) {
        _otherWh1 = [[UIButton alloc]initWithFrame:CGRectMake(_otherBtn1.right+5, [Unity countcoordinatesH:20]+([Unity countcoordinatesH:15]-15)/2, 15, 15)];
        [_otherWh1 addTarget:self action:@selector(otherWh1Click) forControlEvents:UIControlEventTouchUpInside];
        [_otherWh1 setBackgroundImage:[UIImage imageNamed:@"?"] forState:UIControlStateNormal];
    }
    return _otherWh1;
}
- (UIButton *)otherBtn2{
    if (!_otherBtn2) {
        _otherBtn2 = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:100], _otherBtn1.bottom+[Unity countcoordinatesH:10]+([Unity countcoordinatesH:20]-15)/2, 15, 15)];
        [_otherBtn2 addTarget:self action:@selector(otherBtn2Click) forControlEvents:UIControlEventTouchUpInside];
        [_otherBtn2 setImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [_otherBtn2 setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
    }
    return _otherBtn2;
}
- (UIButton *)otherBtn3{
    if (!_otherBtn3) {
        _otherBtn3 = [[UIButton alloc] initWithFrame:CGRectMake(_otherBtn2.right+5, _otherBtn1.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-20-[Unity countcoordinatesW:110], [Unity countcoordinatesH:30])];
        [_otherBtn3 addTarget:self action:@selector(otherBtn2Click) forControlEvents:UIControlEventTouchUpInside];
        [_otherBtn3 setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_otherBtn3 setTitle:@"易碎,易变形,贵重物品 要加购包装材料规则与费用说明" forState:UIControlStateNormal];
        _otherBtn3.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _otherBtn3.titleLabel.lineBreakMode = 0;
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"易碎,易变形,贵重物品 要加购包装材料规则与费用说明"];
        [str addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"aa112d"] range:NSMakeRange(str.length-7,7)];
        _otherBtn3.titleLabel.attributedText = str;
        [_otherBtn3 setAttributedTitle:str forState:UIControlStateNormal];
    }
    return _otherBtn3;
}
- (UIButton *)otherWh2{
    if (!_otherWh2) {
        _otherWh2 = [[UIButton alloc]initWithFrame:CGRectMake([Unity widthOfString:_otherBtn3.titleLabel.text OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:15]]-self.otherBtn3.width+25+[Unity countcoordinatesW:110], _otherBtn3.top+[Unity countcoordinatesH:15], 15, 15)];
        [_otherWh2 setBackgroundImage:[UIImage imageNamed:@"?"] forState:UIControlStateNormal];
        [_otherWh2 addTarget:self action:@selector(otherWh2Click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _otherWh2;
}

#pragma mark packView
- (UIView *)packView {
    if (!_packView) {
        _packView = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:45])];
        _packView.backgroundColor = [UIColor whiteColor];
        UILabel * label = [Unity lableViewAddsuperview_superView:_packView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:20], [Unity countcoordinatesW:90], [Unity countcoordinatesH:15]) _string:@"加强包装:" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
        
        [_packView addSubview:self.packBtn1];
        [_packView addSubview:self.packBtn2];
        
    }
    return _packView;
}
- (UIButton *)packBtn1{
    if (!_packBtn1) {
        _packBtn1 = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:100], [Unity countcoordinatesH:20], [Unity countcoordinatesW:60], [Unity countcoordinatesH:15])];
        [_packBtn1 addTarget:self action:@selector(packBtn1Click) forControlEvents:UIControlEventTouchUpInside];
        [_packBtn1 setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_packBtn1 setTitle:@"  是" forState:UIControlStateNormal];
        _packBtn1.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _packBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_packBtn1 setImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [_packBtn1 setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
    }
    return _packBtn1;
}
- (UIButton *)packBtn2{
    if (!_packBtn2) {
        _packBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(_packBtn1.right, [Unity countcoordinatesH:20], [Unity countcoordinatesW:60], [Unity countcoordinatesH:15])];
        [_packBtn2 addTarget:self action:@selector(packBtn2Click) forControlEvents:UIControlEventTouchUpInside];
        [_packBtn2 setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_packBtn2 setTitle:@"  否" forState:UIControlStateNormal];
        _packBtn2.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _packBtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_packBtn2 setImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [_packBtn2 setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
        _packBtn2.selected = YES;
    }
    return _packBtn2;
}
#pragma mark markView
- (UIView *)markView{
    if (!_markView) {
        CGFloat h;
        if ([self.source isEqualToString:@"yahoo"]) {
            h= [Unity countcoordinatesH:125];
        }else{
            h= [Unity countcoordinatesH:45];
        }
        _markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, h)];
        _markView.backgroundColor = [UIColor whiteColor];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:35])];
        label.numberOfLines = 0;
        NSString *label_text2 = @"※运输费用有时可能会因为加强包装,产生浮动通知发货时建议咨询客服";
        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
        [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(18)] range:NSMakeRange(0, 1)];
        [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(12)] range:NSMakeRange(1, label_text2.length-1)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"#aa112d"] range:NSMakeRange(0, 1)];
        
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(1, label_text2.length-1)];
        
        label.attributedText = attributedString2;
        [_markView addSubview:label];
        
        UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:10], label.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:35])];
        label1.numberOfLines = 0;
        NSString *label_text1 = @"※加强包装或多件包装如需包装纸盒,会收取每个纸盒费,单纸盒费为300円";
        NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc]initWithString:label_text1];
        [attributedString1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(18)] range:NSMakeRange(0, 1)];
        [attributedString1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(12)] range:NSMakeRange(1, label_text1.length-1)];
        [attributedString1 addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"#aa112d"] range:NSMakeRange(0, 1)];
        [attributedString1 addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(1, label_text2.length-1)];
        [attributedString1 addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"aa112d"] range:NSMakeRange(label_text1.length-4, 3)];
        [attributedString1 addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(label_text1.length-1, 1)];
        label1.attributedText = attributedString1;
        [_markView addSubview:label1];

        UILabel * label3 = [[UILabel alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:10], label1.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:35])];
        label3.numberOfLines = 0;
        NSString *label_text3 = @"※如您未勾选以上加购包装材料，如发生以下情况仍需收取纸箱费用：查看详情 ";
        NSMutableAttributedString *attributedString3 = [[NSMutableAttributedString alloc]initWithString:label_text3];
        [attributedString3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(18)] range:NSMakeRange(0, 1)];
        [attributedString3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(12)] range:NSMakeRange(1, label_text3.length-1)];
        [attributedString3 addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"#aa112d"] range:NSMakeRange(0, 1)];
        [attributedString3 addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(1, label_text2.length-1)];
        [attributedString3 addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"aa112d"] range:NSMakeRange(label_text3.length-5, 4)];
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        
        // 表情图片
        
        attch.image = [UIImage imageNamed:@"?"];
        
        // 设置图片大小
        
        attch.bounds = CGRectMake(0, 0, 13, 13);
        
        // 创建带有图片的富文本
        
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
        
        [attributedString3 appendAttributedString:string]; //在文字后面添加图片
        label3.attributedText = attributedString3;
        [_markView addSubview:label3];
        [label3 yb_addAttributeTapActionWithStrings:@[@"查看详情 "] tapClicked:^(UILabel *label,NSString *string, NSRange range, NSInteger index) {
//            NSLog(@"点击了查看详情");
            [self helpNumber:@"173"];
        }];
        //        //设置是否有点击效果，默认是YES
        label3.enabledTapEffect = NO;
        
        
        if (![self.source isEqualToString:@"yahoo"]) {
            label1.hidden = YES;
            label3.hidden = YES;
        }
    }
    return _markView;
}
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NavBarHeight-bottomH, SCREEN_WIDTH, bottomH)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        line.backgroundColor = [Unity getColor:@"f0f0f0"];
        [_bottomView addSubview:line];
        [_bottomView addSubview:self.confirm];
    }
    
    return _bottomView;
}
- (UIButton *)confirm{
    if (!_confirm) {
        _confirm = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:5], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        [_confirm addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        [_confirm setTitle:@"确认发货" forState:UIControlStateNormal];
        [_confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirm.backgroundColor = [Unity getColor:@"cb6d7f"];
        _confirm.layer.cornerRadius = _confirm.height/2;
        _confirm.userInteractionEnabled = NO;
    }
    return _confirm;
}








- (NSMutableArray *)expressArr{
    if (!_expressArr) {
        _expressArr = [NSMutableArray new];
    }
    return _expressArr;
}
//地址点击
- (void)addressClick:(UITapGestureRecognizer *)sender{
    NSLog(@"1111");
    AddressViewController * avc = [[AddressViewController alloc]init];
    avc.page = 1;
    avc.delegate = self;
    [self.navigationController pushViewController:avc animated:YES];
}
- (void)EntrustAddress:(NSMutableArray *)list WithIndexPath:(NSInteger )indexpath{
    [self.addressArr removeAllObjects];
    self.addressArr = list;
    index = indexpath;
    addressId = self.addressArr[index][@"id"];
    self.nameL.text = self.addressArr[index][@"w_name"];
    self.mobileL.text = [Unity editMobile:self.addressArr[index][@"w_mobile"]];
    self.addressName.text = [NSString stringWithFormat:@"%@ %@ %@",self.addressArr[index][@"w_address"],self.addressArr[index][@"w_address_detail"],self.addressArr[index][@"w_other"]];
    goods_name = self.addressArr[index][@"w_name"];
    goods_postal = self.addressArr[index][@"postal"];
    addressId = @"1";
    goods_phone = self.addressArr[index][@"w_mobile"];
    goods_address = [NSString stringWithFormat:@"%@ %@ %@",self.addressArr[index][@"w_address"],self.addressArr[index][@"w_address_detail"],self.addressArr[index][@"w_other"]];
}
- (void)otherbtn1Click{
    if (self.otherBtn1.selected == YES) {
        self.otherBtn1.selected = NO;
        isBuyIns = NO;
    }else{
        self.otherBtn1.selected = YES;
        isBuyIns = YES;
    }
}
- (void)otherBtn2Click{
    if (isBuyPack) {
        self.otherBtn2.selected = NO;
        isBuyPack = NO;
    }else{
        self.otherBtn2.selected = YES;
        isBuyPack = YES;
    }
}
- (void)otherWh1Click{
    NSLog(@"购买运输保险后面问号");
    [self helpNumber:@"128"];//82
}
- (void)otherWh2Click{
//    NSLog(@"易碎易变性后面问号");
    [self helpNumber:@"173"];
}
- (void)helpNumber:(NSString *)num{
    WebTwoViewController * wtc = [[WebTwoViewController alloc]init];
    wtc.num = num;
    [self.navigationController pushViewController:wtc animated:YES];
}
- (void)packBtn1Click{
    self.packBtn1.selected = YES;
    self.packBtn2.selected = NO;
    isAn = YES;
    [self.tableView reloadData];
}
- (void)packBtn2Click{
    self.packBtn2.selected = YES;
    self.packBtn1.selected = NO;
    isAn = NO;
    [self.tableView reloadData];
}
//cell回调
- (void)packBtnRead:(NSMutableArray *)array{
    NSLog(@"%@",array);
}
//商品cell回调
- (void)fillInWillSee{
    //填写必看
}
- (void)placeText:(NSString *)place WithCell:(NewDeliveryInfoCell *)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    [self.placeDic setObject:place forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    [self checkInfo];
}
- (NSMutableDictionary *)placeDic{
    if (!_placeDic) {
        _placeDic = [NSMutableDictionary new];
    }
    return _placeDic;
}
- (void)confirmClick{
    //确认发货
    NSLog(@"%@",self.placeDic);
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSMutableDictionary * dic = [NSMutableDictionary new];
    NSString * str1 = @"";
    NSString * str2 = @"";
    NSString * str3 = @"";
    if (isAn) {
        str1 = @"1";
    }else{
        str1 = @"0";
    }
    if (isBuyIns) {
        str2 = @"1";
    }else{
        str2 = @"0";
    }
    if (isBuyPack) {
        str3 = @"1";
    }else{
        str3 = @"0";
    }
    if (![self.source isEqualToString:@"yahoo"]) {
        transport = @"4";
    }else{
        switch (btnIndex) {
            case 0:
                transport = @"1";
                break;
                case 1:
                transport = @"2";
                break;
                case 2:
                transport = @"3";
                break;
            default:
                transport = @"5";
                break;
        }
    }
//    NSMutableArray * arr1 = [NSMutableArray new];
//    for (int i=0; i<self.listArray.count; i++) {
//        NSMutableDictionary * dict = [NSMutableDictionary new];
//        [dict setObject:self.listArray[i][@"bid_id"] forKey:@"bid_id"];
//        [dict setObject:self.placeDic[[NSString stringWithFormat:@"%d",i]] forKey:@"goods_val"];
//        [arr1 addObject:dict];
//    }
    [dic setObject:userInfo[@"token"] forKey:@"login_token"];
    [dic setObject:userInfo[@"w_email"] forKey:@"user"];
    [dic setObject:self.listArray[0][@"currency"] forKey:@"currency"];
    [dic setObject:goods_name forKey:@"get_name"];
    [dic setObject:goods_address forKey:@"get_address"];
    [dic setObject:goods_postal forKey:@"get_postal"];
    [dic setObject:goods_phone forKey:@"get_phone"];
    [dic setObject:transport forKey:@"traffic_type"];
    [dic setObject:str3 forKey:@"packing_add"];
    [dic setObject:str1 forKey:@"packing_strengthen"];
    [dic setObject:@"1" forKey:@"order_category_id"];
    [dic setObject:str2 forKey:@"safe_traffic"];
    [dic setObject:@"1" forKey:@"os"];
    for (int i=0; i<self.listArray.count; i++) {
        NSMutableDictionary * dict = [NSMutableDictionary new];
//        [dict setObject:self.listArray[i][@"bid_id"] forKey:@"bid_id"];
//        [dict setObject:self.placeDic[[NSString stringWithFormat:@"%d",i]] forKey:@"goods_val"];
//        [arr1 addObject:dict];
        if (self.isNew) {
            [dic setObject:self.listArray[i][@"agent_id"] forKey:[NSString stringWithFormat:@"order_arr[%d][order_id]",i]];
            [dic setObject:@"100" forKey:[NSString stringWithFormat:@"order_arr[%d][order_category_id]",i]];
        }else{
            [dic setObject:self.listArray[i][@"bid_id"] forKey:[NSString stringWithFormat:@"order_arr[%d][order_id]",i]];
            [dic setObject:@"1" forKey:[NSString stringWithFormat:@"order_arr[%d][order_category_id]",i]];
        }
        [dic setObject:self.placeDic[[NSString stringWithFormat:@"%d",i]] forKey:[NSString stringWithFormat:@"order_arr[%d][goods_val]",i]];
    }
//    dic = @{@"login_token":userInfo[@"token"],@"user":userInfo[@"w_email"],@"currency":self.listArray[0][@"currency"],@"get_name":goods_name,@"get_address":goods_address,@"get_postal":goods_postal,@"get_phone":goods_phone,@"traffic_type":transport,@"packing_add":str3,@"packing_strengthen":str1,@"order_category_id":@"1",@"safe_traffic":str2,@"bid_arr":arr1,@"os":@"1"};

    NSLog(@"发货请求数据 %@",dic);
    [self.aAnimation startAround];
    
    [GZMrequest postWithURLString:[NSString stringWithFormat:@"%@/index/order_transport/transport_create",[[NSUserDefaults standardUserDefaults] objectForKey:@"new_sdxurl"]] parameters:dic success:^(NSDictionary *data) {
        NSLog(@"fahuo%@",data);
        [self.aAnimation stopAround];
        if ([data[@"status"] intValue] == 0) {
            [self.delegate reloadTableView];
            [self.navigationController popViewControllerAnimated:YES];
        }
        [WHToast showMessage:data[@"mes"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    } failure:^(NSError *error) {
        [self.aAnimation stopAround];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
//    [self.aAnimation startAround];
//    [GZMrequest postWithURLString:@"http://bms.shaogood.com/index/order_transport/transport_bid_create" parameters:dic success:^(NSDictionary *data) {
//        NSLog(@"确认发货 %@",data);
//        [self.aAnimation stopAround];
////        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
////            [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
//////            [self.delegate senViewBack:self.listArr.count];
////            [self.navigationController popViewControllerAnimated:YES];
////        }else{
////            [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
////        }
//    } failure:^(NSError *error) {
//        [self.aAnimation stopAround];
//        NSLog(@"%@",error);
//        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
//    }];
}
//校验发货按钮是否可点击
- (void)checkInfo{
    if (self.listArray.count != self.placeDic.count || addressId == nil) {
        self.confirm.backgroundColor = [Unity getColor:@"cb6d7f"];
        self.confirm.userInteractionEnabled = NO;
    }else{
        for (int i=0; i<self.listArray.count; i++) {
            if ([self.placeDic[[NSString stringWithFormat:@"%d",i]] isEqualToString:@""]) {
                self.confirm.backgroundColor = [Unity getColor:@"cb6d7f"];
                self.confirm.userInteractionEnabled = NO;
                return;
            }
        }
        self.confirm.backgroundColor = [Unity getColor:@"aa112d"];
        self.confirm.userInteractionEnabled = YES;
    }
}

- (NSMutableArray *)addressArr{
    if (!_addressArr) {
        _addressArr = [NSMutableArray new];
    }
    return _addressArr;
}
- (void)allSeletedClick:(UIButton *)btn{
    btnIndex = btn.tag-1000;
    if (btn != self.seletedBtn) {
        self.seletedBtn.selected = NO;
        btn.selected = YES;
        self.seletedBtn = btn;
    }
    float kg=0.0;
    for (int i=0; i<self.listArray.count; i++) {
        kg=kg+[self.listArray[i][@"warehouse_get_weight"] floatValue];
    }
    NSInteger yf=0.0;
    if (btnIndex ==0) {
        yf = [Unity getFreightWithWeight:[NSString stringWithFormat:@"%f",kg] WithSteam:@"ems"];
        self.exMark.text = [NSString stringWithFormat:@"日本案件，预估运费%ld円，运输时间3~7天",(long)yf];
        transport = @"1";
    }else if (btnIndex == 1){
        yf = [Unity getFreightWithWeight:[NSString stringWithFormat:@"%f",kg] WithSteam:@"sal"];
//        self.exMark.text = @"日本案件，预估运费4200円，运输时间7~14天";
        self.exMark.text = [NSString stringWithFormat:@"日本案件，预估运费%ld円，运输时间7~14天",(long)yf];
        transport = @"3";
    }else if (btnIndex == 2){
        yf = [Unity getFreightWithWeight:[NSString stringWithFormat:@"%f",kg] WithSteam:@"ship"];
        self.exMark.text = [NSString stringWithFormat:@"日本案件，预估运费%ld円，运输时间25~40天",(long)yf];
        transport = @"2";
    }else{
        yf = [Unity getFreightWithWeight:[NSString stringWithFormat:@"%f",kg] WithSteam:@"kg"];
        self.exMark.text = [NSString stringWithFormat:@"日本案件，预估运费%ld円，集货形式，集货周期不定",(long)yf];
        transport = @"4";
    }
}
- (NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [NSMutableArray new];
    }
    return _listArray;
}
- (void)requestDetail{
    [Unity showanimate];
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"login_token":userInfo[@"token"],@"user":userInfo[@"w_email"],@"bid_id_arr":self.id_arr};
    [GZMrequest postWithURLString:[NSString stringWithFormat:@"%@/index/order_bid/send_goods",[[NSUserDefaults standardUserDefaults] objectForKey:@"new_sdxurl"]] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        NSLog(@"%@",data);
        self.nameL.text = data[@"get_name"];
        self.mobileL.text = [Unity editMobile:data[@"get_phone"]];
        self.addressName.text = data[@"get_address"];
        addressId = data[@"get_postal"];//youbian
        goods_name = data[@"get_name"];
        goods_phone = data[@"get_phone"];
        goods_address = data[@"get_address"];
        goods_postal = data[@"get_postal"];
        self.listArray = [data[@"bid"] mutableCopy];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)requestDetailNew{
    [Unity showanimate];
    NSDictionary * dic = @{@"agent_id_arr":self.id_arr};
    [GZMrequest postWithURLString:@"https://bms.shaogood.com.hk/index/order_agent/send_goods" parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        NSLog(@"%@",data);
        self.nameL.text = data[@"get_name"];
        self.mobileL.text = [Unity editMobile:data[@"get_phone"]];
        self.addressName.text = data[@"get_address"];
        addressId = data[@"get_postal"];//youbian
        goods_name = data[@"get_name"];
        goods_phone = data[@"get_phone"];
        goods_address = data[@"get_address"];
        goods_postal = data[@"get_postal"];
        self.listArray = [data[@"agent"] mutableCopy];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
@end
