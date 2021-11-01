//
//  HTPayCell3.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2020/3/3.
//  Copyright © 2020 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  HTPayCell3Delegate <NSObject>
- (void)creditCardBankNum:(NSString *)bankNum;
- (void)creditCardIdNum:(NSString *)idNum;
- (void)creditCardMobileNum:(NSString *)mobileNum;
- (void)creditCardCodeNum:(NSString *)codeNum;
- (void)creditCardName:(NSString *)name;
- (void)creditCardValidity:(NSString *)validity;
- (void)creditCardSafetyCode:(NSString *)code;
- (void)creditCardseleteBankName;
- (void)creditCardpaymentNuf_id:(NSString *)nuf_id;
@end
@interface HTPayCell3 : UITableViewCell
@property (nonatomic, strong) id<HTPayCell3Delegate>delegate;
@property (nonatomic , strong) UITextField * bankNameText;
@property (nonatomic , strong) NSString * bankCode;
@property (nonatomic , strong) NSString * order_id;
@end

NS_ASSUME_NONNULL_END
