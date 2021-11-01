//
//  AddPlaceView.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/1/17.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  AddPlaceViewDelegate <NSObject>

- (void)confirmPrice:(NSString *)price;
@end
@interface AddPlaceView : UIView

@property (nonatomic, strong) id<AddPlaceViewDelegate>delegate;
+(instancetype)setAddPlaceView:(UIView *)view;
- (void)showAddPlaceView;
@property (nonatomic ,strong) UILabel * number;//投标编号
@property (nonatomic , strong) UILabel * goodsName;//商品名称
@property (nonatomic , strong) UILabel * bidPrice;//投标价格
@property (nonatomic , strong) UILabel * currentPrice;//当前价格

@property (nonatomic , strong) UILabel * markL;//出价增额提示
@property (nonatomic , strong) UILabel * currencyL;//货币符号
@property (nonatomic , strong) NSString * rate;
@end

NS_ASSUME_NONNULL_END
