//
//  LTSCalendarScrollView.m
//  LTSCalendar
//
//  Created by 李棠松 on 2018/1/13.
//  Copyright © 2018年 leetangsong. All rights reserved.
//

#import "LTSCalendarScrollView.h"
#import "FootPrintCell.h"
#import "FootHeaderView.h"
#import "FootGoodsModel.h"
#import "FootHearModel.h"
#import <MJExtension.h>
#import "FootCollectionReusableView.h"
#define CellIdentifier @"CellIdentifier"
@interface LTSCalendarScrollView()<UICollectionViewDelegate,UICollectionViewDataSource,FootCellDelegate,FootHeaderDelegate>
{
    BOOL status;//yes 编辑状态  no取消编辑
    CGFloat * apl;
    NSInteger page;
    NSInteger dSection;//点击3个点编辑按钮 记录section
    NSInteger dRow;//点击3个点编辑按钮 记录row
    NSString * xzDate;//选中红点的日期   默认空（全部）
}
@property (nonatomic,strong)UIView *line;
@property (nonatomic,strong) UICollectionViewFlowLayout * flowLayout;

@property (nonatomic , strong) UIButton * footBtn;

@property (nonatomic , strong) NSMutableArray * newList;

@end
@implementation LTSCalendarScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self initUI];
        page =1;
        apl=0;
        status = NO;
        self.scrollEnabled = NO;
        xzDate = @"";
        //注册通知：
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(footEdit:) name:@"footEdit" object:nil];
        //注册通知：
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(oneDelete) name:@"danshan" object:nil];
        //注册通知：
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(seletedDate:) name:@"seletedDate" object:nil];
        //注册通知：
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(collection) name:@"collection" object:nil];
    }
    return self;
}
- (void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
    self.backgroundColor = bgColor;
//    self.tableView.backgroundColor = bgColor;
    self.line.backgroundColor = bgColor;
}

- (void)initUI{
    
    self.delegate = self;
    self.bounces = false;
    self.showsVerticalScrollIndicator = false;
    self.backgroundColor = [LTSCalendarAppearance share].scrollBgcolor;
    LTSCalendarContentView *calendarView = [[LTSCalendarContentView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [LTSCalendarAppearance share].weekDayHeight*[LTSCalendarAppearance share].weeksToDisplay)];
    calendarView.currentDate = [NSDate date];
    [self addSubview:calendarView];
    self.calendarView = calendarView;
    
        self.line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(calendarView.frame), CGRectGetWidth(self.frame),0.5)];
    
//    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(calendarView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-CGRectGetMaxY(calendarView.frame)) collectionViewLayout:self.flowLayout];
//    self.flowLayout.minimumLineSpacing = 0;
//    self.flowLayout.minimumInteritemSpacing = 0;
////    self.flowLayout.footerReferenceSize = CGSizeMake(0, 50);
//    if (@available(iOS 9.0, *)) {
//        self.flowLayout.sectionHeadersPinToVisibleBounds = false;
//    } else {
//        // Fallback on earlier versions
//    }
    
//    self.flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/3,[Unity countcoordinatesH:200]);
//    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[FootPrintCell class] forCellWithReuseIdentifier:CellIdentifier];
    self.collectionView.backgroundColor = [Unity getColor:@"#f0f0f0"];
    [self.collectionView registerClass:[FootHeaderView class]
             forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                    withReuseIdentifier:@"CollectionViewHeaderView"];
    [self.collectionView registerClass:[FootCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
    [self addSubview:self.collectionView];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self requestFootData:page Type:@"up"];
    }];
    // 马上进入刷新状态
    [self.collectionView.mj_header beginRefreshing];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self requestFootData:page Type:@"down"];
        [self.collectionView.mj_footer beginRefreshing];
    }];
//    self.collectionView.scrollEnabled = NO;
    
    self.line.backgroundColor = self.backgroundColor;
    [self addSubview:self.line];
    [LTSCalendarAppearance share].isShowSingleWeek ? [self scrollToSingleWeek]:[self scrollToAllWeek];
    UIWindow * window = [UIApplication sharedApplication].windows[0];
    [window addSubview:self.deleteBtn];
    
