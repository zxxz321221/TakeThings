//
//  TrialViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/24.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "TrialViewController.h"
#import "EntrustViewController.h"
#import "LoginViewController.h"
//#define bottomH (IS_iPhoneX ? [Unity countcoordinatesH:70] : [Unity countcoordinatesH:50])
@interface TrialViewController ()
{
    NSInteger btnIndex;
    BOOL isMerchant;//yes 是 no 否
    NSString * stream;//配送方式  如果是日本配送方式默认EMS
    NSInteger freight;//国际运送费默认0
    NSDictionary * userInfo;
    NSString * goodsStr;
}
@property (nonatomic , strong) UIScrollView * scrollView;
@property (nonatomic , strong) UILabel * navL;
@property (nonatomic , strong) UIView * goodsView;
@property (nonatomic , strong) UIView * freightView;
@property (nonatomic , strong) UIView * costView;

@property (nonatomic , strong) UIButton * biddingBtn;

@property (nonatomic , strong) UIImageView * goodsImage;
@property (nonatomic , strong) UILabel * goodsName;
@property (nonatomic , strong) UILabel * currentPriceL;//目前出价
@property (nonatomic , strong) UILabel * currencyL;//商品所在国家货币金额
@property (nonatomic , strong) UILabel * rmbL;//商品金额转换成人民币

//三个单选按钮和label
@property (nonatomic,strong) UIButton *selectedBtn;
@property (nonatomic , strong) UITextField * weightText;
@property (nonatomic , strong) UITextField * freightText;

//costView UI
@property (nonatomic , strong) UILabel * transferFee;//转账费
@property (nonatomic , strong) UILabel * handling;//当地处理费
@property (nonatomic , strong) UILabel * deliveryCosts;//运送费
@property (nonatomic , strong) UILabel * contractFee;//代工费
@property (nonatomic , strong) UILabel * payment;//预付款
@property (nonatomic , strong) UILabel * totalPrice;//共计

@property (nonatomic , strong) UIButton * merchantBtn;//是
@property (nonatomic , strong) UIButton * notMerchantBtn;//否

@property (nonatomic , strong) UIView * wView;
@property (nonatomic , strong) UIButton * seletedBtn;

@property (nonatomic , strong) UIView * bottomView;
@property (nonatomic , strong) UIButton * collectionBtn;
@property (nonatomic , strong) UIImageView * collImg;
@property (nonatomic , strong) UIButton * bidBtn;

@end

