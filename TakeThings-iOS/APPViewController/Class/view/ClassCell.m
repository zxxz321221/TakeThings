//
//  ClassCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/22.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "ClassCell.h"

@implementation ClassCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, self.bounds.size.width-10, self.bounds.size.width-10)];
        self.imgView.contentMode = UIViewContentModeScaleAspectFit;
        self.imgView.image = [UIImage imageNamed:@"Loading"];
        [self.contentView addSubview:self.imgView];
        
        self.name = [[UILabel alloc]initWithFrame:CGRectMake(0, self.imgView.bottom, self.bounds.size.width, self.bounds.size.height-self.bounds.size.width)];
        self.name.font = [UIFont systemFontOfSize:12.0];
        self.name.numberOfLines = 0;
        self.name.textAlignment = NSTextAlignmentCenter;
//        self.name.backgroundColor = [UIColor yellowColor];
        [self .contentView addSubview:self.name];
    }
    return self;
}
@end
