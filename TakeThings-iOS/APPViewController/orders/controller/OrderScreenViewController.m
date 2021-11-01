//
//  OrderScreenViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/5.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "OrderScreenViewController.h"
#import "LMJDropdownMenu.h"
@interface OrderScreenViewController ()<LMJDropdownMenuDataSource,LMJDropdownMenuDelegate>
{
    UIButton * _seleteBtn;//被选中的button
    UIButton * _seleteBtn2;//被选中的button
    NSInteger btnIndex;//筛选按钮单选 记录
    NSInteger btnIndex2;//出价方式
    NSInteger listIndex;//列表状态记录
    NSInteger statusIndex;//委托单状态记录
    LMJDropdownMenu * menu1;
    LMJDropdownMenu * menu2;
    NSArray * _menu1OptionTitles;
    NSArray * _menu2OptionTitles;
}
@property (nonatomic , strong) UIView * navView;
@property (nonatomic , strong) UIButton * leftBtn;
@property (nonatomic , strong) UIButton * rightBtn;
@property (nonatomic , strong) UILabel * navL;
@property (nonatomic , strong) UILabel * lineL;
@property (nonatomic , strong) UILabel * titleL;

@property (nonatomic , strong) UILabel * overTimeL;//结标时间
@property (nonatomic , strong) UILabel * createTimeL;//委托时间

@property (nonatomic , strong) UILabel * line0;
@property (nonatomic , strong) UILabel * subTitle;
@property (nonatomic , strong) UILabel * type;//出价方式
@property (nonatomic , strong) UILabel * precelL;//包裹
@property (nonatomic , strong) UILabel * orderL;//订单

@property (nonatomic , strong) UIButton * confirmBtn;

@end

@implementation OrderScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _menu1OptionTitles = @[@"进　行　中",@"已　发　出",@"已　结　束"];
    listIndex = self.tap;
    statusIndex = self.statusP;
    btnIndex = self.timeP;
    btnIndex2 = self.typeP;

    if (listIndex == 0) {
        _menu2OptionTitles = @[@"　全　部　",@"委托单待审核",@"定金等待支付",@"定金支付成功",@"委托单竞价中",@"竞拍无法出价",@"出价被迫取消",@"竞拍价被超过"];
    }else if (listIndex == 1){
        _menu2OptionTitles = @[@"　全　部　",@"委托单已得标",@"得标付款成功",@"定金退回成功",@"海外等待汇款",@"海外汇款成功",@"商品正在运输",@"海外仓已收货"];
    }else{
        _menu2OptionTitles = @[@"　全　部　",@"拍卖提前结束",@"委托单被直购",@"委托单已流标",@"商品已被签收"];
    }

    [self createUI];
}

