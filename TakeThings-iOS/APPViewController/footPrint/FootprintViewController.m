//
//  FootprintViewController.m
//  GlobalBuyer
//
//  Created by 桂在明 on 2019/5/6.
//  Copyright © 2019 薛铭. All rights reserved.
//

#import "FootprintViewController.h"
#import "LTSCalendar/LTSCalendarManager.h"
#import "FootView.h"
#import "FootGoodsModel.h"
#import "FootHearModel.h"
#import <MJExtension.h>
#import "NewYahooDetailViewController.h"
#import "NewEbayDetailViewcontroller.h"
@interface FootprintViewController ()<LTSCalendarEventSource,FootViewDelegate>
{
    NSMutableDictionary *eventsByDate;
    NSArray *  arr;
    BOOL isDelete;//yes 编辑状态  no初始化
    NSString * sec;
    NSString * index;
}
@property (nonatomic,strong)LTSCalendarManager *manager;

@property (nonatomic , strong) UIButton * leftBtn;
@property (nonatomic , strong) UIButton * rightBtn;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UIButton * deleteBtn;

@property (nonatomic , strong) FootView * footView;
@property (nonatomic , strong) NSMutableArray * mutableList;
/**
 *  数据模型数组
 */
@property(nonatomic,strong) NSMutableArray * modelArrs;
/**
 *  组数据模型
 */
@property(nonatomic,strong) NSMutableArray * groupArrs;

@end

@implementation FootprintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册通知：
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(singleDelete:) name:@"singleDelete" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(allDelete) name:@"deleteSuccess" object:nil];
    //实现监听方法
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openDetail:) name:@"openDetail" object:nil];
    isDelete = NO;
    arr = @[
            @{@"days":@"5月6日",@"data":@[@{@"image":@"",@"name":@"非经典款沙拉酱付款大连市静安看了非经典款啦记录",@"isSelect":@"0"}]},
  @{@"days":@"4月17日",@"data":@[@{@"image":@"",@"name":@"非经典款沙拉酱付款大连市静安看了非经典款啦记录",@"isSelect":@"0"}]},
  @{@"days":@"4月8日",@"data":@[@{@"image":@"",@"name":@"非经典款沙拉酱付款大连市静安看了非经典款啦记录",@"isSelect":@"0"},@{@"image":@"",@"name":@"非经典款沙拉酱付款大连市静安看了非经典款啦记录",@"isSelect":@"0"},@{@"image":@"",@"name":@"非经典款沙拉酱付款大连市静安看了非经典款啦记录",@"isSelect":@"0"},@{@"image":@"",@"name":@"非经典款沙拉酱付款大连市静安看了非经典款啦记录",@"isSelect":@"0"}]},
  @{@"days":@"4月1日",@"data":@[@{@"image":@"",@"name":@"非经典款沙拉酱付款大连市静安看了非经典款啦记录",@"isSelect":@"0"},@{@"image":@"",@"name":@"非经典款沙拉酱付款大连市静安看了非经典款啦记录",@"isSelect":@"0"},@{@"image":@"",@"name":@"非经典款沙拉酱付款大连市静安看了非经典款啦记录",@"isSelect":@"0"}]}
  ];
    self.mutableList = [arr mutableCopy];
