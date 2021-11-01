//
//  OrderSearchViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/10.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "OrderSearchViewController.h"
#import "SearchListViewController.h"
@interface OrderSearchViewController ()
@property (nonatomic , strong) UIView * navView;
@property (nonatomic , strong) UIButton * goback;
@property (nonatomic , strong) UIView * searchView;
@property (nonatomic , strong) UITextField * searchText;
@property (nonatomic , strong) UIButton * searchBtn;

@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UIView * btnView;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UIButton * deleteBtn;
@property (nonatomic , strong) NSMutableArray * listArray;
@end

@implementation OrderSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [Unity getColor:@"aa112d"];
    self.listArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"orderSearch"] mutableCopy];
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.searchText resignFirstResponder];//结束聚焦
}
- (void)createUI{
    [self.view addSubview:self.navView];
    
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.titleL];
    [_backView addSubview:self.deleteBtn];
    [_backView addSubview:self.btnView];
    [self irregularButton:self.listArray];
}
- (UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight)];
        _navView.backgroundColor = [Unity getColor:@"aa112d"];
        [_navView addSubview:self.searchView];
        [_navView addSubview:self.searchBtn];
        [_navView addSubview:self.goback];
    }
    return _navView;
}
- (UIButton *)goback{
    if (!_goback) {
        _goback = [[UIButton alloc]initWithFrame:CGRectMake(12, NavBarHeight-44+12, 13, 20)];
        [_goback setBackgroundImage:[UIImage imageNamed:@"back_w"] forState:UIControlStateNormal];
        [_goback addTarget:self action:@selector(gobackClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goback;
}
- (void)gobackClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIView *)searchView{
    if (_searchView == nil) {
        _searchView = [[UIView alloc]initWithFrame:CGRectMake(40, NavBarHeight-44, SCREEN_WIDTH-100, 37)];
        //        _searchView.backgroundColor = [UIColor yellowColor];
        UIImageView * searchImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 15, 20)];
        searchImgView.image = [UIImage imageNamed:@"home_search"];
        [_searchView addSubview:searchImgView];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, _searchView.width, 1)];
        line.backgroundColor = [Unity getColor:@"#d58896"];
        [_searchView addSubview:line];
        
        [_searchView addSubview:self.searchText];
    }
    
    return _searchView;
}
- (UIButton *)searchBtn{
    if (_searchBtn ==nil) {
        _searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(_searchView.right+5, _searchView.top+7, 50, 30)];
        _searchBtn.backgroundColor = [Unity getColor:@"#ffffff"];
        _searchBtn.layer.cornerRadius = 15;
        [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        [_searchBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}
- (UITextField *)searchText{
    if (_searchText == nil) {
        _searchText = [[UITextField alloc]initWithFrame:CGRectMake(25, 10, _searchView.width-35, 20)];
        _searchText.textColor = [Unity getColor:@"#ffffff"];
        _searchText.font = [UIFont systemFontOfSize:FontSize(12)];
        _searchText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"直接搜索委托单编号" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[Unity getColor:@"#d58896"]}]; ///新的实现
    }
    return _searchText;
}

