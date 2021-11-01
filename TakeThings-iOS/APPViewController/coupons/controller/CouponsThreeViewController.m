//
//  CouponsThreeViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/7/10.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "CouponsThreeViewController.h"
#import "CouponsCell.h"
@interface CouponsThreeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableDictionary * dic;
    NSArray * arr;
}
@property (nonatomic,strong)UITableView * tableView;

@end

@implementation CouponsThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary* dict = @{@"0":@"0",@"1":@"0"};
    dic = [dict mutableCopy];
    arr = @[@"20",@"5"];
    [self createUI];
}
- (void)createUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-[Unity countcoordinatesH:40]) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = FALSE;
    self.tableView.showsHorizontalScrollIndicator = FALSE;
    [self.tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    //没有数据时不显示cell
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.estimatedRowHeight = 0;
    }
}

//section个数
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [Unity countcoordinatesH:115];
}
//sectionview
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]init];
    view.tag = section;
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:105], [Unity countcoordinatesH:105])];
    imageView.image = [UIImage imageNamed:@"grayRRR"];
    [view addSubview:imageView];
    UIImageView * imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(imageView.right, [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:125], [Unity countcoordinatesH:105])];
    imageView1.image = [UIImage imageNamed:@"grayLRR"];
    imageView1.userInteractionEnabled = YES;
    [view addSubview:imageView1];
    UIImageView * tbImg = [[UIImageView alloc]initWithFrame:CGRectMake(imageView1.width-[Unity countcoordinatesW:20.5], [Unity countcoordinatesH:87.5], [Unity countcoordinatesW:10.5], [Unity countcoordinatesH:5])];
    tbImg.image = [UIImage imageNamed:@"下拉"];
    [imageView1 addSubview:tbImg];
    NSString * str = [NSString stringWithFormat:@"%ld",(long)section];
    if ([dic[str]isEqualToString:@"1"]) {
        imageView.image = [UIImage imageNamed:@"grayRR"];
        imageView1.image = [UIImage imageNamed:@"grayLR"];
        tbImg.image = [UIImage imageNamed:@"上拉"];
    }
    UILabel * rmbL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:7], [Unity countcoordinatesH:7], 50, [Unity countcoordinatesH:15])];
    rmbL.text = @"RMB";
    rmbL.textColor = [UIColor whiteColor];
    rmbL.font = [UIFont systemFontOfSize:FontSize(12)];
    [imageView addSubview:rmbL];
    UILabel * placeL = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:23], [Unity countcoordinatesW:105], [Unity countcoordinatesH:50])];
    placeL.text = arr[section];
    placeL.textColor = [UIColor whiteColor];
    placeL.font = [UIFont systemFontOfSize:FontSize(49)];
    placeL.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:placeL];
    UILabel * markL = [[UILabel alloc]initWithFrame:CGRectMake(0, placeL.bottom, placeL.width, [Unity countcoordinatesH:15])];
    markL.text = @"无门槛使用";
    markL.textColor = [UIColor whiteColor];
    markL.font = [UIFont systemFontOfSize:FontSize(12)];
    markL.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:markL];
    
    UILabel * titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], 100, [Unity countcoordinatesH:20])];
    titleL.text = @"代工费";
    titleL.textColor = LabelColor9;
    titleL.font = [UIFont systemFontOfSize:FontSize(16)];
    [imageView1 addSubview:titleL];
    
    UILabel * timeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], titleL.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:125], [Unity countcoordinatesH:15])];
    timeL.text = @"2019.05.02-2019.06.02";
    timeL.textColor = LabelColor9;
    timeL.font = [UIFont systemFontOfSize:FontSize(12)];
    [imageView1 addSubview:timeL];
    
    UILabel * guoqi = [[UILabel alloc]initWithFrame:CGRectMake(imageView1.width-[Unity countcoordinatesW:60], timeL.top-[Unity countcoordinatesH:2.5],[Unity countcoordinatesW:50], [Unity countcoordinatesH:20])];
    guoqi.text = @"已过期";
    guoqi.textColor = LabelColor6;
    guoqi.font = [UIFont systemFontOfSize:FontSize(14)];
    guoqi.textAlignment = NSTextAlignmentRight;
    [imageView1 addSubview:guoqi];
    
    UILabel * shuom = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:82.5], 100, [Unity countcoordinatesH:15])];
    shuom.text = @"使用说明";
    shuom.textColor = LabelColor9;
    shuom.font = [UIFont systemFontOfSize:FontSize(12)];
    [imageView1 addSubview:shuom];
    
    
    UITapGestureRecognizer *singleTap =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerView:)];
    singleTap.numberOfTapsRequired = 1; //点击次数
    singleTap.numberOfTouchesRequired = 1; //点击手指数
    [view addGestureRecognizer:singleTap];
    return view;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //zhankai
    NSString * str = [NSString stringWithFormat:@"%ld",(long)section];
    if ([dic[str] isEqualToString:@"0"]) {
        return 0;
    }else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [Unity countcoordinatesH:0];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [Unity countcoordinatesH:65];//cell高度
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CouponsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CouponsCell class])];
    if (cell == nil) {
        cell = [[CouponsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CouponsCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configWithisRed:NO WithPlace:arr[indexPath.row]];
    return cell;
}
- (void)headerView:(UITapGestureRecognizer *)tapGesture{
    //    NSLog(@"%ld",tapGesture.view.tag);
    NSString * str = [NSString stringWithFormat:@"%ld",(long)tapGesture.view.tag];
    if ([dic[str]isEqualToString:@"0"]) {
        [dic setObject:@"1" forKey:str];
    }else{
        [dic setObject:@"0" forKey:str];
    }
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:tapGesture.view.tag];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
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
