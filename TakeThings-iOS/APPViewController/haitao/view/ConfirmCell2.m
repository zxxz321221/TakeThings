//
//  ConfirmCell2.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/14.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import "ConfirmCell2.h"
@interface ConfirmCell2()

@property (nonatomic , strong) UILabel * xvhao;
@property (nonatomic , strong) UILabel * goodsName;
@property (nonatomic , strong) UILabel * goodsParam;
@property (nonatomic , strong) UILabel * goodsId;
@property (nonatomic , strong) UILabel * goodsPrice;
@property (nonatomic , strong) UILabel * goodsNum;
@property (nonatomic , strong) UILabel * line;
@end
@implementation ConfirmCell2
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self create];
        [self.contentView addSubview:self.xvhao];
        [self.contentView addSubview:self.goodsName];
        [self.contentView addSubview:self.goodsParam];
        [self.contentView addSubview:self.goodsId];
        [self.contentView addSubview:self.goodsPrice];
        [self.contentView addSubview:self.goodsNum];
        [self.contentView addSubview:self.line];
    }
    return self;
}
- (void)create{
    NSArray * arr = @[@"序号",@"商品名称",@"商品规格",@"商品ID",@"外币单价",@"数量"];
    for (int i=0; i<arr.count; i++) {
        UILabel * title = [Unity lableViewAddsuperview_superView:self.contentView _subViewFrame:CGRectMake([Unity countcoordinatesW:20], i*[Unity countcoordinatesH:25], [Unity countcoordinatesW:60], [Unity countcoordinatesH:25]) _string:arr[i] _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        title.backgroundColor = [UIColor clearColor];
    }
}
- (UILabel *)xvhao{
    if (!_xvhao) {
        _xvhao = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:90], 0, [Unity countcoordinatesW:210], [Unity countcoordinatesH:25])];
        _xvhao.textColor = LabelColor6;
        _xvhao.textAlignment = NSTextAlignmentRight;
        _xvhao.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _xvhao;
}
- (UILabel *)goodsName{
    if (!_goodsName) {
        _goodsName = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:90], _xvhao.bottom, [Unity countcoordinatesW:210], [Unity countcoordinatesH:25])];
        _goodsName.textColor = LabelColor6;
        _goodsName.textAlignment = NSTextAlignmentRight;
        _goodsName.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _goodsName;
}
- (UILabel *)goodsParam{
    if (!_goodsParam) {
        _goodsParam = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:90], _goodsName.bottom, [Unity countcoordinatesW:210], [Unity countcoordinatesH:25])];
        _goodsParam.textColor = LabelColor6;
        _goodsParam.textAlignment = NSTextAlignmentRight;
        _goodsParam.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _goodsParam;
}
- (UILabel *)goodsId{
    if (!_goodsId) {
        _goodsId = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:90], _goodsParam.bottom, [Unity countcoordinatesW:210], [Unity countcoordinatesH:25])];
        _goodsId.textColor = LabelColor6;
        _goodsId.textAlignment = NSTextAlignmentRight;
        _goodsId.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _goodsId;
}
- (UILabel *)goodsPrice{
    if (!_goodsPrice) {
        _goodsPrice = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:90], _goodsId.bottom, [Unity countcoordinatesW:210], [Unity countcoordinatesH:25])];
        _goodsPrice.textColor = LabelColor6;
        _goodsPrice.textAlignment = NSTextAlignmentRight;
        _goodsPrice.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _goodsPrice;
}
- (UILabel *)goodsNum{
    if (!_goodsNum) {
        _goodsNum = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:90], _goodsPrice.bottom, [Unity countcoordinatesW:210], [Unity countcoordinatesH:25])];
        _goodsNum.textColor = LabelColor6;
        _goodsNum.textAlignment = NSTextAlignmentRight;
        _goodsNum.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _goodsNum;
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:155]-1, SCREEN_WIDTH-[Unity countcoordinatesW:20], 1)];
        _line.backgroundColor = [Unity getColor:@"f0f0f0"];
    }
    return _line;
}
- (void)configWithData:(NSDictionary *)dic WithIndex:(NSInteger)index WithSource:(NSString *)source{
    self.xvhao.text = [NSString stringWithFormat:@"%ld",(long)index];
    self.goodsName.text = dic[@"name"];
    self.goodsParam.text = dic[@"param"];
    self.goodsId.text = dic[@"gid"];
    if ([source isEqualToString:@"yahoo"]) {
        self.goodsPrice.text = [NSString stringWithFormat:@"%@円",dic[@"price"]];
    }else{
        self.goodsPrice.text = [NSString stringWithFormat:@"%@美元",dic[@"price"]];
    }
    self.goodsNum.text = dic[@"num"];
    
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