//    [self.calendarView setSingleWeek:true];//周
    
    [self addSubview:self.footBtn];
//    [self.collectionView bringSubviewToFront:self.footBtn];
//    [self.collectionView insertSubview:self.footBtn atIndex:10];
}
- (UIButton *)footBtn{
    if (!_footBtn) {
        _footBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:50], 300-[Unity countcoordinatesH:15], [Unity countcoordinatesW:30], [Unity countcoordinatesH:30])];
//        _footBtn.backgroundColor = [UIColor redColor];
        [_footBtn addTarget:self action:@selector(footClick:) forControlEvents:UIControlEventTouchUpInside];
        [_footBtn setBackgroundImage:[UIImage imageNamed:@"footup"] forState:UIControlStateNormal];
        _footBtn.adjustsImageWhenHighlighted = NO;//取消点击效果
        [_footBtn setBackgroundImage:[UIImage imageNamed:@"footdown"] forState:UIControlStateSelected];
    }
    return _footBtn;
}
- (void)footClick:(UIButton *)btn{
    if (btn.selected == NO) {
        btn.selected=YES;
        [self scrollToSingleWeek];//周
    }else{
        btn.selected = NO;
        
        [self scrollToAllWeek];//月
    }
}
- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-[Unity countcoordinatesW:2.5]*5)/3, [Unity countcoordinatesH:180]);
        _flowLayout.minimumLineSpacing = [Unity countcoordinatesW:2.5];
        _flowLayout.minimumInteritemSpacing = [Unity countcoordinatesW:2.5];
    }
    return _flowLayout;
}
#pragma mark UICollectionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.newList.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [[self.newList[section]objectForKey:@"data"] count];//每个section有多少个cell
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FootPrintCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if ([self.newList[indexPath.section][@"data"][indexPath.row][@"source"] isEqualToString:@"yahoo"]) {
        cell.time = [Unity timeSwitchTimestamp:self.newList[indexPath.section][@"data"][indexPath.row][@"over_time"] andFormatter:@"YYYY-MM-dd HH:mm:ss" andForTimeZone:@"Asia/Tokyo"];
    }else{
//        NSLog(@"%@",self.newList[indexPath.section][@"data"][indexPath.row][@"over_time"]);
//        NSDateFormatter *format = [[NSDateFormatter alloc] init];
//        format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//        format.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"]; //将时间字符串当utc处理，打印时根据本地时区自动打印 +8
//        NSDate *utcDate = [format dateFromString:self.newList[indexPath.section][@"data"][indexPath.row][@"over_time"]];  // Summary 2017-10-25 02:07:39 UTC
////        NSLog(@"utc = %@",utcDate);
//        NSString * ssss = [self getLocalDateFormateUTCDate:[format stringFromDate:utcDate]];
////        NSLog(@"ssss=%@",ssss);
//        NSArray * array10 = [ssss componentsSeparatedByString:@"-"];
//        NSString * endtime = [NSString stringWithFormat:@"%@/%@/%@",array10[0],array10[1],array10[2]];
//        NSLog(@"endtime = %@",endtime);
        cell.time = [Unity timeSwitchTimestamp:self.newList[indexPath.section][@"data"][indexPath.row][@"over_time_ch"] andFormatter:@"YYYY-MM-dd HH:mm:ss" andForTimeZone:@"Asia/Beijing"];
    }
    [cell configWithSection:indexPath.section IndexPath:indexPath.row IsEdit:status];
    NSLog(@"%@",self.newList[indexPath.section][@"data"][indexPath.row][@"over_time"]);
    cell.model = self.modelArrs[indexPath.section][indexPath.row];
    cell.delegate = self;
    return cell;
}
- (NSString *)getLocalDateFormateUTCDate:(NSString *)utcStr {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    format.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSDate *utcDate = [format dateFromString:utcStr];
    format.timeZone = [NSTimeZone localTimeZone];
    NSString *dateString = [format stringFromDate:utcDate];
    return dateString;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"openDetail" object:nil userInfo:self.newList[indexPath.section][@"data"][indexPath.row]]];
