//
//  CouponsOneViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/7/10.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "CouponsOneViewController.h"
#import "CouponsCell.h"
@interface CouponsOneViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    NSMutableDictionary * dic;
    NSArray * arr;
}
@property (nonatomic,strong)UITableView * tableView;
@end

@implementation CouponsOneViewController

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
    imageView.image = [UIImage imageNamed:@"redRRR"];
    [view addSubview:imageView];
    UIImageView * imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(imageView.right, [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:125], [Unity countcoordinatesH:105])];
    imageView1.image = [UIImage imageNamed:@"redLRR"];
    imageView1.userInteractionEnabled = YES;
    [view addSubview:imageView1];
    UIImageView * tbImg = [[UIImageView alloc]initWithFrame:CGRectMake(imageView1.width-[Unity countcoordinatesW:20.5], [Unity countcoordinatesH:87.5], [Unity countcoordinatesW:10.5], [Unity countcoordinatesH:5])];
    tbImg.image = [UIImage imageNamed:@"下拉"];
    [imageView1 addSubview:tbImg];
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(imageView1.width-1, [Unity countcoordinatesH:2.5], 1, [Unity countcoordinatesH:100])];
    line.backgroundColor = [Unity getColor:@"ffdcdc"];
    [imageView1 addSubview:line];
//    line.hidden =YES;
    NSString * str = [NSString stringWithFormat:@"%ld",(long)section];
    if ([dic[str]isEqualToString:@"1"]) {
        imageView.image = [UIImage imageNamed:@"redRR"];
        imageView1.image = [UIImage imageNamed:@"redLR"];
        tbImg.image = [UIImage imageNamed:@"上拉"];
        line.hidden =NO;
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
    titleL.textColor = LabelColor6;
    titleL.font = [UIFont systemFontOfSize:FontSize(16)];
    [imageView1 addSubview:titleL];
    
    UILabel * timeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], titleL.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:125], [Unity countcoordinatesH:15])];
    timeL.text = @"2019.06.02-2019.07.02";
    timeL.textColor = LabelColor3;
    timeL.font = [UIFont systemFontOfSize:FontSize(12)];
    [imageView1 addSubview:timeL];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(timeL.right, timeL.top-[Unity countcoordinatesH:2.5], [Unity countcoordinatesW:50], [Unity countcoordinatesH:20])];
    btn.tag = section;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"去使用" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    btn.layer.cornerRadius = btn.height/2;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = [Unity getColor:@"aa112d"];
    [imageView1 addSubview:btn];
    
    UILabel * shuom = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:82.5], 100, [Unity countcoordinatesH:15])];
    shuom.text = @"使用说明";
    shuom.textColor = LabelColor6;
    shuom.font = [UIFont systemFontOfSize:FontSize(12)];
    [imageView1 addSubview:shuom];
    
    
    UITapGestureRecognizer *singleTap =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerView:)];
    singleTap.delegate = self;
//    singleTap.cancelsTouchesInView = NO;
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
    [cell configWithisRed:YES WithPlace:arr[indexPath.row]];
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
- (void)buttonClick:(UIButton *)btn{
    NSLog(@"按钮%ld",(long)btn.tag);
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UIButton class]]) {
        //放过button点击拦截
        return NO;
    }else{
        return YES;
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
