//
//  InterestViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/30.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "InterestViewController.h"
#import "InterestCell.h"
#import "InterestReusableView.h"
#define ICellIdentifier @"CellIdentifier"
@interface InterestViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSDictionary * userInfo;
}
@property (nonatomic , strong) UICollectionView * collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout * flowLayout;

@property (nonatomic , strong) UIButton * confirmBtn;
@property (nonatomic , strong) NSMutableArray * listArray;
@property (nonatomic , strong) NSMutableArray * selectArray;
@property (nonatomic , strong) NSMutableArray * newArray;
@end

@implementation InterestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.confirmBtn];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"感兴趣的分类";
    userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    [self addLeftBarButtonWithImage:[UIImage imageNamed:@"back"] action:@selector(back)];
}
- (void)back{
    if (self.backIndex == 1) {
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)addLeftBarButtonWithImage:(UIImage *)image action:(SEL)action
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    view.backgroundColor = [UIColor clearColor];
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.frame = CGRectMake(0, 0, 44, 44);
    [firstButton setImage:image forState:UIControlStateNormal];
    [firstButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    firstButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0, 5 * SCREEN_WIDTH / 375.0, 0, 0)];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:firstButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}
- (UIButton *)confirmBtn{
    if (_confirmBtn == nil) {
        _confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], SCREEN_HEIGHT-NavBarHeight-[Unity countcoordinatesH:60], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        [_confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.layer.cornerRadius = [Unity countcoordinatesH:20];
        _confirmBtn.backgroundColor = [Unity getColor:@"#cb6d7f"];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_confirmBtn setTitleColor:[Unity getColor:@"#ffffff"] forState:UIControlStateNormal];
        _confirmBtn.userInteractionEnabled = NO;
        _confirmBtn.hidden = YES;
    }
    return _confirmBtn;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-[Unity countcoordinatesH:70]) collectionViewLayout:self.flowLayout];
        self.flowLayout.minimumLineSpacing = 10;
        self.flowLayout.minimumInteritemSpacing = 0;
        if (@available(iOS 9.0, *)) {
            self.flowLayout.sectionHeadersPinToVisibleBounds = true;
        } else {
            // Fallback on earlier versions
        }
        //设置header大小
        self.flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, [Unity countcoordinatesH:50]);
        
        self.flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/3,[Unity countcoordinatesH:120]);
        self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.allowsMultipleSelection = YES;//允许多选
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[InterestCell class] forCellWithReuseIdentifier:ICellIdentifier];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[InterestReusableView class]
                 forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                        withReuseIdentifier:@"InterestReusableView"];
        
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //进行数据刷新操作
            [self requestInterestData];
        }];
        
        // 马上进入刷新状态
        [_collectionView.mj_header beginRefreshing];
        
    }
    return _collectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.listArray.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    InterestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ICellIdentifier forIndexPath:indexPath];

    NSInteger index=0;
    for (int i=0; i<self.selectArray.count; i++) {
        if ([self.selectArray[i] isEqualToString:self.listArray[indexPath.row][@"id"]]) {
            index = index+1;
            cell.selected = YES;
            break;
        }
    }
    if (index == 0) {
        cell.maskV.hidden=YES;//未选中
    }else{
        cell.maskV.hidden=NO;//选中
        [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }
    [cell configInterestDataImage:self.listArray[indexPath.row][@"src"] WithTitle:self.listArray[indexPath.row][@"name"]];
    return cell;
}

#pragma mark -

//collView学名是集合视图  tableView是表视图