//    NSLog(@"%@",self.newList[indexPath.section][@"data"][indexPath.row]);
//    if ([self.newList[indexPath.section][@"data"][indexPath.row][@"source"] isEqualToString:@"yahoo"]) {
//        NewYahooDetailViewController * nvc = [[NewYahooDetailViewController alloc]init];
//        nvc.item = self.newList[indexPath.section][@"data"][indexPath.row][@"ids"];
//        nvc.platform = @"0";
//
//    }
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdentifier;
    // header
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        reuseIdentifier = @"CollectionViewHeaderView";
        FootHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                            withReuseIdentifier:reuseIdentifier
                                                                                   forIndexPath:indexPath];
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            view.backgroundColor = [UIColor clearColor];
            [view configWithIsEdit:status Section:indexPath.section];
            view.model = self.groupArrs[indexPath.section];
            view.delegate = self;
        }
        return view;
    }
    FootCollectionReusableView * footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"foot" forIndexPath:indexPath];
    footerView.backgroundColor = [Unity getColor:@"#f0f0f0"];
    
    return footerView;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_WIDTH, [Unity countcoordinatesH:40]);
}
//footer的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    int i = self.groupArrs.count;
    if (section == i-1) {
        return CGSizeMake(SCREEN_WIDTH, 50);
    }
    return CGSizeMake(SCREEN_WIDTH, 0.1);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
    CGFloat offsetY = scrollView.contentOffset.y;
   
    
    if (scrollView != self) {
        return;
    }
//    if (scrollView == self.collectionView.scr) {
//        return;
//    }
    
    LTSCalendarAppearance *appearce =  [LTSCalendarAppearance share];
    ///表需要滑动的距离
    CGFloat tableCountDistance = appearce.weekDayHeight*(appearce.weeksToDisplay-1);
    ///日历需要滑动的距离
    CGFloat calendarCountDistance = self.calendarView.singleWeekOffsetY;
    CGFloat scale = calendarCountDistance/tableCountDistance;
//     NSLog(@"%lf",ABS(offsetY));
    
    CGRect calendarFrame = self.calendarView.frame;
    self.calendarView.maskView.alpha = offsetY/tableCountDistance;
    self.calendarView.maskView.hidden = false;
    calendarFrame.origin.y = offsetY-offsetY*scale;
    if(ABS(offsetY) >= tableCountDistance) {
        //变成周以后
//         self.collectionView.scrollEnabled = true;
        self.calendarView.maskView.hidden = true;
        //为了使滑动更加顺滑，这部操作根据 手指的操作去设置
//         [self.calendarView setSingleWeek:true];
        
    }else{
        
//        self.collectionView.scrollEnabled = false;
        if ([LTSCalendarAppearance share].isShowSingleWeek) {
           
            [self.calendarView setSingleWeek:false];
        }
    }
    CGRect tableFrame = self.collectionView.frame;
    tableFrame.size.height = CGRectGetHeight(self.frame)-CGRectGetHeight(self.calendarView.frame)+offsetY;
    self.collectionView.frame = tableFrame;
    self.bounces = false;
    if (offsetY<=0) {
        self.bounces = true;
        calendarFrame.origin.y = offsetY;
        tableFrame.size.height = CGRectGetHeight(self.frame)-CGRectGetHeight(self.calendarView.frame);
        self.collectionView.frame = tableFrame;
    }
    self.calendarView.frame = calendarFrame;
    
    
    
