//
//  NewSendDetailViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/2/9.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  NewSendDelegate <NSObject>
- (void)reloadTableView;
@end
@interface NewSendDetailViewController : UIViewController
@property (nonatomic, strong) id<NewSendDelegate>delegate;
@property (nonatomic , strong) NSArray * kdArray;
@property (nonatomic , strong) NSArray * id_arr;
@property (nonatomic , strong) NSString * source;
@property (nonatomic , assign) BOOL isNew;
@end

NS_ASSUME_NONNULL_END
