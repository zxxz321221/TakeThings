//
//  CalculateViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/8/6.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "CalculateViewController.h"
#import "UIViewController+YINNav.h"
//#define bottomH (IS_iPhoneX ? [Unity countcoordinatesH:70] : [Unity countcoordinatesH:50])
@interface CalculateViewController ()
{
    NSInteger platfrom;
    BOOL isMerchant;
    NSString * stream;
    NSInteger cost;//代工费(ebay)
    UILabel * Dw1;
    float tax;//消费税  默认0.08
    NSInteger gjyf;//国际运送费
    BOOL isCategory;
}

@property (nonatomic , strong) UIScrollView * scrollView;
/*
 topView
 */
@property (nonatomic , strong) UIView * topView;
@property (nonatomic , strong) UILabel * webL;
@property (nonatomic , strong) UIButton * yahooBtn;
@property (nonatomic , strong) UIImageView * yahooImg;
@property (nonatomic , strong) UIButton * ebayBtn;
@property (nonatomic , strong) UIImageView * ebayImg;
@property (nonatomic , strong) UILabel * goodId;
@property (nonatomic , strong) UITextField * goodText;
@property (nonatomic , strong) UILabel * currency;

@property (nonatomic , strong) UIView * yahooView;
@property (nonatomic , strong) UIView * wView;
@property (nonatomic , strong) UIButton * seletedBtn;
@property (nonatomic , strong) UIButton * merchantBtn;//是
@property (nonatomic , strong) UIButton * notMerchantBtn;//否
@property (nonatomic , strong) UITextField * weightText;
@property (nonatomic , strong) UITextField * freightText;
@property (nonatomic , strong) UIView * ebayView;
@property (nonatomic , strong) UIButton * merchantBtn1;//是
@property (nonatomic , strong) UIButton * notMerchantBtn1;//否
@property (nonatomic , strong) UIButton * generalbtn;//一般物品
@property (nonatomic , strong) UIButton * readBtn1;//3c
@property (nonatomic , strong) UIButton * readBtn2;//3c文字
@property (nonatomic , strong) UIButton * seletedBtn1;


@property (nonatomic , strong) UIView * bottomView;
@property (nonatomic , strong) UILabel * transferFee;//转账费
@property (nonatomic , strong) UILabel * handling;//当地处理费
@property (nonatomic , strong) UILabel * deliveryCosts;//运送费
@property (nonatomic , strong) UILabel * contractFee;//代工费
@property (nonatomic , strong) UILabel * payment;//预付款
@property (nonatomic , strong) UILabel * totalPrice;//共计

@property (nonatomic , strong) UIButton * exitBtn;

@end

@implementation CalculateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    platfrom = 0;
    isMerchant = YES;//yahoo网站是否是商家  默认是  0.08
    tax = 0.08;
    isCategory = YES;
    self.y_navBarBgColor = [UIColor whiteColor];
    [self creareUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.title = @"费用试算";
    self.view.backgroundColor = [Unity getColor:@"f0f0f0"];
}
- (void)creareUI{
    
    _scrollView = [UIScrollView new];
    //    _scrollView.delegate=self;
    _scrollView.showsVerticalScrollIndicator = FALSE;//垂直滚动条
    _scrollView.showsHorizontalScrollIndicator = FALSE;//水平滚动条
    
    [self.view addSubview:_scrollView];
    _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kWidth(50)-bottomH);
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }//解决导航栏设置透明的情况下 scrollView发生偏移的问题：
    
    [self.scrollView addSubview:self.topView];
    [self.scrollView addSubview:self.yahooView];
    [self.scrollView addSubview:self.ebayView];
    [self.scrollView addSubview:self.wView];
    [self.scrollView addSubview:self.bottomView];
