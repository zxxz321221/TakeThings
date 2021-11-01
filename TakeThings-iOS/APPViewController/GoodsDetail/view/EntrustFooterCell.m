//
//  EntrustFooterCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/28.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "EntrustFooterCell.h"
#import "UILabel+YBAttributeTextTapAction.h"
@interface EntrustFooterCell()
{
    NSInteger btnIndex;
    UILabel * typeLabel;
}
@property (nonatomic , strong) UIView * backV;
@property (nonatomic , strong) UIView * addressView;
@property (nonatomic , strong) UILabel * nameL;
@property (nonatomic , strong) UILabel * mobileL;
@property (nonatomic , strong) UILabel * addressName;

@property (nonatomic , strong) UIView * courierV;
@property (nonatomic , strong) UIView * kdView;
@property (nonatomic , strong) UIView * markView;
@property (nonatomic , strong) UIView * agreementView;
@property (nonatomic , strong) UIButton * agreementBtn;
@property (nonatomic , strong) UIButton *selectedBtn;
@property (nonatomic , strong) UIView * bkView;

@property (nonatomic , strong) NSString * platForm;

@end
@implementation EntrustFooterCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        [self setup];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView) name:@"shanyishan" object:nil];
    }
    return self;
}
- (void)setup{
    [self.contentView addSubview:self.backV];
    [self.contentView addSubview:self.bkView];
    [self.contentView addSubview:self.addressView];
    [self.contentView addSubview:self.courierV];
    [self.contentView addSubview:self.kdView];
    [self.contentView addSubview:self.markView];
    [self.contentView addSubview:self.agreementView];
}
- (UIView *)backV{
    if (!_backV) {
        _backV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:70])];
        _backV.backgroundColor = [Unity getColor:@"#f0f0f0"];
        NSString *label_text2 = @"购买成功严禁取消委托，请务必在委托前，确认对商品的所有疑问后谨慎购买，否则公司将依照弃标案件处理规则严肃执行《捎东西会员协议》";
        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
        [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(14)] range:NSMakeRange(0, label_text2.length)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"#aa112d"] range:NSMakeRange(0, label_text2.length-9)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"#4a90e2"] range:NSMakeRange(label_text2.length-9, 9)];

        UILabel *ybLabel2 = [[UILabel alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:50])];
        ybLabel2.numberOfLines = 0;
        ybLabel2.attributedText = attributedString2;
        [_backV addSubview:ybLabel2];
        // block 回调
        [ybLabel2 yb_addAttributeTapActionWithStrings:@[@"《捎东西会员协议》"] tapClicked:^(UILabel *label,NSString *string, NSRange range, NSInteger index) {
//            NSLog(@"点击了");
            [self.delegate sdxxieyi];
        }];
    }
    return _backV;
}
- (UIView *)bkView{
    if (!_bkView) {
        _bkView = [[UIView alloc]initWithFrame:CGRectMake(0, _backV.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:90])];
        _bkView.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        _bkView.layer.borderWidth = 2;
        _bkView.backgroundColor = [UIColor greenColor];
        _bkView.layer.cornerRadius = 5;
    }
    return _bkView;
}
- (UIView *)addressView{
    if (!_addressView) {
        _addressView = [[UIView alloc]initWithFrame:CGRectMake(0, _backV.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:90])];
        _addressView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *singleTap =

        [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addressClick:)];

        [_addressView addGestureRecognizer:singleTap];

        UILabel * label  = [Unity lableViewAddsuperview_superView:_addressView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:90], [Unity countcoordinatesH:15]) _string:@"收件人" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
        [_addressView addSubview:self.nameL];
        [_addressView addSubview:self.mobileL];
        UILabel * addressL = [Unity lableViewAddsuperview_superView:_addressView _subViewFrame:CGRectMake(label.left, label.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:90], [Unity countcoordinatesH:15]) _string:@"收货地址" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        addressL.backgroundColor = [UIColor clearColor];
        [_addressView addSubview:self.addressName];
        UIImageView * imageView = [Unity imageviewAddsuperview_superView:_addressView _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:17.5], [Unity countcoordinatesH:30], [Unity countcoordinatesW:7.5], [Unity countcoordinatesH:15]) _imageName:@"go" _backgroundColor:nil];
        imageView.backgroundColor = [UIColor clearColor];
    }
    return _addressView;
}
- (UILabel *)nameL{
    if (!_nameL) {
        _nameL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:100], [Unity countcoordinatesH:15], [Unity countcoordinatesW:70], [Unity countcoordinatesH:15])];
        _nameL.text = @"请填写收件人";
        _nameL.textColor = LabelColor6;
        _nameL.textAlignment = NSTextAlignmentLeft;
        _nameL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _nameL;
}
- (UILabel *)mobileL{
    if (!_mobileL) {
        _mobileL = [[UILabel alloc]initWithFrame:CGRectMake(_nameL.right, [Unity countcoordinatesH:15], [Unity countcoordinatesW:120], [Unity countcoordinatesH:15])];
        _mobileL.text = @"";
        _mobileL.textColor = LabelColor6;
        _mobileL.textAlignment = NSTextAlignmentRight;
        _mobileL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _mobileL;
}
- (UILabel *)addressName{
    if (!_addressName) {
        _addressName = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:100], _nameL.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:190], [Unity countcoordinatesH:30])];
        _addressName.text = @"请填写地址";
        _addressName.textColor = LabelColor6;
        _addressName.textAlignment = NSTextAlignmentLeft;
        _addressName.font = [UIFont systemFontOfSize:FontSize(14)];
        _addressName.numberOfLines = 0;
    }
    return _addressName;
}

