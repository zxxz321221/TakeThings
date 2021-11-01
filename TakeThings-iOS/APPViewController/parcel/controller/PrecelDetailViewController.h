//
//  PrecelDetailViewController.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/25.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  PrecelDetailDelegate <NSObject>
- (void)detailLoadList;

@end
@interface PrecelDetailViewController : UIViewController
@property (nonatomic, strong) id<PrecelDetailDelegate>delegate;
@property (nonatomic , strong) NSDictionary * dataDic;
@property (nonatomic , strong) NSString * bg_id;//包裹ID
@end

NS_ASSUME_NONNULL_END