//    [self.scrollView addSubview:self.cashBtn];
//
    /*将ui添加到scrollView数组中*/
    [self.scrollView sd_addSubviews:@[self.topView,self.yahooView,self.wView,self.bottomView]];

    // scrollview自动contentsize
    [self.scrollView setupAutoContentSizeWithBottomView:self.bottomView bottomMargin:0];
    
    [self.view addSubview:self.exitBtn];
}
- (UIButton *)exitBtn{
    if (!_exitBtn) {
        _exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _exitBtn.frame = CGRectMake(0, SCREEN_HEIGHT-bottomH-kWidth(50), SCREEN_WIDTH, kWidth(50));
        [_exitBtn addTarget:self action:@selector(exitClick) forControlEvents:UIControlEventTouchUpInside];
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, kWidth(50));
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
        [gradientLayer setColors:@[(id)[[Unity getColor:@"aa112d"] CGColor],(id)[[Unity getColor:@"e5294c"] CGColor]]];//渐变数组
        [_exitBtn.layer addSublayer:gradientLayer];
        
        [_exitBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [_exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _exitBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _exitBtn;
}
- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:90])];
        _topView.backgroundColor = [UIColor whiteColor];
        [_topView addSubview:self.webL];
        [_topView addSubview:self.yahooBtn];
        [_topView addSubview:self.yahooImg];
        [_topView addSubview:self.ebayBtn];
        [_topView addSubview:self.ebayImg];
        
        [_topView addSubview:self.goodId];
        [_topView addSubview:self.goodText];
        [_topView addSubview:self.currency];
    }
    return _topView;
}
- (UILabel *)webL{
    if (!_webL) {
        _webL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:20], [Unity countcoordinatesW:80], [Unity countcoordinatesH:15])];
        _webL.text = @"选择网站:";
        _webL.textColor = LabelColor3;
        _webL.font = [UIFont systemFontOfSize:FontSize(14)];
        [_webL sizeToFit];
    }
    return _webL;
}
- (UIButton *)yahooBtn{
    if (!_yahooBtn) {
        _yahooBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:100], [Unity countcoordinatesH:20], [Unity countcoordinatesW:15], [Unity countcoordinatesW:15])];
        [_yahooBtn addTarget:self action:@selector(yahooClick:) forControlEvents:UIControlEventTouchUpInside];
        [_yahooBtn setBackgroundImage:[UIImage imageNamed:@"未选啊"] forState:UIControlStateNormal];
        [_yahooBtn setBackgroundImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
        _yahooBtn.selected = YES;
    }
    return _yahooBtn;
}
- (UIImageView *)yahooImg{
    if (!_yahooImg) {
        _yahooImg = [[UIImageView alloc]initWithFrame:CGRectMake(_yahooBtn.right+[Unity countcoordinatesW:10], [Unity countcoordinatesH:22.5], [Unity countcoordinatesW:50], [Unity countcoordinatesH:10])];
        _yahooImg.image = [UIImage imageNamed:@"雅虎"];
    }
    return _yahooImg;
}
- (UIButton *)ebayBtn{
    if (!_ebayBtn) {
        _ebayBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:220], [Unity countcoordinatesH:20], [Unity countcoordinatesW:15], [Unity countcoordinatesW:15])];
        [_ebayBtn addTarget:self action:@selector(ebayClick:) forControlEvents:UIControlEventTouchUpInside];
        [_ebayBtn setBackgroundImage:[UIImage imageNamed:@"未选啊"] forState:UIControlStateNormal];
        [_ebayBtn setBackgroundImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
    }
    return _ebayBtn;
}
- (UIImageView *)ebayImg{
    if (!_ebayImg) {
        _ebayImg = [[UIImageView alloc]initWithFrame:CGRectMake(_ebayBtn.right+[Unity countcoordinatesW:10], [Unity countcoordinatesH:20], [Unity countcoordinatesW:38], [Unity countcoordinatesH:15])];
        _ebayImg.image = [UIImage imageNamed:@"易贝"];
    }
    return _ebayImg;
}
- (UILabel *)goodId{
    if (!_goodId) {
        _goodId = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:55], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15])];
        _goodId.text = @"商品费用:";
        _goodId.textColor = LabelColor3;
        _goodId.font = [UIFont systemFontOfSize:FontSize(14)];
        [_goodId sizeToFit];
    }
    return _goodId;
}
- (UITextField *)goodText{
    if (!_goodText) {
        _goodText = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:100], _goodId.top, SCREEN_WIDTH-[Unity countcoordinatesW:135], [Unity countcoordinatesH:15])];
        _goodText.placeholder = @"请输入费用";
        _goodText.font = [UIFont systemFontOfSize:FontSize(14)];
        _goodText.textAlignment = NSTextAlignmentRight;
        _goodText.keyboardType = UIKeyboardTypeDecimalPad;
        [_goodText addTarget:self action:@selector(goodText:) forControlEvents:UIControlEventEditingChanged];
    }
    return _goodText;
}
- (UILabel *)currency{
    if (!_currency) {
        _currency = [[UILabel alloc]initWithFrame:CGRectMake(_goodText.right, _goodText.top, [Unity countcoordinatesW:30], _goodText.height)];
        _currency.text = @"円";
        _currency.textAlignment = NSTextAlignmentRight;
        _currency.textColor = LabelColor6;
        _currency.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _currency;
}
//yahooView
- (UIView *)yahooView{
    if (!_yahooView) {
        _yahooView = [[UIView alloc]initWithFrame:CGRectMake(0, _topView.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:85]+[Unity countcoordinatesH:50])];
        _yahooView.backgroundColor = [UIColor whiteColor];
        UILabel * label1 = [Unity lableViewAddsuperview_superView:_yahooView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20]) _string:@"是否为商家:" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label1.backgroundColor = [UIColor clearColor];
        
        [_yahooView addSubview:self.merchantBtn];
        [_yahooView addSubview:self.notMerchantBtn];
        
        UILabel *  label = [Unity lableViewAddsuperview_superView:_yahooView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:40], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20]) _string:@"国际运输方式:" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
        NSArray * arr = @[@"  EMS",@"  SAL",@"  海运"];
        for (int i=0; i<arr.count; i++) {
            UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:110], [Unity countcoordinatesH:40]+i*[Unity countcoordinatesH:25], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
            btn.tag = 5000+i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:LabelColor6 forState:UIControlStateNormal];
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [btn setImage:[UIImage imageNamed:@"未选啊"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
            [_yahooView addSubview:btn];
            if (i==0) {
                btn.selected = YES;
                self.seletedBtn = btn;
                stream = @"ems";
            }
        }
    }
    return _yahooView;
}
- (UIView *)ebayView{
    if (!_ebayView) {
        _ebayView = [[UIView alloc]initWithFrame:CGRectMake(0, _topView.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:125])];
        _ebayView.backgroundColor = [UIColor whiteColor];
        UILabel * label2 = [Unity lableViewAddsuperview_superView:_ebayView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20]) _string:@"商品类别:" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label2.backgroundColor = [UIColor clearColor];
        [_ebayView addSubview:self.generalbtn];
        [_ebayView addSubview:self.readBtn1];
        [_ebayView addSubview:self.readBtn2];
        
        
        UILabel * label1 = [Unity lableViewAddsuperview_superView:_ebayView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:75], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20]) _string:@"是否有消费税:" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label1.backgroundColor = [UIColor clearColor];
        
        [_ebayView addSubview:self.merchantBtn1];
        [_ebayView addSubview:self.notMerchantBtn1];
        
        UILabel *  label = [Unity lableViewAddsuperview_superView:_ebayView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], label1.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20]) _string:@"国际运输方式:" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
        NSArray * arr = @[@"  UCS快递"];
        for (int i=0; i<arr.count; i++) {
            UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:110], label1.bottom+[Unity countcoordinatesH:10]+i*[Unity countcoordinatesH:25], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
            btn.tag = 5000+i;
