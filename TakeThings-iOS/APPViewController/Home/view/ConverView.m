//
//  ConverView.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/7/26.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "ConverView.h"
#import "LMJDropdownMenu.h"
@interface ConverView() <LMJDropdownMenuDataSource,LMJDropdownMenuDelegate>
{
    NSArray * _menu1OptionTitles;
    NSArray * _menu2OptionTitles;
    
    LMJDropdownMenu * menu1;
    LMJDropdownMenu * menu2;
    NSDictionary * dic;
    NSInteger keyIndex;
}
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UILabel * title;
@property (nonatomic , strong) UILabel * yuan;
@property (nonatomic , strong)UITextField * textField;
@property (nonatomic , strong) UILabel * cLine1;
@property (nonatomic , strong) UILabel * reteL;
@property (nonatomic , strong) UILabel * yuewei;
@property (nonatomic , strong) UILabel * rmbl;
@property (nonatomic , strong) UILabel * yuan1;
@property (nonatomic , strong) UILabel * cLine2;
@property (nonatomic , strong) UIButton * shutDown;
@end
@implementation ConverView
+(instancetype)setConverView:(UIView *)view{
    ConverView * cView = [[ConverView alloc]initWithFrame:view.frame];
    [view addSubview:cView];
    return cView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        keyIndex = 1;
        _menu1OptionTitles = @[@"美   金",@"日   元"];
        dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"exrate"];
        UIColor *color = [UIColor blackColor];
        self.backgroundColor = [color colorWithAlphaComponent:0.3];
        self.hidden = YES;
        [self addSubview:self.backView];
    }
    return self;
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], (SCREEN_HEIGHT-[Unity countcoordinatesH:250])/2, [Unity countcoordinatesW:290], [Unity countcoordinatesH:250])];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 10;
        _backView.layer.masksToBounds = YES;
        
        [_backView addSubview:self.title];
        // ----------------------- menu2 ---------------------------
        menu2 = [[LMJDropdownMenu alloc] init];
        menu2.userInteractionEnabled = NO;
        [menu2 setFrame:CGRectMake([Unity countcoordinatesW:15], [Unity countcoordinatesH:135], [Unity countcoordinatesW:80], [Unity countcoordinatesH:25])];
        menu2.dataSource = self;
        menu2.delegate   = self;
        
        //        menu2.layer.borderColor  = [Unity getColor:@"e0e0e0"].CGColor;
        //        menu2.layer.borderWidth  = 1;
        //        menu2.layer.cornerRadius = 3;
        
        menu2.title           = @"人民币";
        menu2.titleBgColor    = [UIColor clearColor];
        menu2.titleFont       = [UIFont boldSystemFontOfSize:FontSize(16)];
        menu2.titleColor      = LabelColor3;
        menu2.titleAlignment  = NSTextAlignmentLeft;
        menu2.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        
//        menu2.rotateIcon      = [UIImage imageNamed:@"下拉"];
//        menu2.rotateIconSize  = CGSizeMake(15, 8);
        
        menu2.optionBgColor       = [UIColor clearColor];
        menu2.optionFont          = [UIFont systemFontOfSize:FontSize(16)];
        menu2.optionTextColor     = [UIColor blackColor];
        menu2.optionTextAlignment = NSTextAlignmentLeft;
        menu2.optionNumberOfLines = 0;
        menu2.optionLineColor     = [UIColor clearColor];
        menu2.optionIconSize      = CGSizeMake(15, 15);
        [_backView addSubview:menu2];
        
        // ----------------------- menu1 ---------------------------
        menu1 = [[LMJDropdownMenu alloc] init];
