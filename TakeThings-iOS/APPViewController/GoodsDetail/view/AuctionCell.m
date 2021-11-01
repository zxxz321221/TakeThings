//
//  AuctionCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/23.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "AuctionCell.h"
@interface AuctionCell()

@property (nonatomic , strong) UILabel * line;
@property (nonatomic , strong) UIButton * auctionBtn;//竞拍履历 按钮


@end
@implementation AuctionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self AuctionView];
    }
    return self;
}
- (void)AuctionView{
    [self addSubview:self.line];
    [self addSubview:self.auctionBtn];
    
    for (int i=0; i<3; i++) {
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, self.auctionBtn.bottom+(i*[Unity countcoordinatesH:50]), SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        [self addSubview:view];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        line.backgroundColor = [Unity getColor:@"#e0e0e0"];
        [view addSubview:line];
        UILabel * nameL = [Unity lableViewAddsuperview_superView:view _subViewFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:15], [Unity countcoordinatesW:60], [Unity countcoordinatesH:20]) _string:@"k*t7**" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:[Unity getColor:@"#aa112d"] _textAlignment:NSTextAlignmentLeft];
        UILabel * orderL = [Unity lableViewAddsuperview_superView:view _subViewFrame:CGRectMake(nameL.right, nameL.top, [Unity countcoordinatesW:50], [Unity countcoordinatesH:20]) _string:@"领先" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:[Unity getColor:@"#aa112d"] _textAlignment:NSTextAlignmentLeft];
        UILabel * timeL = [Unity lableViewAddsuperview_superView:view _subViewFrame:CGRectMake(orderL.right+[Unity countcoordinatesW:10], orderL.top, [Unity countcoordinatesW:100], [Unity countcoordinatesH:20]) _string:@"04.08 12:50:33" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:[Unity getColor:@"#aa112d"] _textAlignment:NSTextAlignmentLeft];
        UILabel * amountL = [Unity lableViewAddsuperview_superView:view _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:90], timeL.top, [Unity countcoordinatesW:80], [Unity countcoordinatesH:20]) _string:@"¥280,000" _lableFont:[UIFont systemFontOfSize:FontSize(12)] _lableTxtColor:[Unity getColor:@"#aa112d"] _textAlignment:NSTextAlignmentRight];
        if (i == 1) {
            nameL.textColor = LabelColor3;
            orderL.textColor = LabelColor3;
            timeL.textColor = LabelColor3;
            amountL.textColor = LabelColor3;
        }else if (i == 2){
            nameL.textColor = LabelColor6;
            orderL.textColor = LabelColor6;
            timeL.textColor = LabelColor6;
            amountL.textColor = LabelColor6;
        }
    }
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:10])];
        _line.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return _line;
}
- (UIButton *)auctionBtn{
    if (!_auctionBtn) {
        _auctionBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _line.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        [_auctionBtn addTarget:self action:@selector(auctionClick) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel * CV = [Unity lableViewAddsuperview_superView:_auctionBtn _subViewFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:15], [Unity countcoordinatesW:80], [Unity countcoordinatesH:20]) _string:@"竞拍履历" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(CV.right, CV.top, [Unity countcoordinatesW:1], [Unity countcoordinatesH:20])];
        line.backgroundColor = [Unity getColor:@"#e0e0e0"];
        [_auctionBtn addSubview:line];
        UILabel * numL = [Unity lableViewAddsuperview_superView:_auctionBtn _subViewFrame:CGRectMake(line.right+[Unity countcoordinatesW:20], line.top, [Unity countcoordinatesW:50], [Unity countcoordinatesH:20]) _string:@"10条" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentLeft];
        numL.backgroundColor = [UIColor clearColor];
        UIImageView * goImg = [Unity imageviewAddsuperview_superView:_auctionBtn _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:15], [Unity countcoordinatesH:20], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10]) _imageName:@"go" _backgroundColor:nil];
        goImg.backgroundColor = [UIColor clearColor];
    }
    return _auctionBtn;
}
- (void)auctionClick{
    [self.delegate moreClick];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