- (UIView *)courierV{
    if (!_courierV) {
        _courierV = [[UIView alloc]initWithFrame:CGRectMake(0, _addressView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:45])];
        _courierV.backgroundColor = [Unity getColor:@"#f0f0f0"];
        UILabel * label = [Unity lableViewAddsuperview_superView:_courierV _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:15]) _string:@"为保证商品顺利送达，请确认您的收货地址" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
    }
    return _courierV;
}
- (UIView *)kdView{
    if (!_kdView) {
        _kdView = [[UIView alloc]initWithFrame:CGRectMake(0, _courierV.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:45])];
        typeLabel  = [Unity lableViewAddsuperview_superView:_kdView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:90], [Unity countcoordinatesH:15]) _string:@"国际运输方式:" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        typeLabel.backgroundColor = [UIColor whiteColor];
    }
    return _kdView;
}
- (UIView *)markView{
    if (!_markView) {
        _markView = [[UIView alloc]initWithFrame:CGRectMake(0, _kdView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        _markView.backgroundColor = [Unity getColor:@"#f0f0f0"];
        UILabel * label = [Unity lableViewAddsuperview_superView:_markView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:30]) _string:@"包括EMS,SAL,海运,海外到货后会员需自行通知发货才会发出;如产品关税,损坏,丢失情况,会员需自行承担." _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentLeft];
        label.numberOfLines = 0;
    }
    return _markView;
}
- (UIView *)agreementView{
    if (!_agreementView) {
        _agreementView = [[UIView alloc]initWithFrame:CGRectMake(0, _markView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        _agreementBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:19], [Unity countcoordinatesW:12], [Unity countcoordinatesH:12])];
        [_agreementBtn setBackgroundImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [_agreementBtn setBackgroundImage:[UIImage imageNamed:@"read"] forState:UIControlStateSelected];
        [_agreementBtn addTarget:self action:@selector(agreementClick) forControlEvents:UIControlEventTouchUpInside];
        [_agreementView addSubview:_agreementBtn];
        
        NSString *label_text2 = @"我已阅读并同意《公告委托合同书》注意事项";
        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
        [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FontSize(14)] range:NSMakeRange(0, label_text2.length)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:LabelColor3 range:NSMakeRange(0, 7)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"#4a90e2"] range:NSMakeRange(7, 9)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:LabelColor3 range:NSMakeRange(16, 4)];
        UILabel *ybLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(_agreementBtn.right+[Unity countcoordinatesW:5], [Unity countcoordinatesH:15], SCREEN_WIDTH-[Unity countcoordinatesW:40], [Unity countcoordinatesH:20])];
        ybLabel2.attributedText = attributedString2;
        [_agreementView addSubview:ybLabel2];
        // block 回调
        [ybLabel2 yb_addAttributeTapActionWithStrings:@[@"《公告委托合同书》"] tapClicked:^(UILabel *label,NSString *string, NSRange range, NSInteger index) {
//            NSLog(@"点击了");
            [self.delegate weituohetong];
        }];
    }
    return _agreementView;
}
- (void)agreementClick{
    if (self.agreementBtn.selected) {
        self.agreementBtn.selected = NO;
        [self.delegate agreementClick:NO];
    }else{
//        self.agreementBtn.selected = YES;
        [self.delegate agreementClick:YES];
    }
}