- (void)createUI{
    [self.view addSubview:self.navView];
    [self.view addSubview:self.titleL];
    [self.view addSubview:self.overTimeL];
    [self.view addSubview:self.createTimeL];

    

    [self.view addSubview:self.line0];
    [self.view addSubview:self.subTitle];
    [self.view addSubview:self.type];
    [self.view addSubview:self.precelL];
    [self.view addSubview:self.orderL];

    [self createButton];
    [self createMenu2:_menu2OptionTitles];
    [self createMenu1:_menu1OptionTitles];

    [self.view addSubview:self.confirmBtn];

}
- (UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight)];
        _navView.backgroundColor = [UIColor whiteColor];

        [_navView addSubview:self.leftBtn];
        [_navView addSubview:self.rightBtn];
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
- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-62, NavBarHeight-44+7.5, 50, 28.5)];
        [_rightBtn addTarget:self action:@selector(resetClick) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn setTitle:@"重置" forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        _rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightBtn;
}
- (UILabel *)navL{
    if (!_navL) {
        _navL = [[UILabel alloc]initWithFrame:CGRectMake(50, StatusBarHeight, SCREEN_WIDTH-100, 44)];
        _navL.text = @"筛选条件";
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
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], NavBarHeight+[Unity countcoordinatesH:25], 100, [Unity countcoordinatesH:20])];
        _titleL.text = @"时间排序";
        _titleL.font = [UIFont systemFontOfSize:FontSize(16)];
        _titleL.textColor = LabelColor3;
    }
    return _titleL;
}
- (UILabel *)overTimeL{
    if (!_overTimeL) {
        _overTimeL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], _titleL.bottom+[Unity countcoordinatesW:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _overTimeL.text = @"按结标时间排序";
        _overTimeL.textColor = LabelColor3;
        _overTimeL.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _overTimeL;
}
- (UILabel *)createTimeL{
    if (!_createTimeL) {
        _createTimeL = [[UILabel alloc]initWithFrame:CGRectMake(_overTimeL.left, _overTimeL.bottom+[Unity countcoordinatesW:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _createTimeL.text = @"按委托时间排序";
        _createTimeL.textColor = LabelColor3;
        _createTimeL.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _createTimeL;
}
- (void)createButton{

    NSArray * arr = @[@"顺序",@"倒叙",@"顺序",@"倒叙"];
    for (int i=0; i<4; i++) {
        UIButton * btn = [[UIButton  alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:130]+(i%2*[Unity countcoordinatesW:55]), _overTimeL.top+(i/2*[Unity countcoordinatesH:35]), [Unity countcoordinatesW:45], [Unity countcoordinatesH:20])];
        btn.tag = 1000+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[Unity getColor:@"494949"] forState:UIControlStateNormal];
        [btn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateSelected];
        btn.backgroundColor = [Unity getColor:@"f0f0f0"];
        btn.layer.cornerRadius = btn.height/2;
        btn.titleLabel.font = [UIFont systemFontOfSize:FontSize(13)];

        [self.view addSubview:btn];
        if (i==btnIndex) {
            btn.selected = YES;
            btn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
            btn.layer.borderWidth = 1;
            btn.backgroundColor = [UIColor whiteColor];
            _seleteBtn = btn;
//            btnIndex = i;
        }
    }
    
    
    NSArray * arr1 = @[@" 竞价 ",@" 立即出价 "];
        for (int i=0; i<2; i++) {
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:110]+(i%2*[Unity countcoordinatesW:55]), _type.top, [Unity widthOfString:arr1[i] OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:20]], [Unity countcoordinatesH:20])];
//            [btn sizeToFit];
            btn.tag = 3000+i;
            [btn addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:arr1[i] forState:UIControlStateNormal];
            [btn setTitleColor:[Unity getColor:@"494949"] forState:UIControlStateNormal];
            [btn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateSelected];
            btn.backgroundColor = [Unity getColor:@"f0f0f0"];
            btn.layer.cornerRadius = btn.height/2;
            btn.titleLabel.font = [UIFont systemFontOfSize:FontSize(13)];

            [self.view addSubview:btn];
            if (i==btnIndex2) {
                btn.selected = YES;
                btn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
                btn.layer.borderWidth = 1;
                btn.backgroundColor = [UIColor whiteColor];
                _seleteBtn2 = btn;
    //            btnIndex = i;
            }
        }
}
- (UILabel *)line0{
    if (!_line0) {
        _line0 = [[UILabel alloc]initWithFrame:CGRectMake(0, _createTimeL.bottom+[Unity countcoordinatesH:25], SCREEN_WIDTH, 1)];
        _line0.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return _line0;
}
- (UILabel *)subTitle{
    if (!_subTitle) {
        _subTitle = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line0.bottom+[Unity countcoordinatesH:25], 100, [Unity countcoordinatesH:20])];
        _subTitle.text = @"筛选";
        _subTitle.font = [UIFont systemFontOfSize:FontSize(16)];
        _subTitle.textColor = LabelColor3;
    }
    return _subTitle;
}
- (UILabel *)type{
    if (!_type) {
        _type = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], _subTitle.bottom+[Unity countcoordinatesW:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _type.text = @"出价方式";
        _type.textColor = LabelColor3;
        _type.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _type;
}
- (UILabel *)precelL{
    if (!_precelL) {
        _precelL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], _type.bottom+[Unity countcoordinatesW:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _precelL.text = @"按包裹列表筛选";
        _precelL.textColor = LabelColor3;
        _precelL.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _precelL;
}
- (UILabel *)orderL{
    if (!_orderL) {
        _orderL = [[UILabel alloc]initWithFrame:CGRectMake(_precelL.left, _precelL.bottom+[Unity countcoordinatesW:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _orderL.text = @"按包裹状态筛选";
        _orderL.textColor = LabelColor3;
        _orderL.font = [UIFont systemFontOfSize:FontSize(16)];
    }
    return _orderL;
}
- (void)createMenu1:(NSArray *)arr{
     menu1 = [[LMJDropdownMenu alloc] init];
    [menu1 setFrame:CGRectMake([Unity countcoordinatesW:120], _precelL.top, [Unity countcoordinatesW:120], [Unity countcoordinatesH:20])];
    menu1.dataSource = self;
    menu1.delegate   = self;

    menu1.title           = arr[listIndex];
    menu1.titleBgColor    = [UIColor whiteColor];
    menu1.titleFont       = [UIFont systemFontOfSize:FontSize(14)];
    menu1.titleColor      = LabelColor3;
    menu1.titleAlignment  = NSTextAlignmentLeft;
    menu1.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);

    menu1.rotateIcon      = [UIImage imageNamed:@"下拉"];
    menu1.rotateIconSize  = CGSizeMake(15, 8);

    menu1.optionBgColor       = [UIColor whiteColor];
    menu1.optionFont          = [UIFont systemFontOfSize:FontSize(14)];
    menu1.optionTextColor     = LabelColor3;
    menu1.optionTextAlignment = NSTextAlignmentLeft;
    menu1.optionNumberOfLines = 0;
    menu1.optionLineColor     = [UIColor clearColor];
    menu1.optionIconSize      = CGSizeMake(15, 15);
    [self.view addSubview:menu1];
}
- (void)createMenu2:(NSArray *)arr{
     menu2 = [[LMJDropdownMenu alloc] init];
    [menu2 setFrame:CGRectMake([Unity countcoordinatesW:120], _orderL.top, [Unity countcoordinatesW:120], [Unity countcoordinatesH:20])];
    menu2.dataSource = self;
    menu2.delegate   = self;

    menu2.title           = arr[self.statusP];
    menu2.titleBgColor    = [UIColor whiteColor];
    menu2.titleFont       = [UIFont systemFontOfSize:FontSize(14)];
    menu2.titleColor      = LabelColor3;
    menu2.titleAlignment  = NSTextAlignmentLeft;
    menu2.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);

    menu2.rotateIcon      = [UIImage imageNamed:@"下拉"];
    menu2.rotateIconSize  = CGSizeMake(15, 8);

    menu2.optionBgColor       = [UIColor whiteColor];
    menu2.optionFont          = [UIFont systemFontOfSize:FontSize(14)];
    menu2.optionTextColor     = LabelColor3;
    menu2.optionTextAlignment = NSTextAlignmentLeft;
    menu2.optionNumberOfLines = 0;
    menu2.optionLineColor     = [UIColor clearColor];
    menu2.optionIconSize      = CGSizeMake(15, 15);
    [self.view addSubview:menu2];
}
- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], SCREEN_HEIGHT-StatusBarHeight-[Unity countcoordinatesH:60], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        [_confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
        _confirmBtn.layer.cornerRadius = _confirmBtn.height/2;
        _confirmBtn.backgroundColor = [Unity getColor:@"aa112d"];
    }
    return _confirmBtn;
}

/**
 关闭弹出框
 */
- (void)exitClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 重置
 */
- (void)resetClick{
    if (btnIndex != 1) {
        _seleteBtn.selected = NO;
        _seleteBtn.layer.borderColor = [Unity getColor:@"f0f0f0"].CGColor;
        _seleteBtn.layer.borderWidth = 1;
        _seleteBtn.backgroundColor = [Unity getColor:@"f0f0f0"];

        UIButton * btn = (UIButton *)[self.view viewWithTag:1001];
        btn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        btn.layer.borderWidth = 1;
        btn.backgroundColor = [UIColor whiteColor];
        btn.selected = YES;
        _seleteBtn = btn;
        btnIndex = 1;
    }
    if (self.tap == 0) {
        _menu2OptionTitles = @[@"　全　部　",@"委托单待审核",@"定金等待支付",@"定金支付成功",@"委托单竞价中",@"竞拍无法出价",@"出价被迫取消",@"竞拍价被超过"];
    }else if (self.tap == 1){
        _menu2OptionTitles = @[@"　全　部　",@"委托单已得标",@"得标付款成功",@"定金退回成功",@"海外等待汇款",@"海外汇款成功",@"商品正在运输",@"海外仓已收货"];
    }else{
        _menu2OptionTitles = @[@"　全　部　",@"拍卖提前结束",@"委托单被直购",@"委托单已流标",@"商品已被签收"];
    }
    menu1.title = _menu1OptionTitles[self.tap];
    menu2.title = _menu2OptionTitles[0];
    statusIndex = 0;
}
#pragma mark - LMJDropdownMenu DataSource
- (NSUInteger)numberOfOptionsInDropdownMenu:(LMJDropdownMenu *)menu{
    if (menu == menu1) {
        return _menu1OptionTitles.count;
    } else {
        return _menu2OptionTitles.count;
    }
}
- (CGFloat)dropdownMenu:(LMJDropdownMenu *)menu heightForOptionAtIndex:(NSUInteger)index{
    return [Unity countcoordinatesH:25];
}
- (NSString *)dropdownMenu:(LMJDropdownMenu *)menu titleForOptionAtIndex:(NSUInteger)index{
    if (menu == menu1) {
        return _menu1OptionTitles[index];
    } else {
        return _menu2OptionTitles[index];
    }
}
- (UIImage *)dropdownMenu:(LMJDropdownMenu *)menu iconForOptionAtIndex:(NSUInteger)index{
    return nil;
}
#pragma mark - LMJDropdownMenu Delegate
- (void)dropdownMenu:(LMJDropdownMenu *)menu didSelectOptionAtIndex:(NSUInteger)index optionTitle:(NSString *)title{
    if (menu == menu1) {
        if (index != self.tap) {
            listIndex = index;
            if (listIndex == 0) {
                _menu2OptionTitles = @[@"　全　部　",@"委托单待审核",@"定金等待支付",@"定金支付成功",@"委托单竞价中",@"竞拍无法出价",@"出价被迫取消",@"竞拍价被超过"];
            }else if (listIndex == 1){
                _menu2OptionTitles = @[@"　全　部　",@"委托单已得标",@"得标付款成功",@"定金退回成功",@"海外等待汇款",@"海外汇款成功",@"商品正在运输",@"海外仓已收货"];
            }else{
                _menu2OptionTitles = @[@"　全　部　",@"拍卖提前结束",@"委托单被直购",@"委托单已流标",@"商品已被签收"];
            }
            menu2.title = _menu2OptionTitles[0];
            [menu2 reloadOptionsData];
        }

    } else if (menu == menu2) {
        statusIndex = index;
    }
}

- (void)dropdownMenuWillShow:(LMJDropdownMenu *)menu{
    if (menu == menu1) {
//        NSLog(@"--将要显示(will appear)--menu1");
    } else if (menu == menu2) {
//        NSLog(@"--将要显示(will appear)--menu2");
    }
}
- (void)dropdownMenuDidShow:(LMJDropdownMenu *)menu{
    if (menu == menu1) {
//        NSLog(@"--已经显示(did appear)--menu1");
    } else if (menu == menu2) {
//        NSLog(@"--已经显示(did appear)--menu2");
    }
}

- (void)dropdownMenuWillHidden:(LMJDropdownMenu *)menu{
    if (menu == menu1) {
//        NSLog(@"--将要隐藏(will disappear)--menu1");
    } else if (menu == menu2) {
//        NSLog(@"--将要隐藏(will disappear)--menu2");
    }
}
- (void)dropdownMenuDidHidden:(LMJDropdownMenu *)menu{
    if (menu == menu1) {
//        NSLog(@"--已经隐藏(did disappear)--menu1");
    } else if (menu == menu2) {
//        NSLog(@"--已经隐藏(did disappear)--menu2");
    }
}
/**
 确定
 */
- (void)confirmClick{
    [self.delegate screenTime:btnIndex WithListIndex:listIndex WithStatusIndex:statusIndex WithType:btnIndex2];
    [self exitClick];
}
/**
 时间排序
 */
- (void)btnClick:(UIButton *)btn{
    btnIndex = btn.tag-1000;
    if (btn != _seleteBtn) {
        _seleteBtn.selected = NO;
        _seleteBtn.layer.borderColor = [Unity getColor:@"f0f0f0"].CGColor;
        _seleteBtn.layer.borderWidth = 1;
        _seleteBtn.backgroundColor = [Unity getColor:@"f0f0f0"];

        btn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        btn.layer.borderWidth = 1;
        btn.backgroundColor = [UIColor whiteColor];
        btn.selected = YES;
        _seleteBtn = btn;

    }
    NSLog(@"%d",btnIndex);
}

- (void)btnClick2:(UIButton *)btn{
    btnIndex2 = btn.tag-3000;
    if (btn != _seleteBtn2) {
        _seleteBtn2.selected = NO;
        _seleteBtn2.layer.borderColor = [Unity getColor:@"f0f0f0"].CGColor;
        _seleteBtn2.layer.borderWidth = 1;
        _seleteBtn2.backgroundColor = [Unity getColor:@"f0f0f0"];

        btn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        btn.layer.borderWidth = 1;
        btn.backgroundColor = [UIColor whiteColor];
        btn.selected = YES;
        _seleteBtn2 = btn;

    }
    NSLog(@"%d",btnIndex2);
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
