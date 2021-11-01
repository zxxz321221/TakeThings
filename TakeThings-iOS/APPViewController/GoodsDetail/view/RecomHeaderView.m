//
//  RecomHeaderView.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/9/26.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "RecomHeaderView.h"

@implementation RecomHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [Unity getColor:@"#e0e0e0"];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:20])];
        label.text = @"产品推荐";
        label.textColor = LabelColor3;
        label.font = [UIFont systemFontOfSize:FontSize(14)];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    return self;
}
@end
