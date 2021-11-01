//
//  OrderDetailViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/18.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "SendInfoViewController.h"
#import "UIViewController+YINNav.h"
#import "BalanceViewController.h"
#import "KdJapanViewController.h"
#import "KdPostalViewController.h"
#define bottomH (IS_iPhoneX ? [Unity countcoordinatesH:70] : [Unity countcoordinatesH:50])
@interface OrderDetailViewController ()<UIScrollViewDelegate>
{
    float buk;
}
@property (nonatomic , strong) UIScrollView * scrollView;
//第一个view 所有控件
@property (nonatomic , strong) UIView * oneView;
@property (nonatomic , strong) UILabel * patNum;//投标编号
@property (nonatomic , strong) UIImageView * icon;//商品图片
@property (nonatomic , strong) UILabel * goodsTitle;//商品标题
@property (nonatomic , strong) UILabel * goodsNum;//竞拍商品数量
@property (nonatomic , strong) UILabel * subtitle;//副标题
@property (nonatomic , strong) UILabel * castprice;//投标价
@property (nonatomic , strong) UILabel * entrustTime;//委托时间
@property (nonatomic , strong) UILabel * endTime;//结标时间
@property (nonatomic , strong) UILabel * bidprice;//得标价

//第二个view 处理进度
@property (nonatomic , strong) UIView * twoView;
@property (nonatomic , strong) UIView * round1;//已得标 前面的圆
@property (nonatomic , strong) UIView * round2;//已汇款 前面的圆
@property (nonatomic , strong) UIView * round3;//海外已收货 前面的圆
@property (nonatomic , strong) UIView * round4;//海外已发出 前面的圆
@property (nonatomic , strong) UIView * rLine1;//
@property (nonatomic , strong) UIView * rLine2;//
@property (nonatomic , strong) UIView * rLine3;//
@property (nonatomic , strong) UILabel * bidL;//已得标文字
@property (nonatomic , strong) UILabel * payL;//已汇款文字
@property (nonatomic , strong) UILabel * goodsL;//已收货文字
@property (nonatomic , strong) UILabel * deliveryL;//已发货文字
@property (nonatomic , strong) UILabel * bidTime;//已得标时间
@property (nonatomic , strong) UILabel * payTime;//已汇款时间
@property (nonatomic , strong) UILabel * goodsTime;//已收货时间
@property (nonatomic , strong) UILabel * deliveryTime;//已发货时间

//第三个view 寄送信息
@property (nonatomic , strong) UIView * threeView;
@property (nonatomic , strong) UILabel * loseType;//国际运输方式
@property (nonatomic , strong) UILabel * weight;//重量
@property (nonatomic , strong) UILabel * courierNum;//快递单号
@property (nonatomic , strong) UILabel * courierDynamic;//快递动态

//第四个view 代拍费用
@property (nonatomic , strong) UIView * fourView;
@property (nonatomic , strong) UILabel * titleName;//标题名称
@property (nonatomic , strong) UILabel * localTax;//当地消费税
@property (nonatomic , strong) UILabel * bankFee;//银行汇款手续费
@property (nonatomic , strong) UILabel * localFreight;//当地运费
@property (nonatomic , strong) UILabel * overseasFee;//海外处理费
@property (nonatomic , strong) UILabel * damageClaim;//损坏理赔
@property (nonatomic , strong) UILabel * laborFee;//代工费

//第五个view  国际运输费用（高度不定 写活）
@property (nonatomic , strong) UIView * fiveView;
@property (nonatomic , strong) UILabel * fiveLabel1;//国际运费
@property (nonatomic , strong) UILabel * fiveLabel2;//纸箱包装费
@property (nonatomic , strong) UILabel * fiveLabel3;//仓储费用
@property (nonatomic , strong) UILabel * fiveLabel4;//诈骗理赔
@property (nonatomic , strong) UILabel * fiveLabel5;//国内运费

//第六个view  总金额
@property (nonatomic , strong) UIView * sixView;
@property (nonatomic , strong) UILabel * total;//现况总额
@property (nonatomic , strong) UILabel * earnestMoney;//预付金

//bottomView
@property (nonatomic , strong) UIView * bottomView;
@property (nonatomic , strong) UIButton * subMit;
@property (nonatomic , strong) UILabel * supplement;

@property (nonatomic , strong) AroundAnimation * aAnimation;
@property (nonatomic , strong) alertView * altView;

@property (nonatomic , strong) NSMutableArray * infoList;