@implementation TrialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creareUI];
    [self.view addSubview:self.biddingBtn];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.navL];
    
    [self reloadUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    if (self.isDetail) {
        self.title = @"费用试算";
    }else{
        self.title = @"竞拍下单";
        if (userInfo == nil){
            return;
        }
        NSDictionary * dic = @{@"customer":userInfo[@"member_id"],@"area":self.platform,@"item":self.goodsID};
        [GZMrequest getWithURLString:[GZMUrl get_isCollection_url] parameters:dic success:^(NSDictionary *data) {
            NSLog(@"%@",data);
            if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
                goodsStr = [NSString stringWithFormat:@"%@",data[@"data"][@"goods"]];
                if (![goodsStr isEqualToString:@"0"]) {//商品已收藏
                    self.collImg.image = [UIImage imageNamed:@"已收藏"];
                }
            }
        } failure:^(NSError *error) {
            
        }];
    }
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [Unity getColor:@"#f0f0f0"];
}
- (void)creareUI{
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
    
    [self.scrollView addSubview:self.goodsView];
    [self.scrollView addSubview:self.freightView];
    [self.scrollView addSubview:self.wView];
    [self.scrollView addSubview:self.costView];
    
    /*将ui添加到scrollView数组中*/
    [self.scrollView sd_addSubviews:@[self.goodsView,self.freightView,self.wView,self.costView]];
    
    // scrollview自动contentsize
    [self.scrollView setupAutoContentSizeWithBottomView:self.costView bottomMargin:bottomH];
}
- (UIView *)goodsView{
    if (!_goodsView) {
        _goodsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:120])];
        _goodsView.backgroundColor = [UIColor whiteColor];
        [_goodsView addSubview:self.goodsImage];
        [_goodsView addSubview:self.goodsName];
        [_goodsView addSubview:self.currentPriceL];
        [_goodsView addSubview:self.currencyL];
        [_goodsView addSubview:self.rmbL];
    }
    return _goodsView;
}
- (UIView *)freightView{
    if (!_freightView) {
        _freightView = [[UIView alloc]initWithFrame:CGRectMake(0, _goodsView.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:85]+[Unity countcoordinatesH:50])];
        _freightView.backgroundColor = [UIColor whiteColor];
        UILabel * label1 = [Unity lableViewAddsuperview_superView:_freightView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20]) _string:@"是否为商家:" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label1.backgroundColor = [UIColor clearColor];
        
        [_freightView addSubview:self.merchantBtn];
        [_freightView addSubview:self.notMerchantBtn];
        
        UILabel *  label = [Unity lableViewAddsuperview_superView:_freightView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:40], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20]) _string:@"国际运输方式:" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
        NSArray * arr = @[@"  EMS",@"  SAL",@"  海运"];
        for (int i=0; i<arr.count; i++) {
            UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:100], [Unity countcoordinatesH:40]+i*[Unity countcoordinatesH:25], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
            btn.tag = 5000+i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:LabelColor6 forState:UIControlStateNormal];
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [btn setImage:[UIImage imageNamed:@"未选啊"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
            [self.freightView addSubview:btn];
            if (i==0) {
                btn.selected = YES;
                self.seletedBtn = btn;
                stream = @"ems";
            }
        }
    }
    return _freightView;
}
- (UIView *)wView{
    if (!_wView) {
        _wView = [[UIView alloc]initWithFrame:CGRectMake(0, _freightView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:60])];
        _wView.backgroundColor = [UIColor whiteColor];
        UILabel * weight = [Unity lableViewAddsuperview_superView:_wView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:5], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20]) _string:@"参考重量:" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        UILabel * Dw = [Unity lableViewAddsuperview_superView:_wView _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity widthOfString:@"kg" OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:20]]-[Unity countcoordinatesW:10], weight.top, [Unity widthOfString:@"kg" OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:20]], [Unity countcoordinatesH:20]) _string:@"kg" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentRight];
        _weightText = [Unity textFieldAddSuperview_superView:_wView _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:170]-Dw.width, weight.top, [Unity countcoordinatesW:150], [Unity countcoordinatesH:20]) _placeT:@"请输入参考重量" _backgroundImage:nil _delegate:nil andSecure:NO andBackGroundColor:nil];
        _weightText.textAlignment = NSTextAlignmentRight;
        _weightText.keyboardType = UIKeyboardTypeDecimalPad;
        _weightText.font = [UIFont systemFontOfSize:FontSize(14)];
        [_weightText addTarget:self action:@selector(weightText:) forControlEvents:UIControlEventEditingChanged];
        UILabel * freightL = [Unity lableViewAddsuperview_superView:_wView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], weight.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20]) _string:@"预估当地运费:" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        NSString * str;
        if ([self.platform isEqualToString:@"0"]) {
            str = @"円";
        }else{
            str = @"美元";
        }
        UILabel * Dw1 = [Unity lableViewAddsuperview_superView:_wView _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity widthOfString:str OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:20]]-[Unity countcoordinatesW:10], freightL.top, [Unity widthOfString:str OfFontSize:FontSize(14) OfHeight:[Unity countcoordinatesH:20]], [Unity countcoordinatesH:20]) _string:str _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentRight];
        _freightText = [Unity textFieldAddSuperview_superView:_wView _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:170]-Dw1.width, freightL.top, [Unity countcoordinatesW:150], [Unity countcoordinatesH:20]) _placeT:@"请输入当地运费" _backgroundImage:nil _delegate:nil andSecure:NO andBackGroundColor:nil];
        _freightText.textAlignment = NSTextAlignmentRight;
        _freightText.keyboardType = UIKeyboardTypeDecimalPad;
        _freightText.font = [UIFont systemFontOfSize:FontSize(14)];
        [_freightText addTarget:self action:@selector(freightTextText:) forControlEvents:UIControlEventEditingChanged];
    }
    return _wView;
}

