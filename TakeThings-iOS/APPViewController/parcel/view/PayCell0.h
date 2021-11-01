//
//  PayCell0.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/25.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  PayCell0Delegate <NSObject>
- (void)inputBankNum0:(NSString *)bankNum;
- (void)inputIdNum0:(NSString *)idNum;
- (void)inputMobileNum0:(NSString *)mobileNum;
- (void)inputCodeNum0:(NSString *)codeNum;
- (void)inputName0:(NSString *)name;
- (void)seleteBankName0;
- (void)inputVali0:(NSString *)vali;
- (void)paymentNuf_id0:(NSString *)nuf_id;
- (void)inputsafeCode0:(NSString *)code;
@end
@interface PayCell0 : UITableViewCell
@property (nonatomic, strong) id<PayCell0Delegate>delegate;
@property (nonatomic , strong) UITextField * bankNameText;
@property (nonatomic , strong) NSString * bankCode;
@property (nonatomic , strong) NSString * order_id;
@property (nonatomic , assign) NSInteger status;
@property (nonatomic , assign) BOOL isType;
@end

NS_ASSUME_NONNULL_END
