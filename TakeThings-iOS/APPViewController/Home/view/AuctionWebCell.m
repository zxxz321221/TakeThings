//
//  AuctionWebCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/15.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "AuctionWebCell.h"
@interface AuctionWebCell()
{
    NSInteger itemIndex;
}
@property (nonatomic , strong)UIImageView * bigImageView;
@property (nonatomic , strong) NSArray * subjectArr;
@end
@implementation AuctionWebCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [self loadAuctionView];
    }
    return self;
}
- (void)loadAuctionView{
    NSArray * arr = @[@"yahoo",@"ebay"];
    for (int i=0; i<arr.count; i++) {
        UIImageView * imageView = [Unity imageviewAddsuperview_superView:self.contentView _subViewFrame:CGRectMake(kWidth(15)+(i*(SCREEN_WIDTH-kWidth(37))/2)+(i*kWidth(10)), kWidth(5), (SCREEN_WIDTH-kWidth(37))/2, kWidth(40)) _imageName:arr[i] _backgroundColor:nil];
        UITapGestureRecognizer *singleTap =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerAction:)];
        singleTap.numberOfTapsRequired = 1; //点击次数
        singleTap.numberOfTouchesRequired = 1; //点击手指数
        [imageView addGestureRecognizer:singleTap];
        imageView.tag = 1000+i;
        imageView.userInteractionEnabled = YES;
        
        _bigImageView = [Unity imageviewAddsuperview_superView:self.contentView _subViewFrame:CGRectMake(kWidth(5), kWidth(47), SCREEN_WIDTH-kWidth(10), kWidth(80)) _imageName:@"" _backgroundColor:[UIColor clearColor]];
        _bigImageView.layer.cornerRadius = 10;
        UITapGestureRecognizer *singleTap1 =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgAction)];
        singleTap1.numberOfTapsRequired = 1; //点击次数
        singleTap1.numberOfTouchesRequired = 1; //点击手指数
        [_bigImageView addGestureRecognizer:singleTap1];
        _bigImageView.userInteractionEnabled = YES;
    }
}
- (void)headerAction:(UITapGestureRecognizer *)tapGesture{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)tapGesture;
    NSInteger index = singleTap.view.tag;
    itemIndex = index-1000;
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"],self.subjectArr[itemIndex][@"a_picture"]]] placeholderImage:[UIImage imageNamed:@"Loading"]];
    
}
- (void)imgAction{
    [self.delegate auctionIndex:itemIndex];
}
- (void)configWithSubject:(NSArray *)arr{
    self.subjectArr = arr;
    if (arr.count != 0) {
        [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"],arr[0][@"a_picture"]]] placeholderImage:[UIImage imageNamed:@"Loading"]];
    }
}
- (NSArray *)subjectArr{
    if (!_subjectArr) {
        _subjectArr = [NSArray new];
    }
    return _subjectArr;
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
