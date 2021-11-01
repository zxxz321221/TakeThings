//
//  NewDeliveryInfoCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/9.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "NewDeliveryInfoCell.h"
@interface NewDeliveryInfoCell()
@property (nonatomic , strong) UILabel * number;
@property (nonatomic , strong) UIView * goodsView;
@property (nonatomic , strong) UIView * priceView;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UILabel * goodsNum;

@property (nonatomic , strong) UILabel * price;//得标价
@property (nonatomic , strong) UILabel * expenseTax;//消费税  日本货美国
@property (nonatomic , strong) UILabel * freight;//当地运费
@property (nonatomic , strong) UILabel * weight;//商品重量

@property (nonatomic , strong) UITextField * textField;
@property (nonatomic , strong) UILabel * currency;//货币

@property (nonatomic , strong) UIButton * lookBtn;//填写必看按钮
@end
@implementation NewDeliveryInfoCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    [self.contentView addSubview:self.number];
    [self.contentView addSubview:self.goodsView];
    [self.contentView addSubview:self.priceView];
}
- (UILabel *)number{
    if (!_number) {
        _number = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _number.textColor = LabelColor3;
        _number.textAlignment = NSTextAlignmentLeft;
        _number.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _number;
}
- (UIView *)goodsView{
    if (!_goodsView) {
        _goodsView = [[UIView alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:40], SCREEN_WIDTH, [Unity countcoordinatesH:155])];
        _goodsView.backgroundColor = [UIColor whiteColor];
        [_goodsView addSubview:self.titleL];
        [_goodsView addSubview:self.goodsNum];
        
        NSArray * arr = @[@"得标价",@"当地消费税",@"当地运费",@"商品重量"];
        for (int i=0; i<arr.count; i++) {
            UILabel * name = [Unity lableViewAddsuperview_superView:_goodsView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:50]+i*[Unity countcoordinatesH:25], [Unity countcoordinatesW:100], [Unity countcoordinatesH:15]) _string:arr[i] _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
            name.backgroundColor = [UIColor clearColor];
        }
        
        [_goodsView addSubview:self.price];
        [_goodsView addSubview:self.expenseTax];
        [_goodsView addSubview:self.freight];
        [_goodsView addSubview:self.weight];
    }
    return _goodsView;
}
- (UIView *)priceView{
    if (!_priceView) {
        _priceView = [[UIView alloc]initWithFrame:CGRectMake(0, _goodsView.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:85])];
        _priceView.backgroundColor = [UIColor whiteColor];
        UILabel * label = [Unity lableViewAddsuperview_superView:_priceView _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:20], [Unity countcoordinatesW:120], [Unity countcoordinatesH:20]) _string:@"请填写商品价值:" _lableFont:[UIFont systemFontOfSize:FontSize(18)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
        [_priceView addSubview:self.textField];
        [_priceView addSubview:self.currency];
        
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:50], SCREEN_WIDTH-[Unity countcoordinatesH:20], 1)];
        line.backgroundColor = [Unity getColor:@"aa112d"];
        [_priceView addSubview:line];
        
        [_priceView addSubview:self.lookBtn];
        
    }
    return _priceView;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:40], [Unity countcoordinatesH:30])];
        _titleL.textColor = LabelColor3;
        _titleL.textAlignment = NSTextAlignmentLeft;
        _titleL.font = [UIFont systemFontOfSize:FontSize(14)];
        _titleL.numberOfLines = 0;
    }
    return _titleL;
}
- (UILabel *)goodsNum{
    if (!_goodsNum) {
        _goodsNum = [[UILabel alloc]initWithFrame:CGRectMake(_titleL.right, _titleL.top, [Unity countcoordinatesH:20], [Unity countcoordinatesH:15])];
        _goodsNum.textColor = LabelColor6;
        _goodsNum.textAlignment = NSTextAlignmentRight;
        _goodsNum.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _goodsNum;
}
- (UILabel *)price{
    if (!_price) {
        _price = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], [Unity countcoordinatesH:50], SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:15])];
        _price.textColor = LabelColor6;
        _price.textAlignment = NSTextAlignmentRight;
        _price.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _price;
}
- (UILabel *)expenseTax{
    if (!_expenseTax) {
        _expenseTax = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], _price.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:15])];
        _expenseTax.textColor = LabelColor6;
        _expenseTax.textAlignment = NSTextAlignmentRight;
        _expenseTax.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _expenseTax;
}
- (UILabel *)freight{
    if (!_freight) {
        _freight = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], _expenseTax.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:15])];
        _freight.textColor = LabelColor6;
        _freight.textAlignment = NSTextAlignmentRight;
        _freight.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _freight;
}
- (UILabel *)weight{
    if (!_weight) {
        _weight = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], _freight.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:15])];
        _weight.textColor = LabelColor6;
        _weight.textAlignment = NSTextAlignmentRight;
        _weight.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _weight;
}
- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:150], [Unity countcoordinatesH:15], SCREEN_WIDTH- [Unity countcoordinatesW:190], [Unity countcoordinatesH:30])];
        _textField.textColor = [Unity getColor:@"aa112d"];
        _textField.font = [UIFont systemFontOfSize:FontSize(29)];
        _textField.keyboardType = UIKeyboardTypeDecimalPad;
        _textField.textAlignment = NSTextAlignmentRight;
        [_textField addTarget:self action:@selector(placeText:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}
- (UILabel *)currency{
    if (!_currency) {
        _currency = [[UILabel alloc]initWithFrame:CGRectMake(_textField.right, [Unity countcoordinatesH:25], [Unity countcoordinatesW:30], [Unity countcoordinatesH:15])];
        _currency.textColor = [Unity getColor:@"aa112d"];
        _currency.textAlignment = NSTextAlignmentRight;
        _currency.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _currency;
}
- (UIButton *)lookBtn{
    if (!_lookBtn) {
        /* 获取按钮文字的宽度 获取按钮图片和文字的间距 获取图片宽度 */
        CGFloat    space = 5;// 图片和文字的间距
        NSString    * titleString = [NSString stringWithFormat:@"填写必看"];
        CGFloat    titleWidth = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FontSize(14)]}].width;
        UIImage    * btnImage = [UIImage imageNamed:@"?"];// 11*6
        CGFloat    imageWidth = btnImage.size.width;
        //创建按钮
        _lookBtn = [[UIButton alloc] initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:56], 100, [Unity countcoordinatesH:15])];
        [_lookBtn addTarget:self action:@selector(lookClick) forControlEvents:UIControlEventTouchUpInside];
        _lookBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        [_lookBtn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
        [_lookBtn setTitle:@"填写必看" forState:UIControlStateNormal];
        [_lookBtn setImage:[UIImage imageNamed:@"?"] forState:UIControlStateNormal];
        [_lookBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -(imageWidth+space*0.5), 0, (imageWidth+space*0.5))];
        [_lookBtn setImageEdgeInsets:UIEdgeInsetsMake(0, (titleWidth + space*0.5), 0, -(titleWidth + space*0.5))];
        [_lookBtn sizeToFit];
    }
    return _lookBtn;
}