//        menu1.userInteractionEnabled = NO;
        [menu1 setFrame:CGRectMake([Unity countcoordinatesW:15], [Unity countcoordinatesH:70], [Unity countcoordinatesW:80], [Unity countcoordinatesH:25])];
        menu1.dataSource = self;
        menu1.delegate   = self;
        
        menu1.layer.borderColor  = [Unity getColor:@"e0e0e0"].CGColor;
        menu1.layer.borderWidth  = 1;
        menu1.layer.cornerRadius = 3;
        
        menu1.title           = @"日   元";
        menu1.titleBgColor    = [UIColor whiteColor];
        menu1.titleFont       = [UIFont boldSystemFontOfSize:FontSize(16)];
        menu1.titleColor      = LabelColor3;
        menu1.titleAlignment  = NSTextAlignmentLeft;
        menu1.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        
        menu1.rotateIcon      = [UIImage imageNamed:@"下拉"];
        menu1.rotateIconSize  = CGSizeMake(15, 8);
        
        menu1.optionBgColor       = [UIColor whiteColor];
        menu1.optionFont          = [UIFont systemFontOfSize:FontSize(16)];
        menu1.optionTextColor     = LabelColor3;
        menu1.optionTextAlignment = NSTextAlignmentLeft;
        menu1.optionNumberOfLines = 0;
        menu1.optionLineColor     = [UIColor clearColor];
        menu1.optionIconSize      = CGSizeMake(15, 15);
        [_backView addSubview:menu1];
        
        [_backView addSubview:self.yuan];
        [_backView addSubview:self.textField];
        [_backView addSubview:self.cLine1];
        [_backView addSubview:self.reteL];
        [_backView addSubview:self.yuewei];
        [_backView addSubview:self.rmbl];
        [_backView addSubview:self.yuan1];
        [_backView addSubview:self.cLine2];
        [_backView addSubview:self.shutDown];
    }
    return _backView;
}
- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:20], self.backView.width, [Unity countcoordinatesH:20])];
        _title.text = @"汇率转换";
        _title.textColor = LabelColor3;
        _title.font = [UIFont systemFontOfSize:FontSize(18)];
        _title.textAlignment = NSTextAlignmentCenter;
    }
    return _title;
}
- (UILabel *)yuan{
    if (!_yuan) {
        _yuan = [[UILabel alloc]initWithFrame:CGRectMake(self.backView.width-[Unity countcoordinatesW:30], [Unity countcoordinatesH:70], [Unity countcoordinatesW:15], [Unity countcoordinatesH:25])];
        _yuan.text = @"元";
        _yuan.font = [UIFont systemFontOfSize:FontSize(16)];
        _yuan.textAlignment = NSTextAlignmentRight;
        _yuan.textColor = LabelColor3;
    }
    return _yuan;
}
- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:100], [Unity countcoordinatesH:70], self.backView.width-[Unity countcoordinatesW:135], [Unity countcoordinatesW:25])];
        _textField.placeholder = @"请输入金额";
        _textField.font = [UIFont systemFontOfSize:FontSize(16)];
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.keyboardType = UIKeyboardTypeDecimalPad;
        [_textField addTarget:self action:@selector(placeText:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}
- (UILabel *)cLine1{
    if (!_cLine1) {
        _cLine1 = [[UILabel alloc]initWithFrame:CGRectMake(_textField.left, _textField.bottom+[Unity countcoordinatesW:10], _backView.width-_textField.left, 1)];
        _cLine1.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _cLine1;
}
- (UILabel *)reteL{
    if (!_reteL) {
        _reteL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], _cLine1.bottom, _backView.width-[Unity countcoordinatesW:30], [Unity countcoordinatesH:20])];
        _reteL.text = [NSString stringWithFormat:@"日元（JPY）汇率为： %@",dic[@"w_tw_jp"]];
        _reteL.textColor = [Unity getColor:@"aa112d"];
        _reteL.textAlignment = NSTextAlignmentRight;
        _reteL.font = [UIFont systemFontOfSize:FontSize(12)];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_reteL.text];
        [attributedString addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0, 11)];
        _reteL.attributedText = attributedString;
        
    }
    return _reteL;
}
- (UILabel *)yuewei{
    if (!_yuewei) {
        _yuewei = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:100], [Unity countcoordinatesH:135], [Unity countcoordinatesW:50], [Unity countcoordinatesH:25])];
        _yuewei.text = @"约为";
        _yuewei.font = [UIFont systemFontOfSize:FontSize(12)];
        _yuewei.textAlignment = NSTextAlignmentLeft;
        _yuewei.textColor = LabelColor9;
    }
    return _yuewei;
}
- (UILabel *)rmbl{
    if (!_rmbl) {
        _rmbl = [[UILabel alloc]initWithFrame:CGRectMake(_yuewei.right, _yuewei.top, _backView.width-[Unity countcoordinatesW:185], [Unity countcoordinatesH:25])];
        _rmbl.text = @"0";
        _rmbl.textColor = [Unity getColor:@"aa112d"];
        _rmbl.font = [UIFont systemFontOfSize:FontSize(16)];
        _rmbl.textAlignment = NSTextAlignmentRight;
    }
    return _rmbl;
}
- (UILabel *)yuan1{
    if (!_yuan1) {
        _yuan1 = [[UILabel alloc]initWithFrame:CGRectMake(self.backView.width-[Unity countcoordinatesW:30], _rmbl.top, [Unity countcoordinatesW:15], [Unity countcoordinatesH:25])];
        _yuan1.text = @"元";
        _yuan1.font = [UIFont systemFontOfSize:FontSize(16)];
        _yuan1.textAlignment = NSTextAlignmentRight;
        _yuan1.textColor = LabelColor3;
    }
    return _yuan1;
}
- (UILabel *)cLine2{
    if (!_cLine2) {
        _cLine2 = [[UILabel alloc]initWithFrame:CGRectMake(_textField.left, _rmbl.bottom+[Unity countcoordinatesW:10], _backView.width-_textField.left, 1)];
        _cLine2.backgroundColor = [Unity getColor:@"e0e0e0"];
    }
    return _cLine2;
}
- (UIButton *)shutDown{
    if (!_shutDown) {
        _shutDown = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:15], _cLine2.bottom+[Unity countcoordinatesH:20], _backView.width-[Unity countcoordinatesW:30], [Unity countcoordinatesH:40])];
        [_shutDown addTarget:self action:@selector(shutdownClick) forControlEvents:UIControlEventTouchUpInside];
        [_shutDown setTitle:@"关闭" forState:UIControlStateNormal];
        [_shutDown setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
        _shutDown.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
        _shutDown.layer.borderWidth = 1;
        _shutDown.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        _shutDown.layer.cornerRadius = _shutDown.height/2;
        _shutDown.layer.masksToBounds = YES;
    }
    return _shutDown;
}
- (void)optionConverView{
    self.hidden = NO;
}
- (void)hiddenConverView{
    self.hidden = YES;
}
- (void)shutdownClick{
    [self hiddenConverView];
    self.textField.text = @"";
    self.rmbl.text = @"0";
    menu1.title = @"日   元";
    self.reteL.text = [NSString stringWithFormat:@"日元（JPY）汇率为： %@",dic[@"w_tw_jp"]];
    self.reteL.textColor = [Unity getColor:@"aa112d"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_reteL.text];
    [attributedString addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0, 11)];
    self.reteL.attributedText = attributedString;
}
- (void)placeText:(UITextField *)textField{
    if (textField.text.length == 0) {
        self.rmbl.text = @"0";
    }else{
        if (keyIndex == 0) {//美元转rmb
            self.rmbl.text = [Unity configWithCurrentCurrency:@"us" WithTargetCurrency:@"cn" WithAmount:textField.text];
        }else{//日币转rmb
            self.rmbl.text = [Unity configWithCurrentCurrency:@"jp" WithTargetCurrency:@"cn" WithAmount:textField.text];
        }
    }
}