//   NSLog(@"%lf",self.collectionView.top);
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    LTSCalendarAppearance *appearce =  [LTSCalendarAppearance share];
    CGFloat tableCountDistance = appearce.weekDayHeight*(appearce.weeksToDisplay-1);
    if ( appearce.isShowSingleWeek) {
        if (self.contentOffset.y != tableCountDistance) {
            return  nil;
        }
    }
    if ( !appearce.isShowSingleWeek) {
        if (self.contentOffset.y != 0 ) {
            return  nil;
        }
    }

    return  [super hitTest:point withEvent:event];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    LTSCalendarAppearance *appearce =  [LTSCalendarAppearance share];
    CGFloat tableCountDistance = appearce.weekDayHeight*(appearce.weeksToDisplay-1);

    if (scrollView.contentOffset.y>=tableCountDistance) {
        [self.calendarView setSingleWeek:true];
    }
    
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (self != scrollView) {
        return;
    }
   
    LTSCalendarAppearance *appearce =  [LTSCalendarAppearance share];
    ///表需要滑动的距离
    CGFloat tableCountDistance = appearce.weekDayHeight*(appearce.weeksToDisplay-1);
    //point.y<0向上
    CGPoint point =  [scrollView.panGestureRecognizer translationInView:scrollView];
    
    if (point.y<=0) {
       
        [self scrollToSingleWeek];
    }
    
    if (scrollView.contentOffset.y<tableCountDistance-20&&point.y>0) {
        [self scrollToAllWeek];
    }
}
//手指触摸完
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (self != scrollView) {
        return;
    }
    LTSCalendarAppearance *appearce =  [LTSCalendarAppearance share];
    ///表需要滑动的距离
    CGFloat tableCountDistance = appearce.weekDayHeight*(appearce.weeksToDisplay-1);
    //point.y<0向上
    CGPoint point =  [scrollView.panGestureRecognizer translationInView:scrollView];
    
    
    if (point.y<=0) {
        if (scrollView.contentOffset.y>=20) {
            if (scrollView.contentOffset.y>=tableCountDistance) {
                [self.calendarView setSingleWeek:true];
            }
            [self scrollToSingleWeek];
        }else{
            [self scrollToAllWeek];
        }
    }else{
        if (scrollView.contentOffset.y<tableCountDistance-20) {
            [self scrollToAllWeek];
        }else{
            [self scrollToSingleWeek];
        }
    }
  
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
     [self.calendarView setUpVisualRegion];
}


- (void)scrollToSingleWeek{
    LTSCalendarAppearance *appearce =  [LTSCalendarAppearance share];
    ///表需要滑动的距离
    CGFloat tableCountDistance = appearce.weekDayHeight*(appearce.weeksToDisplay-1);
    [self setContentOffset:CGPointMake(0, tableCountDistance) animated:true];
    
    
}

- (void)scrollToAllWeek{
    [self setContentOffset:CGPointMake(0, 0) animated:true];
}