//            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:LabelColor6 forState:UIControlStateNormal];
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [btn setImage:[UIImage imageNamed:@"未选啊"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
            [_ebayView addSubview:btn];
            if (i==0) {
                btn.selected = YES;
                self.seletedBtn1 = btn;
            }
        }
    }
    return _ebayView;
}
- (UIButton *)generalbtn{
    if (!_generalbtn) {
        _generalbtn = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:110], [Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
        [_generalbtn addTarget:self action:@selector(generalClick) forControlEvents:UIControlEventTouchUpInside];
        [_generalbtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_generalbtn setTitle:@"  一般物品" forState:UIControlStateNormal];
        _generalbtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _generalbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_generalbtn setImage:[UIImage imageNamed:@"未选啊"] forState:UIControlStateNormal];
        [_generalbtn setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
        _generalbtn.selected = YES;
    }
    return _generalbtn;
}
- (UIButton *)readBtn1{
    if (!_readBtn1) {
        _readBtn1 = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:110], _generalbtn.bottom+[Unity countcoordinatesH:5]+([Unity countcoordinatesH:20]-15)/2, 15, 15)];
        [_readBtn1 addTarget:self action:@selector(read1Click) forControlEvents:UIControlEventTouchUpInside];
        [_readBtn1 setImage:[UIImage imageNamed:@"未选啊"] forState:UIControlStateNormal];
        [_readBtn1 setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
    }
    return _readBtn1;
}
- (UIButton *)readBtn2{
    if (!_readBtn2) {
        _readBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(_readBtn1.right+5, _generalbtn.bottom+[Unity countcoordinatesH:5], SCREEN_WIDTH-20-[Unity countcoordinatesW:120], [Unity countcoordinatesH:30])];
        [_readBtn2 addTarget:self action:@selector(read1Click) forControlEvents:UIControlEventTouchUpInside];
        [_readBtn2 setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_readBtn2 setTitle:@"3C电子类、手表、名牌包、高尔夫球杆、钓竿、纯金及纯银制产品" forState:UIControlStateNormal];
        _readBtn2.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _readBtn2.titleLabel.lineBreakMode = 0;
    }
    return _readBtn2;
}
- (UIView *)wView{
    if (!_wView) {
        _wView = [[UIView alloc]initWithFrame:CGRectMake(0, _yahooView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:60])];
        _wView.backgroundColor = [UIColor whiteColor];
        UILabel * weight = [Unity lableViewAddsuperview_superView:_wView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:5], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20]) _string:@"参考重量:" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        UILabel * Dw = [Unity lableViewAddsuperview_superView:_wView _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:25],weight.top,[Unity countcoordinatesW:15],weight.height) _string:@"kg" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentRight];
        _weightText = [Unity textFieldAddSuperview_superView:_wView _subViewFrame:CGRectMake([Unity countcoordinatesW:100], weight.top, SCREEN_WIDTH-[Unity countcoordinatesW:135], [Unity countcoordinatesH:20]) _placeT:@"请输入参考重量" _backgroundImage:nil _delegate:nil andSecure:NO andBackGroundColor:nil];
        _weightText.textAlignment = NSTextAlignmentRight;
        _weightText.keyboardType = UIKeyboardTypeDecimalPad;
        _weightText.font = [UIFont systemFontOfSize:FontSize(14)];
        [_weightText addTarget:self action:@selector(weightText:) forControlEvents:UIControlEventEditingChanged];
        UILabel * freightL = [Unity lableViewAddsuperview_superView:_wView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], weight.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20]) _string:@"预估当地运费:" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        Dw1 = [Unity lableViewAddsuperview_superView:_wView _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:35],freightL.top,[Unity countcoordinatesW:30],freightL.height) _string:@"円" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentRight];
        _freightText = [Unity textFieldAddSuperview_superView:_wView _subViewFrame:CGRectMake([Unity countcoordinatesW:100], freightL.top, SCREEN_WIDTH-[Unity countcoordinatesW:135], [Unity countcoordinatesH:20]) _placeT:@"请输入当地运费" _backgroundImage:nil _delegate:nil andSecure:NO andBackGroundColor:nil];
        _freightText.textAlignment = NSTextAlignmentRight;
        _freightText.keyboardType = UIKeyboardTypeDecimalPad;
        _freightText.font = [UIFont systemFontOfSize:FontSize(14)];
        [_freightText addTarget:self action:@selector(freightTextText:) forControlEvents:UIControlEventEditingChanged];
    }
    return _wView;
}
- (UIButton *)merchantBtn{
    if (!_merchantBtn) {
        _merchantBtn = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:110], [Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
        [_merchantBtn addTarget:self action:@selector(merchanClick) forControlEvents:UIControlEventTouchUpInside];
        [_merchantBtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_merchantBtn setTitle:@"  是" forState:UIControlStateNormal];
        _merchantBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _merchantBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_merchantBtn setImage:[UIImage imageNamed:@"未选啊"] forState:UIControlStateNormal];
        [_merchantBtn setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
        _merchantBtn.selected = YES;
    }
    return _merchantBtn;
}
- (UIButton *)notMerchantBtn{
    if (!_notMerchantBtn) {
        _notMerchantBtn = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:210], [Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
        [_notMerchantBtn addTarget:self action:@selector(notMerchanClick) forControlEvents:UIControlEventTouchUpInside];
        [_notMerchantBtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_notMerchantBtn setTitle:@"  否" forState:UIControlStateNormal];
        _notMerchantBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _notMerchantBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_notMerchantBtn setImage:[UIImage imageNamed:@"未选啊"] forState:UIControlStateNormal];
        [_notMerchantBtn setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
    }
    return _notMerchantBtn;
}
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, _wView.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:210])];
        _bottomView.backgroundColor = [UIColor whiteColor];
        NSArray * arr = @[@"银行转账费:",@"日本当地处理费:",@"国际运送费:",@"代工费:",@"预付款:"];
        for (int i=0; i<5; i++) {
            UILabel * label = [Unity lableViewAddsuperview_superView:_bottomView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15]+(i*[Unity countcoordinatesH:25]), [Unity countcoordinatesW:100], [Unity countcoordinatesH:20]) _string:arr[i] _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
            label.tag = 888+i;
            if (i == 0) {
                _transferFee = [Unity lableViewAddsuperview_superView:_bottomView _subViewFrame:CGRectMake([Unity countcoordinatesW:200], label.top, SCREEN_WIDTH-[Unity countcoordinatesW:210], [Unity countcoordinatesH:20]) _string:@"350.00円" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentRight];
            }else if (i == 1){
                _handling = [Unity lableViewAddsuperview_superView:_bottomView _subViewFrame:CGRectMake([Unity countcoordinatesW:200], label.top, SCREEN_WIDTH-[Unity countcoordinatesW:210], [Unity countcoordinatesH:20]) _string:@"500.00円" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentRight];
            }else if (i == 2){
                _deliveryCosts = [Unity lableViewAddsuperview_superView:_bottomView _subViewFrame:CGRectMake([Unity countcoordinatesW:200], label.top, SCREEN_WIDTH-[Unity countcoordinatesW:210], [Unity countcoordinatesH:20]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentRight];
            }else if (i == 3){
                _contractFee = [Unity lableViewAddsuperview_superView:_bottomView _subViewFrame:CGRectMake([Unity countcoordinatesW:200], label.top, SCREEN_WIDTH-[Unity countcoordinatesW:210], [Unity countcoordinatesH:20]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentRight];
            }else{
                _payment = [Unity lableViewAddsuperview_superView:_bottomView _subViewFrame:CGRectMake([Unity countcoordinatesW:200], label.top, SCREEN_WIDTH-[Unity countcoordinatesW:210], [Unity countcoordinatesH:20]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentRight];
            }
        }
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:150], SCREEN_WIDTH, 1)];
        line.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [_bottomView addSubview:line];
        UILabel * sumL = [Unity lableViewAddsuperview_superView:_bottomView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], line.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:50], [Unity countcoordinatesH:20]) _string:@"共计" _lableFont:[UIFont systemFontOfSize:FontSize(16)] _lableTxtColor:[Unity getColor:@"#aa112d"] _textAlignment:NSTextAlignmentLeft];
        _totalPrice = [Unity lableViewAddsuperview_superView:_bottomView _subViewFrame:CGRectMake([Unity countcoordinatesW:200], sumL.top, SCREEN_WIDTH-[Unity countcoordinatesW:210], [Unity countcoordinatesH:20]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(16)] _lableTxtColor:[Unity getColor:@"#aa112d"] _textAlignment:NSTextAlignmentRight];
    }
    return _bottomView;
}


