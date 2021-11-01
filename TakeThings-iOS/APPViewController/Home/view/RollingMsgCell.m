//
//  RollingMsgCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/12.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "RollingMsgCell.h"
#import "LMJScrollTextView2.h"
@interface RollingMsgCell()<LMJScrollTextView2Delegate>
{
    NSInteger index;//消息的个数
}
@property (nonatomic , strong) LMJScrollTextView2 * scro;
@property (nonatomic , strong) NSMutableArray * msgArr;
@property (nonatomic , strong) NSArray * array;
@end

@implementation RollingMsgCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [self loadRollingView];
    }
    return self;
}
- (void)loadRollingView{
    UIImageView * imageView = [Unity imageviewAddsuperview_superView:self.contentView _subViewFrame:CGRectMake(kWidth(15), kWidth(15), kWidth(75), kWidth(20)) _imageName:@"msgicon" _backgroundColor:nil];
    
    _scro = [[LMJScrollTextView2 alloc]initWithFrame:CGRectMake(imageView.right+kWidth(5), imageView.top,SCREEN_WIDTH-kWidth(165) , kWidth(20))];
    [self.contentView addSubview:_scro];
    
    _scro.delegate            = self;
    _scro.textStayTime        = 4;
    _scro.scrollAnimationTime = 1;
    _scro.textColor           = LabelColor9;
    _scro.textFont            = [UIFont boldSystemFontOfSize:FontSize(12)];
    _scro.textAlignment       = NSTextAlignmentLeft;
    _scro.touchEnable         = YES;
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:@""];
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:@"icon"];
    textAttachment.bounds = CGRectMake(0, -4, 15, 15);
    NSAttributedString *attachmentAttrStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attrStr insertAttributedString:attachmentAttrStr atIndex:attrStr.length];
    
    
    _scro.textDataArr = @[];
//    @[@"这是一条数据：000000",@"这是一条数据：111111",@"这是一条数据：222222",@"这是一条数据：333333",@"这是一条数据：444444",@"这是一条数据：555555",attrStr];
    
    
    [_scro startScrollBottomToTopWithNoSpace];
    
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(_scro.right+kWidth(5), imageView.top, kWidth(1), imageView.height)];
    line.backgroundColor = [Unity getColor:@"#666666"];
    [self.contentView addSubview:line];
    
    UIButton * moreBtn = [Unity buttonAddsuperview_superView:self.contentView _subViewFrame:CGRectMake(line.right+kWidth(9), line.top, kWidth(40), line.height) _tag:self _action:@selector(moreClick) _string:@"更多" _imageName:@""];
    [moreBtn setTitleColor:[Unity getColor:@"#666666"] forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];

}

- (void)moreClick{
    [self.delegate msgMore];
}
#pragma mark - LMJScrollTextView2 Delegate
- (void)scrollTextView2:(LMJScrollTextView2 *)scrollTextView currentTextIndex:(NSInteger)index{
//    NSLog(@"当前是信息%ld",index);
}
- (void)scrollTextView2:(LMJScrollTextView2 *)scrollTextView clickIndex:(NSInteger)index content:(NSString *)content{
//    NSLog(@"#####点击的是：第%ld条信息 内容：%@",index,content);
    [self.delegate noticeBack:self.array[index]];
}
- (void)configWithMsgList:(NSMutableArray *)arr{
    self.array = arr;
    
    [self.msgArr removeAllObjects];
    for (int i=0; i<arr.count; i++) {
        [self.msgArr addObject:arr[i][@"w_title"]];
    }
    index = self.msgArr.count;
    self.scro.textDataArr = [self.msgArr copy];
}
- (NSMutableArray *)msgArr{
    if (!_msgArr) {
        _msgArr = [NSMutableArray new];
    }
    return _msgArr;
}
- (NSArray *)array{
    if (!_array) {
        _array = [NSArray new];
    }
    return _array;
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
