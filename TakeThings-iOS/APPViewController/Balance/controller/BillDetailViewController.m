//
//  BillDetailViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/6.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "BillDetailViewController.h"

@interface BillDetailViewController ()
@property (nonatomic , strong) UIView * topView;
@property (nonatomic , strong) UILabel * price;
@property (nonatomic , strong) UILabel * statusL;

@property (nonatomic , strong) UIView * twoView;
//商品名称等 左右两侧label
@property (nonatomic , strong) UILabel * goodsName;
@property (nonatomic , strong) UILabel * costsThat;
@property (nonatomic , strong) UILabel * borrowNum;
@property (nonatomic , strong) UILabel * country;
@property (nonatomic , strong) UILabel * goodsNameR;
@property (nonatomic , strong) UILabel * costsThatR;
@property (nonatomic , strong) UILabel * borrowNumR;
@property (nonatomic , strong) UILabel * countryR;


@property (nonatomic , strong) UIView * bottomView;
@property (nonatomic , strong) UILabel * goodsNum;
@property (nonatomic , strong) UILabel * goodsNumR;
@property (nonatomic , strong) UILabel * time;
@property (nonatomic , strong) UILabel * timeR;

@end

@implementation BillDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"账单详情";
    self.view.backgroundColor = [Unity getColor:@"#f0f0f0"];
}
- (void)createUI{
    [self.view addSubview:self.topView];
    [self.view addSubview:self.twoView];
    [self.view addSubview:self.bottomView];
}
- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:180])];
        _topView.backgroundColor = [UIColor whiteColor];
        [_topView addSubview:self.price];
        [_topView addSubview:self.statusL];
    }
    return _topView;
}
- (UILabel *)price{
    if (!_price) {
        _price = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:55], SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        if ([self.dict[@"w_sz"]isEqualToString:@"s"]) {
            self.price.text  = [NSString stringWithFormat:@"+%@",self.dict[@"w_fse"]];
        }else{
            self.price.text  = [NSString stringWithFormat:@"-%@",self.dict[@"w_fse"]];
        }
        _price.textColor = LabelColor3;
        _price.textAlignment = NSTextAlignmentCenter;
        _price.font= [ UIFont systemFontOfSize:FontSize(55)];
    }
    return _price;
}
- (UILabel *)statusL{
    if (!_statusL) {
        _statusL = [[UILabel alloc]initWithFrame:CGRectMake(0, _price.bottom+[Unity countcoordinatesH:30], SCREEN_WIDTH, [Unity countcoordinatesH:15])];
        _statusL.text = @"交易成功";
        _statusL.textColor = LabelColor9;
        _statusL.textAlignment = NSTextAlignmentCenter;
        _statusL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _statusL;
}

- (UIView *)twoView{
    if (!_twoView) {
        _twoView = [[UIView alloc]initWithFrame:CGRectMake(0, _topView.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:140])];
        _twoView.backgroundColor = [UIColor whiteColor];
        [_twoView addSubview:self.goodsName];
        [_twoView addSubview:self.goodsNameR];
        [_twoView addSubview:self.costsThat];
        [_twoView addSubview:self.costsThatR];
        [_twoView addSubview:self.borrowNum];
        [_twoView addSubview:self.borrowNumR];
        [_twoView addSubview:self.country];
        [_twoView addSubview:self.countryR];
        
    }
    return _twoView;
}
- (UILabel *)goodsName{
    if (!_goodsName) {
        _goodsName = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:15])];
        _goodsName.text = @"商品名称";
        _goodsName.textColor = LabelColor9;
        _goodsName.textAlignment = NSTextAlignmentLeft;
        _goodsName.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _goodsName;
}
- (UILabel *)goodsNameR{
    if (!_goodsNameR) {
        _goodsNameR = [[UILabel alloc]initWithFrame:CGRectMake(_goodsName.right, _goodsName.top, SCREEN_WIDTH-[Unity countcoordinatesW:90], [Unity countcoordinatesH:45])];
        _goodsNameR.text = self.dict[@"w_object"];
        _goodsNameR.textColor = LabelColor3;
        _goodsNameR.textAlignment = NSTextAlignmentLeft;
        _goodsNameR.font = [UIFont systemFontOfSize:FontSize(14)];
        _goodsNameR.numberOfLines = 0;
    }
    return _goodsNameR;
}
- (UILabel *)costsThat{
    if (!_costsThat) {
        _costsThat = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _goodsNameR.bottom+[Unity countcoordinatesH:10], _goodsName.width, [Unity countcoordinatesH:15])];
        _costsThat.text = @"费用说明";
        _costsThat.textColor = LabelColor9;
        _costsThat.textAlignment = NSTextAlignmentLeft;
        _costsThat.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _costsThat;
}
- (UILabel *)costsThatR{
    if (!_costsThatR) {
        _costsThatR = [[UILabel alloc]initWithFrame:CGRectMake(_goodsNameR.left, _costsThat.top, _goodsNameR.width, [Unity countcoordinatesH:15])];
        _costsThatR.text = self.dict[@"w_cause"];
        _costsThatR.textColor = LabelColor3;
        _costsThatR.textAlignment = NSTextAlignmentLeft;
        _costsThatR.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _costsThatR;
}
- (UILabel *)borrowNum{
    if (!_borrowNum) {
        _borrowNum = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _costsThatR.bottom+[Unity countcoordinatesH:10], _goodsName.width, [Unity countcoordinatesH:15])];
        _borrowNum.text = @"借款记录";
        _borrowNum.textColor = LabelColor9;
        _borrowNum.textAlignment = NSTextAlignmentLeft;
        _borrowNum.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _borrowNum;
}
- (UILabel *)borrowNumR{
    if (!_borrowNumR) {
        _borrowNumR = [[UILabel alloc]initWithFrame:CGRectMake(_goodsNameR.left, _borrowNum.top, _goodsNameR.width, [Unity countcoordinatesH:15])];
        _borrowNumR.text = self.dict[@"w_jk"];
        _borrowNumR.textColor = LabelColor3;
        _borrowNumR.textAlignment = NSTextAlignmentLeft;
        _borrowNumR.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _borrowNumR;
}
- (UILabel *)country{
    if (!_country) {
        _country = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _borrowNumR.bottom+[Unity countcoordinatesH:10], _goodsName.width, [Unity countcoordinatesH:15])];
        _country.text = @"国别";
        _country.textColor = LabelColor9;
        _country.textAlignment = NSTextAlignmentLeft;
        _country.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _country;
}
- (UILabel *)countryR{
    if (!_countryR) {
        _countryR = [[UILabel alloc]initWithFrame:CGRectMake(_goodsNameR.left, _country.top, _goodsNameR.width, [Unity countcoordinatesH:15])];
        if ([self.dict[@"w_cc"] isEqualToString:@"0"]) {
           _countryR.text = @"日本";
        }else{
            _countryR.text = @"美国";
        }
        _countryR.textColor = LabelColor3;
        _countryR.textAlignment = NSTextAlignmentLeft;
        _countryR.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _countryR;
}



- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, _twoView.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:60])];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [_bottomView addSubview:self.goodsNum];
        [_bottomView addSubview:self.goodsNumR];
        [_bottomView addSubview:self.time];
        [_bottomView addSubview:self.timeR];
    }
    return _bottomView;
}
- (UILabel *)goodsNum{
    if (!_goodsNum) {
        _goodsNum = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], [Unity countcoordinatesW:70], [Unity countcoordinatesH:15])];
        _goodsNum.text = @"商品编号";
        _goodsNum.textColor = LabelColor9;
        _goodsNum.textAlignment = NSTextAlignmentLeft;
        _goodsNum.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _goodsNum;
}
- (UILabel *)goodsNumR{
    if (!_goodsNumR) {
        _goodsNumR = [[UILabel alloc]initWithFrame:CGRectMake(_goodsNum.right, _goodsNum.top, SCREEN_WIDTH-[Unity countcoordinatesW:90], [Unity countcoordinatesH:15])];
        _goodsNumR.text = self.dict[@"w_jpnid"];
        _goodsNumR.textColor = LabelColor3;
        _goodsNumR.textAlignment = NSTextAlignmentLeft;
        _goodsNumR.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _goodsNumR;
}
- (UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _goodsNumR.bottom+[Unity countcoordinatesH:10], _goodsNum.width, [Unity countcoordinatesH:15])];
        _time.text = @"发生时间";
        _time.textColor = LabelColor9;
        _time.textAlignment = NSTextAlignmentLeft;
        _time.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _time;
}
- (UILabel *)timeR{
    if (!_timeR) {
        _timeR = [[UILabel alloc]initWithFrame:CGRectMake(_goodsNumR.left, _time.top, _goodsNumR.width, [Unity countcoordinatesH:15])];
        _timeR.text = self.dict[@"w_time"];
        _timeR.textColor = LabelColor3;
        _timeR.textAlignment = NSTextAlignmentLeft;
        _timeR.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _timeR;
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