- (UIView *)costView{
    if (!_costView) {
        _costView = [[UIView alloc]initWithFrame:CGRectMake(0, _wView.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:210])];
        _costView.backgroundColor = [UIColor whiteColor];
        NSArray * arr = @[@"银行转账费:",@"日本当地处理费:",@"国际运送费:",@"代工费:",@"预付款:"];
        for (int i=0; i<5; i++) {
            UILabel * label = [Unity lableViewAddsuperview_superView:_costView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15]+(i*[Unity countcoordinatesH:25]), [Unity countcoordinatesW:100], [Unity countcoordinatesH:20]) _string:arr[i] _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
            if (i == 0) {
                _transferFee = [Unity lableViewAddsuperview_superView:_costView _subViewFrame:CGRectMake([Unity countcoordinatesW:200], label.top, SCREEN_WIDTH-[Unity countcoordinatesW:210], [Unity countcoordinatesH:20]) _string:@"350.00円" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentRight];
            }else if (i == 1){
                _handling = [Unity lableViewAddsuperview_superView:_costView _subViewFrame:CGRectMake([Unity countcoordinatesW:200], label.top, SCREEN_WIDTH-[Unity countcoordinatesW:210], [Unity countcoordinatesH:20]) _string:@"500.00円" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentRight];
            }else if (i == 2){
                _deliveryCosts = [Unity lableViewAddsuperview_superView:_costView _subViewFrame:CGRectMake([Unity countcoordinatesW:200], label.top, SCREEN_WIDTH-[Unity countcoordinatesW:210], [Unity countcoordinatesH:20]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentRight];
            }else if (i == 3){
                _contractFee = [Unity lableViewAddsuperview_superView:_costView _subViewFrame:CGRectMake([Unity countcoordinatesW:200], label.top, SCREEN_WIDTH-[Unity countcoordinatesW:210], [Unity countcoordinatesH:20]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentRight];
            }else{
                _payment = [Unity lableViewAddsuperview_superView:_costView _subViewFrame:CGRectMake([Unity countcoordinatesW:200], label.top, SCREEN_WIDTH-[Unity countcoordinatesW:210], [Unity countcoordinatesH:20]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentRight];
            }
        }
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:150], SCREEN_WIDTH, 1)];
        line.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [_costView addSubview:line];
        UILabel * sumL = [Unity lableViewAddsuperview_superView:_costView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], line.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:50], [Unity countcoordinatesH:20]) _string:@"共计" _lableFont:[UIFont systemFontOfSize:FontSize(16)] _lableTxtColor:[Unity getColor:@"#aa112d"] _textAlignment:NSTextAlignmentLeft];
        _totalPrice = [Unity lableViewAddsuperview_superView:_costView _subViewFrame:CGRectMake([Unity countcoordinatesW:200], sumL.top, SCREEN_WIDTH-[Unity countcoordinatesW:210], [Unity countcoordinatesH:20]) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(16)] _lableTxtColor:[Unity getColor:@"#aa112d"] _textAlignment:NSTextAlignmentRight];
    }
    return _costView;
}
- (UIButton *)biddingBtn{
    if (!_biddingBtn) {
        _biddingBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NavBarHeight-[Unity countcoordinatesH:50], SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        [_biddingBtn addTarget:self action:@selector(biddingClick) forControlEvents:UIControlEventTouchUpInside];
        CAGradientLayer *layerG = [CAGradientLayer layer];
        layerG.colors=@[(__bridge id)[Unity getColor:@"#aa112d"].CGColor,(__bridge id)[Unity getColor:@"#e5294c"].CGColor];
        layerG.startPoint = CGPointMake(0, 0.5);
        layerG.endPoint = CGPointMake(1, 0.5);
        layerG.frame = _biddingBtn.bounds;
        [_biddingBtn.layer addSublayer:layerG];
        [_biddingBtn setTitle:@"我要竞标" forState:UIControlStateNormal];
        [_biddingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _biddingBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
        if (!self.isDetail) {
            _biddingBtn.hidden = YES;
        }
    }
    return _biddingBtn;
}
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NavBarHeight-bottomH, SCREEN_WIDTH, bottomH)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [_bottomView addSubview:self.collectionBtn];
        [_bottomView addSubview:self.bidBtn];
        if (self.isDetail) {
            _bottomView.hidden = YES;
        }
    }
    return _bottomView;
}
- (UIButton *)collectionBtn{
    if (!_collectionBtn) {
        _collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _collectionBtn.frame = CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:5], [Unity countcoordinatesW:40], [Unity countcoordinatesH:45]);
        [_collectionBtn addTarget:self action:@selector(collectionClick) forControlEvents:UIControlEventTouchUpInside];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:25], _collectionBtn.width, [Unity countcoordinatesH:15])];
        label.text = @"收藏";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = LabelColor6;
        label.font = [UIFont systemFontOfSize:FontSize(12)];
        [_collectionBtn addSubview:label];
        [_collectionBtn addSubview:self.collImg];
    }
    return _collectionBtn;
}
- (UIImageView *)collImg{
    if (!_collImg) {
        _collImg = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _collImg.image = [UIImage imageNamed:@"未收藏"];
    }
    return _collImg;
}
- (UIButton *)bidBtn{
    if (!_bidBtn) {
        _bidBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:65], [Unity countcoordinatesH:5], [Unity countcoordinatesW:245], [Unity countcoordinatesH:40])];
        [_bidBtn addTarget:self action:@selector(bidBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _bidBtn.backgroundColor = [Unity getColor:@"aa112d"];
        [_bidBtn setTitle:@"我要竞标" forState:UIControlStateNormal];
        [_bidBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _bidBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
        _bidBtn.layer.cornerRadius = _bidBtn.height/2;
        _bidBtn.layer.masksToBounds = YES;
    }
    return _bidBtn;
}
- (UILabel *)navL{
    if (!_navL) {
        _navL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        _navL.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return _navL;
}
- (UIImageView *)goodsImage{
    if (!_goodsImage) {
        _goodsImage = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:90], [Unity countcoordinatesH:90])];
        [_goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.imageUrl]] placeholderImage:[UIImage imageNamed:@"Loading"]];
        _goodsImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _goodsImage;
}
- (UILabel *)goodsName{
    if (!_goodsName) {
        _goodsName = [[UILabel alloc]initWithFrame:CGRectMake(_goodsImage.right+[Unity countcoordinatesW:10], _goodsImage.top+[Unity countcoordinatesH:5], SCREEN_WIDTH-[Unity countcoordinatesW:120], [Unity countcoordinatesH:40])];
        _goodsName.text = self.goodsTitle;
        _goodsName.textColor = LabelColor3;
        _goodsName.textAlignment = NSTextAlignmentLeft;
        _goodsName.font = [UIFont systemFontOfSize:FontSize(14)];
        _goodsName.numberOfLines = 0;
    }
    return _goodsName;
}
- (UILabel *)currentPriceL{
    if (!_currentPriceL) {
        _currentPriceL = [[UILabel alloc]initWithFrame:CGRectMake(_goodsName.left, _goodsName.bottom+[Unity countcoordinatesH:15], 100, [Unity countcoordinatesH:15])];
        _currentPriceL.text = @"目前价格:";
        _currentPriceL.font = [UIFont systemFontOfSize:FontSize(14)];
        _currentPriceL.textColor = LabelColor6;
        [_currentPriceL sizeToFit];
    }
    return _currentPriceL;
}
- (UILabel *)currencyL{
    if (!_currencyL) {
        _currencyL = [[UILabel alloc]initWithFrame:CGRectMake(_currentPriceL.right, _currentPriceL.top, 150, [Unity countcoordinatesH:15])];
        if ([self.platform isEqualToString:@"0"]) {
            _currencyL.text = [NSString stringWithFormat:@"日币%@元",self.price];
        }else{
            _currencyL.text = [NSString stringWithFormat:@"美元%@元",self.price];
        }
        _currencyL.font = [UIFont systemFontOfSize:FontSize(14)];
        _currencyL.textColor = [Unity getColor:@"#aa112d"];
        [_currencyL sizeToFit];
    }
    return _currencyL;
}
- (UILabel *)rmbL{
    if (!_rmbL) {
        _rmbL = [[UILabel alloc]initWithFrame:CGRectMake(_currentPriceL.left, _currentPriceL.bottom, 150, [Unity countcoordinatesH:20])];
        _rmbL.text = @"人民币you约6965元";
        if ([self.platform isEqualToString:@"0"]) {
            _rmbL.text = [NSString stringWithFormat:@"人民币约%@元",[Unity configWithCurrentCurrency:@"jp" WithTargetCurrency:@"cn" WithAmount:_price]];
        }else{
            _rmbL.text = [NSString stringWithFormat:@"人民币约%@元",[Unity configWithCurrentCurrency:@"us" WithTargetCurrency:@"cn" WithAmount:_price]];
        }
        _rmbL.font = [UIFont systemFontOfSize:FontSize(14)];
        _rmbL.textColor = LabelColor6;
        [_rmbL sizeToFit];
    }
    return _rmbL;
}



