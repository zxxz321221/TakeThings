//
//  BidIdCardListViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/3.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  BidIdCardListDelegate <NSObject>

- (void)selectRealName;

@end
NS_ASSUME_NONNULL_BEGIN

@interface BidIdCardListViewController : UIViewController
@property (nonatomic, strong) id<BidIdCardListDelegate>delegate;
@property (nonatomic , strong) NSDictionary * addressDic;
@property (nonatomic , assign) BOOL isEdit;
@end

NS_ASSUME_NONNULL_END