- (UIView *)backView{
    if (!_backView ) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, NavBarHeight+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:550])];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 10;
    }
    return _backView;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:20], 200, [Unity countcoordinatesH:20])];
        _titleL.text = @"历史搜索";
        _titleL.textColor = LabelColor3;
        _titleL.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _titleL;
}
- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:23], [Unity countcoordinatesH:22.5], [Unity countcoordinatesW:13], [Unity countcoordinatesH:15])];
        [_deleteBtn addTarget:self action:@selector(clearClick) forControlEvents:UIControlEventTouchUpInside];
        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"clear_search"] forState:UIControlStateNormal];
    }
    return _deleteBtn;
}
- (UIView *)btnView{
    if (!_btnView) {
        _btnView = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:50], SCREEN_WIDTH, [Unity countcoordinatesH:480])];
        _btnView.backgroundColor = [UIColor whiteColor];
        [_btnView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _btnView;
}
- (void)irregularButton:(NSArray *)arr{
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 0;//用来控制button距离父视图的高
    CGFloat lastBtnY = 0;
    for (int i = 0; i < arr.count; i++) {//创建button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = i+1000;
        button.backgroundColor = [Unity getColor:@"#f0f0f0"];
        button.layer.cornerRadius = 15.0f;
        [button addTarget:self action:@selector(clickHotSearchAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:LabelColor6 forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:14];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button sizeToFit];
        CGFloat length = button.frame.size.width;
        //设置button的frame
        button.frame = CGRectMake(10 + w, h, length + 15 , 30);// 距离屏幕左右边距各10,
        //当button的位置超出屏幕边缘时换行
        if(10 + w + length + 15 > SCREEN_WIDTH){
            w = 0; //换行时将w置为0
            h = h + button.frame.size.height + 10;//距离父视图也变化
            button.frame = CGRectMake(10 + w, h, length + 15, 30);//重设button的frame
         }
        if (length + 20 > SCREEN_WIDTH - 20) {
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 8)];// 设置button的title距离边框有一定的间隙,显示不下的字会省略
            button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, SCREEN_WIDTH - 20, 30);//重设button的frame
            
         }
        w = button.frame.size.width + button.frame.origin.x;//重新赋值
        if (i==arr.count-1) {
            lastBtnY=button.frame.origin.y;
         }
        [self.btnView addSubview:button];
        
        
    }
}
- (NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [NSMutableArray new];
    }
    return _listArray;
}
- (void)clearClick{
    for (UIView * view in self.btnView.subviews) {
    [view removeFromSuperview];
    }
//    NSLog(@"%@",[self.listArray class]);
    [self.listArray removeAllObjects];
    [[NSUserDefaults standardUserDefaults] setObject:self.listArray forKey:@"orderSearch"];
}
- (void)searchClick{
    if (self.searchText.text.length == 0) {
        return;
    }
    //点击搜索先判断 搜索的关键词在不在原有的数组中  如果有 原有的数组中元素删除 0下标插入关键词 否则判断是否数组个数大于10  如果大于10 删除最后一个元素 0下标插入新关键词  如果小于10在数组后插入新关键词
    
    BOOL isbool = [self.listArray containsObject:self.searchText.text];
    if (isbool) {//包含
        [self.listArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:self.searchText.text]) {
                [self.listArray removeObject:obj];
            }
        }];
        self.listArray = [self mutableArrayFlashBack:self.listArray WithText:self.searchText.text];
    }else{//不包含
        if (self.listArray.count == 10) {
            [self.listArray removeLastObject];//最后一个元素
            self.listArray = [self mutableArrayFlashBack:self.listArray WithText:self.searchText.text];
        }else{
            self.listArray = [self mutableArrayFlashBack:self.listArray WithText:self.searchText.text];
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:self.listArray forKey:@"orderSearch"];
    //清空 btnview上子控件
    for (UIView * view in self.btnView.subviews) {
    [view removeFromSuperview];
    }
    //重新排列按钮
    [self irregularButton:self.listArray];
    [self push:self.searchText.text];
    self.searchText.text = @"";
}
- (NSMutableArray *)mutableArrayFlashBack:(NSMutableArray *)arr WithText:(NSString *)text{
    NSArray* reversedArray = [[arr reverseObjectEnumerator] allObjects];
    NSMutableArray * muArr = [reversedArray mutableCopy];
    [muArr addObject:text];
    NSMutableArray * muArray = [[[muArr reverseObjectEnumerator] allObjects] mutableCopy];
    return muArray;
}
- (void)clickHotSearchAction:(UIButton *)sender{
    NSString * str = self.listArray[sender.tag - 1000];
    [self.listArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:self.listArray[sender.tag - 1000]]) {
            [self.listArray removeObject:obj];
        }
    }];
    self.listArray = [self mutableArrayFlashBack:self.listArray WithText:str];
    [[NSUserDefaults standardUserDefaults] setObject:self.listArray forKey:@"orderSearch"];
    //清空 btnview上子控件
    for (UIView * view in self.btnView.subviews) {
    [view removeFromSuperview];
    }
    //重新排列按钮
    [self irregularButton:self.listArray];
    
    [self push:str];
}
- (void)push:(NSString *)keyWord{
    SearchListViewController * svc = [[SearchListViewController alloc]init];
    svc.keyWord = keyWord;
    [self.navigationController pushViewController:svc animated:YES];
}
@end
