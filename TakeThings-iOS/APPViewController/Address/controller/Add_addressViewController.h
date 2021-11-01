//
//  Add_addressViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/31.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  addressSaveDelegate <NSObject>

- (void)loadAddress;

@end
@interface Add_addressViewController : UIViewController
@property (nonatomic, strong) id<addressSaveDelegate>delegate;
@property (nonatomic , strong) NSDictionary * addressDic;
@property (nonatomic , assign) BOOL isEdit;
@end

NS_ASSUME_NONNULL_END