- (void)configWithArr:(NSArray *)arr WithAddress:(NSDictionary *)addressDic WithString:(NSString *)str{
    
    for (UIView *view in _kdView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    
    
    self.platForm = str;
    if ([str isEqualToString:@"0"]) {
        typeLabel.text = @"选择发往仓库:";
    }
    self.kdView.frame = CGRectMake(0, self.courierV.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:30]+(arr.count-1)*[Unity countcoordinatesH:10]+arr.count*[Unity countcoordinatesH:15]);
    self.markView.frame = CGRectMake(0, self.kdView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:50]);
    self.agreementView.frame = CGRectMake(0, self.markView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:50]);
    for (int i= 0 ; i<arr.count; i++) {
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:100], [Unity countcoordinatesH:15]+(i*[Unity countcoordinatesH:25])+[Unity countcoordinatesH:1.5], [Unity countcoordinatesW:210], [Unity countcoordinatesH:15])];
        btn.tag = i+1000;
        [btn addTarget:self action:@selector(kdClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
        [_kdView addSubview:btn];
    }
    UIButton *btn = (UIButton *)[self.kdView viewWithTag:1000];
//    btn.selected = YES;
//    self.selectedBtn = btn;
    
    if (addressDic != nil) {
        self.nameL.text = addressDic[@"w_name"];
        self.mobileL.text = [Unity editMobile:addressDic[@"w_mobile"]];
        self.addressName.text = [NSString stringWithFormat:@"%@ %@ %@",addressDic[@"w_address"],addressDic[@"w_address_detail"],addressDic[@"w_other"]];
    }
}
- (void)configWithTrType:(NSString *)trType{
    if ([trType isEqualToString:@"3"] || [trType isEqualToString:@"2"]) {
        UIButton *btn = (UIButton *)[self.kdView viewWithTag:1000];
        btn.selected = YES;
        self.selectedBtn = btn;
    }else{
        UIButton *btn = (UIButton *)[self.kdView viewWithTag:1001];
        btn.selected = YES;
        self.selectedBtn = btn;
    }
}
- (void)kdClick:(UIButton *)btn{
    btnIndex = btn.tag-1000;
    if (btn!=self.selectedBtn) {
        self.selectedBtn.selected =NO;
        btn.selected =YES;
        self.selectedBtn = btn;
    }
    [self.delegate transportType:btnIndex  WithPlatform:self.platForm];
}
- (void)addressClick:(UITapGestureRecognizer *)sender{
//    NSLog(@"1111");
    [self.delegate editAddress];
}
- (void)refreshTableView{
//    [UIView animateWithDuration:0.5 animations:^{
//        self.addressView.backgroundColor = [UIColor clearColor];
//    }completion:^(BOOL finished){
//        [UIView animateWithDuration:0.5 animations:^{
//            self.addressView.backgroundColor = [UIColor whiteColor];
//        }completion:^(BOOL finished){
//            [UIView animateWithDuration:0.5 animations:^{
//                self.addressView.backgroundColor = [UIColor clearColor];
//            }completion:^(BOOL finished){
//                [UIView animateWithDuration:0.5 animations:^{
//                    self.addressView.backgroundColor = [UIColor whiteColor];
//                }];
//            }];
//        }];
//    }];
    
}
- (void)entrustSeleted{
    self.agreementBtn.selected = YES;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
