//
//  BrandCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/15.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "BrandCell.h"
@interface BrandCell()
@property (nonatomic , strong)UIImageView * bgimg;
@end
@implementation BrandCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [self loadBrandView];
    }
    return self;
}
- (void)loadBrandView{
    UIView * backV = [[UIView alloc]initWithFrame:CGRectMake(kWidth(5), 0, SCREEN_WIDTH-kWidth(10), kWidth(214))];
    backV.backgroundColor = [UIColor whiteColor];
    backV.layer.cornerRadius = 10;
    [self.contentView addSubview:backV];
    
    UIImageView * bgimg = [Unity imageviewAddsuperview_superView:backV _subViewFrame:CGRectMake((backV.width-kWidth(200))/2, kWidth(15),kWidth(200) , kWidth(10)) _imageName:@"brand_bgimg" _backgroundColor:nil];
    self.bgimg = bgimg;
    UILabel * titleL = [Unity lableViewAddsuperview_superView:backV _subViewFrame:CGRectMake(0, kWidth(10), backV.width, kWidth(20)) _string:@"热门品牌" _lableFont:[UIFont systemFontOfSize:18] _lableTxtColor:[Unity getColor:@"#42146e"] _textAlignment:NSTextAlignmentCenter];
    
    for (int i=0; i<9; i++) {
        UIImageView * webImg = [Unity imageviewAddsuperview_superView:backV _subViewFrame:CGRectMake(kWidth(15)+(i%3*((backV.width-kWidth(44))/3))+(i%3*kWidth(7)), titleL.bottom+kWidth(10)+(i/3*kWidth(40))+(i/3*kWidth(7)), (backV.width-kWidth(44))/3, kWidth(40)) _imageName:@"" _backgroundColor:[UIColor clearColor]];
        webImg.contentMode = UIViewContentModeScaleAspectFit;
        UITapGestureRecognizer *singleTap =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerAction:)];
        singleTap.numberOfTapsRequired = 1; //点击次数
        singleTap.numberOfTouchesRequired = 1; //点击手指数
        [webImg addGestureRecognizer:singleTap];
        webImg.tag = 1000+i;
        webImg.userInteractionEnabled = YES;
    }
    
    UIButton * moreBtn = [Unity buttonAddsuperview_superView:backV _subViewFrame:CGRectMake((backV.width-kWidth(100))/2, kWidth(189), kWidth(100), kWidth(15)) _tag:self _action:@selector(moreClick) _string:@"查看更多>>" _imageName:nil];
    [moreBtn setTitleColor:[Unity getColor:@"#999999"] forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:16];
}
- (void)headerAction:(UITapGestureRecognizer *)tapGesture{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)tapGesture;
    NSInteger index = singleTap.view.tag;
    [self.delegate brandCellItem:index];
}
- (void)moreClick{
    [self.delegate brandCellMore];
}
- (void)configWithBrandList:(NSArray *)arr{
    if (arr.count != 0) {
        for (int i=0; i<arr.count; i++) {
            UIImageView * imageView = (UIImageView *)[self.contentView viewWithTag:1000+i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"],arr[i][@"a_logo"]]] placeholderImage:[UIImage imageNamed:@"Loading"]];
        }
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
