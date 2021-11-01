//
//  ProductParametersView.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/30.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "ProductParametersView.h"
#define ppViewH     (IS_iPhoneX ? [Unity countcoordinatesH:420] : [Unity countcoordinatesH:400])
@interface ProductParametersView()
@property (nonatomic , strong) UIView * backView;

@property (nonatomic , strong) UILabel * title;
@property (nonatomic , strong) UILabel * inStock;

@property (nonatomic , strong) UIView * line;
@property (nonatomic , strong) UILabel * returnGoods;
@property (nonatomic , strong) UIView * line1;
@property (nonatomic , strong) UILabel * goodsDetail;
@property (nonatomic , strong) UIView * line2;
@property (nonatomic , strong) UILabel * freightL;
@property (nonatomic , strong) UIView * line3;
@property (nonatomic , strong) UILabel * bidId;

@property (nonatomic , strong) UIView * line4;
@property (nonatomic , strong) UILabel * earlyTerminat;
@property (nonatomic , strong) UIView * line5;
@property (nonatomic , strong) UILabel * extend;
@property (nonatomic , strong) UIView * line6;
@property (nonatomic , strong) UIView * line7;

@property (nonatomic , strong) UIButton * confim;
@end
@implementation ProductParametersView{
    
}

+(instancetype)setProductParametersView:(UIView *)view{
    ProductParametersView * pView = [[ProductParametersView alloc]initWithFrame:view.frame];
    [[UIApplication sharedApplication].keyWindow addSubview:pView];
    return pView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
    
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        self.hidden = YES;
        [self addSubview:self.backView];
    }
    return self;
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, ppViewH)];
        // 左上和右上为圆角
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:_backView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(15, 15)];
        CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
        cornerRadiusLayer.frame = _backView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        _backView.layer.mask = cornerRadiusLayer;
        _backView.backgroundColor = [UIColor whiteColor];
        
        [_backView addSubview:self.title];
        [_backView addSubview:self.inStock];
        [_backView addSubview:self.inStockL];
        [_backView addSubview:self.line];
        [_backView addSubview:self.returnGoods];
        [_backView addSubview:self.returnGoodsL];
        [_backView addSubview:self.line1];
        [_backView addSubview:self.goodsDetail];
        [_backView addSubview:self.goodsDetailL];
        [_backView addSubview:self.line2];
        [_backView addSubview:self.freight];
        [_backView addSubview:self.freightL];
        [_backView addSubview:self.line3];
        [_backView addSubview:self.bidId];
        [_backView addSubview:self.bidIdL];
        [_backView addSubview:self.line4];
        [_backView addSubview:self.earlyTerminat];
        [_backView addSubview:self.earlyTerminatL];
        [_backView addSubview:self.line5];
        [_backView addSubview:self.extend];
        [_backView addSubview:self.extendL];
        [_backView addSubview:self.line6];
        [_backView addSubview:self.remark];
        [_backView addSubview:self.line7];
        [_backView addSubview:self.confim];
        
    }
    return _backView;
}
- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:20])];
        _title.text = @"产品参数";
        _title.textColor = LabelColor3;
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = [UIFont systemFontOfSize:FontSize(18)];
    }
    return _title;
}
- (UILabel *)inStock{
    if (!_inStock) {
        _inStock = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _title.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesH:110], [Unity countcoordinatesH:15])];
        _inStock.text = @"有货:";
        _inStock.textColor = LabelColor3;
        _inStock.textAlignment = NSTextAlignmentLeft;
        _inStock.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _inStock;
}
- (UILabel *)inStockL{
    if (!_inStockL) {
        _inStockL = [[UILabel alloc]initWithFrame:CGRectMake(_inStock.right, _inStock.top, SCREEN_WIDTH-[Unity countcoordinatesW:130], [Unity countcoordinatesH:15])];
        _inStockL.text = @"";
        _inStockL.textColor = LabelColor6;
        _inStockL.textAlignment = NSTextAlignmentLeft;
        _inStockL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _inStockL;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _inStock.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:1])];
        _line.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return _line;
}
- (UILabel *)returnGoods{
    if (!_returnGoods) {
        _returnGoods = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:110], [Unity countcoordinatesH:15])];
        _returnGoods.text = @"*能否退货或取消:";
        _returnGoods.textColor = [Unity getColor:@"#aa112d"];
        _returnGoods.textAlignment = NSTextAlignmentLeft;
        _returnGoods.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _returnGoods;
}
- (UILabel *)returnGoodsL{
    if (!_returnGoodsL) {
        _returnGoodsL = [[UILabel alloc]initWithFrame:CGRectMake(_returnGoods.right, _returnGoods.top, SCREEN_WIDTH-[Unity countcoordinatesW:130], [Unity countcoordinatesH:15])];
        _returnGoodsL.text = @"";
        _returnGoodsL.textColor = [Unity getColor:@"#aa112d"];
        _returnGoodsL.textAlignment = NSTextAlignmentLeft;
        _returnGoodsL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _returnGoodsL;
}
- (UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _returnGoodsL.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:1])];
        _line1.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return _line1;
}
- (UILabel *)goodsDetail{
    if (!_goodsDetail) {
        _goodsDetail = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line1.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:110], [Unity countcoordinatesH:15])];
        _goodsDetail.text = @"商品情况:";
        _goodsDetail.textColor = LabelColor3;
        _goodsDetail.textAlignment = NSTextAlignmentLeft;
        _goodsDetail.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _goodsDetail;
}
- (UILabel *)goodsDetailL{
    if (!_goodsDetailL) {
        _goodsDetailL = [[UILabel alloc]initWithFrame:CGRectMake(_goodsDetail.right, _goodsDetail.top, SCREEN_WIDTH-[Unity countcoordinatesW:130], [Unity countcoordinatesH:15])];
        _goodsDetailL.text = @"";
        _goodsDetailL.textColor = LabelColor9;
        _goodsDetailL.textAlignment = NSTextAlignmentLeft;
        _goodsDetailL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _goodsDetailL;
}
- (UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _goodsDetailL.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:1])];
        _line2.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return _line2;
}
- (UILabel *)freight{
    if (!_freight) {
        _freight = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line2.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:110], [Unity countcoordinatesH:15])];
        _freight.text = @"";
        _freight.textColor = LabelColor3;
        _freight.textAlignment = NSTextAlignmentLeft;
        _freight.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _freight;
}
- (UILabel *)freightL{
    if (!_freightL) {
        _freightL = [[UILabel alloc]initWithFrame:CGRectMake(_freight.right, _freight.top, SCREEN_WIDTH-[Unity countcoordinatesW:130], [Unity countcoordinatesH:15])];
        _freightL.text = @"需要运费 金额请查看原网页";
        _freightL.textColor = LabelColor9;
        _freightL.textAlignment = NSTextAlignmentLeft;
        _freightL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _freightL;
}
- (UIView *)line3{
    if (!_line3) {
        _line3 = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _freightL.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:1])];
        _line3.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return _line3;
}
- (UILabel *)bidId{
    if (!_bidId) {
        _bidId = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line3.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:110], [Unity countcoordinatesH:15])];
        _bidId.text = @"商品ID:";
        _bidId.textColor = LabelColor3;
        _bidId.textAlignment = NSTextAlignmentLeft;
        _bidId.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _bidId;
}
- (UILabel *)bidIdL{
    if (!_bidIdL) {
        _bidIdL = [[UILabel alloc]initWithFrame:CGRectMake(_bidId.right, _bidId.top, SCREEN_WIDTH-[Unity countcoordinatesW:130], [Unity countcoordinatesH:15])];
        _bidIdL.text = @"";
        _bidIdL.textColor = LabelColor9;
        _bidIdL.textAlignment = NSTextAlignmentLeft;
        _bidIdL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _bidIdL;
}
- (UIView *)line4{
    if (!_line4) {
        _line4 = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _bidIdL.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:1])];
        _line4.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return _line4;
}
- (UILabel *)earlyTerminat{
    if (!_earlyTerminat) {
        _earlyTerminat = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line4.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:110], [Unity countcoordinatesH:15])];
        _earlyTerminat.text = @"提前结束:";
        _earlyTerminat.textColor = LabelColor3;
        _earlyTerminat.textAlignment = NSTextAlignmentLeft;
        _earlyTerminat.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _earlyTerminat;
}
- (UILabel *)earlyTerminatL{
    if (!_earlyTerminatL) {
        _earlyTerminatL = [[UILabel alloc]initWithFrame:CGRectMake(_earlyTerminat.right, _earlyTerminat.top, SCREEN_WIDTH-[Unity countcoordinatesW:130], [Unity countcoordinatesH:15])];
        _earlyTerminatL.text = @"";
        _earlyTerminatL.textColor = LabelColor9;
        _earlyTerminatL.textAlignment = NSTextAlignmentLeft;
        _earlyTerminatL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _earlyTerminatL;
}
- (UIView *)line5{
    if (!_line5) {
        _line5 = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _earlyTerminatL.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:1])];
        _line5.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return _line5;
}
- (UILabel *)extend{
    if (!_extend) {
        _extend = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line5.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:110], [Unity countcoordinatesH:15])];
        _extend.text = @"自动延长[?]:";
        _extend.textColor = LabelColor3;
        _extend.textAlignment = NSTextAlignmentLeft;
        _extend.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _extend;
}
- (UILabel *)extendL{
    if (!_extendL) {
        _extendL = [[UILabel alloc]initWithFrame:CGRectMake(_extend.right, _extend.top, SCREEN_WIDTH-[Unity countcoordinatesW:130], [Unity countcoordinatesH:15])];
        _extendL.text = @"";
        _extendL.textColor = LabelColor9;
        _extendL.textAlignment = NSTextAlignmentLeft;
        _extendL.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _extendL;
}
- (UIView *)line6{
    if (!_line6) {
        _line6 = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _extendL.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:1])];
        _line6.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return _line6;
}
- (UILabel *)remark{
    if (!_remark) {
        _remark = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line6.bottom+[Unity countcoordinatesH:10], _line6.width, [Unity countcoordinatesH:30])];
        _remark.text = @"";
        _remark.textColor = LabelColor9;
        _remark.textAlignment = NSTextAlignmentLeft;
        _remark.font = [UIFont systemFontOfSize:FontSize(14)];
        _remark.numberOfLines = 0;
    }
    return _remark;
}
- (UIView *)line7{
    if (!_line7) {
        _line7 = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _remark.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:1])];
        _line7.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return _line7;
}
- (UIButton *)confim{
    if (!_confim) {
        _confim = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line7.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:35])];
        [_confim addTarget:self action:@selector(confimClick) forControlEvents:UIControlEventTouchUpInside];
        [_confim setTitle:@"完成" forState:UIControlStateNormal];
        [_confim setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confim.backgroundColor = [Unity getColor:@"#aa112d"];
        _confim.layer.cornerRadius = _confim.height/2;
    }
    return _confim;
}

- (void)showPPView{
    self.hidden=NO;
    [UIView animateWithDuration:0.5 animations:^{
        [self.backView setFrame:CGRectMake(0, SCREEN_HEIGHT-ppViewH, SCREEN_WIDTH, ppViewH)];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }completion:nil];

}
- (void)confimClick{
    [UIView animateWithDuration:0.5 animations:^{
        [self.backView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, ppViewH)];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    }completion:nil];
    [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:0.5];
}
- (void)delayMethod{
    self.hidden = YES;
}
@end
