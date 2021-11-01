//
//  CategoryViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/9/9.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString * category_id;
    NSDictionary * seletedDic;
}
@property (nonatomic , strong) UIView * navView;
@property (nonatomic , strong) UIButton * leftBtn;
@property (nonatomic , strong) UILabel * navL;
@property (nonatomic , strong) UILabel * lineL;

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) NSMutableArray * sectionArr;
@property (nonatomic , strong) NSMutableArray * rowArr;

@property (nonatomic , strong) UIButton * comfirmBtn;

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    category_id = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray * arr = @[@{@"cid":@"",@"title":@"全部"}];
    self.sectionArr = [arr mutableCopy];
    // Do any additional setup after loading the view.
    [self createUI];
    
    [self requestData:@""];
}
- (void)createUI{
    [self.view addSubview:self.navView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.comfirmBtn];
}
- (UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight)];
        _navView.backgroundColor = [UIColor whiteColor];
        
        [_navView addSubview:self.leftBtn];
        [_navView addSubview:self.navL];
        [_navView addSubview:self.lineL];
    }
    return _navView;
}
- (UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(12, NavBarHeight-44+7.5, 28.5, 28.5)];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"screenX"] forState:UIControlStateNormal];
        _leftBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_leftBtn addTarget:self action:@selector(exitClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _leftBtn;
}
- (UILabel *)navL{
    if (!_navL) {
        _navL = [[UILabel alloc]initWithFrame:CGRectMake(50, StatusBarHeight, SCREEN_WIDTH-100, 44)];
        _navL.text = @"选择分类";
        _navL.textColor = LabelColor3;
        _navL.font = [UIFont systemFontOfSize:17];
        _navL.textAlignment = NSTextAlignmentCenter;
    }
    return _navL;
}
- (UILabel *)lineL{
    if (!_lineL) {
        _lineL = [[UILabel alloc]initWithFrame:CGRectMake(0, NavBarHeight-1, SCREEN_WIDTH, 1)];
        _lineL.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _lineL;
}

- (UITableView  *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-bottomH-44) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate=self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = FALSE;
        _tableView.showsHorizontalScrollIndicator = FALSE;
//        [_tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        //没有数据时不显示cell
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}
#pragma mark - tableView  搭理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.sectionArr.count -1 == section) {
        return self.rowArr.count;
    }else{
       return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [Unity countcoordinatesH:40];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    // 对齐方式
    style.alignment = NSTextAlignmentJustified;
    // 首行缩进
    style.firstLineHeadIndent = [Unity countcoordinatesW:20.0f];
    // 头部缩进
    style.headIndent = [Unity countcoordinatesW:20.0f];
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:self.rowArr[indexPath.row][@"title"] attributes:@{ NSParagraphStyleAttributeName : style}];
    cell.textLabel.attributedText = attrText;
    
    cell.textLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    cell.textLabel.textColor = LabelColor3;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
    //防止越界
    if (self.rowArr.count-1 < indexPath.row) {
        return;
    }
    NSMutableDictionary * dic = [NSMutableDictionary new];
    [dic setObject:self.rowArr[indexPath.row][@"cid"] forKey:@"cid"];
    [dic setObject:self.rowArr[indexPath.row][@"title"] forKey:@"title"];
    [self.sectionArr addObject:dic];
    
    [self requestData:self.rowArr[indexPath.row][@"cid"]];
    
    //调整tableview  显示确定按钮
//    self.tableView.frame = CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight-bottomH);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [Unity countcoordinatesH:40];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.tag = section;
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(login_register:)];
    singleTap.numberOfTapsRequired = 1; //点击次数
    singleTap.numberOfTouchesRequired = 1; //点击手指数
    [view addGestureRecognizer:singleTap];
    
    view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, SCREEN_WIDTH-[Unity countcoordinatesW:50], [Unity countcoordinatesH:40])];
//    label.backgroundColor = [UIColor yellowColor];
    label.text = self.sectionArr[section][@"title"];
    label.font = [UIFont systemFontOfSize:FontSize(17)];
    label.textColor = LabelColor6;
    [view addSubview:label];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:25], [Unity countcoordinatesH:33/2], [Unity countcoordinatesW:15], [Unity countcoordinatesH:7])];
    [view addSubview:imageView];
    if (section != 0) {
        label.frame = CGRectMake([Unity countcoordinatesW:20], 0, SCREEN_WIDTH-[Unity countcoordinatesW:60], [Unity countcoordinatesH:40]);
        label.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    if (self.sectionArr.count - 1 == section) {//选中的  一定是最后一个标题组
        label.textColor = [Unity getColor:@"aa112d"];
        imageView.image = [UIImage imageNamed:@"上拉"];
        seletedDic = [NSDictionary new];
        seletedDic = self.sectionArr[section];
    }else{
        imageView.image = [UIImage imageNamed:@"下拉"];
    }
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:40]-1, SCREEN_WIDTH, 1)];
    line.backgroundColor = [Unity getColor:@"f0f0f0"];
    [view addSubview:line];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [Unity countcoordinatesH:10];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
    
}

- (UIButton *)comfirmBtn{
    if (!_comfirmBtn) {
        _comfirmBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], SCREEN_HEIGHT-bottomH-44, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        [_comfirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        _comfirmBtn.layer.cornerRadius = _comfirmBtn.height/2;
        _comfirmBtn.layer.masksToBounds = YES;
        [_comfirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_comfirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _comfirmBtn.backgroundColor = [Unity getColor:@"aa112d"];
        _comfirmBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
//        _comfirmBtn.hidden = YES;
    }
    return _comfirmBtn;
}
- (void)exitClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSMutableArray *)sectionArr{
    if (!_sectionArr) {
        _sectionArr = [NSMutableArray new];
    }
    return _sectionArr;
}
- (NSMutableArray *)rowArr{
    if (!_rowArr) {
        _rowArr = [NSMutableArray new];
    }
    return _rowArr;
}
- (void)requestData:(NSString *)cid{
    [self.rowArr removeAllObjects];
    [Unity showanimate];
    NSDictionary * dic = @{@"platform":self.platform,@"categoryid":cid};
    [GZMrequest getWithURLString:[GZMUrl get_category_url] parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
//        NSLog(@"%@",data);
        NSArray * array = (NSArray *)data;
        for (int i=0; i<array.count; i++) {
            NSArray * arr = [array[i] allKeys];
            NSMutableDictionary * dict = [NSMutableDictionary new];
            [dict setValue:arr[0] forKey:@"cid"];
            [dict setValue:array[i][arr[0]] forKey:@"title"];
            [self.rowArr addObject:dict];
        }
        [self.tableView reloadData];
//        if (![cid isEqualToString:@""]) {
//            self.comfirmBtn.hidden = NO;
//        }else{
//            self.tableView.frame = CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight);
//            self.comfirmBtn.hidden = YES;
//        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
    }];
}
- (void)login_register:(UITapGestureRecognizer *)tap{
//    NSLog(@"%ld",(long)tap.view.tag);
    for (int i=0; i<self.sectionArr.count; i++) {
        if (i>tap.view.tag) {
            [self.sectionArr removeObjectAtIndex:i];
            i=i-1;
        }
    }
    NSLog(@"%@",self.sectionArr);
    if (tap.view.tag == 0) {
        [self requestData:@""];
    }else{
        [self requestData:self.sectionArr[tap.view.tag][@"cid"]];
    }
    
}
- (void)confirmClick{
//    NSLog(@"%@",seletedDic[@"title"]);
    [self.delegate categoryDic:seletedDic];
    [self dismissViewControllerAnimated:YES completion:nil];
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
