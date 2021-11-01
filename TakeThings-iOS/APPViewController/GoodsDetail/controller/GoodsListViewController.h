//
//  GoodsListViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/12.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFDualWayIndicateView.h"
NS_ASSUME_NONNULL_BEGIN

@interface GoodsListViewController : UIViewController
@property (strong, nonatomic, readonly) SFDualWayIndicateView *minIndicateView;//滑块指示视图
@property (strong, nonatomic, readonly) SFDualWayIndicateView *maxIndicateView;//滑块指示视图
@property (strong, nonatomic, readonly) SFDualWayIndicateView *mxLabelView;//滑块指示视图
@property (nonatomic , assign) BOOL isSearch;
@property (nonatomic , assign) NSInteger pageIndex;//0 分类 1品牌 2卖家 3专题号
@property (nonatomic , strong) NSString * classId;//分类ID
@property (nonatomic , strong) NSString * className;//分类名称
@property (nonatomic , strong) NSString * brandId;//品牌id
@property (nonatomic , strong) NSString * sellerId;//卖家ID
@property (nonatomic , strong) NSString * zhutiId;//主题id
@property (nonatomic , strong) NSString * locale;//语言
@property (nonatomic , strong) NSString * keyWord;//搜索关键字
@property (nonatomic , strong) NSString * platform;//平台

@property (nonatomic , assign) BOOL home;
@end

NS_ASSUME_NONNULL_END
