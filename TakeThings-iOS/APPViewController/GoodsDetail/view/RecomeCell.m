//
//  RecomeCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/9/27.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "RecomeCell.h"
#import "JYTimerUtil.h"
@interface RecomeCell()<JYTimerListener>
@property (nonatomic , strong) UIView * backV;
@property (nonatomic , strong) UIImageView * imageView;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UILabel * priceL;
@property (nonatomic , strong) UILabel * priceN;
@property (nonatomic , strong) UIImageView * countImg;
@property (nonatomic , strong) UILabel * countL;
@property (nonatomic , strong) UIImageView * djsImg;
@property (nonatomic , strong) UILabel * djsL;
@end
@implementation RecomeCell
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        //kvo监听time值改变（解决cell滚动时内容不及时刷新的问题）
        [self addObserver:self forKeyPath:@"time" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [[JYTimerUtil sharedInstance] addListener:self];
        self.contentView.backgroundColor = [Unity getColor:@"#e0e0e0"];
        [self.contentView addSubview:self.backV];
    }
    return self;
}
-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"time"];
    [[JYTimerUtil sharedInstance] removeListener:self];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self onTimer];
}

-(void)didOnTimer:(JYTimerUtil *)timerUtil timeInterval:(NSTimeInterval)timeInterval
{
    [self onTimer];
}
-(void)onTimer
{
    NSTimeInterval lefTime = [[JYTimerUtil sharedInstance] lefTimeInterval:self.time];
    //    NSLog(@"left%f",lefTime);
    if (lefTime>0) {
        NSInteger days = (int)(lefTime/(3600*24));
        NSInteger hours = (int)((lefTime-days*24*3600)/3600);
        NSInteger minute = (int)(lefTime-days*24*3600-hours*3600)/60;
        //        NSInteger second = lefTime - days*24*3600 - hours*3600 - minute*60;
        self.djsL.text = [NSString stringWithFormat:@"%02ld天%02ld时%02ld分",(long)days,(long)hours,(long)minute];\
    }else {
        self.djsL.text = @"已结束";
    }
}
- (UIView *)backV{
    if (!_backV) {
        _backV = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:2.5], [Unity countcoordinatesH:5], self.contentView.width-[Unity countcoordinatesW:5], [Unity countcoordinatesH:245])];
        _backV.backgroundColor = [UIColor whiteColor];
        _backV.layer.cornerRadius = 5;
        
        [_backV addSubview:self.imageView];
        [_backV addSubview:self.titleL];
        [_backV addSubview:self.priceL];
        [_backV addSubview:self.priceN];
        [_backV addSubview:self.countImg];
        [_backV addSubview:self.countL];
        [_backV addSubview:self.djsImg];
        [_backV addSubview:self.djsL];
    }
    return _backV;
}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _backV.width, [Unity countcoordinatesH:165])];
//        _imageView.backgroundColor = [UIColor redColor];
        _imageView.layer.cornerRadius = 5;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _imageView.bottom, _imageView.width-[Unity countcoordinatesW:10], [Unity countcoordinatesH:30])];
//        _titleL.text = @"@#$%^&*()(*&^%$#@#$%^&*()*&^%$#@#$%^&*(";
        _titleL.textColor = LabelColor3;
        _titleL.font = [UIFont systemFontOfSize:FontSize(12)];
        _titleL.numberOfLines= 0;
    }
    return _titleL;
}
- (UILabel *)priceL{
    if (!_priceL) {
        _priceL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _titleL.bottom, [Unity countcoordinatesW:50], [Unity countcoordinatesH:20])];
        _priceL.text = @"当前价格:";
        _priceL.textColor = LabelColor6;
        _priceL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _priceL;
}
- (UILabel *)priceN{
    if (!_priceN) {
        _priceN = [[UILabel alloc]initWithFrame:CGRectMake(_priceL.right, _titleL.bottom, _backV.width-[Unity countcoordinatesW:60], [Unity countcoordinatesH:20])];
//        _priceN.text = @"44493045円";
        _priceN.textColor = [Unity getColor:@"aa112d"];
        _priceN.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _priceN;
}
- (UIImageView *)countImg{
    if (!_countImg) {
        _countImg = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _priceL.bottom+[Unity countcoordinatesH:5], [Unity countcoordinatesW:10], [Unity countcoordinatesH:10])];
        _countImg.image = [UIImage imageNamed:@"footcount"];
    }
    return _countImg;
}
- (UILabel *)countL{
    if (!_countL) {
        _countL = [[UILabel alloc]initWithFrame:CGRectMake(_countImg.right+[Unity countcoordinatesW:5], _priceL.bottom, [Unity countcoordinatesW:30], [Unity countcoordinatesH:20])];
//        _countL.text = @"9999";
        _countL.textColor = LabelColor9;
        _countL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _countL;
}
- (UIImageView *)djsImg{
    if (!_djsImg) {
        _djsImg = [[UIImageView alloc]initWithFrame:CGRectMake(_countL.right+[Unity countcoordinatesW:10], _countImg.top, [Unity countcoordinatesW:10], [Unity countcoordinatesH:10])];
        _djsImg.image = [UIImage imageNamed:@"foottime"];
    }
    return _djsImg;
}
- (UILabel *)djsL{
    if (!_djsL) {
        _djsL = [[UILabel alloc]initWithFrame:CGRectMake(_djsImg.right+[Unity countcoordinatesW:5], _priceL.bottom, _backV.width-[Unity countcoordinatesW:80], [Unity countcoordinatesH:20])];
//        _djsL.text = @"44天44时44分";
        _djsL.textColor = LabelColor9;
        _djsL.font = [UIFont systemFontOfSize:FontSize(12)];
        _djsL.textAlignment = NSTextAlignmentRight;
    }
    return _djsL;
}
- (void)configCellWithImage:(NSString *)image WithTitle:(NSString *)title WithPrice:(NSString *)price WithBid:(NSString *)bid WithType:(NSString *)type{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",image]] placeholderImage:[UIImage imageNamed:@"Loading"]];
    self.titleL.text = [NSString stringWithFormat:@"%@",title];
    self.countL.text = [NSString stringWithFormat:@"%@",bid];
    if ([type isEqualToString:@"yahoo"]) {
        self.priceN.text = [NSString stringWithFormat:@"%@ 円",price];
    }else{
        self.priceN.text = [NSString stringWithFormat:@"%@ 美元",price];
    }
}
@end