- (void)lookClick{
    [self.delegate fillInWillSee];
}
- (void)placeText:(UITextField *)textField{
    [self.delegate placeText:textField.text WithCell:self];
}
- (void)configWithData:(NSDictionary *)dic WithIsNew:(BOOL)isNew{
    self.number.text = [NSString stringWithFormat:@"得标编号 %@",dic[@"order_code"]];
    self.titleL.text = dic[@"goods_name"];
    if (isNew) {
        self.goodsNum.text = [NSString stringWithFormat:@"X%@",dic[@"goods_num"]];
    }else{
        self.goodsNum.text = [NSString stringWithFormat:@"X%@",dic[@"bid_num"]];
    }
    
    if ([dic[@"currency"]isEqualToString:@"円"]) {
        self.textField.frame = CGRectMake([Unity countcoordinatesW:150], [Unity countcoordinatesH:15], SCREEN_WIDTH- [Unity countcoordinatesW:180], [Unity countcoordinatesH:30]);
        self.currency.frame = CGRectMake(_textField.right, [Unity countcoordinatesH:25], [Unity countcoordinatesW:20], [Unity countcoordinatesH:15]);
    }
    self.price.text = [NSString stringWithFormat:@"%@%@",dic[@"over_price"],dic[@"currency"]];
    self.expenseTax.text = [NSString stringWithFormat:@"%@%@",dic[@"cost_local_freight"],dic[@"currency"]];
    self.freight.text = [NSString stringWithFormat:@"%@%@",dic[@"cost_excise"],dic[@"currency"]];
    self.currency.text = [NSString stringWithFormat:@"%@",dic[@"currency"]];
//    self.price.text = 
    self.weight.text = [NSString stringWithFormat:@"%@KG",dic[@"warehouse_get_weight"]];
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