@property (nonatomic , strong) NSDictionary * dataDic;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.y_navLineHidden=YES;
    [self creareUI];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [Unity getColor:@"f0f0f0"];
    self.title = @"订单明细";
    [self requestDetail];
}
- (void)creareUI{
    
    _scrollView = [UIScrollView new];
    _scrollView.delegate=self;
    _scrollView.showsVerticalScrollIndicator = FALSE;//垂直滚动条
    _scrollView.showsHorizontalScrollIndicator = FALSE;//水平滚动条
    [self.view addSubview:_scrollView];
    _scrollView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }//解决导航栏设置透明的情况下 scrollView发生偏移的问题：
    
    [self.scrollView addSubview:self.oneView];
    [self.scrollView addSubview:self.twoView];
    [self.scrollView addSubview:self.threeView];
    [self.scrollView addSubview:self.fourView];
    [self.scrollView addSubview:self.fiveView];
    [self.scrollView addSubview:self.sixView];
    
    /*将ui添加到scrollView数组中*/
    [self.scrollView sd_addSubviews:@[self.oneView,self.twoView,self.threeView,self.fourView,self.fiveView,self.sixView]];
    
    // scrollview自动contentsize
    [self.scrollView setupAutoContentSizeWithBottomView:self.sixView bottomMargin:bottomH];
    
    [self.view addSubview:self.bottomView];
}
#pragma mark ------第一个view初始化
- (UIView *)oneView{
    if (!_oneView) {
        _oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:205])];
        _oneView.backgroundColor = [UIColor whiteColor];
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:40])];
        view.backgroundColor = [Unity getColor:@"f0f0f0"];
        [_oneView addSubview:view];
        UILabel * patNumL = [Unity lableViewAddsuperview_superView:view _subViewFrame:CGRectMake([Unity countcoordinatesW:10], 0, [Unity countcoordinatesW:70], view.height) _string:@"得标编号" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        _patNum = [Unity lableViewAddsuperview_superView:view _subViewFrame:CGRectMake(patNumL.right, 0, SCREEN_WIDTH-[Unity countcoordinatesW:90], view.height) _string:@"" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentRight];
        
        [_oneView addSubview:self.icon];
        [_oneView addSubview:self.goodsTitle];
        [_oneView addSubview:self.goodsNum];
        [_oneView addSubview:self.subtitle];
        [_oneView addSubview:self.castprice];
        
        UILabel * entrustTimeL = [Unity lableViewAddsuperview_superView:_oneView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], self.icon.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:15]) _string:@"委托时间" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentLeft];
        UILabel * endTimeL = [Unity lableViewAddsuperview_superView:_oneView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], entrustTimeL.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:15]) _string:@"结标时间" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentLeft];
        UILabel * bidpriceL = [Unity lableViewAddsuperview_superView:_oneView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], endTimeL.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:15]) _string:@"得标价" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentLeft];
        bidpriceL.backgroundColor = [UIColor clearColor];
        
        [_oneView addSubview:self.entrustTime];
        [_oneView addSubview:self.endTime];
        [_oneView addSubview:self.bidprice];
    }
    return _oneView;
}
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:50], [Unity countcoordinatesW:70], [Unity countcoordinatesH:70])];
        //添加边框
        CALayer * layer = [_icon layer];
        layer.borderColor = [[Unity getColor:@"#e0e0e0"] CGColor];
        layer.borderWidth = 1.0f;
        _icon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _icon;
}
- (UILabel *)goodsTitle{
    if (!_goodsTitle) {
        _goodsTitle = [[UILabel alloc]initWithFrame:CGRectMake(_icon.right+[Unity countcoordinatesW:5], _icon.top, SCREEN_WIDTH-[Unity countcoordinatesW:125], [Unity countcoordinatesH:40])];
        _goodsTitle.text = @"";
        _goodsTitle.numberOfLines = 0;
        _goodsTitle.textColor = LabelColor3;
        _goodsTitle.font = [UIFont systemFontOfSize:FontSize(14)];
        _goodsTitle.textAlignment = NSTextAlignmentLeft;
    }
    return _goodsTitle;
}
- (UILabel *)goodsNum{
    if (!_goodsNum) {
        _goodsNum = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitle.right+[Unity countcoordinatesW:10], _goodsTitle.top+[Unity countcoordinatesH:5], [Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _goodsNum.text = @"";
        _goodsNum.textColor = LabelColor6;
        _goodsNum.font = [UIFont systemFontOfSize:FontSize(12)];
        _goodsNum.textAlignment = NSTextAlignmentRight;
    }
    return _goodsNum;
}
- (UILabel *)subtitle{
    if (!_subtitle) {
        _subtitle = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitle.left, _goodsTitle.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:130], [Unity countcoordinatesH:20])];
        _subtitle.text = @"";
        _subtitle.textColor = LabelColor9;
        _subtitle.font = [UIFont systemFontOfSize:FontSize(12)];
        _subtitle.textAlignment = NSTextAlignmentLeft;
    }
    return _subtitle;
}
- (UILabel *)castprice{
    if (!_castprice) {
        _castprice = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:100], _subtitle.top, [Unity countcoordinatesW:90], _subtitle.height)];
        _castprice.text = @"";
        _castprice.textColor = LabelColor3;
        _castprice.font = [UIFont systemFontOfSize:FontSize(14)];
        _castprice.textAlignment = NSTextAlignmentRight;
    }
    return _castprice;
}
- (UILabel *)entrustTime{
    if (!_entrustTime) {
        _entrustTime = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:80], _icon.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:230], [Unity countcoordinatesH:15])];
        _entrustTime.text = @"";
        _entrustTime.textColor = LabelColor6;
        _entrustTime.font = [UIFont systemFontOfSize:FontSize(14)];
        _entrustTime.textAlignment = NSTextAlignmentRight;
    }
    return _entrustTime;
}
- (UILabel *)endTime{
    if (!_endTime) {
        _endTime = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:80], _entrustTime.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:230], [Unity countcoordinatesH:15])];
        _endTime.text = @"";
        _endTime.textColor = LabelColor6;
        _endTime.font = [UIFont systemFontOfSize:FontSize(14)];
        _endTime.textAlignment = NSTextAlignmentRight;
    }
    return _endTime;
}
- (UILabel *)bidprice{
    if (!_bidprice) {
        _bidprice = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:80], _endTime.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:230], [Unity countcoordinatesH:15])];
        _bidprice.text = @"";
        _bidprice.textColor = [Unity getColor:@"aa112d"];
        _bidprice.font = [UIFont systemFontOfSize:FontSize(14)];
        _bidprice.textAlignment = NSTextAlignmentRight;
    }
    return _bidprice;
}
#pragma mark ------第2个view初始化
- (UIView *)twoView{
    if (!_twoView) {
        _twoView = [[UIView alloc]initWithFrame:CGRectMake(0, _oneView.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:110])];
        _twoView.backgroundColor = [UIColor whiteColor];
        UILabel * progress = [Unity lableViewAddsuperview_superView:_twoView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:15]) _string:@"处理进度" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentLeft];
        progress.backgroundColor = [UIColor clearColor];
        
        [_twoView addSubview:self.round1];
        [_twoView addSubview:self.rLine1];
        [_twoView addSubview:self.round2];
        [_twoView addSubview:self.rLine2];
        [_twoView addSubview:self.round3];
        [_twoView addSubview:self.rLine3];
        [_twoView addSubview:self.round4];
        [_twoView addSubview:self.bidL];
        [_twoView addSubview:self.payL];
        [_twoView addSubview:self.goodsL];
        [_twoView addSubview:self.deliveryL];
        [_twoView addSubview:self.bidTime];
        [_twoView addSubview:self.payTime];
        [_twoView addSubview:self.goodsTime];
        [_twoView addSubview:self.deliveryTime];
    }
    
    return _twoView;
}
- (UIView *)round1{
    if (!_round1) {
        _round1 = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:110], [Unity countcoordinatesH:14], [Unity countcoordinatesW:7], [Unity countcoordinatesH:7])];
        _round1.backgroundColor = LabelColor9;
        _round1.layer.cornerRadius = _round1.height/2;
    }
    return _round1;
}
- (UIView *)rLine1{
    if (!_rLine1) {
        _rLine1 = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:113], _round1.bottom, [Unity countcoordinatesW:1], [Unity countcoordinatesH:18])];
        _rLine1.backgroundColor = LabelColor9;
    }
    return _rLine1;
}
- (UIView *)round2{
    if (!_round2) {
        _round2 = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:110], _rLine1.bottom, [Unity countcoordinatesW:7], [Unity countcoordinatesH:7])];
        _round2.backgroundColor = LabelColor9;
        _round2.layer.cornerRadius = _round2.height/2;
    }
    return _round2;
}
- (UIView *)rLine2{
    if (!_rLine2) {
        _rLine2 = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:113], _round2.bottom, [Unity countcoordinatesW:1], [Unity countcoordinatesH:18])];
        _rLine2.backgroundColor = LabelColor9;
    }
    return _rLine2;
}
- (UIView *)round3{
    if (!_round3) {
        _round3 = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:110], _rLine2.bottom, [Unity countcoordinatesW:7], [Unity countcoordinatesH:7])];
        _round3.backgroundColor = LabelColor9;
        _round3.layer.cornerRadius = _round3.height/2;
    }
    return _round3;
}
- (UIView *)rLine3{
    if (!_rLine3) {
        _rLine3 = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:113], _round3.bottom, [Unity countcoordinatesW:1], [Unity countcoordinatesH:18])];
        _rLine3.backgroundColor = LabelColor9;
    }
    return _rLine3;
}
- (UIView *)round4{
    if (!_round4) {
        _round4 = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:110], _rLine3.bottom, [Unity countcoordinatesW:7], [Unity countcoordinatesH:7])];
        _round4.backgroundColor = LabelColor9;
        _round4.layer.cornerRadius = _round4.height/2;
    }
    return _round4;
}
- (UILabel *)bidL{
    if (!_bidL) {
        _bidL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:125], [Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:15])];
        _bidL.text = @"已得标";
        _bidL.textColor = LabelColor9;
        _bidL.font = [UIFont systemFontOfSize:FontSize(14)];
        _bidL.textAlignment = NSTextAlignmentLeft;
    }
    return _bidL;
}
- (UILabel *)payL{
    if (!_payL) {
        _payL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:125], _bidL.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:15])];
        _payL.text = @"已汇款";
        _payL.textColor = LabelColor9;
        _payL.font = [UIFont systemFontOfSize:FontSize(14)];
        _payL.textAlignment = NSTextAlignmentLeft;
    }
    return _payL;
}
- (UILabel *)goodsL{
    if (!_goodsL) {
        _goodsL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:125], _payL.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:15])];
        _goodsL.text = @"海外已收货";
        _goodsL.textColor = LabelColor9;
        _goodsL.font = [UIFont systemFontOfSize:FontSize(14)];
        _goodsL.textAlignment = NSTextAlignmentLeft;
    }
    return _goodsL;
}
- (UILabel *)deliveryL{
    if (!_deliveryL) {
        _deliveryL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:125], _goodsL.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:80], [Unity countcoordinatesH:15])];
        _deliveryL.text = @"海外已发出";
        _deliveryL.textColor = LabelColor9;
        _deliveryL.font = [UIFont systemFontOfSize:FontSize(14)];
        _deliveryL.textAlignment = NSTextAlignmentLeft;
    }
    return _deliveryL;
}
- (UILabel *)bidTime{
    if (!_bidTime) {
        _bidTime = [[UILabel alloc]initWithFrame:CGRectMake(_bidL.right+[Unity countcoordinatesW:5], [Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15])];
        _bidTime.text = @"";
        _bidTime.textColor = LabelColor6;
        _bidTime.font = [UIFont systemFontOfSize:FontSize(14)];
        _bidTime.textAlignment = NSTextAlignmentRight;
    }
    return _bidTime;
}
- (UILabel *)payTime{
    if (!_payTime) {
        _payTime = [[UILabel alloc]initWithFrame:CGRectMake(_bidL.right+[Unity countcoordinatesW:5], _bidTime.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15])];
        _payTime.text = @"";
        _payTime.textColor = LabelColor6;
        _payTime.font = [UIFont systemFontOfSize:FontSize(14)];
        _payTime.textAlignment = NSTextAlignmentRight;
    }
    return _payTime;
}
- (UILabel *)goodsTime{
    if (!_goodsTime) {
        _goodsTime = [[UILabel alloc]initWithFrame:CGRectMake(_bidL.right+[Unity countcoordinatesW:5], _payTime.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15])];
        _goodsTime.text = @"";
        _goodsTime.textColor = LabelColor6;
        _goodsTime.font = [UIFont systemFontOfSize:FontSize(14)];
        _goodsTime.textAlignment = NSTextAlignmentRight;
    }
    return _goodsTime;
}
- (UILabel *)deliveryTime{
    if (!_deliveryTime) {
        _deliveryTime = [[UILabel alloc]initWithFrame:CGRectMake(_bidL.right+[Unity countcoordinatesW:5], _goodsTime.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15])];
        _deliveryTime.text = @"";
        _deliveryTime.textColor = LabelColor6;
        _deliveryTime.font = [UIFont systemFontOfSize:FontSize(14)];
        _deliveryTime.textAlignment = NSTextAlignmentRight;
    }
    return _deliveryTime;
}
#pragma mark ------第3个view初始化
- (UIView *)threeView{
    if (!_threeView) {
        _threeView = [[UIView alloc]initWithFrame:CGRectMake(0, _twoView.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:165])];
        _threeView.backgroundColor = [UIColor whiteColor];
        UILabel * aaa = [Unity lableViewAddsuperview_superView:_threeView _subViewFrame:CGRectMake(0, [Unity countcoordinatesH:15], [Unity countcoordinatesW:3], [Unity countcoordinatesH:10]) _string:@"" _lableFont:[UIFont systemFontOfSize:0] _lableTxtColor:[UIColor clearColor] _textAlignment:NSTextAlignmentRight];
        aaa.backgroundColor = [Unity getColor:@"aa112d"];
        UILabel * title = [Unity lableViewAddsuperview_superView:_threeView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], 200, [Unity countcoordinatesH:20]) _string:@"寄送信息" _lableFont:[UIFont systemFontOfSize:FontSize(17)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        title.backgroundColor = [UIColor clearColor];
        NSArray * arr =@[@"国际运输方式",@"重量",@"快递单号",@"快递动态"];
        for (int i=0; i<arr.count; i++) {
            UILabel * name = [Unity lableViewAddsuperview_superView:_threeView _subViewFrame:CGRectMake(title.left, title.bottom+(i+1)*[Unity countcoordinatesH:10]+i*[Unity countcoordinatesH:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15]) _string:arr[i] _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentLeft];
            name.backgroundColor = [UIColor clearColor];
        }
        UILabel * markL = [Unity lableViewAddsuperview_superView:_threeView _subViewFrame:CGRectMake(title.left, [Unity countcoordinatesH:140], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:15]) _string:@"数据资料来自快递100，仅供参考，请以快递官网查询结果为准。" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentLeft];
        markL.backgroundColor = [UIColor clearColor];
        
        [_threeView addSubview:self.loseType];
        [_threeView addSubview:self.weight];
        [_threeView addSubview:self.courierNum];
        [_threeView addSubview:self.courierDynamic];
    }
    return _threeView;
}
- (UILabel *)loseType{
    if (!_loseType) {
        _loseType = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], [Unity countcoordinatesH:40], SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:15])];
        _loseType.text = @"";
        _loseType.textColor = LabelColor6;
        _loseType.font = [UIFont systemFontOfSize:FontSize(14)];
        _loseType.textAlignment = NSTextAlignmentRight;
    }
    return _loseType;
}
- (UILabel *)weight{
    if (!_weight) {
        _weight = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], _loseType.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:15])];
        _weight.text = @"";
        _weight.textColor = LabelColor6;
        _weight.font = [UIFont systemFontOfSize:FontSize(14)];
        _weight.textAlignment = NSTextAlignmentRight;
    }
    return _weight;
}
- (UILabel *)courierNum{
    if (!_courierNum) {
        _courierNum = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], _weight.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:15])];
        _courierNum.text = @"工作人员处理中";
        _courierNum.textColor = LabelColor9;
        _courierNum.font = [UIFont systemFontOfSize:FontSize(14)];
        _courierNum.textAlignment = NSTextAlignmentRight;
    }
    return _courierNum;
}
- (UILabel *)courierDynamic{
    if (!_courierDynamic) {
        _courierDynamic = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], _courierNum.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:15])];
        _courierDynamic.text = @"暂无信息请等待";
        _courierDynamic.textColor = LabelColor9;
        _courierDynamic.font = [UIFont systemFontOfSize:FontSize(14)];
        _courierDynamic.textAlignment = NSTextAlignmentRight;
        // 其中labelTap:为label的点击事件
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dynamic)];
        [_courierDynamic addGestureRecognizer:tap];
        _courierDynamic.userInteractionEnabled=NO;
    }
    return _courierDynamic;
}
#pragma mark ------第4个view初始化
- (UIView *)fourView{
    if (!_fourView) {
        _fourView = [[UIView alloc]initWithFrame:CGRectMake(0, _threeView.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:190])];
        _fourView.backgroundColor = [UIColor whiteColor];
        UILabel * aaa = [Unity lableViewAddsuperview_superView:_fourView _subViewFrame:CGRectMake(0, [Unity countcoordinatesH:15], [Unity countcoordinatesW:3], [Unity countcoordinatesH:10]) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentRight];
        aaa.backgroundColor = [Unity getColor:@"aa112d"];
        [_fourView addSubview:self.titleName];
        NSArray * arr = @[@"当地消费税",@"银行汇款手续费",@"当地运费",@"海外处理费",@"损坏理赔",@"代工费"];
        for (int i=0; i<arr.count; i++) {
            UILabel * name = [Unity lableViewAddsuperview_superView:_fourView _subViewFrame:CGRectMake(self.titleName.left, self.titleName.bottom+(i+1)*[Unity countcoordinatesH:10]+i*[Unity countcoordinatesH:15], [Unity countcoordinatesW:120], [Unity countcoordinatesH:15]) _string:arr[i] _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentLeft];
            name.backgroundColor = [UIColor clearColor];
        }
        [_fourView addSubview:self.localTax];
        [_fourView addSubview:self.bankFee];
        [_fourView addSubview:self.localFreight];
        [_fourView addSubview:self.overseasFee];
        [_fourView addSubview:self.damageClaim];
        [_fourView addSubview:self.laborFee];
        
    }
    return _fourView;
}
- (UILabel *)titleName{
    if (!_titleName) {
        _titleName = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _titleName.text = @"";
        _titleName.textColor = LabelColor3;
        _titleName.font = [UIFont systemFontOfSize:FontSize(17)];
        _titleName.textAlignment = NSTextAlignmentLeft;
    }
    return _titleName;
}
- (UILabel *)localTax{
    if (!_localTax) {
        _localTax = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], [Unity countcoordinatesH:40], SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:15])];
        _localTax.text = @"";
        _localTax.textColor = LabelColor6;
        _localTax.font = [UIFont systemFontOfSize:FontSize(14)];
        _localTax.textAlignment = NSTextAlignmentRight;
    }
    return _localTax;
}
- (UILabel *)bankFee{
    if (!_bankFee) {
        _bankFee = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], _localTax.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:15])];
        _bankFee.text = @"";
        _bankFee.textColor = LabelColor6;
        _bankFee.font = [UIFont systemFontOfSize:FontSize(14)];
        _bankFee.textAlignment = NSTextAlignmentRight;
    }
    return _bankFee;
}
- (UILabel *)localFreight{
    if (!_localFreight) {
        _localFreight = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], _bankFee.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:15])];
        _localFreight.text = @"";
        _localFreight.textColor = LabelColor6;
        _localFreight.font = [UIFont systemFontOfSize:FontSize(14)];
        _localFreight.textAlignment = NSTextAlignmentRight;
    }
    return _localFreight;
}
- (UILabel *)overseasFee{
    if (!_overseasFee) {
        _overseasFee = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], _localFreight.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:15])];
        _overseasFee.text = @"";
        _overseasFee.textColor = LabelColor6;
        _overseasFee.font = [UIFont systemFontOfSize:FontSize(14)];
        _overseasFee.textAlignment = NSTextAlignmentRight;
    }
    return _overseasFee;
}
- (UILabel *)damageClaim{
    if (!_damageClaim) {
        _damageClaim = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], _overseasFee.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:15])];
        _damageClaim.text = @"";
        _damageClaim.textColor = LabelColor6;
        _damageClaim.font = [UIFont systemFontOfSize:FontSize(14)];
        _damageClaim.textAlignment = NSTextAlignmentRight;
    }
    return _damageClaim;
}
- (UILabel *)laborFee{
    if (!_laborFee) {
        _laborFee = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], _damageClaim.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:15])];
        _laborFee.text = @"";
        _laborFee.textColor = LabelColor6;
        _laborFee.font = [UIFont systemFontOfSize:FontSize(14)];
        _laborFee.textAlignment = NSTextAlignmentRight;
    }
    return _laborFee;
}

