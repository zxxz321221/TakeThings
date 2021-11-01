//
//  NewMineViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/10/10.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "NewMineViewController.h"
#import <Masonry.h>
@interface NewMineViewController ()<UIScrollViewDelegate>
@property (nonatomic , strong) UIScrollView * scrollView;
@property (nonatomic , strong) UIView * topView;
@property (nonatomic, unsafe_unretained) CGFloat oldY;
@property (nonatomic , strong) UIView * contentView;
@end

@implementation NewMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
}
-(void)initViews{
    _topView = [UIView new];
    _topView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_topView];
    CGFloat topH = NavBarHeight+[Unity countcoordinatesH:200];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(topH);
    }];
    
//    UIImageView *imv = [[UIImageView alloc] init];
//    imv.image = LocalImage(@"login_icon");
//    imv.userInteractionEnabled = YES;
//    imv.contentMode = UIViewContentModeScaleAspectFill;
//    [_topView addSubview:imv];
//
//    [imv mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(_topView);
//    }];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.alwaysBounceVertical = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.contentInset = UIEdgeInsetsMake(topH, 0, 0, 0);
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:_scrollView];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _contentView = [UIView new];
    _contentView.backgroundColor = [UIColor yellowColor];
    [_scrollView addSubview:_contentView];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.width.equalTo(_scrollView);
        make.height.mas_equalTo(1000);
    }];
    
    
//    _contentView.layer.shadowColor = ColorRGBA(230, 230, 230, 0.6).CGColor;
//    _contentView.layer.shadowOffset = CGSizeMake(1, 1);
//    _contentView.layer.shadowOpacity = 0.8;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    if (y < - _topView.height || y > 0) {
        return;
    }
    if (y >_oldY) {
        //上滑
        if (y<0 && y >- _topView.height) {
            _topView.transform = CGAffineTransformTranslate(_topView.transform, 0, (_oldY-y)*0.4);
        }else{
            [UIView animateWithDuration:0.1 animations:^{
                _topView.transform = CGAffineTransformIdentity;
            }];
        }
    }else{
        //下滑
        if (y < 0 && y > -_topView.height) {
            _topView.transform = CGAffineTransformTranslate(_topView.transform, 0, (_oldY-y)*0.4);
            if (_topView.transform.ty < -_topView.height) {
                [UIView animateWithDuration:0.1 animations:^{
                    _topView.transform = CGAffineTransformIdentity;
                }];
            }
        }else{
            [UIView animateWithDuration:0.1 animations:^{
                _topView.transform = CGAffineTransformIdentity;
            }];
        }
    }
    _oldY = y;
}

@end
