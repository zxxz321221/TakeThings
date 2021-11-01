//
//  YhLeftViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/9/5.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "YhLeftViewController.h"
#import "CategoryViewController.h"
@interface YhLeftViewController ()<CategoryDelegate>
{
    CGFloat lastBtnY;//最后一个按钮的Y
    NSInteger index;
    NSString * categoryId;
    NSString * locale;//原文0 中文1
}
@property (nonatomic , strong) UIView * navView;
@property (nonatomic , strong) UIButton * leftBtn;
@property (nonatomic , strong) UIButton * rightBtn;
@property (nonatomic , strong) UILabel * navL;
@property (nonatomic , strong) UILabel * lineL;
@property (nonatomic , strong) UILabel * titleL;

@property (nonatomic , strong) UIScrollView * scrollView;

@property (nonatomic , strong) UIButton * seletedBtn;

@property (nonatomic , strong) UILabel * titleL1;
@property (nonatomic , strong) UITextField * minText;
@property (nonatomic , strong) UITextField * maxText;
@property (nonatomic , strong) UIView * line0;

@property (nonatomic , strong) UILabel * titleL2;

@property (nonatomic , strong) UILabel * seletedL;

@property (nonatomic , strong) UIButton * seleBtn;

@property (nonatomic , strong) UIButton * continueBtn;

@property (nonatomic , strong) UILabel * sellerL;
@property (nonatomic , strong) UITextField * sellerText;
@property (nonatomic , strong) UIView * cLine;

@property (nonatomic , strong) UILabel * brandL;
@property (nonatomic , strong) UITextField * brandText;

@property (nonatomic , strong) NSDictionary * classDic;


@property (nonatomic , strong) UIButton * originalBtn;
@property (nonatomic , strong) UIButton * chineseBtn;

@end

@implementation YhLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    categoryId = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)createUI{
    
    
    
    _scrollView = [UIScrollView new];
//    _scrollView.delegate=self;
    _scrollView.showsVerticalScrollIndicator = FALSE;//垂直滚动条
    _scrollView.showsHorizontalScrollIndicator = FALSE;//水平滚动条
    
    [self.view addSubview:_scrollView];
    _scrollView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }//解决导航栏设置透明的情况下 scrollView发生偏移的问题：
    
    [self.scrollView addSubview:self.titleL];
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = NavBarHeight+[Unity countcoordinatesH:50];//用来控制button距离父视图的高
    
    NSInteger count= self.tjArr.count;
    
    for (int i = 0; i < count; i++) {//创建button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = i+1000;
        button.backgroundColor = [Unity getColor:@"#f0f0f0"];
        button.layer.cornerRadius = 15.0f;
        [button addTarget:self action:@selector(clickHotSearchAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:LabelColor6 forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:FontSize(14)];
        [button setTitle:self.tjArr[i] forState:UIControlStateNormal];
        [button sizeToFit];
        CGFloat length = button.frame.size.width;
        //设置button的frame
        button.frame = CGRectMake(10 + w, h, length + 30 , 30);// 距离屏幕左右边距各10,
        //当button的位置超出屏幕边缘时换行
        if(10 + w + length + 15 > SCREEN_WIDTH){
            w = 0; //换行时将w置为0
            h = h + button.frame.size.height + 10;//距离父视图也变化
            button.frame = CGRectMake(10 + w, h, length + 30, 30);//重设button的frame
        }
        if (length + 20 > SCREEN_WIDTH - 20) {
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 8)];// 设置button的title距离边框有一定的间隙,显示不下的字会省略
            button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, SCREEN_WIDTH - 20, 30);//重设button的frame
        }
        w = button.frame.size.width + button.frame.origin.x;//重新赋值
        if (i==self.tjArr.count-1) {
            lastBtnY=button.frame.origin.y;
        }
        if (i == 0) {
            button.layer.borderWidth =1;
            button.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
            
            index = 0;
            self.seletedBtn = button;
        }
        
        [self.scrollView addSubview:button];
    }
    [self.scrollView addSubview:self.titleL1];
    [self.scrollView addSubview:self.minText];
    [self.scrollView addSubview:self.maxText];
    [self.scrollView addSubview:self.line0];
    [self.scrollView addSubview:self.sellerL];
    [self.scrollView addSubview:self.sellerText];
    [self.scrollView addSubview:self.brandL];
    [self.scrollView addSubview:self.brandText];
    [self.scrollView addSubview:self.originalBtn];
    [self.scrollView addSubview:self.chineseBtn];
    [self.scrollView addSubview:self.cLine];
    [self.scrollView addSubview:self.titleL2];
    [self.scrollView addSubview:self.seletedL];
    [self.scrollView addSubview:self.seleBtn];
    [self.scrollView addSubview:self.continueBtn];
    
    /*将ui添加到scrollView数组中*/
