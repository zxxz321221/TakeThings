//
//  ProductParametersView.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/30.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductParametersView : UIView
+(instancetype)setProductParametersView:(UIView *)view;
@property (nonatomic , strong) UILabel * goodsDetailL;//新品 二手 等
@property (nonatomic , strong) UILabel * earlyTerminatL;//是否提前结束
@property (nonatomic , strong) UILabel * extendL;//是否自动延长
@property (nonatomic , strong) UILabel * bidIdL;//商品id
@property (nonatomic , strong) UILabel * freight;//当地运费label
@property (nonatomic , strong) UILabel * remark;
@property (nonatomic , strong) UILabel * inStockL;
@property (nonatomic , strong) UILabel * returnGoodsL;
- (void)showPPView;
@end

NS_ASSUME_NONNULL_END