- (void)radioClick:(UIButton *)btn{
    btnIndex = btn.tag-1000;
    if (btn!=self.selectedBtn) {
        self.selectedBtn.selected =NO;
        btn.selected =YES;
        self.selectedBtn = btn;
    }else{
        self.selectedBtn.selected =YES;
    }
}
- (void)bidBtnClick{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    if (userInfo == nil) {
        LoginViewController * lvc = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:lvc animated:YES];
        
        return;
    }
    EntrustViewController * evc = [[EntrustViewController alloc]init];
    evc.platform = self.platform;
    evc.price = self.price;
    evc.goodsTitle = self.goodsTitle;
    evc.imageUrl = self.imageUrl;
    evc.endTime = self.endTime;
    evc.increment = self.increment;
    evc.goodId = self.goodsID;
    evc.bidorbuy = self.bidorbuy;
    [self.navigationController pushViewController:evc animated:YES];
}
- (void)biddingClick{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    if (userInfo == nil) {
        LoginViewController * lvc = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:lvc animated:YES];
        
        return;
    }
    if (self.buystatus != 1) {
        [WHToast showMessage:self.buy_msg originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
        return;
    }
    EntrustViewController * evc = [[EntrustViewController alloc]init];
    evc.platform = self.platform;
    evc.price = self.price;
    evc.goodsTitle = self.goodsTitle;
    evc.imageUrl = self.imageUrl;
    evc.endTime = self.endTime;
    evc.increment = self.increment;
    evc.goodId = self.goodsID;
    evc.bidorbuy = self.bidorbuy;
    [self.navigationController pushViewController:evc animated:YES];
}
- (UIButton *)merchantBtn{
    if (!_merchantBtn) {
        _merchantBtn = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:100], [Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
        [_merchantBtn addTarget:self action:@selector(merchanClick) forControlEvents:UIControlEventTouchUpInside];
        [_merchantBtn setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [_merchantBtn setTitle:@"  是" forState:UIControlStateNormal];
        _merchantBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _merchantBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_merchantBtn setImage:[UIImage imageNamed:@"未选啊"] forState:UIControlStateNormal];
        [_merchantBtn setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
    }
    return _merchantBtn;
}
- (UIButton *)notMerchantBtn{
    if (!_notMerchantBtn) {
        _notMerchantBtn = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:200], [Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
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
- (void)merchanClick{
    isMerchant = YES;
    self.merchantBtn.selected = YES;
    self.notMerchantBtn.selected = NO;
    
//    self.freightView.frame = CGRectMake(0, _goodsView.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:60]+[Unity countcoordinatesH:25]);
//    for (int i=0; i<2; i++) {
//        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:100], [Unity countcoordinatesH:40]+i*[Unity countcoordinatesH:25], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
//        [btn addTarget:self action:@selector(notMerchanClick) forControlEvents:UIControlEventTouchUpInside];
//        [btn setTitleColor:LabelColor6 forState:UIControlStateNormal];
//        [btn setTitle:@"  否" forState:UIControlStateNormal];
//        btn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
//        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [btn setImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"read"] forState:UIControlStateSelected];
//        [self.freightView addSubview:btn];
//        if (i==0) {
//            btn.selected = YES;
//        }
//    }
//    self.wView.frame = CGRectMake(0, _freightView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:60]);
//    self.costView.frame = CGRectMake(0, _wView.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:210]);
//    /*将ui添加到scrollView数组中*/
//    [self.scrollView sd_addSubviews:@[self.goodsView,self.freightView,self.wView,self.costView]];
//
//    // scrollview自动contentsize
//    [self.scrollView setupAutoContentSizeWithBottomView:self.costView bottomMargin:[Unity countcoordinatesH:50]];
}
- (void)notMerchanClick{
    isMerchant = NO;
    self.merchantBtn.selected = NO;
    self.notMerchantBtn.selected = YES;
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
            self.deliveryCosts.text = [NSString stringWithFormat:@"%ld.00円",(long)[self getFreightWithWeight:self.weightText.text WithSteam:stream]];
        }else{
            self.deliveryCosts.text = [NSString stringWithFormat:@"%ld.00円",(long)[self getFreightWithWeight:self.weightText.text WithSteam:stream]];
        }
    }
    [self getComputationalCost];
}
//实时监听  重量变化
- (void)weightText:(UITextField *)textField{
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
        self.deliveryCosts.text = [NSString stringWithFormat:@"%ld.00円",(long)[self getFreightWithWeight:self.weightText.text WithSteam:stream]];
    }else{
        self.deliveryCosts.text = [NSString stringWithFormat:@"%ld.00円",(long)[self getFreightWithWeight:textField.text WithSteam:stream]];
    }
    [self getComputationalCost];
}
- (void)freightTextText:(UITextField *)textField{
    [self getComputationalCost];
}
- (NSInteger)getFreightWithWeight:(NSString *)weight WithSteam:(NSString *)steam{
    if ([steam isEqualToString:@"ems"]) {
        if ([weight floatValue]<=0) {
            return 0;
        }else if ([weight floatValue]<=0.3){
            return 900;
        }else if ([weight floatValue]<=0.5){
            return 1400;
        }else if ([weight floatValue]<=0.6){
            return 1540;
        }else if ([weight floatValue]<=0.7){
            return 1680;
        }else if ([weight floatValue]<=0.8){
            return 1820;
        }else if ([weight floatValue]<=0.9){
            return 1960;
        }else if ([weight floatValue]<=1){
            return 2100;
        }else if ([weight floatValue]<=1.25){
            return 2400;
        }else if ([weight floatValue]<=1.5){
            return 2700;
        }else if ([weight floatValue]<=1.75){
            return 3000;
        }else if ([weight floatValue]<=2){
            return 3300;
        }else if ([weight floatValue]<=2.5){
            return 3800;
        }else if ([weight floatValue]<=3){
            return 4300;
        }else if ([weight floatValue]<=3.5){
            return 4800;
        }else if ([weight floatValue]<=4){
            return 5300;
        }else if ([weight floatValue]<=4.5){
            return 5800;
        }else if ([weight floatValue]<=5){
            return 6300;
        }else if ([weight floatValue]<=5.5){
            return 6800;
        }else if ([weight floatValue]<=6){
            return 7300;
        }else if ([weight floatValue]<=7){
            return 8100;
        }else if ([weight floatValue]<=8){
            return 8900;
        }else if ([weight floatValue]<=9){
            return 9700;
        }else if ([weight floatValue]<=10){
            return 10500;
        }else if ([weight floatValue]<=11){
            return 11300;
        }else if ([weight floatValue]<=12){
            return 12100;
        }else if ([weight floatValue]<=13){
            return 12900;
        }else if ([weight floatValue]<=14){
            return 13700;
        }else if ([weight floatValue]<=15){
            return 14500;
        }else if ([weight floatValue]<=16){
            return 15300;
        }else if ([weight floatValue]<=17){
            return 16100;
        }else if ([weight floatValue]<=18){
            return 16900;
        }else if ([weight floatValue]<=19){
            return 17700;
        }else if ([weight floatValue]<=20){
            return 18500;
        }else if ([weight floatValue]<=21){
            return 19300;
        }else if ([weight floatValue]<=22){
            return 20100;
        }else if ([weight floatValue]<=23){
            return 20900;
        }else if ([weight floatValue]<=24){
            return 21700;
        }else if ([weight floatValue]<=25){
            return 22500;
        }else if ([weight floatValue]<=26){
            return 23300;
        }else if ([weight floatValue]<=27){
            return 24100;
        }else if ([weight floatValue]<=28){
            return 24900;
        }else if ([weight floatValue]<=29){
            return 25700;
        }else if ([weight floatValue]<=30){
            return 26500;
        }
    }else if ([steam isEqualToString:@"sal"]){
        if ([weight floatValue]<=0) {
            return 0;
        }else if ([weight floatValue] <= 1){
            return 1800;
        }else if ([weight floatValue] <= 2){
            return 2400;
        }else if ([weight floatValue] <= 3){
            return 3000;
        }else if ([weight floatValue] <= 4){
            return 3600;
        }else if ([weight floatValue] <= 5){
            return 4200;
        }else if ([weight floatValue] <= 6){
            return 4700;
        }else if ([weight floatValue] <= 7){
            return 5200;
        }else if ([weight floatValue] <= 8){
            return 5700;
        }else if ([weight floatValue] <= 9){
            return 6200;
        }else if ([weight floatValue] <= 10){
            return 6700;
        }else if ([weight floatValue] <= 11){
            return 7000;
        }else if ([weight floatValue] <= 12){
            return 7300;
        }else if ([weight floatValue] <= 13){
            return 7600;
        }else if ([weight floatValue] <= 14){
            return 7900;
        }else if ([weight floatValue] <= 15){
            return 8200;
        }else if ([weight floatValue] <= 16){
            return 8500;
        }else if ([weight floatValue] <= 17){
            return 8800;
        }else if ([weight floatValue] <= 18){
            return 9100;
        }else if ([weight floatValue] <= 19){
            return 9400;
        }else if ([weight floatValue] <= 20){
            return 9700;
        }else if ([weight floatValue] <= 21){
            return 10000;
        }else if ([weight floatValue] <= 22){
            return 10300;
        }else if ([weight floatValue] <= 23){
            return 10600;
        }else if ([weight floatValue] <= 24){
            return 10900;
        }else if ([weight floatValue] <= 25){
            return 11200;
        }else if ([weight floatValue] <= 26){
            return 11500;
        }else if ([weight floatValue] <= 27){
            return 11800;
        }else if ([weight floatValue] <= 28){
            return 12100;
        }else if ([weight floatValue] <= 29){
            return 12400;
        }
    }else if ([steam isEqualToString:@"ship"]){
        if ([weight floatValue]<=0) {
            return 0;
        }else if ([weight floatValue] <= 1){
            return 1600;
        }else if ([weight floatValue] <= 2){
            return 1900;
        }else if ([weight floatValue] <= 3){
            return 2200;
        }else if ([weight floatValue] <= 4){
            return 2500;
        }else if ([weight floatValue] <= 5){
            return 2800;
        }else if ([weight floatValue] <= 6){
            return 3100;
        }else if ([weight floatValue] <= 7){
            return 3400;
        }else if ([weight floatValue] <= 8){
            return 3700;
        }else if ([weight floatValue] <= 9){
            return 4000;
        }else if ([weight floatValue] <= 10){
            return 4300;
        }else if ([weight floatValue] <= 11){
            return 4550;
        }else if ([weight floatValue] <= 12){
            return 4800;
        }else if ([weight floatValue] <= 13){
            return 5050;
        }else if ([weight floatValue] <= 14){
            return 5300;
        }else if ([weight floatValue] <= 15){
            return 5550;
        }else if ([weight floatValue] <= 16){
            return 5800;
        }else if ([weight floatValue] <= 17){
            return 6050;
        }else if ([weight floatValue] <= 18){
            return 6300;
        }else if ([weight floatValue] <= 19){
            return 6550;
        }else if ([weight floatValue] <= 20){
            return 6800;
        }else if ([weight floatValue] <= 21){
            return 7050;
        }else if ([weight floatValue] <= 22){
            return 7300;
        }else if ([weight floatValue] <= 23){
            return 7550;
        }else if ([weight floatValue] <= 24){
            return 7800;
        }else if ([weight floatValue] <= 25){
            return 8050;
        }else if ([weight floatValue] <= 26){
            return 8300;
        }else if ([weight floatValue] <= 27){
            return 8550;
        }else if ([weight floatValue] <= 28){
            return 8800;
        }else if ([weight floatValue] <= 29){
            return 9050;
        }else if ([weight floatValue] <= 30){
            return 9300;
        }
    }else{//空港快线按人民币算  折算成当前汇率下的日币进行计算
        NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"exrate"];
        if ([weight floatValue]<=0) {
            return 0;
        }else if ([weight floatValue] <= 0.5){
            return (int)ceilf(51/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 1){
            return (int)ceilf(81/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 1.5){
            return (int)ceilf(112/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 2){
            return (int)ceilf(143/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 2.5){
            return (int)ceilf(174/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 3){
            return (int)ceilf(205/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 3.5){
            return (int)ceilf(235/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 4){
            return (int)ceilf(266/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 4.5){
            return (int)ceilf(297/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 5){
            return (int)ceilf(328/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 5.5){
            return (int)ceilf(359/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 6){
            return (int)ceilf(389/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 6.5){
            return (int)ceilf(420/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 7){
            return (int)ceilf(451/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 7.5){
            return (int)ceilf(482/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 8){
            return (int)ceilf(512/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 8.5){
            return (int)ceilf(543/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 9){
            return (int)ceilf(574/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 9.5){
            return (int)ceilf(605/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 10){
            return (int)ceilf(636/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 11){
            return (int)ceilf(696/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 12){
            return (int)ceilf(759/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 13){
            return (int)ceilf(820/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 14){
            return (int)ceilf(882/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 15){
            return (int)ceilf(943/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 16){
            return (int)ceilf(1005/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 17){
            return (int)ceilf(1066/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 18){
            return (int)ceilf(1128/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 19){
            return (int)ceilf(1190/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 20){
            return (int)ceilf(1251/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 21){
            return (int)ceilf(1313/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 22){
            return (int)ceilf(1374/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 23){
            return (int)ceilf(1436/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 24){
            return (int)ceilf(1497/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 25){
            return (int)ceilf(1559/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 26){
            return (int)ceilf(1620/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 27){
            return (int)ceilf(1682/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 28){
            return (int)ceilf(1744/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 29){
            return (int)ceilf(1805/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 30){
            return (int)ceilf(1867/[dic[@"w_tw_jp"] floatValue]);
        }
    }
    return 0;
}
- (void)reloadUI{
    float result = 0.0;//费用计算
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"exrate"];
    result = [self.price floatValue]*0.03*[dic[@"w_tw_jp"] floatValue];
    if (result > 50) {
        self.contractFee.text = @"50.00RMB";
    }else if (result <10){
        self.contractFee.text = @"10.00RMB";
    }else{
        self.contractFee.text = [NSString stringWithFormat:@"%.0f.00RMB",ceilf(result)];
    }
    
    //是否商家
    if ([self.taxRate isEqualToString:@"0"]) {
        //否
        isMerchant = NO;
        self.merchantBtn.selected = NO;
        self.notMerchantBtn.selected = YES;
    }else{
        //是
        isMerchant = YES;
        self.merchantBtn.selected = YES;
        self.notMerchantBtn.selected = NO;
    }
}
- (void)getComputationalCost{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"exrate"];
    if (self.weightText.text.length == 0 && self.freightText.text.length == 0) {
        self.payment.text = @"";
        self.totalPrice.text = @"";
    }else{
        float aaa;
        float bbb;
        if (self.weightText.text.length == 0) {
            aaa = [self getFreightWithWeight:@"0" WithSteam:stream];
        }else{
            aaa = [self getFreightWithWeight:self.weightText.text WithSteam:stream];
        }
        if (self.freightText.text.length == 0) {
            bbb = 0.0;
        }else{
            bbb = [self.freightText.text floatValue];
        }
        
        float sum = ([self.price floatValue]+bbb+350+500+aaa)*[dic[@"w_tw_jp"] floatValue]+[self.contractFee.text floatValue];
        float advance = ([self.price floatValue]+350+500)*[dic[@"w_tw_jp"] floatValue]+[self.contractFee.text floatValue];
        self.payment.text = [NSString stringWithFormat:@"%.0f.00RMB",ceilf(advance)];
        self.totalPrice.text = [NSString stringWithFormat:@"%.0f.00RMB",ceilf(sum)];
        if (![self.taxRate isEqualToString:@"0"]) {
            float sum = ([self.price floatValue]*1.1+bbb+350+500+aaa)*[dic[@"w_tw_jp"] floatValue]+[self.contractFee.text floatValue];
            float advance = ([self.price floatValue]*1.1+350+500)*[dic[@"w_tw_jp"] floatValue]+[self.contractFee.text floatValue];
            self.payment.text = [NSString stringWithFormat:@"%.0f.、00RMB",ceilf(advance)];
            self.totalPrice.text = [NSString stringWithFormat:@"%.0f.00RMB",ceilf(sum)];
            
        }
    }
}
- (void)collectionClick{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    if (userInfo == nil) {
        LoginViewController * lvc = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:lvc animated:YES];
        
        return;
    }
    if ([goodsStr isEqualToString:@"0"]) {//收藏
        int time = [self.endTime intValue];
        NSDate *date=[NSDate dateWithTimeIntervalSince1970:time];
        NSString *timeStr=[[self dateFormatWith:@"YYYY/MM/dd HH:mm:ss"] stringFromDate:date];
        NSDictionary * dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"area":@"0",@"type":@"goods",@"w_main_category_id":@"",@"w_goods_category_id":@"",@"w_object":self.goodsTitle,@"w_link":self.link,@"w_overtime":timeStr,@"w_jpnid":self.goodsID,@"w_imgsrc":self.imageUrl,@"w_saler":@"",@"w_tag":@""};
//        NSLog(@"收藏请求= %@",dic);
        [Unity showanimate];
        [GZMrequest postWithURLString:[GZMUrl get_collection_url] parameters:dic success:^(NSDictionary *data) {
            [Unity hiddenanimate];
            if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
                [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
                goodsStr = [NSString stringWithFormat:@"%@",data[@"data"]];
                self.collImg.image = [UIImage imageNamed:@"已收藏"];
            }else{
                [WHToast showMessage:data[@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            }
        } failure:^(NSError *error) {
            [Unity hiddenanimate];
            [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }];
    }else{//删除
        //删除收藏
        NSDictionary * dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"type":@"goods",@"ids":goodsStr};
        [Unity showanimate];
        [GZMrequest postWithURLString:[GZMUrl get_deleteCollection_url] parameters:dic success:^(NSDictionary *data) {
            [Unity hiddenanimate];
            if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
                self.collImg.image = [UIImage imageNamed:@"未收藏"];
                [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
                goodsStr = @"0";
            }else{
                [WHToast showMessage:[data objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            }
        } failure:^(NSError *error) {
            [Unity hiddenanimate];
            [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }];
    }
}
//获取日期格式化器
-(NSDateFormatter *)dateFormatWith:(NSString *)formatStr {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formatStr];//@"YYYY-MM-dd HH:mm:ss"
    //设置时区
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Tokyo"];
    [formatter setTimeZone:timeZone];
    
    return formatter;
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