- (void)merchanClick{
    isMerchant = YES;
    self.merchantBtn.selected = YES;
    self.notMerchantBtn.selected = NO;
    [self getComputationalCost];
}
- (void)notMerchanClick{
    isMerchant = NO;
    self.merchantBtn.selected = NO;
    self.notMerchantBtn.selected = YES;
    [self getComputationalCost];
}


#pragma mark  topView 事件
- (void)yahooClick:(UIButton *)btn{
    platfrom = 0;
    if (!btn.selected) {
        [self calculateCos:platfrom];
        self.goodText.frame = CGRectMake([Unity countcoordinatesW:100], _goodId.top, SCREEN_WIDTH-[Unity countcoordinatesW:135], [Unity countcoordinatesH:15]);
        self.currency.text = @"円";
        btn.selected = YES;
        self.ebayBtn.selected = NO;
        Dw1.text = @"円";
        self.freightText.frame = CGRectMake([Unity countcoordinatesW:100], [Unity countcoordinatesH:30], SCREEN_WIDTH-[Unity countcoordinatesW:135], [Unity countcoordinatesH:20]);
        self.transferFee.text = @"350.00円";
        self.handling.text = @"500.00円";
        /*将ui添加到scrollView数组中*/
        [self.scrollView sd_addSubviews:@[self.topView,self.yahooView,self.wView,self.bottomView]];
        self.yahooView.hidden = NO;
        self.ebayView.hidden = YES;
        self.wView.frame = CGRectMake(0, _yahooView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:60]);
        self.bottomView.frame = CGRectMake(0, _wView.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:210]);
        // scrollview自动contentsize
        [self.scrollView setupAutoContentSizeWithBottomView:self.bottomView bottomMargin:0];
        //
        UILabel *label = (UILabel *)[self.bottomView viewWithTag:889];
        label.text = @"日本当地处理费";
        [self getComputationalCost];
        [self weightText:self.weightText];
    }
}
- (void)ebayClick:(UIButton *)btn{
    platfrom = 5;
    if (!btn.selected) {
        [self calculateCos:platfrom];
        self.goodText.frame = CGRectMake([Unity countcoordinatesW:100], _goodId.top, SCREEN_WIDTH-[Unity countcoordinatesW:145], [Unity countcoordinatesH:15]);
        self.currency.text = @"美元";
        
        btn.selected = YES;
        self.yahooBtn.selected = NO;
        Dw1.text = @"美元";
        self.freightText.frame = CGRectMake([Unity countcoordinatesW:110], [Unity countcoordinatesH:30], SCREEN_WIDTH-[Unity countcoordinatesW:145], [Unity countcoordinatesH:20]);
        self.transferFee.text = @"5.00美元";
        self.handling.text = @"6.00美元";
        
        /*将ui添加到scrollView数组中*/
        [self.scrollView sd_addSubviews:@[self.topView,self.ebayView,self.wView,self.bottomView]];
        self.ebayView.hidden = NO;
        self.yahooView.hidden = YES;
        self.wView.frame = CGRectMake(0, _ebayView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:60]);
        self.bottomView.frame = CGRectMake(0, _wView.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:210]);
        // scrollview自动contentsize
        [self.scrollView setupAutoContentSizeWithBottomView:self.bottomView bottomMargin:0];
        UILabel *label = (UILabel *)[self.bottomView viewWithTag:889];
        label.text = @"美国当地处理费";
        [self getComputationalCost];
        [self weightText:self.weightText];
    }
}
- (void)goodText:(UITextField *)textField{
    [self calculateCos:platfrom];
}
- (void)weightText:(UITextField *)textField{
    if (platfrom == 0) {
        int max = 0;
        if ([stream isEqualToString:@"sal"]) {
            max = 29;
        }else{
            max = 30;
        }
        NSLog(@"%@",textField.text);
        if ([textField.text floatValue]>max) {
            [WHToast showMessage:[NSString stringWithFormat:@"重量不能超过%dKG",max] originY:SCREEN_HEIGHT/2 duration:2 finishHandler:^{}];
            self.weightText.text = [NSString stringWithFormat:@"%d",max];
            self.deliveryCosts.text = [NSString stringWithFormat:@"%ld.00円",(long)[Unity getFreightWithWeight:self.weightText.text WithSteam:stream]];
        }else{
            self.deliveryCosts.text = [NSString stringWithFormat:@"%ld.00円",(long)[Unity getFreightWithWeight:textField.text WithSteam:stream]];
        }
    }else{
        self.deliveryCosts.text = [NSString stringWithFormat:@"%ld.00RMB",(long)[self getFreightWithWeight1:textField.text WithSteam:@""]];
    }
    
    [self getComputationalCost];
}
- (void)freightTextText:(UITextField *)textField{
    [self getComputationalCost];
}
- (UIButton *)merchantBtn1{
    if (!_merchantBtn1) {
        _merchantBtn1 = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:110], [Unity countcoordinatesH:75], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
        [_merchantBtn1 addTarget:self action:@selector(merchanClick1) forControlEvents:UIControlEventTouchUpInside];
        [_merchantBtn1 setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_merchantBtn1 setTitle:@"  是" forState:UIControlStateNormal];
        _merchantBtn1.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _merchantBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_merchantBtn1 setImage:[UIImage imageNamed:@"未选啊"] forState:UIControlStateNormal];
        [_merchantBtn1 setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
        _merchantBtn1.selected = YES;
//        isMerchant = YES;
//        tax = 0.08;
    }
    return _merchantBtn1;
}
- (UIButton *)notMerchantBtn1{
    if (!_notMerchantBtn1) {
        _notMerchantBtn1 = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:210], [Unity countcoordinatesH:75], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
        [_notMerchantBtn1 addTarget:self action:@selector(notMerchanClick1) forControlEvents:UIControlEventTouchUpInside];
        [_notMerchantBtn1 setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_notMerchantBtn1 setTitle:@"  否" forState:UIControlStateNormal];
        _notMerchantBtn1.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _notMerchantBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_notMerchantBtn1 setImage:[UIImage imageNamed:@"未选啊"] forState:UIControlStateNormal];
        [_notMerchantBtn1 setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
    }
    return _notMerchantBtn1;
}
- (void)merchanClick1{
//    isMerchant = YES;
    self.merchantBtn1.selected = YES;
    self.notMerchantBtn1.selected = NO;
    tax = 0.08;
    [self getComputationalCost];
    
}
- (void)notMerchanClick1{
//    isMerchant = NO;
    self.merchantBtn1.selected = NO;
    self.notMerchantBtn1.selected = YES;
    tax = 0;
    [self getComputationalCost];
}
- (void)btnClick:(UIButton *)btn{
    if (btn.tag == 5000) {
        stream = @"ems";
    }else if (btn.tag == 5001){
        stream = @"sal";
    }else if (btn.tag == 5002){
        stream = @"ship";
    }else{
        stream = @"kg";
    }
    if (btn != self.seletedBtn) {
        self.seletedBtn.selected = NO;
        btn.selected = YES;
        self.seletedBtn = btn;
    }
    
    int max = 0;
    if ([stream isEqualToString:@"sal"]) {
        max = 29;
    }else{
        max = 30;
        
    }
    if (self.weightText.text.length != 0) {
        //计算国际运送费
        if ([self.weightText.text floatValue]>max) {
            [WHToast showMessage:[NSString stringWithFormat:@"重量不能超过%dKG",max] originY:SCREEN_HEIGHT/2 duration:2 finishHandler:^{}];
            self.weightText.text = [NSString stringWithFormat:@"%d",max];
            self.deliveryCosts.text = [NSString stringWithFormat:@"%ld.00円",(long)[Unity getFreightWithWeight:self.weightText.text WithSteam:stream]];
        }else{
            self.deliveryCosts.text = [NSString stringWithFormat:@"%ld.00円",(long)[Unity getFreightWithWeight:self.weightText.text WithSteam:stream]];
        }
    }
    [self getComputationalCost];
}
- (void)getComputationalCost{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"exrate"];
    if (platfrom == 0) {
        if (self.weightText.text.length == 0 && self.freightText.text.length == 0) {
            self.payment.text = @"";
            self.totalPrice.text = @"";
        }else{
            float aaa;
            float bbb;
            if (self.weightText.text.length == 0) {
                aaa = [Unity getFreightWithWeight:@"0" WithSteam:stream];
            }else{
                aaa = [Unity getFreightWithWeight:self.weightText.text WithSteam:stream];
            }
            if (self.freightText.text.length == 0) {
                bbb = 0.0;
            }else{
                bbb = [self.freightText.text floatValue];
            }
            if (isMerchant) {
                float sum = ([self.goodText.text floatValue]*1.08+bbb+350+500+aaa)*[dic[@"w_tw_jp"] floatValue]+[self.contractFee.text floatValue];
                float advance = ([self.goodText.text floatValue]*1.1+350+500)*[dic[@"w_tw_jp"] floatValue]+[self.contractFee.text floatValue];
                self.payment.text = [NSString stringWithFormat:@"%.0f.00RMB",ceilf(advance)];
                self.totalPrice.text = [NSString stringWithFormat:@"%.0f.00RMB",ceilf(sum)];
                
            }else{
                float sum = ([self.goodText.text floatValue]+bbb+350+500+aaa)*[dic[@"w_tw_jp"] floatValue]+[self.contractFee.text floatValue];
                float advance = ([self.goodText.text floatValue]+350+500)*[dic[@"w_tw_jp"] floatValue]+[self.contractFee.text floatValue];
                self.payment.text = [NSString stringWithFormat:@"%.0f.00RMB",ceilf(advance)];
                self.totalPrice.text = [NSString stringWithFormat:@"%.0f.00RMB",ceilf(sum)];
            }
        }
    }else{
        if (self.weightText.text.length == 0 && self.freightText.text.length == 0) {
            self.payment.text = @"";
            self.totalPrice.text = @"";
        }else{
            float aaa;
            float bbb;
            if (self.weightText.text.length == 0) {
                aaa = [self getFreightWithWeight1:@"0" WithSteam:stream];
            }else{
                aaa = [self getFreightWithWeight1:self.weightText.text WithSteam:stream];
            }
            if (self.freightText.text.length == 0) {
                bbb = 0;
            }else{
                bbb = [self.freightText.text floatValue];
            }
            float advance = ([self.goodText.text floatValue]+6+5)*[dic[@"w_tw_us"] floatValue]+cost;
            self.payment.text = [NSString stringWithFormat:@"%.0f.00RMB",ceilf(advance)];
            
            
            
            float sum = ([self.goodText.text floatValue]+[self.goodText.text floatValue]*tax+bbb+6+5)*[dic[@"w_tw_us"] floatValue]+gjyf+cost;
            self.totalPrice.text = [NSString stringWithFormat:@"%.0f.00RMB",ceilf(sum)];
        }
    }
    
}
- (void)calculateCos:(NSInteger)platform{
    if (platfrom == 0) {
        float result = 0.0;//费用计算
        NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"exrate"];
        result = [self.goodText.text floatValue]*0.03*[dic[@"w_tw_jp"] floatValue];
        if (result > 50) {
            self.contractFee.text = @"50.00RMB";
        }else if (result <10){
            self.contractFee.text = @"10.00RMB";
        }else{
            self.contractFee.text = [NSString stringWithFormat:@"%.0f.00RMB",ceilf(result)];
        }
        [self getComputationalCost];
    }else{
        NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"exrate"];
        if ([self.goodText.text floatValue]<=25) {
            cost = 20;
            self.contractFee.text = @"20.00RMB";
        }else if ([self.goodText.text floatValue]>25 && [self.goodText.text floatValue]<=50){
            cost = ceilf([self.goodText.text floatValue]*0.12*[dic[@"w_tw_us"] floatValue]);
            self.contractFee.text = [NSString stringWithFormat:@"%.0f.00RMB",ceilf([self.goodText.text floatValue]*0.12*[dic[@"w_tw_us"] floatValue])];
        }else{
            cost = ceilf([self.goodText.text floatValue]*0.1*[dic[@"w_tw_us"] floatValue]);
            self.contractFee.text = [NSString stringWithFormat:@"%.0f.00RMB",ceilf([self.goodText.text floatValue]*0.1*[dic[@"w_tw_us"] floatValue])];
            if ([self.contractFee.text floatValue]>300) {
                cost = 300;
                self.contractFee.text = @"300.00RMB";
            }
        }
    }
    if ([self.goodText.text isEqualToString:@""]) {
        self.contractFee.text=@"";
    }
}
- (NSInteger)getFreightWithWeight1:(NSString *)weight WithSteam:(NSString *)steam{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"exrate"];
    if (isCategory) {//一般
        if ([self.weightText.text floatValue]*2.2<1) {
            gjyf = ceilf(11*[dic[@"w_tw_us"] floatValue]);
            return ceilf(11*[dic[@"w_tw_us"] floatValue]);
        }else{
            gjyf = ceilf((11+(ceilf([self.weightText.text floatValue]*2.2)-1)*4.5)*[dic[@"w_tw_us"] floatValue]);
            return ceilf((11+(ceilf([self.weightText.text floatValue]*2.2)-1)*4.5)*[dic[@"w_tw_us"] floatValue]);
        }
    }else{//3c
        if ([self.weightText.text floatValue]*2.2<1) {
            gjyf = ceilf(13*[dic[@"w_tw_us"] floatValue]);
            return ceilf(13*[dic[@"w_tw_us"] floatValue]);
        }else{
            gjyf = ceilf((13+(ceilf([self.weightText.text floatValue]*2.2)-1)*5)*[dic[@"w_tw_us"] floatValue]);
            return ceilf((13+(ceilf([self.weightText.text floatValue]*2.2)-1)*5)*[dic[@"w_tw_us"] floatValue]);
        }
    }
    return 0;
}
- (void)generalClick{
    self.generalbtn.selected = YES;
    isCategory = YES;
    self.readBtn1.selected = NO;
    if (self.weightText.text.length != 0) {
        self.deliveryCosts.text = [NSString stringWithFormat:@"%ld.00RMB",(long)[self getFreightWithWeight1:self.weightText.text WithSteam:@""]];
    }
    [self getComputationalCost];
}
- (void)read1Click{
    self.generalbtn.selected = NO;
    isCategory = NO;
    self.readBtn1.selected = YES;
    if (self.weightText.text.length != 0) {
        self.deliveryCosts.text = [NSString stringWithFormat:@"%ld.00RMB",(long)[self getFreightWithWeight1:self.weightText.text WithSteam:@""]];
    }
    [self getComputationalCost];
}
- (void)exitClick{
    [self.navigationController popViewControllerAnimated:YES];
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