#pragma mark ------第5个view初始化
- (UIView *)fiveView{
    if (!_fiveView) {
        _fiveView = [[UIView alloc]initWithFrame:CGRectMake(0, _fourView.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:165])];
        _fiveView.backgroundColor = [UIColor whiteColor];
        UILabel * aaa = [Unity lableViewAddsuperview_superView:_fiveView _subViewFrame:CGRectMake(0, [Unity countcoordinatesH:15], [Unity countcoordinatesW:3], [Unity countcoordinatesH:10]) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentRight];
        aaa.backgroundColor = [Unity getColor:@"aa112d"];
        UILabel * title = [Unity lableViewAddsuperview_superView:_fiveView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], 200, [Unity countcoordinatesH:20]) _string:@"国际运输费用" _lableFont:[UIFont systemFontOfSize:FontSize(17)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        title.backgroundColor = [UIColor clearColor];
        
        NSArray * arr = @[@"国际运费",@"纸箱包装费",@"仓储费用",@"诈骗理赔",@"国内运费"];
        for (int i=0; i<arr.count; i++) {
            UILabel * name = [Unity lableViewAddsuperview_superView:_fiveView _subViewFrame:CGRectMake(title.left, title.bottom+(i+1)*[Unity countcoordinatesH:10]+i*[Unity countcoordinatesH:15], [Unity countcoordinatesW:120], [Unity countcoordinatesH:15]) _string:arr[i] _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentLeft];
            name.backgroundColor = [UIColor clearColor];
        }
        
        [_fiveView addSubview:self.fiveLabel1];
        [_fiveView addSubview:self.fiveLabel2];
        [_fiveView addSubview:self.fiveLabel3];
        [_fiveView addSubview:self.fiveLabel4];
        [_fiveView addSubview:self.fiveLabel5];
    }
    return _fiveView;
}
- (UILabel *)fiveLabel1{
    if (!_fiveLabel1) {
        _fiveLabel1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], [Unity countcoordinatesH:40], SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:15])];
        _fiveLabel1.text = @"";
        _fiveLabel1.textColor = LabelColor6;
        _fiveLabel1.font = [UIFont systemFontOfSize:FontSize(14)];
        _fiveLabel1.textAlignment = NSTextAlignmentRight;
    }
    return _fiveLabel1;
}
- (UILabel *)fiveLabel2{
    if (!_fiveLabel2) {
        _fiveLabel2 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], _fiveLabel1.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:15])];
        _fiveLabel2.text = @"";
        _fiveLabel2.textColor = LabelColor6;
        _fiveLabel2.font = [UIFont systemFontOfSize:FontSize(14)];
        _fiveLabel2.textAlignment = NSTextAlignmentRight;
    }
    return _fiveLabel2;
}
- (UILabel *)fiveLabel3{
    if (!_fiveLabel3) {
        _fiveLabel3 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], _fiveLabel2.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:15])];
        _fiveLabel3.text = @"";
        _fiveLabel3.textColor = LabelColor6;
        _fiveLabel3.font = [UIFont systemFontOfSize:FontSize(14)];
        _fiveLabel3.textAlignment = NSTextAlignmentRight;
    }
    return _fiveLabel3;
}
- (UILabel *)fiveLabel4{
    if (!_fiveLabel4) {
        _fiveLabel4 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], _fiveLabel3.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:15])];
        _fiveLabel4.text = @"";
        _fiveLabel4.textColor = LabelColor6;
        _fiveLabel4.font = [UIFont systemFontOfSize:FontSize(14)];
        _fiveLabel4.textAlignment = NSTextAlignmentRight;
    }
    return _fiveLabel4;
}
- (UILabel *)fiveLabel5{
    if (!_fiveLabel5) {
        _fiveLabel5 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], _fiveLabel4.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:15])];
        _fiveLabel5.text = @"";
        _fiveLabel5.textColor = LabelColor6;
        _fiveLabel5.font = [UIFont systemFontOfSize:FontSize(14)];
        _fiveLabel5.textAlignment = NSTextAlignmentRight;
    }
    return _fiveLabel5;
}
#pragma mark ------第6个view初始化
- (UIView *)sixView{
    if (!_sixView) {
        _sixView = [[UIView alloc]initWithFrame:CGRectMake(0, _fiveView.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:90])];
        _sixView.backgroundColor = [UIColor whiteColor];
        UILabel * aaa = [Unity lableViewAddsuperview_superView:_sixView _subViewFrame:CGRectMake(0, [Unity countcoordinatesH:15], [Unity countcoordinatesW:3], [Unity countcoordinatesH:10]) _string:@"" _lableFont:nil _lableTxtColor:nil _textAlignment:NSTextAlignmentRight];
        aaa.backgroundColor = [Unity getColor:@"aa112d"];
        UILabel * title = [Unity lableViewAddsuperview_superView:_sixView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], 200, [Unity countcoordinatesH:20]) _string:@"总金额" _lableFont:[UIFont systemFontOfSize:FontSize(17)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        title.backgroundColor = [UIColor clearColor];
        NSArray * arr = @[@"现况总额",@"预付金"];
        for (int i=0; i<arr.count; i++) {
            UILabel * name = [Unity lableViewAddsuperview_superView:_sixView _subViewFrame:CGRectMake(self.titleName.left, self.titleName.bottom+(i+1)*[Unity countcoordinatesH:10]+i*[Unity countcoordinatesH:15], [Unity countcoordinatesW:120], [Unity countcoordinatesH:15]) _string:arr[i] _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor6 _textAlignment:NSTextAlignmentLeft];
            name.backgroundColor = [UIColor clearColor];
        }
        [_sixView addSubview:self.total];
        [_sixView addSubview:self.earnestMoney];
    }
    return _sixView;
}
- (UILabel *)total{
    if (!_total) {
        _total = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], [Unity countcoordinatesH:40], SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:15])];
        _total.text = @"";
        _total.textColor = LabelColor6;
        _total.font = [UIFont systemFontOfSize:FontSize(14)];
        _total.textAlignment = NSTextAlignmentRight;
    }
    return _total;
}
- (UILabel *)earnestMoney{
    if (!_earnestMoney) {
        _earnestMoney = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], _total.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:15])];
        _earnestMoney.text = @"";
        _earnestMoney.textColor = LabelColor6;
        _earnestMoney.font = [UIFont systemFontOfSize:FontSize(14)];
        _earnestMoney.textAlignment = NSTextAlignmentRight;
    }
    return _earnestMoney;
}
#pragma mark ------底部bottomview初始化
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NavBarHeight-bottomH, SCREEN_WIDTH, bottomH)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        line.backgroundColor = [Unity getColor:@"e0e0e0"];
        [_bottomView addSubview:line];
        [_bottomView addSubview:self.supplement];
        [_bottomView addSubview:self.subMit];
        
    }
    return _bottomView;
}
- (UILabel *)supplement{
    if (!_supplement) {
        _supplement = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:180], [Unity countcoordinatesH:20])];
