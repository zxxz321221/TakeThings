//
//  NewHaitaoCell6.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/13.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "NewHaitaoCell6.h"
@interface NewHaitaoCell6()
{
    NSString * ggg;
    NSInteger _sumNum;
    NSString * gid;
    NSString * link;
}
@property (nonatomic , strong) UILabel * xvhao;//
@property (nonatomic , strong) UITextField * goodsName;
@property (nonatomic , strong) UITextField * goodsPrice;
@property (nonatomic , strong) UITextField * goodsParam;
@property (nonatomic , strong) UITextField * goodsNum;
@property (nonatomic , strong) UIButton * updateBtn;
@property (nonatomic , strong) UIButton * deleteBtn;
@property (nonatomic , strong) UILabel * line;
@end
@implementation NewHaitaoCell6
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self create];
        [self.contentView addSubview:self.xvhao];
        [self.contentView addSubview:self.goodsName];
        [self.contentView addSubview:self.goodsPrice];
        [self.contentView addSubview:self.goodsParam];
        [self.contentView addSubview:self.goodsNum];
        [self.contentView addSubview:self.deleteBtn];
        [self.contentView addSubview:self.updateBtn];
        [self.contentView addSubview:self.line];
    }
    return self;
}
- (void)create{
    NSArray * arr = @[@"序号",@"商品名称",@"商品单价",@"规格",@"数量"];
    for (int i=0; i<arr.count; i++) {
        UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:20], i*[Unity countcoordinatesH:25], [Unity countcoordinatesW:70], [Unity countcoordinatesH:25])];
        title.text = arr[i];
        title.textColor = LabelColor3;
        title.font = [UIFont systemFontOfSize:FontSize(14)];
        [self.contentView addSubview:title];
    }
}
- (UILabel *)xvhao{
    if (!_xvhao) {
        _xvhao = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:100], 0, SCREEN_WIDTH-[Unity countcoordinatesW:110], [Unity countcoordinatesH:25])];
        _xvhao.textColor = LabelColor6;
        _xvhao.font = [UIFont systemFontOfSize:FontSize(14)];
        _xvhao.textAlignment = NSTextAlignmentRight;
    }
    return _xvhao;
}
- (UITextField *)goodsName{
    if (!_goodsName) {
        _goodsName = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:100], _xvhao.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:110], [Unity countcoordinatesH:25])];
        _goodsName.textColor = LabelColor6;
        _goodsName.font = [UIFont systemFontOfSize:FontSize(14)];
        _goodsName.textAlignment = NSTextAlignmentRight;
        _goodsName.userInteractionEnabled = NO;
    }
    return _goodsName;
}
- (UITextField *)goodsPrice{
    if (!_goodsPrice) {
        _goodsPrice = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:100], _goodsName.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:110], [Unity countcoordinatesH:25])];
        _goodsPrice.textColor = LabelColor6;
        _goodsPrice.font = [UIFont systemFontOfSize:FontSize(14)];
        _goodsPrice.textAlignment = NSTextAlignmentRight;
        _goodsPrice.userInteractionEnabled = NO;
    }
    return _goodsPrice;
}
- (UITextField *)goodsParam{
    if (!_goodsParam) {
        _goodsParam = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:100], _goodsPrice.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:110], [Unity countcoordinatesH:25])];
        _goodsParam.textColor = LabelColor6;
        _goodsParam.font = [UIFont systemFontOfSize:FontSize(14)];
        _goodsParam.textAlignment = NSTextAlignmentRight;
        _goodsParam.userInteractionEnabled = NO;
    }
    return _goodsParam;
}
- (UITextField *)goodsNum{
    if (!_goodsNum) {
        _goodsNum = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:100], _goodsParam.bottom, SCREEN_WIDTH-[Unity countcoordinatesW:110], [Unity countcoordinatesH:25])];
        _goodsNum.textColor = LabelColor6;
        _goodsNum.font = [UIFont systemFontOfSize:FontSize(14)];
        _goodsNum.textAlignment = NSTextAlignmentRight;
        _goodsNum.userInteractionEnabled = NO;
    }
    return _goodsNum;
}
- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:70], _goodsNum.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:60], [Unity countcoordinatesH:25])];
        [_deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        _deleteBtn.layer.cornerRadius = _deleteBtn.height/2;
        _deleteBtn.layer.borderWidth =1;
        _deleteBtn.layer.borderColor = LabelColor3.CGColor;
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _deleteBtn;
}
- (UIButton *)updateBtn{
    if (!_updateBtn) {
        _updateBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:140], _goodsNum.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:60], [Unity countcoordinatesH:25])];
        [_updateBtn addTarget:self action:@selector(updateClick:) forControlEvents:UIControlEventTouchUpInside];
        [_updateBtn setTitle:@"修改" forState:UIControlStateNormal];
        [_updateBtn setTitle:@"确认" forState:UIControlStateSelected];
        [_updateBtn setTitleColor:LabelColor3 forState:UIControlStateNormal];
        [_updateBtn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateSelected];
        _updateBtn.layer.cornerRadius = _updateBtn.height/2;
        _updateBtn.layer.borderWidth =1;
        _updateBtn.layer.borderColor = LabelColor3.CGColor;
        _updateBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _updateBtn;
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:165]-1, SCREEN_WIDTH-[Unity countcoordinatesW:20], 1)];
        _line.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return _line;
}
- (void)configWithData:(NSDictionary *)dic WithNum:(NSInteger )num WithSumNum:(NSInteger)sumNum{
    self.xvhao.text = [NSString stringWithFormat:@"%ld",(long)num];
    self.goodsName.text = dic[@"name"];
    self.goodsPrice.text = dic[@"price"];
    self.goodsParam.text = dic[@"param"];
    self.goodsNum.text = dic[@"num"];
    ggg = dic[@"ggg"];
    gid = dic[@"gid"];
    link = dic[@"link"];
    _sumNum = sumNum-[dic[@"num"] intValue];
    
}
- (void)deleteClick{
    [self.delegate goodsDelete:ggg];
}
- (void)updateClick:(UIButton *)btn{
    if (btn.selected) {//确认
        if ([self.goodsNum.text intValue]+_sumNum>10) {
            [WHToast showMessage:@"商品总数量不得超过10件" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
            return;
        }
        if (self.goodsName.text.length == 0) {
            [WHToast showMessage:@"商品名称不能为空" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
            return;
        }
        if (self.goodsParam.text.length == 0){
            [WHToast showMessage:@"商品规格不能为空" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
            return;
        }
        if (self.goodsPrice.text.length == 0) {
            [WHToast showMessage:@"商品单价不能为空" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
            return;
        }
        [self.delegate updateWithName:self.goodsName.text WithLink:link WithParam:self.goodsParam.text WithGid:gid WithPrice:self.goodsPrice.text WithNum:self.goodsNum.text WithGgg:ggg WithCell:self];
        self.goodsName.userInteractionEnabled = NO;
        self.goodsPrice.userInteractionEnabled = NO;
        self.goodsParam.userInteractionEnabled = NO;
        self.goodsNum.userInteractionEnabled = NO;
        self.updateBtn.selected = NO;
        self.updateBtn.layer.borderColor = LabelColor3.CGColor;
    }else{//修改
        self.goodsName.userInteractionEnabled = YES;
        self.goodsPrice.userInteractionEnabled = YES;
        self.goodsParam.userInteractionEnabled = YES;
        self.goodsNum.userInteractionEnabled = YES;
        self.updateBtn.selected = YES;
        self.updateBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
    }
    
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
