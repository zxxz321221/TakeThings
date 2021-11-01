//
//  HTPayCell2.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/3/3.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  HTPayCell2Delegate <NSObject>
- (void)depositCardBankNum:(NSString *)bankNum;
- (void)depositCardIdNum:(NSString *)idNum;
- (void)depositCardMobileNum:(NSString *)mobileNum;
- (void)depositCardCodeNum:(NSString *)codeNum;
- (void)depositCardName:(NSString *)name;
- (void)depositCardseleteBankName;
- (void)depositCardpaymentNuf_id:(NSString *)nuf_id;
@end
@interface HTPayCell2 : UITableViewCell
@property (nonatomic, strong) id<HTPayCell2Delegate>delegate;
@property (nonatomic , strong) UITextField * bankNameText;
@property (nonatomic , strong) NSString * bankCode;
@property (nonatomic , strong) NSString * order_id;
@end

NS_ASSUME_NONNULL_END