//        _supplement.text = @"需补国际运费：850.00RMB";
        _supplement.text = @"暂不确定";
        _supplement.textColor = LabelColor6;
        _supplement.textAlignment = NSTextAlignmentLeft;
        _supplement.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _supplement;
}
- (UIButton *)subMit{
    if (!_subMit) {
        _subMit = [[UIButton alloc]initWithFrame:CGRectMake(_supplement.right, [Unity countcoordinatesH:7.5], [Unity countcoordinatesW:120], [Unity countcoordinatesH:35])];
        [_subMit addTarget:self action:@selector(subMitClick) forControlEvents:UIControlEventTouchUpInside];
        [_subMit setTitle:@"补款" forState:UIControlStateNormal];
        [_subMit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _subMit.backgroundColor = [Unity getColor:@"aa112d"];
        _subMit.backgroundColor = LabelColor9;
        _subMit.layer.cornerRadius = _subMit.height/2;
        _subMit.layer.masksToBounds = YES;
        _subMit.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
        _subMit.userInteractionEnabled = NO;//默认无需补款 禁用按钮
    }
    return _subMit;
}
#pragma mark ------事件处理
- (void)subMitClick{
    NSLog(@"需要补款 %fRMB",buk);
    BalanceViewController * bvc = [[BalanceViewController alloc]init];
    [self.navigationController pushViewController:bvc animated:YES];
}
- (void)requestDetail{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    [self.aAnimation startAround];
    NSDictionary *params = @{@"customer":userInfo[@"member_id"],@"order":self.order,@"finish":self.finish};
//    NSDictionary *params = @{@"customer":@"14010",@"order":@"44737"};
    NSLog(@"par %@",params);
    [GZMrequest getWithURLString:[GZMUrl get_caseDetail_url] parameters:params success:^(NSDictionary *data) {
        [self.aAnimation stopAround];
        NSLog(@"案件详情 = %@",data);
        
        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
            NSDictionary *infoData = [self deleteNullWithDic:data[@"data"]];
            self.dataDic = data;
            self.patNum.text = [NSString stringWithFormat:@"%@/%@",infoData[@"w_lsh"],infoData[@"w_jpnid"]];
            [self.icon sd_setImageWithURL:[NSURL URLWithString:infoData[@"w_imgsrc"]] placeholderImage:[UIImage imageNamed:@"Loading"]];
            self.goodsTitle.text = infoData[@"w_object"];
            self.goodsNum.text = [NSString stringWithFormat:@"x%@",infoData[@"w_tbsl"]];
            self.entrustTime.text = infoData[@"w_ordertime"];
            self.endTime.text = infoData[@"w_overtime"];
            self.subtitle.text = infoData[@"w_zwpm"];
            if ([infoData[@"w_cc"] isEqualToString:@"0"]) {
                self.bidprice.text = [NSString stringWithFormat:@"%@円",infoData[@"w_jbj_jp"]];
                self.castprice.text = [NSString stringWithFormat:@"%@円",infoData[@"w_maxpay_jp"]];
                self.titleName.text = [NSString stringWithFormat:@"日本代拍费用（汇率：%@）",infoData[@"w_rate"]];
                self.damageClaim.text = [NSString stringWithFormat:@"%@円",infoData[@"w_shlp_jp"]];
                self.bankFee.text = [NSString stringWithFormat:@"%@円",infoData[@"w_hf_jp"]];
                self.fiveLabel1.text = [NSString stringWithFormat:@"%@円",infoData[@"w_gjyz_tw"]];
                self.localFreight.text = [NSString stringWithFormat:@"%@円",infoData[@"w_yz_jp"]];
                self.localTax.text = [NSString stringWithFormat:@"%@円",infoData[@"w_sj_jp"]];
                self.overseasFee.text = [NSString stringWithFormat:@"%@円",infoData[@"w_gs_tw"]];
                self.overseasFee.text = [NSString stringWithFormat:@"%@円",infoData[@"w_gs_tw"]];
                self.fiveLabel2.text = [NSString stringWithFormat:@"%@円",infoData[@"w_newbag"]];
                self.fiveLabel3.text = [NSString stringWithFormat:@"%@円",infoData[@"w_cangchu"]];
                self.fiveLabel4.text = [NSString stringWithFormat:@"%@円",infoData[@"w_zplp_jp"]];
            }else{
                self.bidprice.text = [NSString stringWithFormat:@"%@美元",infoData[@"w_jbj_jp"]];
                self.castprice.text = [NSString stringWithFormat:@"%@美元",infoData[@"w_maxpay_jp"]];
                self.titleName.text = [NSString stringWithFormat:@"美国代拍费用（汇率：%@）",infoData[@"w_rate"]];
                self.damageClaim.text = [NSString stringWithFormat:@"%@美元",infoData[@"w_shlp_jp"]];
                self.bankFee.text = [NSString stringWithFormat:@"%@美元",infoData[@"w_hf_jp"]];
                self.fiveLabel1.text = [NSString stringWithFormat:@"%@美元",infoData[@"w_gjyz_tw"]];
                self.localFreight.text = [NSString stringWithFormat:@"%@美元",infoData[@"w_yz_jp"]];
                self.localTax.text = [NSString stringWithFormat:@"%@美元",infoData[@"w_sj_jp"]];
                self.overseasFee.text = [NSString stringWithFormat:@"%@美元",infoData[@"w_gs_tw"]];
                self.overseasFee.text = [NSString stringWithFormat:@"%@美元",infoData[@"w_gs_tw"]];
                self.fiveLabel2.text = [NSString stringWithFormat:@"%@美元",infoData[@"w_newbag"]];
                self.fiveLabel3.text = [NSString stringWithFormat:@"%@美元",infoData[@"w_cangchu"]];
                self.fiveLabel4.text = [NSString stringWithFormat:@"%@美元",infoData[@"w_zplp_jp"]];

            }
            self.total.text = [NSString stringWithFormat:@"%@RMB",infoData[@"w_total_tw"]];
            self.earnestMoney.text = [NSString stringWithFormat:@"%@RMB",infoData[@"w_prepay_tw"]];
//            self->buk =[infoData[@"w_total_tw"] floatValue]-[infoData[@"w_prepay_tw"] floatValue];
//            float fabBuk = fabsf(self->buk);
//            if (self->buk > 0) {
//                //需要补款
//                self.supplement.text = [NSString stringWithFormat:@"待补款金额：%.2fRMB",self->buk];
//                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.supplement.text];
//                [str addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"aa112d"] range:NSMakeRange(7,self.supplement.text.length-7)];
//                [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(17)] range:NSMakeRange(7,self.supplement.text.length-7)];
//                self.supplement.attributedText = str;
//
//                self.subMit.backgroundColor = [Unity getColor:@"aa112d"];
//                self.subMit.userInteractionEnabled = YES;
//            }
            if ([infoData[@"w_total_tw"] floatValue] >0) {
                if ([infoData[@"w_total_tw"] floatValue] > [infoData[@"w_prepay_tw"] floatValue]) {
                    self.supplement.text = [NSString stringWithFormat:@"待补款金额：%.2fRMB",[infoData[@"w_total_tw"] floatValue] - [infoData[@"w_prepay_tw"] floatValue]];
                    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.supplement.text];
                    [str addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"aa112d"] range:NSMakeRange(6,self.supplement.text.length-6)];
                    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(17)] range:NSMakeRange(6,self.supplement.text.length-6)];
                    self.supplement.attributedText = str;
                    
                    self.subMit.backgroundColor = [Unity getColor:@"aa112d"];
                    self.subMit.userInteractionEnabled = YES;
                }else if ([infoData[@"w_total_tw"] floatValue] < [infoData[@"w_prepay_tw"] floatValue]){
                    self.supplement.text = [NSString stringWithFormat:@"待退款金额：%.2fRMB",[infoData[@"w_prepay_tw"] floatValue] - [infoData[@"w_total_tw"] floatValue]];
                    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.supplement.text];
                    [str addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"aa112d"] range:NSMakeRange(6,self.supplement.text.length-6)];
                    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(17)] range:NSMakeRange(6,self.supplement.text.length-6)];
                    self.supplement.attributedText = str;
                }else{
                    if ([infoData[@"w_gjyz_tw"] floatValue] == 0) {
                        self.supplement.text = @"差国际运费";
                    }else if ([infoData[@"w_gnyz_tw"] floatValue] == 0){
                        self.supplement.text = @"差国内运费";
                    }else{
                        self.supplement.text = @"已结清";
                    }
                }
            }
            
            if (![infoData[@"w_overtime"] isKindOfClass:[NSNull class]]) {
                    self.round1.backgroundColor = [Unity getColor:@"aa112d"];
                    self.bidL.textColor = [Unity getColor:@"aa112d"];
                    NSArray *array = [infoData[@"w_overtime"] componentsSeparatedByString:@" "];
                    self.bidTime.text = array[0];
            }
            if (![infoData[@"w_hktime"] isKindOfClass:[NSNull class]]) {
                    self.round2.backgroundColor = [Unity getColor:@"aa112d"];
                    self.payL.textColor = [Unity getColor:@"aa112d"];
                    NSArray *array = [infoData[@"w_hktime"] componentsSeparatedByString:@" "];
                    self.payTime.text = array[0];
                    self.rLine1.backgroundColor = [Unity getColor:@"aa112d"];
            }
            if (![infoData[@"w_hwshtime"] isKindOfClass:[NSNull class]] && infoData[@"w_hwshtime"] !=nil) {
                    self.round3.backgroundColor = [Unity getColor:@"aa112d"];
                    self.goodsL.textColor = [Unity getColor:@"aa112d"];
                    NSArray *array = [infoData[@"w_hwshtime"] componentsSeparatedByString:@" "];
                    self.goodsTime.text = array[0];
                    self.rLine2.backgroundColor = [Unity getColor:@"aa112d"];
            }
            if (![infoData[@"w_time_jp"] isKindOfClass:[NSNull class]]) {
                    self.round4.backgroundColor = [Unity getColor:@"aa112d"];
                    self.deliveryL.textColor = [Unity getColor:@"aa112d"];
                    NSArray *array = [infoData[@"w_time_jp"] componentsSeparatedByString:@" "];
                    self.deliveryTime.text = array[0];
                    self.rLine3.backgroundColor = [Unity getColor:@"aa112d"];
                    
                    self.courierDynamic.text = @"查看动态";
                    self.courierDynamic.textColor = [Unity getColor:@"4a90e2"];
                    self.courierDynamic.userInteractionEnabled = YES;
                for (int i=0; i< [infoData[@"transport"][@"data"] count]; i++) {
                    NSMutableDictionary * dict = [NSMutableDictionary new];
                    dict = [infoData[@"transport"][@"data"][i] mutableCopy];
                    NSString * str = [NSString stringWithFormat:@"%f",[self getWidth:SCREEN_WIDTH-[Unity countcoordinatesW:110] title:infoData[@"transport"][@"data"][i][@"context"] font:[UIFont systemFontOfSize:FontSize(14)]]+[Unity countcoordinatesH:30]];
                    [dict setObject:str forKey:@"cellH"];
                    [self.infoList addObject:dict];
                }
            }
            self.loseType.text = infoData[@"ysfwstr"];
            self.weight.text = [NSString stringWithFormat:@"%@KG",infoData[@"w_kgs"]];
            if (![infoData[@"w_ems_zzfh"] isKindOfClass:[NSNull class]]) {
                self.courierNum.text = infoData[@"w_ems_zzfh"];
                self.courierNum.textColor = LabelColor6;
            }
            
            //当地代拍费用
            self.laborFee.text = [NSString stringWithFormat:@"%@RMB",infoData[@"w_dgf_tw"]];
            
            //国际运输费用
            self.fiveLabel5.text = [NSString stringWithFormat:@"%@RMB",infoData[@"w_gnyz_tw"]];
        }else{
            [self.altView showAlertView];
            self.altView.msgL.text = [data objectForKey:@"msg"];
        }
    } failure:^(NSError *error) {
        [self.aAnimation stopAround];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];

}

