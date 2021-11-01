//
//  SellerCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/23.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "SellerCell.h"
@interface SellerCell()

@property (nonatomic , strong) UILabel * line;
@property (nonatomic , strong) UIImageView * icon;
@property (nonatomic , strong) UILabel * sellerL;
@property (nonatomic , strong) UIButton * sellerBtn;
@property (nonatomic , strong) UILabel * nameL;

@property (nonatomic , strong) UILabel * evaluate;
//好评h差评 图片和数量
@property (nonatomic , strong) UIImageView * haoImg;
@property (nonatomic , strong) UILabel * haoL;
@property (nonatomic , strong) UIImageView * chaImg;
@property (nonatomic , strong) UILabel * chaL;

@property (nonatomic , strong) UIButton * originalPageBtn;
@property (nonatomic , strong) UIButton * allGoodsBtn;

@property (nonatomic , strong) UILabel * line1;

@end
@implementation SellerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self SellerView];
    }
    return self;
}
- (void)SellerView{
    [self addSubview:self.line];
//    [self addSubview:self.icon];
//    [self addSubview:self.sellerL];
    [self addSubview:self.nameL];
    [self addSubview:self.sellerBtn];
    [self addSubview:self.evaluate];
//    [self addSubview:self.haoImg];
    [self addSubview:self.haoL];
//    [self addSubview:self.chaImg];
    [self addSubview:self.chaL];
    
    [self addSubview:self.originalPageBtn];
    [self addSubview:self.allGoodsBtn];
    [self addSubview:self.line1];
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        _line.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return  _line;
}
- (UILabel *)line1{
    if (!_line1) {
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:96], SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        _line1.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return  _line1;
}
//- (UIImageView *)icon{
//    if (!_icon) {
//        _icon = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:25], [Unity countcoordinatesW:36], [Unity countcoordinatesH:36])];
//        _icon.backgroundColor = [UIColor redColor];
//    }
//    return _icon;
//}
//- (UILabel *)sellerL{
//    if (!_sellerL) {
//        _sellerL = [[UILabel alloc]initWithFrame:CGRectMake(_icon.right+[Unity countcoordinatesW:5], [Unity countcoordinatesH:34], [Unity countcoordinatesW:30], [Unity countcoordinatesH:18])];
//        _sellerL.layer.cornerRadius = _sellerL.height/2;
//        _sellerL.layer.masksToBounds = YES;
//        _sellerL.text = @"卖家";
//        _sellerL.backgroundColor = [Unity getColor:@"#aa112d"];
//        _sellerL.textColor = [UIColor whiteColor];
//        _sellerL.font = [UIFont systemFontOfSize:12];
//        _sellerL.textAlignment = NSTextAlignmentCenter;
//    }
//    return _sellerL;
//}
- (UILabel *)nameL{
    if (!_nameL) {
        _nameL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:34], [Unity countcoordinatesW:80], [Unity countcoordinatesH:18])];
        _nameL.text = @"";
        _nameL.textColor = LabelColor3;
        _nameL.textAlignment = NSTextAlignmentLeft;
        _nameL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _nameL;
}
- (UIButton *)sellerBtn{
    if (!_sellerBtn) {
        _sellerBtn = [[UIButton alloc]initWithFrame:CGRectMake(_nameL.right+[Unity countcoordinatesW:10], _nameL.top+[Unity countcoordinatesH:1.5], [Unity countcoordinatesW:50], [Unity countcoordinatesH:15])];
        [_sellerBtn addTarget:self action:@selector(salerClick) forControlEvents:UIControlEventTouchUpInside];
        _sellerBtn.backgroundColor = LabelColor9;
        [_sellerBtn setTitle:@"关注卖家" forState:UIControlStateNormal];
        [_sellerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sellerBtn.layer.cornerRadius = _sellerBtn.height/2;
        _sellerBtn.layer.masksToBounds = YES;
        _sellerBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(12)];
        //卖家已关注 背景颜色AA112D
    }
    return _sellerBtn;
}
- (UILabel *)evaluate{
    if (!_evaluate) {
        _evaluate = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesH:10], [Unity countcoordinatesH:70], (SCREEN_WIDTH-[Unity countcoordinatesW:20])/3, [Unity countcoordinatesH:15])];
        _evaluate.text = @"";
        _evaluate.font = [UIFont systemFontOfSize:FontSize(12)];
        _evaluate.textColor = LabelColor6;
        
    }
    return _evaluate;
}
//- (UIImageView *)haoImg{
//    if (!_haoImg) {
//        _haoImg = [[UIImageView alloc]initWithFrame:CGRectMake(_evaluate.right, [Unity countcoordinatesH:50], [Unity countcoordinatesW:4], [Unity countcoordinatesH:8])];
//        _haoImg.image = [UIImage imageNamed:@"haoping"];
//
//    }
//    return _haoImg;
//}
- (UILabel *)haoL{
    if (!_haoL) {
        _haoL = [[UILabel alloc]initWithFrame:CGRectMake(_evaluate.right, _evaluate.top, _evaluate.width, _evaluate.height)];
        _haoL.text = @"";
        _haoL.textAlignment = NSTextAlignmentCenter;
        _haoL.font = [UIFont systemFontOfSize:FontSize(12)];
        _haoL.textColor = [Unity getColor:@"#4a90e2"];
    }
    return _haoL;
}
//- (UIImageView *)chaImg{
//    if (!_chaImg) {
//        _chaImg = [[UIImageView alloc]initWithFrame:CGRectMake(_haoL.right+[Unity countcoordinatesW:3], _haoImg.top, [Unity countcoordinatesW:4], [Unity countcoordinatesH:8])];
//        _chaImg.image = [UIImage imageNamed:@"chaping"];
//    }
//    return _chaImg;
//}
- (UILabel *)chaL{
    if (!_chaL) {
        _chaL = [[UILabel alloc]initWithFrame:CGRectMake(_haoL.right, _haoL.top, _haoL.width, _haoL.height)];
        _chaL.text = @"";
        _chaL.textAlignment = NSTextAlignmentRight;
        _chaL.font = [UIFont systemFontOfSize:FontSize(12)];
        _chaL.textColor = [Unity getColor:@"#aa112d"];
    }
    return _chaL;
}