- (void)layoutSubviews{
    [super layoutSubviews];

    self.contentSize = CGSizeMake(0, CGRectGetHeight(self.frame)+[LTSCalendarAppearance share].weekDayHeight*([LTSCalendarAppearance share].weeksToDisplay-1));
}
- (void)withOfDelete:(NSInteger)section IndexPath:(NSInteger)indexPath{
//    [self.delegate withOfDeleteSection:section IndexPath:indexPath];
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"singleDelete" object:nil userInfo:nil]];
    dSection = section;
    dRow = indexPath;
}
-(void)footEdit:(NSNotification *)notification
{
    //移除通知
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loadH5code" object:self];
    if ([notification.userInfo[@"key"]isEqualToString:@"1"]) {
        status = YES;
        self.deleteBtn.hidden=NO;
    }else{
        status = NO;
        self.deleteBtn.hidden=YES;
    }
    [self loadModel];
    [self.collectionView reloadData];
}
- (void)seletedDate:(NSNotification *)notification{
    xzDate = notification.userInfo[@"key"];
    page = 1;
    [self requestFootData:page Type:@"up"];
}
- (void)loadModel{
//    _carLists = dict[@"shoppingCar"];
    
    NSMutableArray * modelArrs = [NSMutableArray array];
    for (NSDictionary * dict in self.newList)
    {
        NSMutableArray * modelArr = [FootGoodsModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        
        [modelArrs addObject:modelArr];
    }
    self.modelArrs = modelArrs;
    NSMutableArray * groupArrs = [FootHearModel mj_objectArrayWithKeyValuesArray:self.newList];
    self.groupArrs = groupArrs;
}
/**
 *  cell的代理方法
 *
 *  @param cell     cell可以拿到indexpath
 *  @param selectBt 选中按钮
 */
- (void)shoppingCellDelegate:(ClassCell *)cell WithSelectButton:(UIButton *)selectBt
{
    NSIndexPath * indexPath = [self.collectionView indexPathForCell:cell];
    NSLog(@"indexpath%@",indexPath);
    FootGoodsModel * model = self.modelArrs[indexPath.section][indexPath.row];
    NSArray * arr = self.modelArrs[indexPath.section];
    model.isSelect = !selectBt.selected;
    //在这里修改 元数据里的状态 默认0 不编辑 改成1   后期点击删除   状态为1的全删
    NSString * isS = @"0";
    NSLog(@"ifReadOnly value: %@" ,model.isSelect?@"YES":@"NO");
    if (model.isSelect) {
        isS = @"1";
    }
    NSMutableDictionary * dict = [NSMutableDictionary new];
    dict = [self.newList[indexPath.section] mutableCopy];
    NSMutableArray * arr1 = [NSMutableArray new];
    arr1 = [[dict objectForKey:@"data"] mutableCopy];
    NSMutableDictionary * dic = [arr1[indexPath.row] mutableCopy];
    [dic setObject:isS forKey:@"isSelect"];
    [arr1 replaceObjectAtIndex:indexPath.row withObject:dic];
    [dict setObject:arr1 forKey:@"data"];
    [self.newList replaceObjectAtIndex:indexPath.section withObject:dict];
    
/////////
    
    int counts = 0;
    for (FootGoodsModel * modelArr in arr)
    {
        if(modelArr.isSelect)
        {
            counts ++ ;
        }
    }
    FootHearModel * headerModel = self.groupArrs[indexPath.section];
    if(counts == arr.count)
    {
        headerModel.isSelect = YES;
    }else
    {
        headerModel.isSelect = NO;
    }
    
    [self isallSelectAllPrice];
    [self.collectionView reloadData];
}
/**
 *  遍历所有是否全选
 */
- (void)isallSelectAllPrice
{
    for (NSArray * arr in self.modelArrs)
    {
        for (FootGoodsModel * model in arr)
        {
            if (!model.isSelect)
            {
//                self.bottomModel.isSelect = NO;
                return;
            }else
            {
//                self.bottomModel.isSelect = YES;
            }
        }
    }
}
- (void)shoppingCarHeaderViewDelegat:(UIButton *)bt WithHeadView:(FootHearModel *)view
{
    
    bt.selected = !bt.selected;
    NSInteger indexpath = bt.tag - 1000;
    FootHearModel *headModel = self.groupArrs[indexpath];
    NSArray *allSelectArr = self.modelArrs[indexpath];
    
    NSString * isS = @"0";
    if (bt.selected) {
        isS = @"1";
    }
    NSMutableDictionary * dict = [NSMutableDictionary new];
    dict = [self.newList[indexpath] mutableCopy];
    NSMutableArray * arr1 = [NSMutableArray new];
    arr1 = [[dict objectForKey:@"data"] mutableCopy];
    NSMutableArray * arr2 = [NSMutableArray new];
    for (int i=0; i<arr1.count; i++) {
        NSMutableDictionary * dic = [arr1[i] mutableCopy];
        [dic setObject:isS forKey:@"isSelect"];
        [arr2 addObject:dic];
    }
    [dict setObject:arr2 forKey:@"data"];
    [self.newList replaceObjectAtIndex:indexpath withObject:dict];
//    NSLog(@"修改后的数据%@",self.newList);
    
    if(bt.selected)
    {
        for (FootGoodsModel * model in allSelectArr)
        {
            model.isSelect = YES;
            headModel.isSelect = YES;
        }
    }else
    {
        for (FootGoodsModel * model in allSelectArr)
        {
            model.isSelect = NO;
            headModel.isSelect = NO;
        }
    }
    [self isallSelectAllPrice];
    [self.collectionView reloadData];
}
- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], SCREEN_HEIGHT-45, SCREEN_WIDTH-[Unity countcoordinatesW:20], 40)];
        [_deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _deleteBtn.layer.cornerRadius = 20;
        _deleteBtn.layer.masksToBounds = YES;
        _deleteBtn.backgroundColor = [Unity getColor:@"#aa112d"];
        _deleteBtn.hidden=YES;
    }
    return _deleteBtn;
}
- (void)deleteClick{
    //发送通知
//    NSDictionary *dict = @{@"deleteData":self.newList};
//    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"allDelete" object:nil userInfo:dict]];
    //数据线从服务器删除  服务器删除成功本地删除
    //遍历数组   统计被选中的id
    NSString * ids;
    for (int i=0; i<self.newList.count; i++) {
        NSDictionary * dict = [NSDictionary new];
        dict = self.newList[i];
        NSArray * arr = dict[@"data"];
        for (int j=0; j<arr.count; j++) {
            if ([[arr[j]objectForKey:@"isSelect"]isEqualToString:@"1"]) {
                if (ids==nil) {
                    ids = arr[j][@"ids"];
                }else{
                    ids = [ids stringByAppendingString:[NSString stringWithFormat:@",%@",arr[j][@"ids"]]];
                }
            }
        }
    }
    
    if (ids == nil) {
        return;
    }
    [Unity showanimate];
    NSDictionary * info = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSDictionary * param = @{@"user":info[@"w_email"],@"markids":ids};
    [GZMrequest postWithURLString:[GZMUrl get_deleteFoot_url] parameters:param success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([data[@"status"] intValue] == 1) {//删除成功
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"deleteSuccess" object:nil userInfo:nil]];
            NSLog(@"data=%@",data);
            NSMutableDictionary * dic = [NSMutableDictionary new];
            NSMutableArray * array = [NSMutableArray new];
            for (int i=0; i<self.newList.count; i++) {
                dic = [self.newList[i] mutableCopy];
                array  = [dic objectForKey:@"data"];
                for (int j=0; j<array.count; j++) {
                    if ([[array[j]objectForKey:@"isSelect"]isEqualToString:@"1"]) {
                        [array removeObjectAtIndex:j];
                        j=j-1;
                    }
                }
                if (array.count == 0) {
                    [self.newList removeObjectAtIndex:i];
                    i=i-1;
                }else{
                    [dic setObject:array forKey:@"data"];
                    [self.newList replaceObjectAtIndex:i withObject:dic];
                }
            }
            [self loadModel:[self.newList copy]];
            //请求服务器 删除数据
            [self.collectionView reloadData];
        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
    }];
}
- (void)requestFootData:(NSInteger)pageindex Type:(NSString *)type{
    NSDictionary * info = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"page":[NSString stringWithFormat:@"%ld",(long)pageindex],@"pagesize":@"12",@"user":info[@"w_email"],@"ymd":xzDate};
    [GZMrequest getWithURLString:[GZMUrl get_selectFootData_url] parameters:dic success:^(NSDictionary *data) {
        NSLog(@"%@",data);
        if ([data[@"status"] intValue] == 1) {
            page = page+1;
            if ([type isEqualToString:@"up"]) {
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView.mj_footer resetNoMoreData];
                [self.newList removeAllObjects];
            }else{
                [self.collectionView.mj_footer endRefreshing];
            }
            if ([data[@"data"][@"data"] count] < 12) {
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                [WHToast showMessage:@"没有更多数据" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            }
            //按日期分组
            for (int i=0; i<[data[@"data"][@"data"] count]; i++) {
                NSMutableDictionary * dict = [NSMutableDictionary new];
                NSMutableDictionary * dictt = [NSMutableDictionary new];
                NSMutableArray * arr = [NSMutableArray new];//data 数组 存商品集合
                if (self.newList.count == 0) {
                    [dict setObject:[self dateRectification:data[@"data"][@"data"][i][@"read_time"]] forKey:@"days"];
                    if ([Unity dictionaryWithJsonString:data[@"data"][@"data"][i][@"goods_img"]] == nil) {
                        [dictt setObject:data[@"data"][@"data"][i][@"goods_img"] forKey:@"image"];
                    }else{
                        NSArray * arr1 = [[Unity dictionaryWithJsonString:data[@"data"][@"data"][i][@"goods_img"]] allKeys];
                        NSString * img = [Unity dictionaryWithJsonString:data[@"data"][@"data"][i][@"goods_img"]][arr1[0]];
                        [dictt setObject:img forKey:@"image"];
                    }
                    [dictt setObject:data[@"data"][@"data"][i][@"source"] forKey:@"source"];
                    [dictt setObject:data[@"data"][@"data"][i][@"over_time"] forKey:@"over_time"];
                    [dictt setObject:data[@"data"][@"data"][i][@"goods_name"] forKey:@"name"];
                    [dictt setObject:[data[@"data"][@"data"][i][@"id"] stringValue] forKey:@"ids"];
                    [dictt setObject:data[@"data"][@"data"][i][@"goods_url"] forKey:@"goods_url"];
                    [dictt setObject:data[@"data"][@"data"][i][@"auction_id"] forKey:@"auction_id"];
                    [dictt setObject:@"0" forKey:@"isSelect"];
                    [arr addObject:dictt];
                    [dict setObject:arr forKey:@"data"];
                    [self.newList addObject:dict];
                    
                }else{
                    dict = [self.newList[self.newList.count-1] mutableCopy];
                    if ([dict[@"days"] isEqualToString:[self dateRectification:data[@"data"][@"data"][i][@"read_time"]]]) {
                        arr = [dict[@"data"] mutableCopy];
                        if ([Unity dictionaryWithJsonString:data[@"data"][@"data"][i][@"goods_img"]] == nil) {
                            [dictt setObject:data[@"data"][@"data"][i][@"goods_img"] forKey:@"image"];
                        }else{
                            NSArray * arr1 = [[Unity dictionaryWithJsonString:data[@"data"][@"data"][i][@"goods_img"]] allKeys];
                            NSString * img = [Unity dictionaryWithJsonString:data[@"data"][@"data"][i][@"goods_img"]][arr1[0]];
                            [dictt setObject:img forKey:@"image"];
                        }
                        [dictt setObject:data[@"data"][@"data"][i][@"source"] forKey:@"source"];
                        [dictt setObject:data[@"data"][@"data"][i][@"over_time"] forKey:@"over_time"];
                        [dictt setObject:data[@"data"][@"data"][i][@"goods_name"] forKey:@"name"];
                        [dictt setObject:[data[@"data"][@"data"][i][@"id"] stringValue] forKey:@"ids"];
                        [dictt setObject:data[@"data"][@"data"][i][@"goods_url"] forKey:@"goods_url"];
                        [dictt setObject:data[@"data"][@"data"][i][@"auction_id"] forKey:@"auction_id"];
                        [dictt setObject:@"0" forKey:@"isSelect"];
                        [arr addObject:dictt];
                        [dict setObject:arr forKey:@"data"];
                        [self.newList replaceObjectAtIndex:self.newList.count-1 withObject:dict];
                    }else{
                        [dict setObject:[self dateRectification:data[@"data"][@"data"][i][@"read_time"]] forKey:@"days"];
                        if ([Unity dictionaryWithJsonString:data[@"data"][@"data"][i][@"goods_img"]] == nil) {
                            [dictt setObject:data[@"data"][@"data"][i][@"goods_img"] forKey:@"image"];
                        }else{
                            NSArray * arr1 = [[Unity dictionaryWithJsonString:data[@"data"][@"data"][i][@"goods_img"]] allKeys];
                            NSString * img = [Unity dictionaryWithJsonString:data[@"data"][@"data"][i][@"goods_img"]][arr1[0]];
                            [dictt setObject:img forKey:@"image"];
                        }
                        
                        [dictt setObject:data[@"data"][@"data"][i][@"source"] forKey:@"source"];
                        [dictt setObject:data[@"data"][@"data"][i][@"over_time"] forKey:@"over_time"];
                        [dictt setObject:data[@"data"][@"data"][i][@"goods_name"] forKey:@"name"];
                        [dictt setObject:[data[@"data"][@"data"][i][@"id"] stringValue] forKey:@"ids"];
                        [dictt setObject:data[@"data"][@"data"][i][@"goods_url"] forKey:@"goods_url"];
                        [dictt setObject:data[@"data"][@"data"][i][@"auction_id"] forKey:@"auction_id"];
                        [dictt setObject:@"0" forKey:@"isSelect"];
                        [arr addObject:dictt];
                        [dict setObject:arr forKey:@"data"];
                        [self.newList addObject:dict];
                    }
                }
            }
            [self loadModel:self.newList];
            [self.collectionView reloadData];
        }else{
            
        }
    } failure:^(NSError *error) {
        
    }];
}
- (NSMutableArray *)newList{
    if (!_newList) {
        _newList = [NSMutableArray new];
    }
    return _newList;
}
- (NSString *)dateRectification:(NSString *)date{
    NSArray * arr = [date componentsSeparatedByString:@" "];
    NSArray * arr1 = [arr[0] componentsSeparatedByString:@"-"];
    int mm = [arr1[1] intValue];
    int dd = [arr1[2] intValue];
    return [NSString stringWithFormat:@"%d月%d日",mm,dd];
}
- (void)loadModel:(NSArray *)arr{
    //    _carLists = dict[@"shoppingCar"];
    
    NSMutableArray * modelArrs = [NSMutableArray array];
    for (NSDictionary * dict in arr)
    {
        NSMutableArray * modelArr = [FootGoodsModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        
        [modelArrs addObject:modelArr];
    }
    self.modelArrs = modelArrs;
    NSMutableArray * groupArrs = [FootHearModel mj_objectArrayWithKeyValuesArray:arr];
    self.groupArrs = groupArrs;
}
- (NSMutableArray *)modelArrs{
    if (!_modelArrs) {
        _modelArrs = [NSMutableArray new];
    }
    return _modelArrs;
}
- (NSMutableArray *)groupArrs{
    if (!_groupArrs) {
        _groupArrs = [NSMutableArray new];
    }
    return _groupArrs;
}
- (void)oneDelete{
    
    NSLog(@"选中 %@",self.newList[dSection][@"data"][dRow][@"ids"]);
    NSString * idsStr = self.newList[dSection][@"data"][dRow][@"ids"];
    [Unity showanimate];
    NSDictionary * info = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSDictionary * param = @{@"user":info[@"w_email"],@"markids":idsStr};
    [GZMrequest postWithURLString:[GZMUrl get_deleteFoot_url] parameters:param success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([data[@"status"] intValue] == 1) {//删除成功
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"deleteSuccess" object:nil userInfo:nil]];
            NSLog(@"data=%@",data);
            NSMutableDictionary * dic = [NSMutableDictionary new];
            NSMutableArray * array = [NSMutableArray new];
            for (int i=0; i<self.newList.count; i++) {
                dic = [self.newList[i] mutableCopy];
                array  = [dic objectForKey:@"data"];
                for (int j=0; j<array.count; j++) {
                    if ([[array[j]objectForKey:@"ids"]isEqualToString:idsStr]) {
                        [array removeObjectAtIndex:j];
                        j=j-1;
                    }
                }
                if (array.count == 0) {
                    [self.newList removeObjectAtIndex:i];
                    i=i-1;
                }else{
                    [dic setObject:array forKey:@"data"];
                    [self.newList replaceObjectAtIndex:i withObject:dic];
                }
            }
            [self loadModel:[self.newList copy]];
            //请求服务器 删除数据
            [self.collectionView reloadData];
        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
    }];
}
- (void)collection{
    NSDictionary * info = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSString * area = @"";
    if ([self.newList[dSection][@"data"][dRow][@"source"] isEqualToString:@"yahoo"]) {
        area = @"0";
    }else{
        area = @"1";
    }
    NSDictionary * dic = @{@"customer":info[@"w_email"],@"area":area,@"type":@"goods",@"w_object":self.newList[dSection][@"data"][dRow][@"name"],@"w_link":self.newList[dSection][@"data"][dRow][@"goods_url"],@"w_overtime":self.newList[dSection][@"data"][dRow][@"over_time"],@"w_jpnid":self.newList[dSection][@"data"][dRow][@"ids"],@"w_imgsrc":self.newList[dSection][@"data"][dRow][@"image"],@"w_tag":@""};
    [Unity showanimate];
    [GZMrequest postWithURLString:[GZMUrl get_collection_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }else{
            [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];

}
@end
