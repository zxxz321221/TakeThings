//
//  RegionView.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/31.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "RegionView.h"
#import "RegionCell.h"
@interface RegionView()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger regionIndex;//0省 1市 2区 默认0
    NSString * proviceStr;
    NSString * cityStr;
    int indexi;
    int indexj;
}
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UILabel * title;
@property (nonatomic , strong) UIButton * cancel;

@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) UIView * headerView;

@property (nonatomic , strong) UILabel * china;
@property (nonatomic , strong) UIView * chinaLine;
@property (nonatomic , strong) UILabel * topCityL;
@property (nonatomic , strong) UILabel  * provinceL;
@property (nonatomic , strong) UILabel * cityL;

@property (nonatomic , strong) UIView * indicator;//指示器

@property (nonatomic , strong) NSArray * dataSource;//省市区所有数据源
@property (nonatomic , strong) NSMutableArray * cityList;//市数据源
@property (nonatomic , strong) NSMutableArray * areaList;//区数据源

@property (nonatomic , strong) UIView * headerV;//市区headerView
//省市区3个按钮
@property (nonatomic , strong) UIButton * provinceBtn;
@property (nonatomic , strong) UIButton * cityBtn;
@property (nonatomic , strong) UIButton * areaBtn;


@end
@implementation RegionView