#pragma mark - LMJDropdownMenu DataSource
- (NSUInteger)numberOfOptionsInDropdownMenu:(LMJDropdownMenu *)menu{
    if (menu == menu1) {
        return _menu1OptionTitles.count;
    } else if (menu == menu2) {
        return _menu2OptionTitles.count;
    } else {
        return 0;
    }
}
- (CGFloat)dropdownMenu:(LMJDropdownMenu *)menu heightForOptionAtIndex:(NSUInteger)index{
    if (menu == menu1) {
        return [Unity countcoordinatesH:25];
    } else if (menu == menu2) {
        return 40;
    } else {
        return 0;
    }
}
- (NSString *)dropdownMenu:(LMJDropdownMenu *)menu titleForOptionAtIndex:(NSUInteger)index{
    if (menu == menu1) {
        return _menu1OptionTitles[index];
    } else if (menu == menu2) {
        return _menu2OptionTitles[index];
    } else {
        return @"";
    }
}
- (UIImage *)dropdownMenu:(LMJDropdownMenu *)menu iconForOptionAtIndex:(NSUInteger)index{
    return nil;
}
#pragma mark - LMJDropdownMenu Delegate
- (void)dropdownMenu:(LMJDropdownMenu *)menu didSelectOptionAtIndex:(NSUInteger)index optionTitle:(NSString *)title{
    if (menu == menu1) {
        keyIndex = index;
        if (index ==0) {
            self.reteL.text = [NSString stringWithFormat:@"美元（USD）汇率为： %@",dic[@"w_tw_us"]];
            self.reteL.textColor = [Unity getColor:@"aa112d"];
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_reteL.text];
            [attributedString addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0, 11)];
            self.reteL.attributedText = attributedString;
        }else{
            self.reteL.text = [NSString stringWithFormat:@"日元（JPY）汇率为： %@",dic[@"w_tw_jp"]];
            self.reteL.textColor = [Unity getColor:@"aa112d"];
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_reteL.text];
            [attributedString addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0, 11)];
            self.reteL.attributedText = attributedString;
        }
        if (self.textField.text.length ==0) {
            return;
        }else{
            if (index == 0) {
                self.rmbl.text = [Unity configWithCurrentCurrency:@"us" WithTargetCurrency:@"cn" WithAmount:self.textField.text];
            }else{
                self.rmbl.text = [Unity configWithCurrentCurrency:@"jp" WithTargetCurrency:@"cn" WithAmount:self.textField.text];
            }
        }
//        NSLog(@"你选择了(you selected)：menu1，index: %ld - title: %@", index, title);
    } else if (menu == menu2) {
//        NSLog(@"你选择了(you selected)：menu2，index: %ld - title: %@", index, title);
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
