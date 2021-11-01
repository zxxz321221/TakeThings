//
//  PackagingCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/19.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "PackagingCell.h"
@interface PackagingCell()
{
    float cellH;
}
@property (nonatomic , strong) NSMutableArray * array;
@end
@implementation PackagingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)configWithPackBtnArr:(NSArray *)arr{
    if (arr.count == 0) {
        return;
    }
//    self.array = [arr mutableCopy];
    CGFloat w = [Unity countcoordinatesW:100];//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = [Unity countcoordinatesH:5];//用来控制button距离父视图的高
    CGFloat lastBtnY = 0;
    for (int i = 0; i < arr.count; i++) {//创建button
        UIButton *button = [[UIButton alloc]init];
        button.tag = i+1000;
        button.backgroundColor = [Unity getColor:@"f0f0f0"];
        //设置边框颜色
        button.layer.cornerRadius = 12.5f;
        [button addTarget:self action:@selector(clickHotSearchAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:LabelColor6 forState:UIControlStateNormal];
        [button setTitleColor:[Unity getColor:@"aa112d"] forState:UIControlStateSelected];
        button.titleLabel.font=[UIFont systemFontOfSize:FontSize(12)];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button sizeToFit];
        CGFloat length = button.frame.size.width;
        //设置button的frame
        button.frame = CGRectMake(10 + w, h, length + 15 , 25);// 距离屏幕左右边距各10,
        //当button的位置超出屏幕边缘时换行
        if(20 + w + length + 15 > SCREEN_WIDTH){
            w = [Unity countcoordinatesW:100]; //换行时将w置为0
            h = h + button.frame.size.height + 10;//距离父视图也变化
            button.frame = CGRectMake(10 + w, h, length + 15, 25);//重设button的frame
        }
        if (length + 20 > SCREEN_WIDTH - 20) {
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 8)];// 设置button的title距离边框有一定的间隙,显示不下的字会省略
            button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, SCREEN_WIDTH - 20, 25);//重设button的frame
            
        }
        w = button.frame.size.width + button.frame.origin.x;//重新赋值
        if (i==arr.count-1) {
            lastBtnY=button.frame.origin.y;
        }
        [self.contentView addSubview:button];
    }
}
- (void)clickHotSearchAction:(UIButton *)btn{
    if (btn.selected == YES) {
        btn.selected = NO;
        btn.backgroundColor = [Unity getColor:@"f0f0f0"];
        btn.layer.borderColor = [Unity getColor:@"f0f0f0"].CGColor;
        btn.layer.borderWidth = 1;
        for (int i=0; i<self.array.count; i++) {
            NSString *str = [NSString stringWithFormat:@"%ld",btn.tag-1000];
            if ([self.array[i] isEqualToString:str]) {
                [self.array removeObjectAtIndex:i];
                i--;
            }
        }
    }else{
        btn.selected = YES;
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.borderColor = [Unity getColor:@"aa112d"].CGColor;
        btn.layer.borderWidth = 1;
        [self.array addObject:[NSString stringWithFormat:@"%ld",btn.tag-1000]];
    }
    [self.delegate packBtnRead:self.array];
}
- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray new];
    }
    return _array;
}
@end
