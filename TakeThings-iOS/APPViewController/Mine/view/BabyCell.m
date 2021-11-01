//
//  BabyCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/12.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "BabyCell.h"
#import "BabyModel.h"
@interface BabyCell()
@property (nonatomic , strong) UIImageView * img;
@property (nonatomic , strong) UILabel * titleL;
@property (nonatomic , strong) UILabel * timeL;
@property (nonatomic , strong) UIButton * oldPage;
@property (nonatomic , strong) UIButton * patBtn;

@property (nonatomic , strong) UIView * maskView;
@property (nonatomic , strong) UILabel  * maskTL;

@property (nonatomic , strong) UIButton * seletdBtn;

@property (nonatomic , strong) NSTimer * timer;
@end
@implementation BabyCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self babyView];
    }
    return self;
}
- (void)babyView{
    [self.contentView addSubview:self.seletdBtn];
    [self.contentView addSubview:self.img];
    [self.contentView addSubview:self.titleL];
    [self.contentView addSubview:self.timeL];
    [self.contentView addSubview:self.oldPage];
    [self.contentView addSubview:self.patBtn];
    [self.contentView addSubview:self.maskView];
    [self.contentView addSubview:self.maskTL];
//    [self hasAuction];
}
- (UIButton *)seletdBtn{
    if (!_seletdBtn) {
        _seletdBtn = [[UIButton alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:55], [Unity countcoordinatesW:15], [Unity countcoordinatesH:15])];
        [_seletdBtn addTarget:self action:@selector(readClick:) forControlEvents:UIControlEventTouchUpInside];
        [_seletdBtn setBackgroundImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [_seletdBtn setBackgroundImage:[UIImage imageNamed:@"read"] forState:UIControlStateSelected];
        _seletdBtn.hidden = YES;
    }
    return _seletdBtn;
}
- (UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:10], [Unity countcoordinatesW:110], [Unity countcoordinatesH:110])];
        _img.layer.cornerRadius = 10;
        _img.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _img;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(_img.right+[Unity countcoordinatesW:10], _img.top, SCREEN_WIDTH-[Unity countcoordinatesW:130], [Unity countcoordinatesH:30])];
        _titleL.text = @"";
        _titleL.textColor = LabelColor6;
        _titleL.font = [UIFont systemFontOfSize:FontSize(14)];
        _titleL.textAlignment = NSTextAlignmentLeft;
        _titleL.numberOfLines = 0;
    }
    return _titleL;
}
- (UILabel *)timeL{
    if (!_timeL) {
        _timeL = [[UILabel alloc]initWithFrame:CGRectMake(_titleL.left, _titleL.bottom, _titleL.width, [Unity countcoordinatesH:20])];
        _timeL.text = @"";
        _timeL.textColor = LabelColor9;
        _timeL.textAlignment = NSTextAlignmentLeft;
        _timeL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _timeL;
}
- (UIButton *)oldPage{
    if (!_oldPage) {
        _oldPage = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:150], _timeL.bottom+[Unity countcoordinatesH:30], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_oldPage addTarget:self action:@selector(oldpageClick) forControlEvents:UIControlEventTouchUpInside];
        [_oldPage setTitle:@"原始页面" forState:UIControlStateNormal];
        [_oldPage setTitleColor:LabelColor3 forState:UIControlStateNormal];
        _oldPage.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _oldPage.layer.borderWidth = 1;
        _oldPage.layer.borderColor = LabelColor9.CGColor;
        _oldPage.layer.cornerRadius = _oldPage.height/2;
    }
    return _oldPage;
}
- (UIButton *)patBtn{
    if (!_patBtn) {
        _patBtn = [[UIButton alloc]initWithFrame:CGRectMake(_oldPage.right+[Unity countcoordinatesW:5], _timeL.bottom+[Unity countcoordinatesH:30], [Unity countcoordinatesW:70], [Unity countcoordinatesH:30])];
        [_patBtn addTarget:self action:@selector(patClick) forControlEvents:UIControlEventTouchUpInside];
        [_patBtn setTitle:@"我要购买" forState:UIControlStateNormal];
        [_patBtn setTitleColor:[Unity getColor:@"#aa112d"] forState:UIControlStateNormal];
        _patBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
        _patBtn.layer.borderWidth = 1;
        _patBtn.layer.borderColor = [Unity getColor:@"#aa112d"].CGColor;
        _patBtn.layer.cornerRadius = _patBtn.height/2;
    }
    return _patBtn;
}
- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(_img.left, _img.top, _img.width, _img.height)];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.5;
        _maskView.layer.cornerRadius = 10;
        _maskView.hidden = YES;
    }
    return _maskView;
}
- (UILabel *)maskTL{
    if (!_maskTL) {
        _maskTL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:10]+(_maskView.height-[Unity countcoordinatesH:20])/2, _maskView.width, [Unity countcoordinatesH:20])];
        _maskTL.text = @"已结束";
        _maskTL.textColor = [Unity getColor:@"#fdfdfd"];
        _maskTL.alpha = 1;
        _maskTL.textAlignment = NSTextAlignmentCenter;
        _maskTL.font = [UIFont systemFontOfSize:FontSize(19)];
        _maskTL.hidden = YES;
    }
    return _maskTL;
}