//    [self.scrollView sd_addSubviews:@[self.titleL,self.titleL1,self.minText,self.maxText,self.line0,self.sellerL,self.sellerText,self.brandL,self.brandText,self.cLine,self.titleL2,self.seletedL,self.seleBtn,self.continueBtn]];
    
    // scrollview自动contentsize
    [self.scrollView setupAutoContentSizeWithBottomView:self.continueBtn bottomMargin:20];
    
    [self.view addSubview:self.navView];
    
    
    
    
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
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], NavBarHeight+[Unity countcoordinatesH:15], 100, [Unity countcoordinatesH:20])];
        _titleL.text = @"选项";
        _titleL.font = [UIFont systemFontOfSize:FontSize(16)];
        _titleL.textColor = LabelColor6;
    }
    return _titleL;
}
- (UILabel *)titleL1{
    if (!_titleL1) {
        _titleL1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], lastBtnY+30+[Unity countcoordinatesH:20], 100, [Unity countcoordinatesH:20])];
        _titleL1.text = @"价格区间";
        _titleL1.font = [UIFont systemFontOfSize:FontSize(16)];
        _titleL1.textColor = LabelColor6;
    }
    return _titleL1;
}
- (UITextField *)minText{
    if (!_minText) {
        _minText = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _titleL1.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesH:120], [Unity countcoordinatesH:35])];
        _minText.layer.cornerRadius = _minText.height/2;
        _minText.layer.borderWidth =1;
        _minText.layer.borderColor = [Unity getColor:@"e0e0e0"].CGColor;
        _minText.font = [UIFont systemFontOfSize:FontSize(14)];
        _minText.textAlignment = NSTextAlignmentCenter;
        _minText.placeholder = @"最低价";
        _minText.keyboardType = UIKeyboardTypeDecimalPad;
        _minText.text = self.minStr;
    }
    return _minText;
}
- (UITextField *)maxText{
    if (!_maxText) {
        _maxText = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:130], _titleL1.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesH:120], [Unity countcoordinatesH:35])];
        _maxText.layer.cornerRadius = _maxText.height/2;
        _maxText.layer.borderWidth =1;
        _maxText.layer.borderColor = [Unity getColor:@"e0e0e0"].CGColor;
        _maxText.font = [UIFont systemFontOfSize:FontSize(14)];
        _maxText.textAlignment = NSTextAlignmentCenter;
        _maxText.placeholder = @"最高价";
        _maxText.keyboardType = UIKeyboardTypeDecimalPad;
        _maxText.text = self.maxStr;
    }
    return _maxText;
}
- (UIView *)line0{
    if (!_line0) {
        _line0 = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-[Unity countcoordinatesW:25])/2, _titleL1.bottom+[Unity countcoordinatesH:27], [Unity countcoordinatesW:25], [Unity countcoordinatesH:1])];
        _line0.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _line0;
}
- (UILabel *)sellerL{
    if (!_sellerL) {
        _sellerL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _maxText.bottom+[Unity countcoordinatesH:20], 100, [Unity countcoordinatesH:20])];
        _sellerL.text = @"卖家ID";
        _sellerL.font = [UIFont systemFontOfSize:FontSize(16)];
        _sellerL.textColor = LabelColor6;
    }
    return _sellerL;
}
- (UITextField *)sellerText{
    if (!_sellerText) {
        _sellerText = [[UITextField alloc]initWithFrame:CGRectMake(_sellerL.left, _sellerL.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:35])];
        _sellerText.placeholder = @"请输入";
        _sellerText.layer.cornerRadius = _sellerText.height/2;
        _sellerText.layer.masksToBounds = YES;
        _sellerText.layer.borderWidth =1;
        _sellerText.layer.borderColor = [Unity getColor:@"e0e0e0"].CGColor;
        _sellerText.font = [UIFont systemFontOfSize:FontSize(14)];
        _sellerText.textAlignment = NSTextAlignmentCenter;
        _sellerText.text = self.sellerStr;
    }
    return _sellerText;
}
- (UILabel *)brandL{
    if (!_brandL) {
        _brandL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _sellerText.bottom+[Unity countcoordinatesH:20], 100, [Unity countcoordinatesH:20])];
        _brandL.text = @"关键字";
        _brandL.font = [UIFont systemFontOfSize:FontSize(16)];
        _brandL.textColor = LabelColor6;
    }
    return _brandL;
}
- (UITextField *)brandText{
    if (!_brandText) {
        _brandText = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _brandL.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:35])];
        _brandText.placeholder = @"请输入";
        _brandText.layer.cornerRadius = _sellerText.height/2;
        _brandText.layer.masksToBounds = YES;
        _brandText.layer.borderWidth =1;
        _brandText.layer.borderColor = [Unity getColor:@"e0e0e0"].CGColor;
        _brandText.font = [UIFont systemFontOfSize:FontSize(14)];
        _brandText.textAlignment = NSTextAlignmentCenter;
        _brandText.text = self.wordStr;
    }
    return _brandText;
}
- (UIButton *)originalBtn{
    if (!_originalBtn) {
        _originalBtn = [[UIButton alloc]initWithFrame:CGRectMake(_brandText.right+[Unity countcoordinatesW:10], _brandText.top, [Unity countcoordinatesW:60], [Unity countcoordinatesH:35])];
        [_originalBtn addTarget:self action:@selector(oriClick) forControlEvents:UIControlEventTouchUpInside];
        [_originalBtn setTitle:@"原文" forState:UIControlStateNormal];
        [_originalBtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_originalBtn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateSelected];
        _originalBtn.layer.borderColor = [Unity getColor:@"f0f0f0"].CGColor;
        _originalBtn.layer.borderWidth = 1;
        _originalBtn.layer.cornerRadius = _originalBtn.height/2;
        if ([self.local isEqualToString:@""] || [self.local isEqualToString:@"0"]) {
            locale = @"0";
            _originalBtn.selected = YES;
            _originalBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        }
    }
    return _originalBtn;
}
- (UIButton *)chineseBtn{
    if (!_chineseBtn) {
        _chineseBtn = [[UIButton alloc]initWithFrame:CGRectMake(_originalBtn.right+[Unity countcoordinatesW:10], _originalBtn.top, [Unity countcoordinatesW:60], [Unity countcoordinatesH:35])];
        [_chineseBtn addTarget:self action:@selector(chineseClick) forControlEvents:UIControlEventTouchUpInside];
        [_chineseBtn setTitle:@"中文" forState:UIControlStateNormal];
        [_chineseBtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_chineseBtn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateSelected];
        _chineseBtn.layer.borderColor = [Unity getColor:@"f0f0f0"].CGColor;
        _chineseBtn.layer.borderWidth = 1;
        _chineseBtn.layer.cornerRadius = _chineseBtn.height/2;
        if ([self.local isEqualToString:@"1"]) {
            locale = @"1";
            _chineseBtn.selected = YES;
            _chineseBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        }
    }
    return _chineseBtn;
}
- (UIView *)cLine{
    if (!_cLine) {
        _cLine = [[UIView alloc]initWithFrame:CGRectMake(0, _brandText.bottom+[Unity countcoordinatesH:20], SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        _cLine.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return _cLine;
}





- (UILabel *)titleL2{
    if (!_titleL2) {
        _titleL2 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _cLine.bottom+[Unity countcoordinatesH:20], 100, [Unity countcoordinatesH:20])];
        _titleL2.text = @"商品分类";
        _titleL2.font = [UIFont systemFontOfSize:FontSize(16)];
        _titleL2.textColor = LabelColor6;
    }
    return _titleL2;
}
- (UILabel *)seletedL{
    if (!_seletedL) {
        _seletedL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _titleL2.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:200], [Unity countcoordinatesH:20])];
        _seletedL.text = @"全部";
        _seletedL.textColor = LabelColor3;
        _seletedL.font = [UIFont systemFontOfSize:FontSize(14)];
        if (![self.categoryStr isEqualToString:@""]) {
            _seletedL.text = self.categoryStr;
            categoryId = self.categoryID;
        }
    }
    return _seletedL;
}
- (UIButton *)seleBtn{
    if (!_seleBtn) {
        /* 获取按钮文字的宽度 获取按钮图片和文字的间距 获取图片宽度 */
        CGFloat    space = 5;// 图片和文字的间距
        NSString    * titleString = [NSString stringWithFormat:@"请选择"];
        CGFloat    titleWidth = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FontSize(16)]}].width;
        UIImage    * btnImage = [UIImage imageNamed:@"go"];// 11*6
        CGFloat    imageWidth = btnImage.size.width;
        //创建按钮
        _seleBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:100], _seletedL.top, [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
        [_seleBtn addTarget:self action:@selector(seletedClick) forControlEvents:UIControlEventTouchUpInside];
        _seleBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        [_seleBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_seleBtn setTitle:@"请选择" forState:UIControlStateNormal];
        [_seleBtn setImage:[UIImage imageNamed:@"go"] forState:UIControlStateNormal];
        [_seleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -(imageWidth+space*0.5), 0, (imageWidth+space*0.5))];
        [_seleBtn setImageEdgeInsets:UIEdgeInsetsMake(0, (titleWidth + space*0.5), 0, -(titleWidth + space*0.5))];
        _seleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _seleBtn;
}
- (UIButton *)continueBtn{
    if (!_continueBtn) {
        _continueBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], self.seleBtn.bottom+[Unity countcoordinatesH:20], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        [_continueBtn addTarget:self action:@selector(continueClick) forControlEvents:UIControlEventTouchUpInside];
        [_continueBtn setTitle:@"筛选" forState:UIControlStateNormal];
        [_continueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _continueBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
        _continueBtn.backgroundColor = [Unity getColor:@"aa112d"];
        _continueBtn.layer.cornerRadius = _continueBtn.height/2;
        
    }
    return _continueBtn;
}


