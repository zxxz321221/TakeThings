//
//  NewHaitaoCell1.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/12.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "NewHaitaoCell1.h"
@interface NewHaitaoCell1()
{
    NSString * goods_name;//商品名称
    NSString * goods_link;//商品网址
    NSString * goods_param;//商品规格
    NSString * goods_id;//商品id
    NSString * goods_price;//单价
    NSString * goods_num;//数量
    
    NSInteger sumNum;//商品总件数
}
@property (nonatomic , strong) UILabel * block0;//标题前红快
@property (nonatomic , strong) UILabel * goodsInfo;
@property (nonatomic , strong) UIButton * jianBtn;
@property (nonatomic , strong) UIButton * jiaBtn;
@property (nonatomic , strong) UITextField * numText;
@property (nonatomic , strong) UILabel * dwL;
@property (nonatomic , strong) UILabel * line0;
@property (nonatomic , strong) UIButton * addBtn;
@end
@implementation NewHaitaoCell1
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.block0];
        [self.contentView addSubview:self.goodsInfo];
        [self createInfo];
        [self.contentView addSubview:self.jianBtn];
        [self.contentView addSubview:self.numText];
        [self.contentView addSubview:self.jiaBtn];
        [self.contentView addSubview:self.line0];
        [self.contentView addSubview:self.addBtn];
    }
    return self;
}
- (UILabel *)block0{
    if (!_block0) {
        _block0 = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:15], [Unity countcoordinatesW:3], [Unity countcoordinatesH:10])];
        _block0.backgroundColor = [Unity getColor:@"aa112d"];
    }
    return _block0;
}
- (UILabel *)goodsInfo{
    if (!_goodsInfo) {
        _goodsInfo = [[UILabel alloc]initWithFrame:CGRectMake(_block0.right+[Unity countcoordinatesW:10], [Unity countcoordinatesH:10], 200, [Unity countcoordinatesH:20])];
        _goodsInfo.text = @"填写商品信息";
        _goodsInfo.font = [UIFont systemFontOfSize:FontSize(17)];
        _goodsInfo.textColor = LabelColor3;
    }
    return _goodsInfo;
}
- (void)createInfo{
    NSArray * arr = @[@"商品名称",@"网址",@"商品规格",@"商品ID",@"单价",@"数量"];
    for (int i=0; i<arr.count; i++) {
        UILabel * label = [Unity lableViewAddsuperview_superView:self.contentView _subViewFrame:CGRectMake([Unity countcoordinatesW:20], _goodsInfo.bottom+i*[Unity countcoordinatesH:25], [Unity countcoordinatesW:80], [Unity countcoordinatesH:25]) _string:arr[i] _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
    }
    NSArray * arr1 = @[@"请输入商品名称",@"请输入网址",@"请输入商品规格",@"请输入商品ID",@"请输入商品单价"];
    for (int i=0; i<arr1.count; i++) {
        UITextField * textField = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:110], _goodsInfo.bottom+i*[Unity countcoordinatesH:25], [Unity countcoordinatesW:200], [Unity countcoordinatesH:25])];
        textField.placeholder = arr1[i];
        textField.textAlignment = NSTextAlignmentRight;
        textField.textColor = LabelColor9;
        textField.tag = i+1000;
        textField.font = [UIFont systemFontOfSize:FontSize(14)];
        [textField addTarget:self action:@selector(textInput:) forControlEvents:UIControlEventEditingChanged];
        if (i==4) {
            textField.keyboardType = UIKeyboardTypeNumberPad;
            textField.frame = CGRectMake([Unity countcoordinatesW:110], _goodsInfo.bottom+i*[Unity countcoordinatesH:25], [Unity countcoordinatesW:175], [Unity countcoordinatesH:25]);
            self.dwL = [Unity lableViewAddsuperview_superView:self.contentView _subViewFrame:CGRectMake(textField.right, textField.top, [Unity countcoordinatesW:25], textField.height) _string:@"円" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentRight];
            
        }
        [self.contentView addSubview:textField];
    }
}
- (UIButton *)jianBtn{
    if (!_jianBtn) {
        _jianBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:90], _goodsInfo.bottom+[Unity countcoordinatesH:125], [Unity countcoordinatesW:25], [Unity countcoordinatesH:25])];
        [_jianBtn setBackgroundImage:[UIImage imageNamed:@"newjian"] forState:UIControlStateNormal];
        [_jianBtn addTarget:self action:@selector(jianClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jianBtn;
}
- (UITextField *)numText{
    if (!_numText) {
        _numText = [[UITextField alloc]initWithFrame:CGRectMake(_jianBtn.right, _jianBtn.top, [Unity countcoordinatesW:30], _jianBtn.height)];
        _numText.text = @"1";
        _numText.textColor = LabelColor9;
        _numText.font = [UIFont systemFontOfSize:FontSize(14)];
        _numText.textAlignment = NSTextAlignmentCenter;
        [_numText addTarget:self action:@selector(numText:) forControlEvents:UIControlEventEditingChanged];
    }
    return _numText;
}
- (UIButton *)jiaBtn{
    if (!_jiaBtn) {
        _jiaBtn = [[UIButton alloc]initWithFrame:CGRectMake(_numText.right, _goodsInfo.bottom+[Unity countcoordinatesH:125], [Unity countcoordinatesW:25], [Unity countcoordinatesH:25])];
        [_jiaBtn setBackgroundImage:[UIImage imageNamed:@"newjia"] forState:UIControlStateNormal];
        [_jiaBtn addTarget:self action:@selector(jiaClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jiaBtn;
}
- (UILabel *)line0{
    if (!_line0) {
        _line0 = [[UILabel alloc]initWithFrame:CGRectMake(0, _goodsInfo.bottom+[Unity countcoordinatesH:150], SCREEN_WIDTH, 1)];
        _line0.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return _line0;
}
- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-[Unity countcoordinatesW:140])/2, _line0.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:140], [Unity countcoordinatesH:25])];
        [_addBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
        _addBtn.layer.cornerRadius = _addBtn.height/2;
        _addBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        _addBtn.layer.borderWidth = 1;
        [_addBtn setTitle:@"添加商品" forState:UIControlStateNormal];
        [_addBtn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _addBtn;
}

- (void)configWithSource:(NSString *)source WithSum:(NSInteger)sum{
    sumNum = sum;
    if (![source isEqualToString:@"yahoo"]) {
        self.dwL.text = @"美元";
    }
}
- (void)textInput:(UITextField *)textField{
    if (textField.tag == 1000) {
        goods_name = textField.text;
    }else if (textField.tag == 1001){
        goods_link = textField.text;
    }else if (textField.tag == 1002){
        goods_param = textField.text;
    }else if (textField.tag == 1003){
        goods_id = textField.text;
    }else{
        goods_price = textField.text;
    }
}
- (void)numText:(UITextField *)textField{
    if ([textField.text intValue] > 10) {
        [WHToast showMessage:@"商品数量不能大于10" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
        textField.text = @"10";
        // 2.回收键盘
        [textField resignFirstResponder];
    }
    if ([textField.text intValue] < 1) {
        [WHToast showMessage:@"商品数量不能小于1" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
        textField.text = @"1";
        // 2.回收键盘
        [textField resignFirstResponder];
    }
}
- (void)jianClick{
//    NSLog(@"%@",self.numText.text);
    NSInteger num = [self.numText.text intValue]-1;
    if (num<1) {
        [WHToast showMessage:@"商品数量不能小于1" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
        self.numText.text = @"1";
    }else{
        self.numText.text = [NSString stringWithFormat:@"%ld",(long)num];
    }
}
- (void)jiaClick{
//    NSLog(@"%@",self.numText.text);
    NSInteger num = [self.numText.text intValue]+1;
    if (num > 10) {
        [WHToast showMessage:@"商品数量不得超过10件" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
        self.numText.text = @"10";
    }else{
        self.numText.text = [NSString stringWithFormat:@"%ld",(long)num];
    }
}
- (void)addClick{
    if ([self.numText.text intValue]+sumNum >10) {
        [WHToast showMessage:@"商品总数量不得超过10件" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
        return;
    }
    if (goods_name.length == 0) {
        [WHToast showMessage:@"商品名称不能为空" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
        return;
    }
    if (goods_link.length == 0){
        [WHToast showMessage:@"商品网址不能为空" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
        return;
    }
    if (goods_param.length == 0){
        [WHToast showMessage:@"商品规格不能为空" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
        return;
    }
    if (goods_id.length == 0){
        [WHToast showMessage:@"商品ID不能为空" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
        return;
    }
    if (goods_price.length == 0) {
        [WHToast showMessage:@"商品单价不能为空" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
        return;
    }
//    NSLog(@"%@",self.numText.text);
    [self.delegate addGoodsWithName:goods_name WithLink:goods_link WithParam:goods_param WithGid:goods_id WithPrice:goods_price WithNum:self.numText.text];
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
