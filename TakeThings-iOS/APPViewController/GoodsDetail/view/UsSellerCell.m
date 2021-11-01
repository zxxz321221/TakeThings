//
//  UsSellerCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/20.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "UsSellerCell.h"
@interface UsSellerCell()

@property (nonatomic , strong) UILabel * line;
@property (nonatomic , strong) UIImageView * icon;
@property (nonatomic , strong) UILabel * sellerL;
@property (nonatomic , strong) UIButton * sellerBtn;
@property (nonatomic , strong) UILabel * nameL;

@property (nonatomic , strong) UILabel * evaluate;

@property (nonatomic , strong) UIButton * originalPageBtn;
@property (nonatomic , strong) UIButton * allGoodsBtn;

@property (nonatomic , strong) UILabel * line1;

@end
@implementation UsSellerCell
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
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:76], SCREEN_WIDTH, [Unity countcoordinatesH:10])];
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
//        _sellerL = [[UILabel alloc]initWithFrame:CGRectMake(_icon.right+[Unity countcoordinatesW:5], [Unity countcoordinatesH:20], [Unity countcoordinatesW:30], [Unity countcoordinatesH:18])];
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
        _nameL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:20], [Unity countcoordinatesW:80], [Unity countcoordinatesH:18])];
        _nameL.textColor = LabelColor3;
        _nameL.textAlignment = NSTextAlignmentLeft;
        _nameL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _nameL;
}
- (UIButton *)sellerBtn{
    if (!_sellerBtn) {
        _sellerBtn = [[UIButton alloc]initWithFrame:CGRectMake(_nameL.right+[Unity countcoordinatesW:10], _nameL.top+[Unity countcoordinatesH:1.5], [Unity countcoordinatesW:50], [Unity countcoordinatesH:15])];
        _sellerBtn.backgroundColor = LabelColor9;
        [_sellerBtn addTarget:self action:@selector(salerClick) forControlEvents:UIControlEventTouchUpInside];
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
        _evaluate = [[UILabel alloc]initWithFrame:CGRectMake(_nameL.left, _nameL.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:140], [Unity countcoordinatesH:18])];
        _evaluate.text = @"";
        _evaluate.font = [UIFont systemFontOfSize:FontSize(12)];
        _evaluate.textColor = LabelColor3;
        
    }
    return _evaluate;
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
- (void)configWithDict:(NSDictionary *)dict isCollection:(BOOL)isCollec{
    if (!dict || dict.count ==0) {
        return;
    }
    self.nameL.text = dict[@"goods"][@"Item"][@"Seller"][@"UserID"];
    NSInteger W=0;
    if ([Unity widthOfString:self.nameL.text OfFontSize:FontSize(12) OfHeight:[Unity countcoordinatesH:18]]>[Unity countcoordinatesW:90]) {
        W=[Unity countcoordinatesW:90];
    }else{
        W=[Unity widthOfString:self.nameL.text OfFontSize:FontSize(12) OfHeight:[Unity countcoordinatesH:18]];
    }
    self.nameL.frame = CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:20], W, [Unity countcoordinatesH:18]);
    self.sellerBtn.frame = CGRectMake(self.nameL.right+[Unity countcoordinatesW:10], self.nameL.top+[Unity countcoordinatesH:1.5], [Unity countcoordinatesW:50], [Unity countcoordinatesH:15]);
    NSString * str1 = @"%";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"全部评价  %@(%@%@)",dict[@"goods"][@"Item"][@"Seller"][@"FeedbackScore"],dict[@"goods"][@"Item"][@"Seller"][@"PositiveFeedbackPercent"],str1]];
    [str addAttribute:NSForegroundColorAttributeName value:LabelColor9 range:NSMakeRange(0,4)];
    self.evaluate.attributedText = str;
    if (isCollec) {
        self.sellerBtn.backgroundColor = [Unity getColor:@"aa112d"];
    }else{
        self.sellerBtn.backgroundColor = LabelColor9;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)salerClick{
    [self.delegate sellerCollectionClick];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