//已结标的商品调用此方法
- (void)hasAuction{
    self.maskView.hidden = NO;
    self.maskTL.hidden = NO;
    self.patBtn.layer.borderColor = LabelColor9.CGColor;
    [self.patBtn setTitleColor:LabelColor9 forState:UIControlStateNormal];
    self.patBtn.userInteractionEnabled = NO;
}
- (void)config:(BOOL)edit{
    if (edit) {
        self.seletdBtn.hidden = NO;
        self.img.frame = CGRectMake([Unity countcoordinatesW:25], [Unity countcoordinatesH:10], [Unity countcoordinatesW:110], [Unity countcoordinatesH:110]);
        self.titleL.frame = CGRectMake(_img.right+[Unity countcoordinatesW:10], _img.top, SCREEN_WIDTH-[Unity countcoordinatesW:150], [Unity countcoordinatesH:30]);
        self.timeL.frame = CGRectMake(_titleL.left, _titleL.bottom, _titleL.width, [Unity countcoordinatesH:20]);
        self.oldPage.hidden = YES;
        self.patBtn.hidden= YES;
        self.maskView.frame = CGRectMake(self.img.left, self.img.top, self.img.width, self.img.height);
        self.maskTL.frame = CGRectMake([Unity countcoordinatesW:25], [Unity countcoordinatesH:10]+(self.maskView.height-[Unity countcoordinatesH:20])/2, self.maskView.width, [Unity countcoordinatesH:20]);
    }else{
        self.seletdBtn.hidden = YES;
        self.img.frame = CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:10], [Unity countcoordinatesW:110], [Unity countcoordinatesH:110]);
        self.titleL.frame = CGRectMake(_img.right+[Unity countcoordinatesW:10], _img.top, SCREEN_WIDTH-[Unity countcoordinatesW:130], [Unity countcoordinatesH:30]);
        self.timeL.frame = CGRectMake(_titleL.left, _titleL.bottom, _titleL.width, [Unity countcoordinatesH:20]);
        self.oldPage.hidden = NO;
        self.patBtn.hidden= NO;
        self.maskView.frame = CGRectMake(self.img.left, self.img.top, self.img.width, self.img.height);
        self.maskTL.frame = CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:10]+(self.maskView.height-[Unity countcoordinatesH:20])/2, self.maskView.width, [Unity countcoordinatesH:20]);
    }
}

- (void)setModel:(BabyModel *)model{
    self.seletdBtn.selected = model.isSelect;
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.w_imgsrc] placeholderImage:[UIImage imageNamed:@"Loading"]];
    self.titleL.text = model.w_object;
    // 当前时间的时间戳
    NSString *nowStr = [Unity getCurrentTimeyyyymmdd];
    // 计算时间差值
    NSInteger secondsCountDown = [Unity getDateDifferenceWithNowDateStr:nowStr deadlineStr:model.w_overtime];
    if ([model.w_cc isEqualToString:@"0"]) {
        [self daojishi:secondsCountDown-3600];
    }else{
        [self daojishi:secondsCountDown];
    }
    
}
- (void)daojishi:(NSInteger)ss{
    __weak __typeof(self) weakSelf = self;
    
    if (_timer == nil) {
        __block NSInteger timeout = ss; // 倒计时时间
        
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC,  0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout <= 0){ //  当倒计时结束时做需要的操作: 关闭 活动到期不能提交
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.timeL.text = @"已结束";
                        [self hasAuction];
                    });
                } else { // 倒计时重新计算 时/分/秒
                    NSInteger days = (int)(timeout/(3600*24));
                    NSInteger hours = (int)((timeout-days*24*3600)/3600);
                    NSInteger minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    NSInteger second = timeout - days*24*3600 - hours*3600 - minute*60;
                    NSString *strTime = [NSString stringWithFormat:@"剩余时间: %ld天%02ld小时%02ld分%02ld秒", (long)days,hours, minute, second];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.timeL.text = strTime;
                    });
                    timeout--; // 递减 倒计时-1(总时间以秒来计算)
                }
            });
            dispatch_resume(_timer);
        }
    }
}
- (void)readClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(babyCellDelegate:WithSelectButton:)])
    {
        [self.delegate babyCellDelegate:self WithSelectButton:sender];
    }
}
- (void)oldpageClick{
    [self.delegate oldpageClick:self];
}
- (void)patClick{
    [self.delegate patClick:self];
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
