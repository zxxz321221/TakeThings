//
//  AddressViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/31.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  AddressViewDelegate <NSObject>

- (void)EntrustAddress:(NSMutableArray *)list WithIndexPath:(NSInteger )indexpath;

@end
NS_ASSUME_NONNULL_BEGIN

@interface AddressViewController : UIViewController
@property (nonatomic, strong) id<AddressViewDelegate>delegate;
@property (nonatomic , assign) NSInteger page;//0 委托单 1发货 2我的 3包裹列表 4包裹详情
@end

NS_ASSUME_NONNULL_END
