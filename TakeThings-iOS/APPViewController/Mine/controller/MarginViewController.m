//
//  MarginViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/7/3.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "MarginViewController.h"
#import "PaymentViewController.h"
#import "RefundViewController.h"
#import "ActivityWebViewController.h"
#import "ServiceViewController.h"
#define bottomH (IS_iPhoneX ? [Unity countcoordinatesH:70] : [Unity countcoordinatesH:50])
@interface MarginViewController ()<UIScrollViewDelegate>
{
    NSInteger currentLever;//当前会员等级  默认0
    NSInteger currentRead;//当前选中等级 默认999
    BOOL isPay;//默认yes  付款
    NSDictionary * userInfo;
}
@property (nonatomic , strong) UIScrollView * scrollView;
@property (nonatomic , strong) UIView * topView;
@property (nonatomic , strong) UIImageView * topIcon;
@property (nonatomic , strong) UILabel * nameL;
@property (nonatomic , strong) UILabel * statusL;
@property (nonatomic , strong) UIButton * btn999;
@property (nonatomic , strong) UILabel * label999;
@property (nonatomic , strong) UILabel * place999;
@property (nonatomic , strong) UIButton * read999;
@property (nonatomic , strong) UILabel * refund999;
@property (nonatomic , strong) UILabel * limit999;

@property (nonatomic , strong) UIButton * btn99;
@property (nonatomic , strong) UIButton * read99;
@property (nonatomic , strong) UILabel * refund99;
@property (nonatomic , strong) UILabel * limit99;

@property (nonatomic , strong) UIButton * btn399;
@property (nonatomic , strong) UIButton * read399;
@property (nonatomic , strong) UILabel * refund399;
@property (nonatomic , strong) UILabel * limit399;

@property (nonatomic , strong) UIButton * btn699;
@property (nonatomic , strong) UIButton * read699;
@property (nonatomic , strong) UILabel * refund699;
@property (nonatomic , strong) UILabel * limit699;

@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UILabel * contentL;
@property (nonatomic , strong) UILabel * titleL1;
@property (nonatomic , strong) UILabel * contentL1;

@property (nonatomic , strong) UIView * bottomView;
@property (nonatomic , strong) UIButton * confirm;

@end

@implementation MarginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isPay= YES;
    
    [self createUI];
    
    [self loadViewUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"保证金";
}
- (void)loadViewUI{
    userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    if (![userInfo[@"w_photo"]isEqualToString:@""]) {
        NSString * str = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"],userInfo[@"w_photo"]];
        [self.topIcon sd_setImageWithURL:[NSURL URLWithString:str]];
    }
    self.nameL.text = userInfo[@"w_nickname"];
    if ([userInfo[@"w_coins"]floatValue] == 999) {
        self.statusL.text = @"您当前是999优等专属账号";
        currentRead = 999;
    }else if ([userInfo[@"w_coins"]floatValue] == 699){
        self.statusL.text = @"您当前是699正式普通账号";
        currentRead = 699;
    }else if ([userInfo[@"w_coins"]floatValue] == 399){
        self.statusL.text = @"您当前是399正式普通账号";
        currentRead = 399;
    }else if ([userInfo[@"w_coins"]floatValue] == 99){
        self.statusL.text = @"您当前是99正式普通账号";
        currentRead = 99;
    }else{
        self.statusL.text = @"您当前是体验用户";
        currentRead = 0;
    }
    currentLever = currentRead;
    [self reloadLayout:currentRead];
}
- (void)createUI{
    
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
    
//    [self creareHearderView];
    [self.scrollView addSubview:self.topView];
    [self.scrollView addSubview:self.btn999];
    [self.scrollView addSubview:self.btn99];
    [self.scrollView addSubview:self.btn399];
    [self.scrollView addSubview:self.btn699];
    [self.scrollView addSubview:self.titleL];
    [self.scrollView addSubview:self.contentL];
    [self.scrollView addSubview:self.titleL1];
    [self.scrollView addSubview:self.contentL1];
    /*将ui添加到scrollView数组中*/
    [self.scrollView sd_addSubviews:@[self.contentL1]];
    
    // scrollview自动contentsize
    [self.scrollView setupAutoContentSizeWithBottomView:self.contentL1 bottomMargin:20+bottomH];
    
    [self.view addSubview:self.bottomView];
}
- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:145])];
        [_topView addSubview:self.topIcon];
        [_topView addSubview:self.nameL];
        [_topView addSubview:self.statusL];
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:55], SCREEN_WIDTH, [Unity countcoordinatesH:45])];
        view.backgroundColor = LabelColor3;
        [_topView addSubview:view];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:25])];
        label.text = @"首次升99正式会员需联络客服手动帮您操作！本规则仅适用于日本雅虎委托";
        label.textColor = [Unity getColor:@"e5cfa4"];
        label.font = [UIFont systemFontOfSize:FontSize(11)];
        label.numberOfLines = 0;
        [view addSubview:label];
        
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:110], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:25])];
        label1.text = @"为避免因部分会员恶意弃单而影响到其他会员的委托权益，捎东西最新出炉会员等级制度，为保障您的委托权益倾尽全力";
        label1.textColor = LabelColor9;
        label1.font = [UIFont systemFontOfSize:FontSize(12)];
        label1.numberOfLines = 0;
        [_topView addSubview:label1];
    }
    return _topView;
}
- (UIImageView *)topIcon{
    if (!_topIcon) {
        _topIcon = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:7.5], [Unity countcoordinatesW:40], [Unity countcoordinatesH:40])];
