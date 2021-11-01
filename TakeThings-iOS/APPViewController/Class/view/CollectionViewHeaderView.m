//
//  CollectionViewHeaderView.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/22.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "CollectionViewHeaderView.h"

@implementation CollectionViewHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.label = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:10], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20])];
        self.label.font = [UIFont systemFontOfSize:15.0];
        self.label.textAlignment = NSTextAlignmentLeft;
        self.label.textColor = LabelColor6;
//        self.label.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
        [self addSubview:self.label];
        
//        UIButton * btn = [Unity buttonAddsuperview_superView:self _subViewFrame:CGRectMake(self.bounds.size.width-[Unity countcoordinatesW:65], self.label.top, [Unity countcoordinatesW:60], [Unity countcoordinatesH:20]) _tag:self _action:@selector(moreClick) _string:@"更多 >" _imageName:nil];
//        [btn setTitleColor:LabelColor9 forState:UIControlStateNormal];
//        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//        btn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}
//- (void)moreClick{
//    [self.delegate moreClick:self.label.text];
//}
@end