+(instancetype)setRegionView:(UIView *)view{
    RegionView * pView = [[RegionView alloc]initWithFrame:view.frame];
    [[UIApplication sharedApplication].keyWindow addSubview:pView];
    return pView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        regionIndex = 0;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        self.hidden = YES;
        [self addSubview:self.backView];
        [self readData];
    }
    return self;
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT/4*3)];
        // 左上和右上为圆角
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:_backView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(15, 15)];
        CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
        cornerRadiusLayer.frame = _backView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        _backView.layer.mask = cornerRadiusLayer;
        _backView.backgroundColor = [UIColor whiteColor];
        
        [_backView addSubview:self.title];
        [_backView addSubview:self.cancel];
        [_backView addSubview:self.provinceBtn];
        [_backView addSubview:self.cityBtn];
        [_backView addSubview:self.areaBtn];
        [_backView addSubview:self.indicator];
        [_backView addSubview:self.tableView];
        
        
    }
    return _backView;
}
- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-[Unity countcoordinatesW:100])/2, [Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _title.text = @"请选择";
        _title.textColor = LabelColor3;
        _title.font = [UIFont systemFontOfSize:FontSize(17)];
        _title.textAlignment = NSTextAlignmentCenter;
    }
    return _title;
}
- (UIButton *)cancel{
    if (!_cancel) {
        _cancel = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:26], [Unity countcoordinatesH:12], [Unity countcoordinatesW:16], [Unity countcoordinatesW:16])];
        [_cancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [_cancel setBackgroundImage:[UIImage imageNamed:@"address_x"] forState:UIControlStateNormal];
    }
    return _cancel;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, _title.bottom+[Unity countcoordinatesH:10],SCREEN_WIDTH ,_backView.height-[Unity countcoordinatesH:40]) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [Unity getColor:@"#fbfbfb"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        if (@available(iOS 11,*)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        //隐藏tableViewCell下划线 隐藏所有分割线
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _tableView;
}
#pragma mark - tableView  搭理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (regionIndex == 0) {
        return self.dataSource.count;
    }else if (regionIndex == 1){
        return self.cityList.count;
    }else{
        return self.areaList.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RegionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RegionCell class])];
    if (cell == nil) {
        cell = [[RegionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([RegionCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [Unity getColor:@"#fbfbfb"];
    if (regionIndex == 0) {
        [cell configWithLetter:[self.dataSource[indexPath.row]objectForKey:@"letter"] WithName:[self.dataSource[indexPath.row]objectForKey:@"name"]];
    }else if (regionIndex == 1){
        [cell configWithLetter:[self.cityList[indexPath.row]objectForKey:@"letter"] WithName:[self.cityList[indexPath.row]objectForKey:@"name"]];
    }else{
        [cell configWithLetter:[self.areaList[indexPath.row]objectForKey:@"letter"] WithName:[self.areaList[indexPath.row]objectForKey:@"name"]];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (regionIndex == 0) {
        [self.cityList removeAllObjects];
        proviceStr = [self.dataSource[indexPath.row]objectForKey:@"name"];
        for (int i=0; i<self.dataSource.count; i++) {
            if ([[self.dataSource[i]objectForKey:@"name"]isEqualToString:proviceStr]) {
                for (int j=0; j<[[self.dataSource[i]objectForKey:@"city"] count]; j++) {
                    [self.cityList addObject:[self.dataSource[i]objectForKey:@"city"][j]];
                }
            }
        }
        self.tableView.frame = CGRectMake(0, [Unity countcoordinatesH:85], SCREEN_WIDTH, self.backView.height-[Unity countcoordinatesH:85]);
        self.provinceBtn.frame = CGRectMake([Unity countcoordinatesW:10], self.title.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:150], [Unity countcoordinatesH:15]);
        [self.provinceBtn setTitle:[self.dataSource[indexPath.row]objectForKey:@"name"] forState:UIControlStateNormal];
        [self.provinceBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [self.provinceBtn sizeToFit];
        self.cityBtn.frame = CGRectMake(self.provinceBtn.right+[Unity countcoordinatesW:15], self.provinceBtn.top, [Unity countcoordinatesW:150], [Unity countcoordinatesH:15]);
        [self.cityBtn setTitle:@"请选择城市" forState:UIControlStateNormal];
        [self.cityBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        [self.cityBtn sizeToFit];
        self.indicator.frame = CGRectMake(self.cityBtn.left+((self.cityBtn.width-[Unity countcoordinatesW:15])/2), self.cityBtn.bottom+[Unity countcoordinatesH:4], [Unity countcoordinatesW:15], [Unity countcoordinatesH:2]);
        self.indicator.backgroundColor = [Unity getColor:@"#aa112d"];
        self.areaBtn.hidden=YES;
        regionIndex = 1;
        [self.tableView reloadData];
    }else if (regionIndex == 1){
        [self.areaList removeAllObjects];
        cityStr = [self.cityList[indexPath.row]objectForKey:@"name"];
        for (int i=0; i<self.cityList.count; i++) {
            if ([[self.cityList[i]objectForKey:@"name"]isEqualToString:cityStr]) {
                for (int j=0; j<[[self.cityList[i]objectForKey:@"area"] count]; j++) {
                    [self.areaList addObject:[self.cityList[i]objectForKey:@"area"][j]];
                }
            }
        }
        [self.cityBtn setTitle:cityStr forState:UIControlStateNormal];
        [self.cityBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [self.cityBtn sizeToFit];
        self.areaBtn.hidden=NO;
        self.areaBtn.frame = CGRectMake(self.cityBtn.right+[Unity countcoordinatesW:15], self.cityBtn.top, [Unity countcoordinatesW:150], [Unity countcoordinatesH:15]);
        [self.areaBtn setTitle:@"请选择县" forState:UIControlStateNormal];
        [self.areaBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        [self.areaBtn sizeToFit];
        self.indicator.frame = CGRectMake(self.areaBtn.left+((self.areaBtn.width-[Unity countcoordinatesW:15])/2), self.areaBtn.bottom+[Unity countcoordinatesH:4], [Unity countcoordinatesW:15], [Unity countcoordinatesH:2]);
        regionIndex = 2;
        [self.tableView reloadData];
    }else{
        
        NSString * areaStr = [self.areaList[indexPath.row]objectForKey:@"name"];
        [self.areaBtn setTitle:areaStr forState:UIControlStateNormal];
        [self.areaBtn sizeToFit];
        self.indicator.frame = CGRectMake(self.areaBtn.left+((self.areaBtn.width-[Unity countcoordinatesW:15])/2), self.areaBtn.bottom+[Unity countcoordinatesH:4], [Unity countcoordinatesW:15], [Unity countcoordinatesH:2]);
        [self.delegate areaSelection:[NSString stringWithFormat:@"%@ %@ %@",proviceStr,cityStr,areaStr]];
        [self cancelClick];
    }
}

#pragma mark - 自定义headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (regionIndex == 0) {
        return self.headerView;
    }else{
        return self.headerV;
    }
}
//section 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (regionIndex == 0) {
       return [Unity countcoordinatesH:190];
    }else{
        return [Unity countcoordinatesH:30];
    }
}

#pragma mark - 自定义footerView
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    return [UIView new];
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, _title.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:190])];
        [_headerView addSubview:self.china];
        [_headerView addSubview:self.chinaLine];
        [_headerView addSubview:self.topCityL];
        NSArray * arr =@[@"北京",@"上海",@"广州",@"深圳",@"杭州",@"南京",@"苏州",@"天津",@"武汉",@"长沙",@"重庆",@"成都"];
        for (int i=0; i<12; i++) {
            CGFloat W = [Unity widthOfString:@"背景" OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:15]];
            UIButton * btn = [Unity buttonAddsuperview_superView:_headerView _subViewFrame:CGRectMake((i%4+1)*((SCREEN_WIDTH-W*4)/5)+i%4*W, _topCityL.bottom+(i/4+1)*[Unity countcoordinatesH:15]+(i/4)*[Unity countcoordinatesH:15], W, [Unity countcoordinatesH:15]) _tag:self _action:@selector(topCityClick:) _string:arr[i] _imageName:@""];
            btn.tag = i+1000;
            [btn setTitleColor:LabelColor3 forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        }
        [_headerView addSubview:self.provinceL];
    }
    return _headerView;
}
- (UILabel *)china{
    if (!_china) {
        _china = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:15], SCREEN_WIDTH, [Unity countcoordinatesH:15])];
        _china.text = @"中国大陆";
        _china.textColor = [Unity getColor:@"#aa112d"];
        _china.textAlignment  = NSTextAlignmentCenter;
        _china.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _china;
}
- (UIView *)chinaLine{
    if (!_chinaLine) {
        _chinaLine = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-[Unity countcoordinatesW:30])/2, _china.bottom+[Unity countcoordinatesH:8], [Unity countcoordinatesW:30], [Unity countcoordinatesH:2])];
        _chinaLine.backgroundColor = [Unity getColor:@"#aa112d"];
    }
    return _chinaLine;
}
- (UILabel *)topCityL{
    if (!_topCityL) {
        _topCityL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _chinaLine.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15])];
        _topCityL.text = @"热门城市";
        _topCityL.textColor = LabelColor9;
        _topCityL.textAlignment = NSTextAlignmentLeft;
        _topCityL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _topCityL;
}
- (UILabel *)provinceL{
    if (!_provinceL) {
        _provinceL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:175], [Unity countcoordinatesW:200], [Unity countcoordinatesH:15])];
        _provinceL.text = @"选择省份/地区";
        _provinceL.textColor = LabelColor9;
        _provinceL.textAlignment = NSTextAlignmentLeft;
        _provinceL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _provinceL;
}
- (UIView *)headerV{
    if (!_headerV) {
        _headerV = [[UIView alloc]initWithFrame:CGRectMake(0, _title.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:30])];
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:45])];
        [_headerV addSubview:view];
        
        [_headerV addSubview:self.cityL];
        
    }
    return _headerV;
}
- (UILabel *)cityL{
    if (!_cityL) {
        _cityL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:200], [Unity countcoordinatesH:15])];
        _cityL.text = @"选择城市";
        _cityL.textColor = LabelColor9;
        _cityL.textAlignment = NSTextAlignmentLeft;
        _cityL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _cityL;
}
- (UIButton *)provinceBtn{
    if (!_provinceBtn) {
        _provinceBtn = [UIButton new];
        [_provinceBtn addTarget:self action:@selector(provinceClick) forControlEvents:UIControlEventTouchUpInside];
        [_provinceBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        _provinceBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _provinceBtn;
}
- (UIButton *)cityBtn{
    if (!_cityBtn) {
        _cityBtn = [UIButton new];
        [_cityBtn addTarget:self action:@selector(cityClick) forControlEvents:UIControlEventTouchUpInside];
//        [_cityBtn setTitle:@"请选择城市" forState:UIControlStateNormal];
        [_cityBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        _cityBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _cityBtn;
}
- (UIButton *)areaBtn{
    if (!_areaBtn) {
        _areaBtn = [UIButton new];
        [_areaBtn addTarget:self action:@selector(areaClick) forControlEvents:UIControlEventTouchUpInside];
//        [_areaBtn setTitle:@"请选择县" forState:UIControlStateNormal];
        [_areaBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        _areaBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _areaBtn.hidden=YES;
    }
    return _areaBtn;
}
- (UIView *)indicator{
    if (!_indicator) {
        _indicator = [UIView new];
    }
    return _indicator;
}






- (void)showRegionView{
    self.hidden=NO;
    [UIView animateWithDuration:0.5 animations:^{
        [self.backView setFrame:CGRectMake(0, SCREEN_HEIGHT-self.backView.height, SCREEN_WIDTH, self.backView.height)];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }completion:nil];
}
- (void)cancelClick{
    [UIView animateWithDuration:0.5 animations:^{
        [self.backView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT/4*3)];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    }completion:nil];
    [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:0.5];
}
- (void)delayMethod{
    self.hidden = YES;
}
- (void)topCityClick:(UIButton *)btn{
    NSArray * arr =@[@"北京",@"上海",@"广州",@"深圳",@"杭州",@"南京",@"苏州",@"天津",@"武汉",@"长沙",@"重庆",@"成都"];
    for (int i=0; i<self.dataSource.count; i++) {
        for (int j=0; j<[[self.dataSource[i]objectForKey:@"city"]count]; j++) {
            
            NSRange range;
            range = [[[self.dataSource[i]objectForKey:@"city"][j]objectForKey:@"name"] rangeOfString:arr[btn.tag-1000]];
            if(range.location!=NSNotFound) {
                indexi = i;
                indexj = j;
            }
            
        }
    }
    self.tableView.frame = CGRectMake(0, [Unity countcoordinatesH:85], SCREEN_WIDTH, self.backView.height-[Unity countcoordinatesH:85]);
    self.provinceBtn.frame = CGRectMake([Unity countcoordinatesW:10], self.title.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:150], [Unity countcoordinatesH:15]);
    [self.provinceBtn setTitle:[self.dataSource[indexi]objectForKey:@"name"] forState:UIControlStateNormal];
    [self.provinceBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
    [self.provinceBtn sizeToFit];
    self.cityBtn.frame = CGRectMake(self.provinceBtn.right+[Unity countcoordinatesW:15], self.provinceBtn.top, [Unity countcoordinatesW:150], [Unity countcoordinatesH:15]);
    [self.cityBtn setTitle:[[self.dataSource[indexi]objectForKey:@"city"][indexj]objectForKey:@"name"] forState:UIControlStateNormal];
    [self.cityBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
    [self.cityBtn sizeToFit];
    self.areaBtn.hidden=NO;
    self.areaBtn.frame = CGRectMake(self.cityBtn.right+[Unity countcoordinatesW:15], self.cityBtn.top, [Unity countcoordinatesW:150], [Unity countcoordinatesH:15]);
    [self.areaBtn setTitle:@"请选择县" forState:UIControlStateNormal];
    [self.areaBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
    [self.areaBtn sizeToFit];
    self.indicator.frame = CGRectMake(self.areaBtn.left+((self.areaBtn.width-[Unity countcoordinatesW:15])/2), self.areaBtn.bottom+[Unity countcoordinatesH:4], [Unity countcoordinatesW:15], [Unity countcoordinatesH:2]);
    self.indicator.backgroundColor = [Unity getColor:@"#aa112d"];
    regionIndex = 2;
    [self.cityList removeAllObjects];
    for (int i=0; i<[[self.dataSource[indexi]objectForKey:@"city"]count]; i++) {
        [self.cityList addObject:[self.dataSource[indexi]objectForKey:@"city"][i]];
    }
    [self.areaList removeAllObjects];
    for (int i=0; i<[[[self.dataSource[indexi]objectForKey:@"city"][indexj]objectForKey:@"area"]count]; i++) {
        [self.areaList addObject:[[self.dataSource[indexi]objectForKey:@"city"][indexj]objectForKey:@"area"][i]];
    }
    proviceStr = [self.dataSource[indexi]objectForKey:@"name"];
    cityStr = [[self.dataSource[indexi]objectForKey:@"city"][indexj]objectForKey:@"name"];
    
    [self.tableView reloadData];
}

#pragma mark readData
- (void)readData{
    NSString * path = [[NSBundle mainBundle]pathForResource:@"city" ofType:@"plist"];
    self.dataSource = [NSArray arrayWithContentsOfFile:path];
    NSLog(@"%@",self.dataSource);
    [self.tableView reloadData];
}
- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSArray new];
    }
    return _dataSource;
}
- (NSMutableArray *)cityList{
    if (!_cityList) {
        _cityList = [NSMutableArray new];
    }
    return _cityList;
}
- (NSMutableArray *)areaList{
    if (!_areaList) {
        _areaList = [NSMutableArray new];
    }
    return _areaList;
}

- (void)provinceClick{
    regionIndex = 0;
    [self.provinceBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
    self.indicator.frame = CGRectMake(self.provinceBtn.left+((self.provinceBtn.width-[Unity countcoordinatesW:15])/2), self.provinceBtn.bottom+[Unity countcoordinatesH:4], [Unity countcoordinatesW:15], [Unity countcoordinatesH:2]);
    [self.cityBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
    [self.areaBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
    [self.tableView reloadData];
}
- (void)cityClick{
    regionIndex = 1;
    [self.provinceBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
    [self.cityBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
    self.indicator.frame = CGRectMake(self.cityBtn.left+((self.cityBtn.width-[Unity countcoordinatesW:15])/2), self.cityBtn.bottom+[Unity countcoordinatesH:4], [Unity countcoordinatesW:15], [Unity countcoordinatesH:2]);
    [self.areaBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
    [self.tableView reloadData];
}
- (void)areaClick{
    regionIndex = 2;
    [self.provinceBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
    [self.cityBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
    [self.areaBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
    self.indicator.frame = CGRectMake(self.areaBtn.left+((self.areaBtn.width-[Unity countcoordinatesW:15])/2), self.areaBtn.bottom+[Unity countcoordinatesH:4], [Unity countcoordinatesW:15], [Unity countcoordinatesH:2]);
    [self.tableView reloadData];
}

@end
