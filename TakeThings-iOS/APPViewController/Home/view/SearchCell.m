//
//  SearchCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/16.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "SearchCell.h"
@interface SearchCell()
@property (nonatomic , strong) UIButton * btn;
@property (nonatomic , strong) NSMutableArray * array;
@end
@implementation SearchCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.contentView.backgroundColor = [Unity getColor:@"#f0f0f0"];
    }
    return self;
}
- (void)configDatasource:(NSMutableArray *)arr{
    self.array = arr;
    NSLog(@"搜索%@",arr);
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 0;//用来控制button距离父视图的高
    CGFloat lastBtnY = 0;
    int count=0;
    if (self.array.count>10) {
        count = 10;
    }else{
        count = self.array.count;
    }
    for (int i = 0; i < count; i++) {//创建button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = i+1000;
        button.backgroundColor = [Unity getColor:@"#f0f0f0"];
        button.layer.cornerRadius = 15.0f;
        [button addTarget:self action:@selector(clickHotSearchAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:LabelColor6 forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:14];
        [button setTitle:self.array[i][@"word"] forState:UIControlStateNormal];
        [button sizeToFit];
        CGFloat length = button.frame.size.width;
        //设置button的frame
        button.frame = CGRectMake(10 + w, h, length + 15 , 30);// 距离屏幕左右边距各10,
        //当button的位置超出屏幕边缘时换行
        if(10 + w + length + 15 > SCREEN_WIDTH){
            w = 0; //换行时将w置为0
            h = h + button.frame.size.height + 10;//距离父视图也变化
            button.frame = CGRectMake(10 + w, h, length + 15, 30);//重设button的frame
         }
        if (length + 20 > SCREEN_WIDTH - 20) {
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 8)];// 设置button的title距离边框有一定的间隙,显示不下的字会省略
            button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, SCREEN_WIDTH - 20, 30);//重设button的frame
            
         }
        w = button.frame.size.width + button.frame.origin.x;//重新赋值
        if (i==self.array.count-1) {
            lastBtnY=button.frame.origin.y;
         }
        [self.contentView addSubview:button];
        
        
    }
}
-(void)clickHotSearchAction:(UIButton *)btn{
//    NSInteger i = btn.tag-1000;
    NSDictionary * dic = self.array[btn.tag-1000];
    NSString * str = dic[@"word"];
    NSLog(@"字典  %@",dic);
    NSLog(@"字符串 %@",str);
//
//    [self.delegate searchKeywords:self.array[i][@"word"]];
    [self.delegate searchKeywords:str WithTag:btn.tag-1000];
}
- (NSMutableArray *)array{
    if (_array == nil) {
        _array = [NSMutableArray array];
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