//        _topIcon.backgroundColor = [UIColor redColor];
        _topIcon.image = [UIImage imageNamed:@"组8"];
        _topIcon.layer.cornerRadius = _topIcon.width/2;
        _topIcon.layer.masksToBounds = YES;
    }
    return _topIcon;
}
- (UILabel *)nameL{
    if (!_nameL) {
        _nameL = [[UILabel alloc]initWithFrame:CGRectMake(_topIcon.right+[Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:70], [Unity countcoordinatesH:20])];
        _nameL.text = @"账号名称";
        _nameL.textColor = LabelColor3;
        _nameL.font = [UIFont systemFontOfSize:FontSize(17)];
    }
    return _nameL;
}
- (UILabel *)statusL{
    if (!_statusL) {
        _statusL = [[UILabel alloc]initWithFrame:CGRectMake(_nameL.left, _nameL.bottom, _nameL.width, [Unity countcoordinatesH:15])];
        _statusL.text = @"您当前是体验用户";
        _statusL.textColor = LabelColor9;
        _statusL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _statusL;
}
- (UIButton *)btn999{
    if (!_btn999) {
        _btn999 = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _topView.bottom,SCREEN_WIDTH-[Unity countcoordinatesW:20] ,[Unity countcoordinatesH:85])];
        _btn999.tag = 999+1000;
        [_btn999 addTarget:self action:@selector(leverClick:) forControlEvents:UIControlEventTouchUpInside];
        _btn999.layer.cornerRadius = 10;
        _btn999.layer.masksToBounds = YES;
        _btn999.backgroundColor = [Unity getColor:@"aa112d"];
        
        [_btn999 addSubview:self.label999];
        [_btn999 addSubview:self.place999];
        [_btn999 addSubview:self.read999];
        [_btn999 addSubview:self.refund999];
        [_btn999 addSubview:self.limit999];
    }
    return _btn999;
}
- (UILabel *)label999{
    if (!_label999) {
        _label999 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:200], [Unity countcoordinatesH:20])];
        _label999.textColor = [UIColor whiteColor];
        _label999.font = [UIFont systemFontOfSize:FontSize(12)];
        NSString *specialStr = @"优等专属帐号 可委托6单";
        NSMutableAttributedString *infoStr = [[NSMutableAttributedString alloc] initWithString:specialStr];
        [infoStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(17)]range:NSMakeRange(0, 6)];
        _label999.attributedText = infoStr;
    }
    return _label999;
}
- (UILabel *)place999{
    if (!_place999) {
        _place999 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _label999.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:35])];
        _place999.textColor = [UIColor whiteColor];
        _place999.font = [UIFont systemFontOfSize:FontSize(12)];
        NSString *specialStr = @"999(RMB)";
        NSMutableAttributedString *infoStr = [[NSMutableAttributedString alloc] initWithString:specialStr];
        [infoStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(36)]range:NSMakeRange(0, 3)];
        _place999.attributedText = infoStr;
    }
    return _place999;
}
- (UIButton *)read999{
    if (!_read999) {
        _read999 = [[UIButton alloc]initWithFrame:CGRectMake(_btn999.width-[Unity countcoordinatesW:25], [Unity countcoordinatesH:12.5], [Unity countcoordinatesW:15], [Unity countcoordinatesH:15])];
        [_read999 setBackgroundImage:[UIImage imageNamed:@"未选啊"] forState:UIControlStateNormal];
        [_read999 setBackgroundImage:[UIImage imageNamed:@"选啊"] forState:UIControlStateSelected];
        _read999.selected = YES;
    }
    return _read999;
}
- (UILabel *)refund999{
    if (!_refund999) {
        _refund999 = [[UILabel alloc]initWithFrame:CGRectMake(_btn999.width-[Unity widthOfString:@"申请退回保证金" OfFontSize:FontSize(15) OfHeight:[Unity countcoordinatesH:20]]-[Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity widthOfString:@"申请退回保证金" OfFontSize:FontSize(15) OfHeight:[Unity countcoordinatesH:20]], [Unity countcoordinatesH:20])];
        _refund999.font = [UIFont systemFontOfSize:FontSize(15)];
        NSMutableAttributedString * content =[[NSMutableAttributedString alloc]initWithString:@"申请退回保证金"];
        NSRange contentRange ={0,[content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]range:contentRange];
        _refund999.attributedText=content;
        _refund999.textColor=LabelColor3;
        _refund999.hidden = YES;
    }
    return _refund999;
}
- (UILabel *)limit999{
    if (!_limit999) {
        _limit999 = [[UILabel alloc]initWithFrame:CGRectMake(_btn999.width-[Unity widthOfString:@"金额没有限制" OfFontSize:FontSize(12) OfHeight:[Unity countcoordinatesH:15]]-5-[Unity countcoordinatesW:10], [Unity countcoordinatesH:60], [Unity widthOfString:@"金额没有限制" OfFontSize:FontSize(12) OfHeight:[Unity countcoordinatesH:15]]+5, [Unity countcoordinatesH:15])];
        _limit999.layer.cornerRadius = _limit999.height/2;
        _limit999.layer.masksToBounds = YES;
        _limit999.backgroundColor = [Unity getColor:@"e7bcc4"];
        _limit999.text = @"金额没有限制";
        _limit999.textAlignment = NSTextAlignmentCenter;
        _limit999.textColor = [Unity getColor:@"aa112d"];
        _limit999.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _limit999;
}

- (UIButton *)btn99{
    if (!_btn99) {
        _btn99 = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _btn999.bottom+[Unity countcoordinatesH:10],SCREEN_WIDTH-[Unity countcoordinatesW:20] ,[Unity countcoordinatesH:85])];
        _btn99.tag = 99+1000;
        [_btn99 addTarget:self action:@selector(leverClick:) forControlEvents:UIControlEventTouchUpInside];
        _btn99.layer.cornerRadius = 10;
        _btn99.layer.masksToBounds = YES;
        _btn99.backgroundColor = [Unity getColor:@"e0e0e0"];
        
        UILabel * label99 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:200], [Unity countcoordinatesH:20])];
        label99.textColor = LabelColor3;
        label99.font = [UIFont systemFontOfSize:FontSize(12)];
        NSString *specialStr = @"正式普通帐号 可委托3单";
        NSMutableAttributedString *infoStr = [[NSMutableAttributedString alloc] initWithString:specialStr];
        [infoStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(17)]range:NSMakeRange(0, 6)];
        label99.attributedText = infoStr;
        [_btn99 addSubview:label99];
        
        UILabel * place99 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], label99.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:35])];
        place99.textColor = LabelColor3;
        place99.font = [UIFont systemFontOfSize:FontSize(12)];
        NSString *specialStr1 = @"99(RMB)";
        NSMutableAttributedString *infoStr1 = [[NSMutableAttributedString alloc] initWithString:specialStr1];
        [infoStr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(36)]range:NSMakeRange(0, 2)];
        place99.attributedText = infoStr1;
        [_btn99 addSubview:place99];

        [_btn99 addSubview:self.read99];
        [_btn99 addSubview:self.refund99];
        [_btn99 addSubview:self.limit99];
    }
    return _btn99;
}
- (UIButton *)read99{
    if (!_read99) {
        _read99 = [[UIButton alloc]initWithFrame:CGRectMake(_btn99.width-[Unity countcoordinatesW:25], [Unity countcoordinatesH:12.5], [Unity countcoordinatesW:15], [Unity countcoordinatesH:15])];
        [_read99 setBackgroundImage:[UIImage imageNamed:@"未选啊"] forState:UIControlStateNormal];
        [_read99 setBackgroundImage:[UIImage imageNamed:@"选啊"] forState:UIControlStateSelected];
    }
    return _read99;
}
- (UILabel *)refund99{
    if (!_refund99) {
        _refund99 = [[UILabel alloc]initWithFrame:CGRectMake(_btn99.width-[Unity widthOfString:@"申请退回保证金" OfFontSize:FontSize(15) OfHeight:[Unity countcoordinatesH:20]]-[Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity widthOfString:@"申请退回保证金" OfFontSize:FontSize(15) OfHeight:[Unity countcoordinatesH:20]], [Unity countcoordinatesH:20])];
        _refund99.font = [UIFont systemFontOfSize:FontSize(15)];
        NSMutableAttributedString * content =[[NSMutableAttributedString alloc]initWithString:@"申请退回保证金"];
        NSRange contentRange ={0,[content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]range:contentRange];
        _refund99.attributedText=content;
        _refund99.textColor=LabelColor3;
        _refund99.hidden = YES;
    }
    return _refund99;
}
- (UILabel *)limit99{
    if (!_limit99) {
        _limit99 = [[UILabel alloc]initWithFrame:CGRectMake(_btn99.width-[Unity widthOfString:@"金额<30000円" OfFontSize:FontSize(12) OfHeight:[Unity countcoordinatesH:15]]-5-[Unity countcoordinatesW:10], [Unity countcoordinatesH:60], [Unity widthOfString:@"金额<30000円" OfFontSize:FontSize(12) OfHeight:[Unity countcoordinatesH:15]]+5, [Unity countcoordinatesH:15])];
        _limit99.layer.cornerRadius = _limit99.height/2;
        _limit99.layer.masksToBounds = YES;
        _limit99.layer.borderColor = LabelColor3.CGColor;
        _limit99.layer.borderWidth =1;
        _limit99.text = @"金额<30000円";
        _limit99.textAlignment = NSTextAlignmentCenter;
        _limit99.textColor = LabelColor3;
        _limit99.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _limit99;
}

- (UIButton *)btn399{
    if (!_btn399) {
        _btn399 = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _btn99.bottom+[Unity countcoordinatesH:10],SCREEN_WIDTH-[Unity countcoordinatesW:20] ,[Unity countcoordinatesH:85])];
        _btn399.tag = 399+1000;
        [_btn399 addTarget:self action:@selector(leverClick:) forControlEvents:UIControlEventTouchUpInside];
        _btn399.layer.cornerRadius = 10;
        _btn399.layer.masksToBounds = YES;
        _btn399.backgroundColor = [Unity getColor:@"e0e0e0"];
        
        UILabel * label399 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:200], [Unity countcoordinatesH:20])];
        label399.textColor = LabelColor3;
        label399.font = [UIFont systemFontOfSize:FontSize(12)];
        NSString *specialStr = @"正式普通帐号 可委托4单";
        NSMutableAttributedString *infoStr = [[NSMutableAttributedString alloc] initWithString:specialStr];
        [infoStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(17)]range:NSMakeRange(0, 6)];
        label399.attributedText = infoStr;
        [_btn399 addSubview:label399];
        
        UILabel * place399 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], label399.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:35])];
        place399.textColor = LabelColor3;
        place399.font = [UIFont systemFontOfSize:FontSize(12)];
        NSString *specialStr1 = @"399(RMB)";
        NSMutableAttributedString *infoStr1 = [[NSMutableAttributedString alloc] initWithString:specialStr1];
        [infoStr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(36)]range:NSMakeRange(0, 3)];
        place399.attributedText = infoStr1;
        [_btn399 addSubview:place399];
        
        [_btn399 addSubview:self.read399];
        [_btn399 addSubview:self.refund399];
        [_btn399 addSubview:self.limit399];
    }
    return _btn399;
}
- (UIButton *)read399{
    if (!_read399) {
        _read399 = [[UIButton alloc]initWithFrame:CGRectMake(_btn399.width-[Unity countcoordinatesW:25], [Unity countcoordinatesH:12.5], [Unity countcoordinatesW:15], [Unity countcoordinatesH:15])];
        [_read399 setBackgroundImage:[UIImage imageNamed:@"未选啊"] forState:UIControlStateNormal];
        [_read399 setBackgroundImage:[UIImage imageNamed:@"选啊"] forState:UIControlStateSelected];
    }
    return _read399;
}
- (UILabel *)refund399{
    if (!_refund399) {
        _refund399 = [[UILabel alloc]initWithFrame:CGRectMake(_btn399.width-[Unity widthOfString:@"申请退回保证金" OfFontSize:FontSize(15) OfHeight:[Unity countcoordinatesH:20]]-[Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity widthOfString:@"申请退回保证金" OfFontSize:FontSize(15) OfHeight:[Unity countcoordinatesH:20]], [Unity countcoordinatesH:20])];
        _refund399.font = [UIFont systemFontOfSize:FontSize(15)];
        NSMutableAttributedString * content =[[NSMutableAttributedString alloc]initWithString:@"申请退回保证金"];
        NSRange contentRange ={0,[content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]range:contentRange];
        _refund399.attributedText=content;
        _refund399.textColor=LabelColor3;
        _refund399.hidden = YES;
    }
    return _refund399;
}
- (UILabel *)limit399{
    if (!_limit399) {
        _limit399 = [[UILabel alloc]initWithFrame:CGRectMake(_btn399.width-[Unity widthOfString:@"金额<60000円" OfFontSize:FontSize(12) OfHeight:[Unity countcoordinatesH:15]]-5-[Unity countcoordinatesW:10], [Unity countcoordinatesH:60], [Unity widthOfString:@"金额<60000円" OfFontSize:FontSize(12) OfHeight:[Unity countcoordinatesH:15]]+5, [Unity countcoordinatesH:15])];
        _limit399.layer.cornerRadius = _limit399.height/2;
        _limit399.layer.masksToBounds = YES;
        _limit399.layer.borderColor = LabelColor3.CGColor;
        _limit399.layer.borderWidth =1;
        _limit399.text = @"金额<60000円";
        _limit399.textAlignment = NSTextAlignmentCenter;
        _limit399.textColor = LabelColor3;
        _limit399.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _limit399;
}

- (UIButton *)btn699{
    if (!_btn699) {
        _btn699 = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _btn399.bottom+[Unity countcoordinatesH:10],SCREEN_WIDTH-[Unity countcoordinatesW:20] ,[Unity countcoordinatesH:85])];
        _btn699.tag = 699+1000;
        [_btn699 addTarget:self action:@selector(leverClick:) forControlEvents:UIControlEventTouchUpInside];
        _btn699.layer.cornerRadius = 10;
        _btn699.layer.masksToBounds = YES;
        _btn699.backgroundColor = [Unity getColor:@"e0e0e0"];
        
        UILabel * label699 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:200], [Unity countcoordinatesH:20])];
        label699.textColor = LabelColor3;
        label699.font = [UIFont systemFontOfSize:FontSize(12)];
        NSString *specialStr = @"正式普通帐号 可委托5单";
        NSMutableAttributedString *infoStr = [[NSMutableAttributedString alloc] initWithString:specialStr];
        [infoStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(17)]range:NSMakeRange(0, 6)];
        label699.attributedText = infoStr;
        [_btn699 addSubview:label699];
        
        UILabel * place699 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], label699.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:35])];
        place699.textColor = LabelColor3;
        place699.font = [UIFont systemFontOfSize:FontSize(12)];
        NSString *specialStr1 = @"699(RMB)";
        NSMutableAttributedString *infoStr1 = [[NSMutableAttributedString alloc] initWithString:specialStr1];
        [infoStr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(36)]range:NSMakeRange(0, 3)];
        place699.attributedText = infoStr1;
        [_btn699 addSubview:place699];
        
        [_btn699 addSubview:self.read699];
        [_btn699 addSubview:self.refund699];
        [_btn699 addSubview:self.limit699];
    }
    return _btn699;
}
- (UIButton *)read699{
    if (!_read699) {
        _read699 = [[UIButton alloc]initWithFrame:CGRectMake(_btn399.width-[Unity countcoordinatesW:25], [Unity countcoordinatesH:12.5], [Unity countcoordinatesW:15], [Unity countcoordinatesH:15])];
        [_read699 setBackgroundImage:[UIImage imageNamed:@"未选啊"] forState:UIControlStateNormal];
        [_read699 setBackgroundImage:[UIImage imageNamed:@"选啊"] forState:UIControlStateSelected];
    }
    return _read699;
}
- (UILabel *)refund699{
    if (!_refund699) {
        _refund699 = [[UILabel alloc]initWithFrame:CGRectMake(_btn699.width-[Unity widthOfString:@"申请退回保证金" OfFontSize:FontSize(15) OfHeight:[Unity countcoordinatesH:20]]-[Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity widthOfString:@"申请退回保证金" OfFontSize:FontSize(15) OfHeight:[Unity countcoordinatesH:20]], [Unity countcoordinatesH:20])];
        _refund699.font = [UIFont systemFontOfSize:FontSize(15)];
        NSMutableAttributedString * content =[[NSMutableAttributedString alloc]initWithString:@"申请退回保证金"];
        NSRange contentRange ={0,[content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]range:contentRange];
        _refund699.attributedText=content;
        _refund699.textColor=LabelColor3;
        _refund699.hidden = YES;
    }
    return _refund699;
}
- (UILabel *)limit699{
    if (!_limit699) {
        _limit699 = [[UILabel alloc]initWithFrame:CGRectMake(_btn699.width-[Unity widthOfString:@"金额<100000円" OfFontSize:FontSize(12) OfHeight:[Unity countcoordinatesH:15]]-5-[Unity countcoordinatesW:10], [Unity countcoordinatesH:60], [Unity widthOfString:@"金额<100000円" OfFontSize:FontSize(12) OfHeight:[Unity countcoordinatesH:15]]+5, [Unity countcoordinatesH:15])];
        _limit699.layer.cornerRadius = _limit699.height/2;
        _limit699.layer.masksToBounds = YES;
        _limit699.layer.borderColor = LabelColor3.CGColor;
        _limit699.layer.borderWidth =1;
        _limit699.text = @"金额<100000円";
        _limit699.textAlignment = NSTextAlignmentCenter;
        _limit699.textColor = LabelColor3;
        _limit699.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _limit699;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _topView.bottom+[Unity countcoordinatesH:390], 200, [Unity countcoordinatesH:15])];
        _titleL.text = @"【注意事项】";
        _titleL.textColor = LabelColor6;
        _titleL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _titleL;
}
- (UILabel *)contentL{
    if (!_contentL) {
        _contentL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _titleL.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:20], 0)];
        _contentL.text = @"1.捎东西网站体验会员升级至99正式会员，会员无法自行操作，需联络捎东西在线客服验证后到后台操作; 99正式会员升级到399及以上正式会员，可以自行操作升级。\n2.本网站所给予会员的委托次数是根据会员信用度设定的，系统会根据您信用度的好坏自动增减委托次数，所以会员在下单前请三思，如有不确定的问题，请先与我们的翻译人员联系并确认。一旦购买后成功就必须付款，如有弃单的情况发生，您、卖家与捎东西三方都会承受损失，所以请您尽量避免。";
        _contentL.textColor = LabelColor9;
        _contentL.font = [UIFont systemFontOfSize:FontSize(12)];
        _contentL.numberOfLines = 0;
        
        [_contentL sizeToFit];
    }
    return _contentL;
}
- (UILabel *)titleL1{
    if (!_titleL1) {
        _titleL1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _contentL.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:15])];
        _titleL1.text = @"本制度最终解释权由捎东西网所有";
        _titleL1.textColor = LabelColor6;
        _titleL1.textAlignment = NSTextAlignmentRight;
        _titleL1.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _titleL1;
}
- (UILabel *)contentL1{
    if (!_contentL1) {
        _contentL1 = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _titleL1.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH-[Unity countcoordinatesW:20], 0)];
        _contentL1.text = @"【注】可委托案件单数是指您可同时进行委托的案件的数量，当参与的案件失效或者已付款后，系统会自动将此可委托案件数返还您。";
        _contentL1.textColor = LabelColor6;
        _contentL1.font = [UIFont systemFontOfSize:FontSize(12)];
        _contentL1.numberOfLines = 0;
        
        [_contentL1 sizeToFit];
    }
    return _contentL1;
}
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NavBarHeight-bottomH, SCREEN_HEIGHT, bottomH)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        line.backgroundColor = [Unity getColor:@"f0f0f0"];
        [_bottomView addSubview:line];
        [_bottomView addSubview:self.confirm];
    }
    return _bottomView;
}
- (UIButton *)confirm{
    if (!_confirm) {
        _confirm = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:3], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        [_confirm addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        _confirm.backgroundColor = [Unity getColor:@"aa112d"];
        [_confirm setTitle:@"提交并付款" forState:UIControlStateNormal];
        [_confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirm.titleLabel.font = [UIFont systemFontOfSize:FontSize(17)];
        _confirm.layer.cornerRadius = _confirm.height/2;
        _confirm.layer.masksToBounds = YES;
    }
    return _confirm;
}

- (void)confirmClick{
//    currentLever = currentRead;
//    [self reloadLayout:currentRead];
//    if (isPay) {
//        PaymentViewController * pvc = [[PaymentViewController alloc]init];
//        pvc.place = currentRead-currentLever;
//        [self.navigationController pushViewController:pvc animated:YES];
//    }else{
//        RefundViewController * rvc = [[RefundViewController alloc]init];
//        rvc.place = currentLever-currentRead;
//        [self.navigationController pushViewController:rvc animated:YES];
//    }
    
//    ActivityWebViewController *webService = [[ActivityWebViewController alloc]init];
//    // 获得当前iPhone使用的语言
//    NSString* currentLanguage = NSLocalizedString(@"GlobalBuyer_Nativelanguage", nil);
//    NSLog(@"当前使用的语言：%@",currentLanguage);
//    if ([currentLanguage isEqualToString:@"zh-Hans-US"]) {
//        webService.href = @"http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html";
//    }else if([currentLanguage isEqualToString:@"zh-Hant"]){
//        webService.href = @"http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html";
//    }else if([currentLanguage isEqualToString:@"en"]){
//        webService.href = @"http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html";
//    }else{
//        webService.href = @"http://buy.dayanghang.net/user_data/special/20190124/qqmsCustomerService.html";
//    }
//    webService.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:webService animated:YES];
    ServiceViewController * svc = [[ServiceViewController alloc]init];
    svc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:svc animated:YES];
}
- (void)reloadLayout:(NSInteger)lever{
    if (lever == 0) {
        self.btn999.frame = CGRectMake([Unity countcoordinatesW:10], _topView.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:85]);
        self.btn99.frame = CGRectMake([Unity countcoordinatesW:10], self.btn999.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:85]);
        self.btn399.frame = CGRectMake([Unity countcoordinatesW:10], self.btn99.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:85]);
        self.btn699.frame = CGRectMake([Unity countcoordinatesW:10], self.btn399.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:85]);
        self.btn999.backgroundColor = [Unity getColor:@"aa112d"];
        self.label999.textColor = [UIColor whiteColor];
        self.place999.textColor = [UIColor whiteColor];
        self.read999.hidden = NO;
        self.refund999.hidden = YES;
        self.limit999.backgroundColor = [Unity getColor:@"e7bcc4"];
        self.limit999.textColor = [Unity getColor:@"aa112d"];
        self.btn99.backgroundColor = [Unity getColor:@"e0e0e0"];
        self.read99.hidden = NO;
        self.refund99.hidden = YES;
        self.limit99.backgroundColor = [UIColor clearColor];
        self.limit99.textColor = LabelColor3;
        self.btn399.backgroundColor = [Unity getColor:@"e0e0e0"];
        self.read399.hidden = NO;
        self.refund399.hidden = YES;
        self.limit399.backgroundColor = [UIColor clearColor];
        self.limit399.textColor = LabelColor3;
        self.btn699.backgroundColor = [Unity getColor:@"e0e0e0"];
        self.read699.hidden = NO;
        self.refund699.hidden = YES;
        self.limit699.backgroundColor = [UIColor clearColor];
        self.limit699.textColor = LabelColor3;
        self.confirm.backgroundColor = [Unity getColor:@"cb6d7f"];
        self.confirm.userInteractionEnabled = NO;
        self.read99.selected = NO;
        self.read399.selected = NO;
        self.read699.selected = NO;
        currentRead = 999;
        self.read999.selected = YES;
    }else if (lever == 999){
        self.btn999.frame = CGRectMake([Unity countcoordinatesW:10], _topView.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:85]);
        self.btn99.frame = CGRectMake([Unity countcoordinatesW:10], self.btn999.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:85]);
        self.btn399.frame = CGRectMake([Unity countcoordinatesW:10], self.btn99.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:85]);
        self.btn699.frame = CGRectMake([Unity countcoordinatesW:10], self.btn399.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:85]);
        self.btn999.backgroundColor = [Unity getColor:@"e5cfa4"];
        self.label999.textColor = LabelColor3;
        self.place999.textColor = LabelColor3;
        self.read999.hidden = YES;
        self.refund999.hidden = NO;
        self.limit999.backgroundColor = [Unity getColor:@"57524a"];
        self.limit999.textColor = [Unity getColor:@"e5cfa4"];
        self.btn99.backgroundColor = [Unity getColor:@"e0e0e0"];
        self.read99.hidden = NO;
        self.refund99.hidden = YES;
        self.limit99.backgroundColor = [UIColor clearColor];
        self.limit99.textColor = LabelColor3;
        self.btn399.backgroundColor = [Unity getColor:@"e0e0e0"];
        self.read399.hidden = NO;
        self.refund399.hidden = YES;
        self.limit399.backgroundColor = [UIColor clearColor];
        self.limit399.textColor = LabelColor3;
        self.btn699.backgroundColor = [Unity getColor:@"e0e0e0"];
        self.read699.hidden = NO;
        self.refund699.hidden = YES;
        self.limit699.backgroundColor = [UIColor clearColor];
        self.limit699.textColor = LabelColor3;
        self.confirm.backgroundColor = [Unity getColor:@"cb6d7f"];
        self.confirm.userInteractionEnabled = NO;
        self.read99.selected = NO;
        self.read399.selected = NO;
        self.read699.selected = NO;
    }else if (lever == 699){
        self.btn699.frame = CGRectMake([Unity countcoordinatesW:10], _topView.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:85]);
        self.btn999.frame = CGRectMake([Unity countcoordinatesW:10], self.btn699.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:85]);
        self.btn99.frame = CGRectMake([Unity countcoordinatesW:10], self.btn999.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:85]);
        self.btn399.frame = CGRectMake([Unity countcoordinatesW:10], self.btn99.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:85]);
        self.btn699.backgroundColor = [Unity getColor:@"e5cfa4"];
        self.read699.hidden = YES;
        self.refund699.hidden = NO;
        self.limit699.backgroundColor = [Unity getColor:@"57524a"];
        self.limit699.textColor = [Unity getColor:@"e5cfa4"];
        self.btn999.backgroundColor = [Unity getColor:@"aa112d"];
        self.label999.textColor = [UIColor whiteColor];
        self.place999.textColor = [UIColor whiteColor];
        self.read999.hidden = NO;
        self.refund999.hidden = YES;
        self.limit999.backgroundColor = [Unity getColor:@"e7bcc4"];
        self.limit999.textColor = [Unity getColor:@"aa112d"];
        self.btn99.backgroundColor = [Unity getColor:@"e0e0e0"];
        self.read99.hidden = NO;
        self.refund99.hidden = YES;
        self.limit99.backgroundColor = [UIColor clearColor];
        self.limit99.textColor = LabelColor3;
        self.btn399.backgroundColor = [Unity getColor:@"e0e0e0"];
        self.read399.hidden = NO;
        self.refund399.hidden = YES;
        self.limit399.backgroundColor = [UIColor clearColor];
        self.limit399.textColor = LabelColor3;
        currentRead = 999;
        self.read999.selected = YES;
    }else if (lever == 399){
        self.btn399.frame = CGRectMake([Unity countcoordinatesW:10], _topView.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:85]);
        self.btn999.frame = CGRectMake([Unity countcoordinatesW:10], self.btn399.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:85]);
        self.btn99.frame = CGRectMake([Unity countcoordinatesW:10], self.btn999.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:85]);
        self.btn699.frame = CGRectMake([Unity countcoordinatesW:10], self.btn99.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:85]);
        self.btn399.backgroundColor = [Unity getColor:@"e5cfa4"];
        self.read399.hidden = YES;
        self.refund399.hidden = NO;
        self.limit399.backgroundColor = [Unity getColor:@"57524a"];
        self.limit399.textColor = [Unity getColor:@"e5cfa4"];
        self.btn999.backgroundColor = [Unity getColor:@"aa112d"];
        self.label999.textColor = [UIColor whiteColor];
        self.place999.textColor = [UIColor whiteColor];
        self.read999.hidden = NO;
        self.refund999.hidden = YES;
        self.limit999.backgroundColor = [Unity getColor:@"e7bcc4"];
        self.limit999.textColor = [Unity getColor:@"aa112d"];
        self.btn99.backgroundColor = [Unity getColor:@"e0e0e0"];
        self.read99.hidden = NO;
        self.refund99.hidden = YES;
        self.limit99.backgroundColor = [UIColor clearColor];
        self.limit99.textColor = LabelColor3;
        self.btn699.backgroundColor = [Unity getColor:@"e0e0e0"];
        self.read699.hidden = NO;
        self.refund699.hidden = YES;
        self.limit699.backgroundColor = [UIColor clearColor];
        self.limit699.textColor = LabelColor3;
        currentRead = 999;
        self.read999.selected = YES;
    }else{
        self.btn99.frame = CGRectMake([Unity countcoordinatesW:10], _topView.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:85]);
        self.btn999.frame = CGRectMake([Unity countcoordinatesW:10], self.btn99.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:85]);
        self.btn399.frame = CGRectMake([Unity countcoordinatesW:10], self.btn999.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:85]);
        self.btn699.frame = CGRectMake([Unity countcoordinatesW:10], self.btn399.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:85]);
        self.btn99.backgroundColor = [Unity getColor:@"e5cfa4"];
        self.read99.hidden = YES;
        self.refund99.hidden = NO;
        self.limit99.backgroundColor = [Unity getColor:@"57524a"];
        self.limit99.textColor = [Unity getColor:@"e5cfa4"];
        self.btn999.backgroundColor = [Unity getColor:@"aa112d"];
        self.label999.textColor = [UIColor whiteColor];
        self.place999.textColor = [UIColor whiteColor];
        self.read999.hidden = NO;
        self.refund999.hidden = YES;
        self.limit999.backgroundColor = [Unity getColor:@"e7bcc4"];
        self.limit999.textColor = [Unity getColor:@"aa112d"];
        self.btn399.backgroundColor = [Unity getColor:@"e0e0e0"];
        self.read399.hidden = NO;
        self.refund399.hidden = YES;
        self.limit399.backgroundColor = [UIColor clearColor];
        self.limit399.textColor = LabelColor3;
        self.btn699.backgroundColor = [Unity getColor:@"e0e0e0"];
        self.read699.hidden = NO;
        self.refund699.hidden = YES;
        self.limit699.backgroundColor = [UIColor clearColor];
        self.limit699.textColor = LabelColor3;
        currentRead = 999;
        self.read999.selected = YES;
    }
    
}
- (void)leverClick:(UIButton *)btn{
    if (btn.tag-1000 == currentLever) {
        self.confirm.backgroundColor = [Unity getColor:@"cb6d7f"];
        self.confirm.userInteractionEnabled = NO;
    }else{
        self.confirm.backgroundColor = [Unity getColor:@"aa112d"];
        self.confirm.userInteractionEnabled = YES;
    }
    currentRead = btn.tag-1000;
    if (btn.tag-1000 == 999) {
        self.read999.selected = YES;
        self.read99.selected = NO;
        self.read399.selected = NO;
        self.read699.selected = NO;
    }
    if (btn.tag-1000 == 99) {
        self.read99.selected = YES;
        self.read999.selected = NO;
        self.read399.selected = NO;
        self.read699.selected = NO;
    }
    if (btn.tag-1000 == 399) {
        self.read399.selected = YES;
        self.read999.selected = NO;
        self.read99.selected = NO;
        self.read699.selected = NO;
    }
    if (btn.tag-1000 == 699) {
        self.read699.selected = YES;
        self.read999.selected = NO;
        self.read399.selected = NO;
        self.read99.selected = NO;
    }
    if (currentLever<currentRead) {
        NSLog(@"补充%d",currentRead-currentLever);
        isPay = YES;
    }
    if (currentLever>currentRead) {
        NSLog(@"退钱%d",currentLever-currentRead);
        isPay= NO;
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