- (NSDictionary *)deleteNullWithDic:(NSDictionary *)dic{

    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
    for (NSString *keyStr in dic.allKeys) {
    
        if ([[dic objectForKey:keyStr] isKindOfClass:[NSNull class]]) {
        
            [mutableDic setObject:@"" forKey:keyStr];
        }
        else{
        
            [mutableDic setObject:[dic objectForKey:keyStr] forKey:keyStr];
        }
    }
    return mutableDic;
}
// 计算label高度
- (CGFloat)getWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    // 创建一个label对象，给出目标label的宽度
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    // 获得文字
    label.text = title;
    // 获得字体大小
    label.font = font;
    // 自适应
    label.numberOfLines = 0;
    [label sizeToFit];
    // 经过自适应之后的label，已经有新的高度
    CGFloat height = label.frame.size.height;
    // 返回高度
    return height;
}
- (AroundAnimation *)aAnimation{
    if (!_aAnimation) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _aAnimation = [AroundAnimation AroundAnimationViewSetView:window];
    }
    return _aAnimation;
}
- (alertView *)altView{
    if (_altView == nil) {
        _altView = [alertView setAlertView:self.view];
    }
    return _altView;
}
- (void)dynamic{
//    NSLog(@"快递动态");
    if ([self.dataDic[@"data"][@"w_cc"] isEqualToString:@"0"]) {
        if ([self.dataDic[@"data"][@"w_ysfw"] isEqualToString:@"4"]) {//空港快线
            KdPostalViewController * kvc = [[KdPostalViewController alloc]init];
            kvc.kd_id = self.dataDic[@"data"][@"w_ems_zzfh"];
            [self.navigationController pushViewController:kvc animated:YES];
        }else{
            KdJapanViewController * kvc = [[KdJapanViewController alloc]init];
            kvc.kd_id = self.dataDic[@"data"][@"w_ems_zzfh"];
            [self.navigationController pushViewController:kvc animated:YES];
        }
    }else{
        SendInfoViewController * svc = [[SendInfoViewController alloc]init];
        svc.listArray = self.infoList;
        [self.navigationController pushViewController:svc animated:YES];
    }
}
- (NSMutableArray *)infoList{
    if (!_infoList) {
        _infoList = [NSMutableArray new];
    }
    return _infoList;
}
- (NSDictionary *)dataDic{
    if (!_dataDic) {
        _dataDic = [[NSDictionary alloc]init];
    }
    return _dataDic;
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
