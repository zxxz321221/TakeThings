//
//  PayCell0.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/25.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "PayCell0.h"
@interface PayCell0()<UITextFieldDelegate>
@property (nonatomic , strong) UILabel * nameLabel;
@property (nonatomic , strong) UITextField * nameText;
@property (nonatomic , strong) UILabel * bankNum;
@property (nonatomic , strong) UITextField * bankNumText;
@property (nonatomic , strong) UILabel * idNum;
@property (nonatomic , strong) UITextField * idNumText;
@property (nonatomic , strong) UILabel * mobileNum;
@property (nonatomic , strong) UITextField * mobileNumText;
@property (nonatomic , strong) UIButton * codeBtn;
@property (nonatomic , strong) UITextField * codeText;
@property (nonatomic , strong) UILabel * bankName;
@property (nonatomic , strong) UILabel * validLabel;
@property (nonatomic , strong) UITextField * validText;
@property (nonatomic , strong) UILabel * safeLabel;
@property (nonatomic , strong) UITextField * safeText;
@end
@implementation PayCell0
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self payCellView];
    }
    return self;
}
- (void)payCellView{
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.nameText];
    [self.contentView addSubview:self.bankNum];
    [self.contentView addSubview:self.bankNumText];
    [self.contentView addSubview:self.idNum];
    [self.contentView addSubview:self.idNumText];
    [self.contentView addSubview:self.mobileNum];
    [self.contentView addSubview:self.mobileNumText];
    [self.contentView addSubview:self.bankName];
    [self.contentView addSubview:self.bankNameText];
    [self.contentView addSubview:self.validLabel];
    [self.contentView addSubview:self.validText];
    [self.contentView addSubview:self.safeLabel];
    [self.contentView addSubview:self.safeText];
    [self.contentView addSubview:self.codeBtn];
    [self.contentView addSubview:self.codeText];
}
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], [Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _nameLabel.text = @"姓名";
        _nameLabel.textColor = LabelColor3;
        _nameLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _nameLabel;
}
- (UITextField *)nameText{
    if (!_nameText) {
        _nameText = [[UITextField alloc]initWithFrame:CGRectMake(_nameLabel.right, _nameLabel.top, SCREEN_WIDTH-[Unity countcoordinatesW:130], [Unity countcoordinatesH:20])];
        _nameText.placeholder = @"请输入姓名";
        _nameText.font = [UIFont systemFontOfSize:FontSize(14)];
        [_nameText addTarget:self action:@selector(nameClick:) forControlEvents:UIControlEventEditingChanged];
    }
    return _nameText;
}
- (UILabel *)bankNum{
    if (!_bankNum) {
        _bankNum = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], _nameLabel.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _bankNum.text = @"银行卡号";
        _bankNum.textColor = LabelColor3;
        _bankNum.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _bankNum;
}
- (UITextField *)bankNumText{
    if (!_bankNumText) {
        _bankNumText = [[UITextField alloc]initWithFrame:CGRectMake(_bankNum.right, _bankNum.top, SCREEN_WIDTH-[Unity countcoordinatesW:130], [Unity countcoordinatesH:20])];
        _bankNumText.placeholder = @"请输入银行卡号";
        _bankNumText.keyboardType = UIKeyboardTypeNumberPad;
        _bankNumText.font = [UIFont systemFontOfSize:FontSize(14)];
        [_bankNumText addTarget:self action:@selector(bankNumClick:) forControlEvents:UIControlEventEditingChanged];
    }
    return _bankNumText;
}
- (UILabel *)idNum{
    if (!_idNum) {
        _idNum = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], _bankNum.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _idNum.text = @"身份证号码";
        _idNum.textColor = LabelColor3;
        _idNum.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _idNum;
}
- (UITextField *)idNumText{
    if (!_idNumText) {
        _idNumText = [[UITextField alloc]initWithFrame:CGRectMake(_idNum.right, _idNum.top, SCREEN_WIDTH-[Unity countcoordinatesW:130], [Unity countcoordinatesH:20])];
        _idNumText.font = [UIFont systemFontOfSize:FontSize(14)];
        _idNumText.placeholder = @"请输入身份证号码";
//        _idNumText.keyboardType = UIKeyboardTypeNumberPad;
        [_idNumText addTarget:self action:@selector(idNumClick:) forControlEvents:UIControlEventEditingChanged];
    }
    return _idNumText;
}
- (UILabel *)mobileNum{
    if (!_mobileNum) {
        _mobileNum = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], _idNum.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _mobileNum.text = @"手机号";
        _mobileNum.textColor = LabelColor3;
        _mobileNum.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _mobileNum;
}
- (UITextField *)mobileNumText{
    if (!_mobileNumText) {
        _mobileNumText = [[UITextField alloc]initWithFrame:CGRectMake(_mobileNum.right, _mobileNum.top, SCREEN_WIDTH-[Unity countcoordinatesW:130], [Unity countcoordinatesH:20])];
        _mobileNumText.font = [UIFont systemFontOfSize:FontSize(14)];
        _mobileNumText.placeholder = @"请输入手机号码";
        _mobileNumText.keyboardType = UIKeyboardTypeNumberPad;
        [_mobileNumText addTarget:self action:@selector(mobileNumClick:) forControlEvents:UIControlEventEditingChanged];
    }
    return _mobileNumText;
}
- (UILabel *)bankName{
    if (!_bankName) {
        _bankName = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], _mobileNum.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _bankName.text = @"银行名称";
        _bankName.textColor = LabelColor3;
        _bankName.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _bankName;
}
- (UITextField *)bankNameText{
    if (!_bankNameText) {
        _bankNameText = [[UITextField alloc]initWithFrame:CGRectMake(_bankName.right, _bankName.top, SCREEN_WIDTH-[Unity countcoordinatesW:130], [Unity countcoordinatesH:20])];
        _bankNameText.font = [UIFont systemFontOfSize:FontSize(14)];
        _bankNameText.placeholder = @"请选择银行名称";
        _bankNameText.delegate = self;
    }
    return _bankNameText;
}
- (UILabel *)validLabel{
    if (!_validLabel) {
        _validLabel = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], _bankName.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _validLabel.text = @"有效期";
        _validLabel.textColor = LabelColor3;
        _validLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _validLabel;
}
- (UITextField *)validText{
    if (!_validText) {
        _validText = [[UITextField alloc]initWithFrame:CGRectMake(_validLabel.right, _validLabel.top, SCREEN_WIDTH-[Unity countcoordinatesW:130], [Unity countcoordinatesH:20])];
        _validText.font = [UIFont systemFontOfSize:FontSize(14)];
        _validText.keyboardType = UIKeyboardTypeNumberPad;
        _validText.placeholder = @"有效期2002";
        [_validText addTarget:self action:@selector(validClick:) forControlEvents:UIControlEventEditingChanged];
    }
    return _validText;
}
- (UILabel *)safeLabel{
    if (!_safeLabel) {
        _safeLabel = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], _validLabel.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _safeLabel.text = @"信用卡安全码";
        _safeLabel.textColor = LabelColor3;
        _safeLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _safeLabel;
}
- (UITextField *)safeText{
    if (!_safeText) {
        _safeText = [[UITextField alloc]initWithFrame:CGRectMake(_safeLabel.right, _safeLabel.top, SCREEN_WIDTH-[Unity countcoordinatesW:130], [Unity countcoordinatesH:20])];
        _safeText.font = [UIFont systemFontOfSize:FontSize(14)];
        _safeText.keyboardType = UIKeyboardTypeNumberPad;
        _safeText.placeholder = @"信用卡背面3位数";
        [_safeText addTarget:self action:@selector(safeClick:) forControlEvents:UIControlEventEditingChanged];
    }
    return _safeText;
}
- (UIButton *)codeBtn{
    if (!_codeBtn) {
        _codeBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:110], _safeText.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:30])];
        [_codeBtn addTarget:self action:@selector(codeClick) forControlEvents:UIControlEventTouchUpInside];
        _codeBtn.backgroundColor = [Unity getColor:@"f0f0f0"];
        _codeBtn.layer.cornerRadius = [Unity countcoordinatesH:15];
        [_codeBtn setTitle:@"点击获取验证码" forState:UIControlStateNormal];
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        [_codeBtn setTitleColor:LabelColor9 forState:UIControlStateNormal];
    }
    return _codeBtn;
}
- (UITextField *)codeText{
    if (!_codeText) {
        _codeText = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], _safeText.bottom+[Unity countcoordinatesH:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        _codeText.font = [UIFont systemFontOfSize:FontSize(14)];
        _codeText.placeholder = @"请输入验证码";
        _codeText.keyboardType = UIKeyboardTypeNumberPad;
        [_codeText addTarget:self action:@selector(codeTextClick:) forControlEvents:UIControlEventEditingChanged];
    }
    return _codeText;
}
/***
点击获取验证码
***/
- (void)codeClick{
    if (self.nameText.text.length ==0) {
        [WHToast showMessage:@"请输入姓名" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        return;
    }
    if (self.bankNumText.text.length ==0) {
        [WHToast showMessage:@"请输入银行卡号" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        return;
    }
    if (self.idNumText.text.length ==0) {
        [WHToast showMessage:@"请输入身份证号码" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        return;
    }
    if (self.mobileNumText.text.length ==0) {
        [WHToast showMessage:@"请输入手机号" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        return;
    }
    if (self.bankNameText.text.length ==0) {
        [WHToast showMessage:@"请选择银行名称" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        return;
    }
    if (self.validText.text.length == 0) {
        [WHToast showMessage:@"请输入有效期" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        return;
    }
    if (self.safeText.text.length == 0) {
        [WHToast showMessage:@"请输入信用卡安全码" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        return;
    }
    [self requestCode];
}
/***
 短信验证码倒计时
 ***/
-(void)startTime{
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置（倒计时结束后调用）
                [self.codeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                //设置不可点击
                self.codeBtn.userInteractionEnabled = YES;
                
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.codeBtn setTitle:[NSString stringWithFormat:@"重新发送(%@s)",strTime] forState:UIControlStateNormal];
                //设置可点击
                self.codeBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    
    dispatch_resume(_timer);
}
/***
 事实监听 textField输入内容
 */
- (void)bankNumClick:(UITextField *)textField{
    [self.delegate inputBankNum0:textField.text];
}
- (void)idNumClick:(UITextField *)textField{
    [self.delegate inputIdNum0:textField.text];
}
- (void)mobileNumClick:(UITextField *)textField{
    [self.delegate inputMobileNum0:textField.text];
}
- (void)codeTextClick:(UITextField *)textField{
    [self.delegate inputCodeNum0:textField.text];
}
- (void)nameClick:(UITextField *)textField{
    [self.delegate inputName0:textField.text];
}
- (void)validClick:(UITextField *)textField{
    [self.delegate inputVali0:textField.text];
}
- (void)safeClick:(UITextField *)textField{
    [self.delegate inputsafeCode0:textField.text];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.delegate seleteBankName0];
    return NO;
}

/**
 请求验证码
 */
- (void)requestCode{
    NSDictionary * info = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSDictionary * dic = @{@"login_token":info[@"token"],@"user":info[@"w_email"],@"order_id":self.order_id,@"payment_method":@"CREDIT_CARD",@"payer_name":self.nameText.text,@"payer_phone":self.mobileNumText.text,@"citizen_id":self.idNumText.text,@"bank_code":self.bankCode,@"bank_number":self.bankNumText.text,@"bank_valid_date":self.validText.text,@"safe_code":self.safeText.text,@"os":@"1"};
    NSLog(@"%@",dic);
    NSString * url;
    if (self.isType) {
        url = [GZMUrl get_newOrderPay_url];
    }else{
        if (self.status == 160) {
            url = [GZMUrl get_wlPay_url];
        }else{
            url = [GZMUrl get_payment_tariff_url];
        }
    }
    [Unity showanimate];
    [GZMrequest postWithURLString:url parameters:dic success:^(NSDictionary *data) {
        [Unity hiddenanimate];
        if ([[data[@"meta"][@"ret_code"] stringValue] isEqualToString:@"0000"]) {
           [self startTime];
            [self.delegate paymentNuf_id0:data[@"paymentumf_id"]];
        }else{
            [WHToast showMessage:data[@"meta"][@"ret_msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
    } failure:^(NSError *error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
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
