//
//  PremiumView.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/30.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  PremiumViewDelegate <NSObject>

- (void)updatePlace:(NSDictionary *)dic;
@end
NS_ASSUME_NONNULL_BEGIN

@interface PremiumView : UIView
@property (nonatomic, strong) id<PremiumViewDelegate>delegate;
+(instancetype)setPremiumView:(UIView *)view;
@property (nonatomic ,strong) UILabel * number;//投标编号
@property (nonatomic , strong) UILabel * goodsName;//商品名称
@property (nonatomic , strong) UILabel * bidPrice;//投标价格
@property (nonatomic , strong) UILabel * currentPrice;//当前价格

@property (nonatomic , strong) UILabel * markL;//出价增额提示
@property (nonatomic , strong) UILabel * currencyL;//货币符号
@property (nonatomic , strong) NSString * w_cc;


- (void)showPremiumView;
@end

NS_ASSUME_NONNULL_END