- (UIButton *)originalPageBtn{
    if (!_originalPageBtn) {
        _originalPageBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:150], [Unity countcoordinatesH:29.5], [Unity countcoordinatesW:70], [Unity countcoordinatesH:27])];
        [_originalPageBtn setTitle:@"原始页面" forState:UIControlStateNormal];
        _originalPageBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(12)];
        [_originalPageBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        _originalPageBtn.layer.cornerRadius = _originalPageBtn.height/2;
        //设置边框颜色
        _originalPageBtn.layer.borderColor = [[Unity getColor:@"#aa112d"] CGColor];
        //设置边框宽度
        _originalPageBtn.layer.borderWidth = 1.0f;
        [_originalPageBtn addTarget:self action:@selector(oriClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _originalPageBtn;
}
- (UIButton *)allGoodsBtn{
    if (!_allGoodsBtn) {
        _allGoodsBtn = [[UIButton alloc]initWithFrame:CGRectMake(_originalPageBtn.right+[Unity countcoordinatesW:5], [Unity countcoordinatesH:29.5], [Unity countcoordinatesW:70], [Unity countcoordinatesH:27])];
        [_allGoodsBtn setTitle:@"全部商品" forState:UIControlStateNormal];
        _allGoodsBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(12)];
        [_allGoodsBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        _allGoodsBtn.layer.cornerRadius = _allGoodsBtn.height/2;
        //设置边框颜色
        _allGoodsBtn.layer.borderColor = [[Unity getColor:@"#aa112d"] CGColor];
        //设置边框宽度
        _allGoodsBtn.layer.borderWidth = 1.0f;
        [_allGoodsBtn addTarget:self action:@selector(allClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allGoodsBtn;
}
- (void)oriClick{
    [self.delegate originalClick];
}
- (void)allClick{
    [self.delegate allGoodsClick];
}
- (void)salerClick{
    [self.delegate sellerCollectionClick];
}
- (void)configWithDict:(NSDictionary *)dict isCollection:(BOOL)isCollec{
    if (!dict || dict.count ==0) {
        return;
    }
    self.nameL.text = dict[@"goods"][@"Result"][@"Seller"][@"Id"];
    NSInteger W=0;
    if ([Unity widthOfString:self.nameL.text OfFontSize:FontSize(12) OfHeight:[Unity countcoordinatesH:18]]>[Unity countcoordinatesW:90]) {
        W=[Unity countcoordinatesW:90];
    }else{
        W=[Unity widthOfString:self.nameL.text OfFontSize:FontSize(12) OfHeight:[Unity countcoordinatesH:18]];
    }
    self.nameL.frame = CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:34], W, [Unity countcoordinatesH:18]);
    self.sellerBtn.frame = CGRectMake(self.nameL.right+[Unity countcoordinatesW:10], self.nameL.top+[Unity countcoordinatesH:1.5], [Unity countcoordinatesW:50], [Unity countcoordinatesH:15]);
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"综合 %@",dict[@"goods"][@"Result"][@"Seller"][@"Rating"][@"Point"]]];
    [str addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0,2)];
    self.evaluate.attributedText = str;
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"好评 %@",dict[@"goods"][@"Result"][@"Seller"][@"Rating"][@"TotalGoodRating"]]];
    [str1 addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0,2)];
    self.haoL.attributedText = str1;
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"差评 %@",dict[@"goods"][@"Result"][@"Seller"][@"Rating"][@"TotalBadRating"]]];
    [str2 addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0,2)];
    self.chaL.attributedText = str2;
    if (isCollec) {
        self.sellerBtn.backgroundColor = [Unity getColor:@"aa112d"];
    }else{
        self.sellerBtn.backgroundColor = LabelColor9;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