- (void)clickHotSearchAction:(UIButton *)sender{
    if (index == sender.tag-1000) {
        return;
    }else{
        self.seletedBtn.layer.borderWidth =1;
        self.seletedBtn.layer.borderColor = [Unity getColor:@"f0f0f0"].CGColor;
        self.seletedBtn.backgroundColor = [Unity getColor:@"f0f0f0"];
        [self.seletedBtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        
        index = sender.tag-1000;
        UIButton *btn = (UIButton *)[self.view viewWithTag:sender.tag];
        btn.layer.borderWidth =1;
        btn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
        
        self.seletedBtn = btn;
    }
    
}
- (void)seletedClick{
//    [self.delegate seletedCategory];
    CategoryViewController * cvc = [[CategoryViewController alloc]init];
    cvc.delegate = self;
    cvc.platform = self.platForm;
    [self presentViewController:cvc animated:YES completion:nil];
//    NSLog(@"%@",self.navigationController);
}
- (void)exitClick{
//    NSLog(@"关闭");
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)resetClick{
//    NSLog(@"重置");
    self.seletedBtn.layer.borderWidth =1;
    self.seletedBtn.layer.borderColor = [Unity getColor:@"f0f0f0"].CGColor;
    self.seletedBtn.backgroundColor = [Unity getColor:@"f0f0f0"];
    [self.seletedBtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:1000];
    btn.layer.borderWidth =1;
    btn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
    
    self.seletedBtn = btn;
    
    self.minText.text = @"";
    self.maxText.text = @"";
    self.sellerText.text = self.sellerA;
    if ([self.categoryA isEqualToString:@""]) {
        self.seletedL.text = @"全部";
    }else{
       self.seletedL.text = self.categoryB;
    }
    categoryId = self.categoryA;
    index = 0;
    self.brandText.text = self.wordA;
    if ([self.localA isEqualToString:@""] || [self.localA isEqualToString:@"0"]) {
        [self oriClick];
    }else{
        [self chineseClick];
    }
}
- (void)categoryDic:(NSDictionary *)dic{
    categoryId = dic[@"cid"];
    self.seletedL.text = dic[@"title"];
    self.classDic = dic;
    
}
- (void)continueClick{
    if ([self.platForm isEqualToString:@"0"]) {
        if ([self.minText.text floatValue] < 1) {
            self.minText.text = @"1";
        }
    }
    if (![self.maxText.text isEqualToString:@""]) {
        if ([self.minText.text floatValue]>[self.maxText.text floatValue]) {
            [WHToast showMessage:@"请正确选择价格区间" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            return;
        }
    }
    if ([self.maxText.text floatValue] < [self.maxText.text floatValue]) {
        [WHToast showMessage:@"请正确选择价格区间" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        return;
    }
    [self dismissViewControllerAnimated:NO completion:nil];
    UIButton *btn = (UIButton *)[self.view viewWithTag:index+1000];
    [self.delegate configYhLeftRadio:btn.currentTitle WithMinPlace:self.minText.text WithMaxPlace:self.maxText.text WithSellerId:self.sellerText.text WithClassId:categoryId WithIndex:index WithKeyWord:self.brandText.text WithClassName:self.seletedL.text WithLanguage:locale];
}
- (NSDictionary *)classDic{
    if (!_classDic) {
        _classDic = [NSDictionary new];
    }
    return _classDic;
}
- (void)oriClick{
    locale = @"0";
    self.originalBtn.selected = YES;
    self.originalBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
    self.chineseBtn.selected = NO;
    self.chineseBtn.layer.borderColor = [Unity getColor:@"f0f0f0"].CGColor;
    
}
- (void)chineseClick{
    locale = @"1";
    self.chineseBtn.selected = YES;
    self.chineseBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
    self.originalBtn.selected = NO;
    self.originalBtn.layer.borderColor = [Unity getColor:@"f0f0f0"].CGColor;
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
