//
//  InterestReusableView.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/30.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "InterestReusableView.h"
@interface InterestReusableView ()

@property (nonatomic ,retain)UILabel *label;

@end
@implementation InterestReusableView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.label.text = @"可多选，至少选1项";
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = LabelColor3;
        self.label.font = [UIFont systemFontOfSize:17];
        [self addSubview:self.label];
    }
    
    return self;
}
@end