//collView中的foot header 是曽补视图



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
        InterestReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"InterestReusableView" forIndexPath:indexPath];
        
        reusableView.backgroundColor = [UIColor whiteColor];
        return reusableView;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //根据idenxPath获取对应的cell
    InterestCell *cell = (InterestCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.maskV.hidden=NO;//选中
    [self.selectArray addObject:self.listArray[indexPath.row][@"id"]];
    [self checkButton];
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    InterestCell *cell = (InterestCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.maskV.hidden=YES;//未选中
    for (int i=0; i<self.selectArray.count; i++) {
        if ([self.selectArray[i] intValue] == [self.listArray[indexPath.row][@"id"]intValue]) {
            [self.selectArray removeObjectAtIndex:i];
            i--;
        }
    }
    [self checkButton];
}
//确定
- (void)confirmClick{
    NSLog(@"%@",self.selectArray);
    if (self.selectArray.count == 0) {
        [WHToast showMessage:@"至少选1项" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        return;
    }
    NSString * idsStr= @"";
    for (int i=0; i<self.selectArray.count; i++) {
        if ([idsStr isEqualToString:@""]) {
            idsStr = self.selectArray[i];
        }else{
            idsStr = [idsStr stringByAppendingString:[NSString stringWithFormat:@",%@",self.selectArray[i]]];
        }
    }
    [Unity showanimate];
    NSDictionary * dic = @{@"customer":userInfo[@"member_id"],@"interest":idsStr};
    [GZMrequest postWithURLString:[GZMUrl get_subInterest_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            if (self.backIndex == 1) {
                NSInteger index = (NSInteger)[[self.navigationController viewControllers] indexOfObject:self];
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index-3)] animated:YES];
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"请求超时" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (void)requestInterestData{
    [self.listArray removeAllObjects];
    [self.selectArray removeAllObjects];
    NSDictionary * dic = @{@"customer":userInfo[@"member_id"]};
    [GZMrequest getWithURLString:[GZMUrl get_interest_url] parameters:dic success:^(NSDictionary *data) {
        NSLog(@"%@",data);
        [self.collectionView.mj_header endRefreshing];
        [self.listArray removeAllObjects];
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            for (int i=0; i<[data[@"data"][@"interest"] count]; i++) {
                [self.listArray addObject:data[@"data"][@"interest"][i]];
            }
            for (int i=0; i<[data[@"data"][@"member"] count]; i++) {
                if (![data[@"data"][@"member"][i] isEqualToString:@""]) {
                    [self.selectArray addObject:data[@"data"][@"member"][i]];
                    [self.newArray addObject:data[@"data"][@"member"][i]];
                }
            }
            [self.collectionView reloadData];
            self.confirmBtn.hidden = NO;
        }else{
            [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [NSMutableArray new];
    }
    return _listArray;
}
- (NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [NSMutableArray new];
    }
    return _selectArray;
}
- (NSMutableArray *)newArray{
    if (!_newArray) {
        _newArray = [NSMutableArray new];
    }
    return _newArray;
}
- (void)checkButton{
    if ([self isEqualArray:self.newArray WithSelectArr:self.selectArray] || self.selectArray.count ==0) {
        self.confirmBtn.backgroundColor = [Unity getColor:@"cb6d7f"];
        self.confirmBtn.userInteractionEnabled = NO;
    }else{
        self.confirmBtn.backgroundColor = [Unity getColor:@"aa112d"];
        self.confirmBtn.userInteractionEnabled = YES;
    }
    
}
- (BOOL)isEqualArray:(NSMutableArray *)newArr WithSelectArr:(NSMutableArray *)selectArr{
    bool bol = false;
    [newArr sortUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 localizedStandardCompare: obj2];
        
    }];
    if (newArr.count == selectArr.count) {
        bol = true;
        for (int16_t i = 0; i < selectArr.count; i++) {
            id c1 = [selectArr objectAtIndex:i];
            id newc = [newArr objectAtIndex:i];
            if (![newc isEqualToString:c1]) {
                bol = false;break;
            }
        }
    }
    if (bol){
//        NSLog(@"两个数组的内容相同！");
        return YES;
    }else {
//        NSLog(@"两个数组的内容不相同！");
        return NO;
    }
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
