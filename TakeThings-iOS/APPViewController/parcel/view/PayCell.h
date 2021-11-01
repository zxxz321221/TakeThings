//
//  PayCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/12/24.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  PayCellDelegate <NSObject>
- (void)inputBankNum:(NSString *)bankNum;
- (void)inputIdNum:(NSString *)idNum;
- (void)inputMobileNum:(NSString *)mobileNum;
- (void)inputCodeNum:(NSString *)codeNum;
- (void)inputName:(NSString *)name;
- (void)seleteBankName;
- (void)paymentNuf_id:(NSString *)nuf_id;
@end
@interface PayCell : UITableViewCell
@property (nonatomic, strong) id<PayCellDelegate>delegate;
@property (nonatomic , strong) UITextField * bankNameText;
@property (nonatomic , strong) NSString * bankCode;
@property (nonatomic , strong) NSString * order_id;
@property (nonatomic , assign) NSInteger status;
@property (nonatomic , assign) BOOL isType;
@end

NS_ASSUME_NONNULL_END
