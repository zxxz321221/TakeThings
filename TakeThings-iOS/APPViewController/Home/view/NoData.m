//
//  NoData.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/8/12.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "NoData.h"
@interface NoData()

@end
@implementation NoData

+(instancetype)setNoData:(UIView *)view{
    NoData * nData = [[NoData alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:90], SCREEN_WIDTH, SCREEN_HEIGHT-[Unity countcoordinatesH:90])];
    [view addSubview:nData];
    return nData;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.hidden = YES;
        [self addSubview:self.imageView];
        [self addSubview:self.msgLabel];
        [self addSubview:self.homeBtn];
    }
    return self;
}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-[Unity countcoordinatesW:80])/2, [Unity countcoordinatesH:70], [Unity countcoordinatesW:80], [Unity countcoordinatesH:92])];
//        _imageView.image = [UIImage imageNamed:@"nodata"];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}
- (UILabel *)msgLabel{
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageView.bottom+[Unity countcoordinatesH:30], SCREEN_WIDTH, [Unity countcoordinatesH:15])];
//        _msgLabel.text = @"您还没有相关订单，快去挑选吧~";
        _msgLabel.textColor = LabelColor3;
        _msgLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _msgLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _msgLabel;
}
- (UIButton *)homeBtn{
    if (!_homeBtn) {
        _homeBtn = [[UIButton alloc]initWithFrame:CGRectMake(_imageView.left, _msgLabel.bottom+[Unity countcoordinatesH:20], _imageView.width, [Unity countcoordinatesH:30])];
        [_homeBtn addTarget:self action:@selector(homeBtnClck) forControlEvents:UIControlEventTouchUpInside];
//        [_homeBtn setTitle:@"逛逛首页" forState:UIControlStateNormal];
        [_homeBtn setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateNormal];
        _homeBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _homeBtn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        _homeBtn.layer.borderWidth =1;
        _homeBtn.layer.cornerRadius = _homeBtn.height/2;
    }
    return _homeBtn;
}
- (void)showNoData{
    self.hidden = NO;
}
- (void)hiddenNoData{
    self.hidden = YES;
}
- (void)homeBtnClck{
    [self.delegate pushHome];
}
@end