//    [self loadModel:arr];
    [self lts_InitUI];
    [self requestDate];//请求红点日期
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
-(void)singleDelete:(NSNotification *)notification
{
    [self.footView showFootView];
}
-(void)allDelete{
    [self requestDate];
//    //移除通知
//    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loadH5code" object:self];
//    self.mutableList = notification.userInfo[@"deleteData"];
//    NSMutableDictionary * dic = [NSMutableDictionary new];
//    NSMutableArray * array = [NSMutableArray new];
//    for (int i=0; i<self.mutableList.count; i++) {
//        dic = [self.mutableList[i] mutableCopy];
//        array  = [dic objectForKey:@"data"];
//        for (int j=0; j<array.count; j++) {
//            if ([[array[j]objectForKey:@"isSelect"]isEqualToString:@"1"]) {
//                [array removeObjectAtIndex:j];
//                j=j-1;
//            }
//        }
//        if (array.count == 0) {
//            [self.mutableList removeObjectAtIndex:i];
//            i=i-1;
//        }else{
//            [dic setObject:array forKey:@"data"];
//            [self.mutableList replaceObjectAtIndex:i withObject:dic];
//        }
//    }
//    [self loadModel:[self.mutableList copy]];
//    self.manager.calenderScrollView.groupArrs = self.groupArrs;
//    self.manager.calenderScrollView.modelArrs = self.modelArrs;
//    [self.manager.calenderScrollView.collectionView reloadData];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"足迹";
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    view.backgroundColor = [UIColor clearColor];
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn.frame = CGRectMake(0, 0, 44, 44);
    [self.deleteBtn setTitle:@"" forState:UIControlStateNormal];
    [self.deleteBtn setTitle:@"完成" forState:UIControlStateSelected];
    [self.deleteBtn setTitleColor:LabelColor3 forState:UIControlStateSelected];
//    [self.deleteBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.deleteBtn setImage:[UIImage imageNamed:@"多删"] forState:UIControlStateNormal];
//    [self.deleteBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    [self.deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    self.deleteBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.deleteBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5 * SCREEN_WIDTH / 375.0)];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.deleteBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;;
}
- (UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-63, 8, 8, 14)];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"footleft"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-45, 0, 90, 30)];
        _titleL.font = [UIFont systemFontOfSize:14];
        _titleL.textAlignment = NSTextAlignmentCenter;
        _titleL.textColor = [Unity getColor:@"#333333"];
    }
    return  _titleL;
}
- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(_titleL.right+10, 8, 8, 14)];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"footright"] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
- (void)lts_InitUI{
    [self.view addSubview:self.leftBtn];
    [self.view addSubview:self.titleL];
    [self.view addSubview:self.rightBtn];
    
    self.manager = [LTSCalendarManager new];
    self.manager.eventSource = self;
    self.manager.weekDayView = [[LTSCalendarWeekDayView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 30)];
    [self.view addSubview:self.manager.weekDayView];
    
    self.manager.calenderScrollView = [[LTSCalendarScrollView alloc] initWithFrame:CGRectMake(0, self.manager.weekDayView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-self.manager.weekDayView.height-30)];
//    self.manager.calenderScrollView.delegate = self;
    [self.view addSubview:self.manager.calenderScrollView];
    [self.manager.calenderScrollView scrollToAllWeek];//默认显示月
//    self.manager.calenderScrollView.listArray = [arr mutableCopy];
//    self.manager.calenderScrollView.modelArrs = self.modelArrs;
//    self.manager.calenderScrollView.groupArrs = self.groupArrs;
//    [self createRandomEvents];
    self.automaticallyAdjustsScrollViewInsets = false;
}
//创建红点
- (void)createRandomEvents:(NSMutableArray *)arr
{
//    NSArray * arr1= @[@"2019.09.20",@"2019.09.23",@"2019.09.24"];
    eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < arr.count; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = arr[i];
        //        [[self dateFormatter] stringFromDate:randomDate];
//        NSLog(@"%@",key);
        if(!eventsByDate[key]){
            eventsByDate[key] = [NSMutableArray new];
        }
        
        [eventsByDate[key] addObject:randomDate];
    }
    [self.manager reloadAppearanceAndData];
}
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy.MM.dd";
    }
    
    return dateFormatter;
}
// 该日期是否有事件
- (BOOL)calendarHaveEventWithDate:(NSDate *)date {
    
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(eventsByDate[key] && [eventsByDate[key] count] > 0){
        return YES;
    }
    return NO;
}
//当前 选中的日期  执行的方法
- (void)calendarDidSelectedDate:(NSDate *)date {
    
    NSString *key = [[self dateFormatter] stringFromDate:date];
    //    self.label.text =  key;
//    NSLog(@"data=%@",key);
    NSString *string =key;
    NSArray *array = [string componentsSeparatedByString:@"."]; //从字符A中分隔成2个元素的数组
    NSString * dd = [NSString stringWithFormat:@"%@年%d月",array[0],[array[1] intValue]];
    self.titleL.text = dd;
    NSArray *events = eventsByDate[key];
//    NSLog(@"===%@",date);
    if (events.count>0) {
//        [self.mutableList removeAllObjects];
//        [self.mutableList addObject:arr[0]];
//        self.manager.calenderScrollView.listArray = self.mutableList;
//        [self loadModel:[self.mutableList copy]];
//        self.manager.calenderScrollView.groupArrs = self.groupArrs;
//        self.manager.calenderScrollView.modelArrs = self.modelArrs;
//        //该日期有事件    tableView 加载数据
//        [self.manager.calenderScrollView.collectionView reloadData];
        NSString * rq = [NSString stringWithFormat:@"%@-%@-%@",array[0],array[1],array[2]];\
        NSDictionary * dic = @{@"key":rq};
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"seletedDate" object:nil userInfo:dic]];
//        NSLog(@"该日期有事件    collectionView 加载数据");
    }
}
- (void)leftClick{
    [self.manager loadPreviousPage];
}
- (void)rightClick{
    [self.manager loadNextPage];
}
- (void)deleteClick{
    NSDictionary * dic = [[NSDictionary alloc]init];
    if (isDelete) {
        dic = @{@"key":@"0"};
        self.manager.calenderScrollView.listArray = [arr mutableCopy];
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"footEdit" object:nil userInfo:dic]];
        isDelete = NO;
        self.deleteBtn.selected = NO;
        [self.deleteBtn setImage:[UIImage imageNamed:@"多删"] forState:UIControlStateNormal];
    }else{
        //编辑状态显示全部数据
        dic = @{@"key":@"1"};
        self.manager.calenderScrollView.listArray = [arr mutableCopy];
         [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"footEdit" object:nil userInfo:dic]];
//        [self.manager.calenderScrollView.collectionView reloadData];
       
        isDelete = YES;
        self.deleteBtn.selected = YES;
        [self.deleteBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
}
- (FootView *)footView{
    if (!_footView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _footView = [FootView setFootView:window];
        _footView.delegate = self;
    }
    return _footView;
}
- (void)footCollection{
//    NSLog(@"收藏");
    [self.footView hiddenFootView];
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"collection" object:nil userInfo:nil]];
}
- (void)footDelete{
    [self.footView hiddenFootView];
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"danshan" object:nil userInfo:nil]];
    
//    NSMutableArray * mutable = [NSMutableArray new];
//    mutable = [[self.mutableList[[sec intValue]] objectForKey:@"data"] mutableCopy];
//    [mutable removeObjectAtIndex:[sec intValue]];
//    if (mutable.count == 0) {
//        [self.mutableList removeObjectAtIndex:[sec intValue]];
//    }else{
//        NSMutableDictionary * dic = [NSMutableDictionary new];
//        dic = [self.mutableList[[sec intValue]] mutableCopy];
//        [dic setObject:mutable forKey:@"data"];
//        [self.mutableList replaceObjectAtIndex:[sec intValue] withObject:dic];
//    }
//    self.manager.calenderScrollView.listArray = self.mutableList;
//    [self loadModel:[self.mutableList copy]];
//    self.manager.calenderScrollView.groupArrs = self.groupArrs;
//    self.manager.calenderScrollView.modelArrs = self.modelArrs;
//    //该日期有事件    tableView 加载数据
//    [self.manager.calenderScrollView.collectionView reloadData];
}
- (NSMutableArray *)mutableList{
    if (!_mutableList) {
        _mutableList = [NSMutableArray new];
    }
    return _mutableList;
}
- (void)requestDate{
    NSDictionary *info = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"user":info[@"w_email"]};
    [GZMrequest getWithURLString:[GZMUrl get_footDate_url] parameters:dic success:^(NSDictionary *data) {
        NSLog(@"riqi%@",data);
        if ([data[@"status"]intValue] == 1) {
            NSMutableArray * mutableArr = [NSMutableArray new];
            NSArray * arr = [data[@"data"] allKeys];
            for (int i=0; i < arr.count; i++) {
                for (int j=0 ; j < [data[@"data"][arr[i]] count]; j++) {
                    [mutableArr addObject:[NSString stringWithFormat:@"%@.%@",[arr[i] stringByReplacingOccurrencesOfString:@"-" withString:@"."],data[@"data"][arr[i]][j]]];
                }
                
            }
            NSLog(@"%@",mutableArr);
            [self createRandomEvents:mutableArr];
        }
        
    } failure:^(NSError *error) {
        
    }];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.manager.calenderScrollView.deleteBtn.hidden = YES;
}
- (void)openDetail:(NSNotification *)notification{
    NSLog(@"%@",notification.userInfo);
    if ([notification.userInfo[@"source"] isEqualToString:@"yahoo"]) {
        NewYahooDetailViewController * nvc = [[NewYahooDetailViewController alloc]init];
        nvc.item = notification.userInfo[@"auction_id"];
        nvc.platform = @"0";
        [self.navigationController pushViewController:nvc animated:YES];
    }else{
        NewEbayDetailViewController * nvc = [[NewEbayDetailViewController alloc]init];
        nvc.item = notification.userInfo[@"auction_id"];
        nvc.platform = @"5";
        [self.navigationController pushViewController:nvc animated:YES];
    }
}
//- (void)withOfDeleteSection:(NSInteger)section IndexPath:(NSInteger)indexPath{
//    NSLog(@"第%ldsection中的第%ld cell",section,indexPath);
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
