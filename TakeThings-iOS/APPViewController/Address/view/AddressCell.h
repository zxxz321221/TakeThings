//
//  AddressCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/31.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressCell;
@protocol  AddressCellDelegate <NSObject>

- (void)defaultCellDelegate:(AddressCell *_Nullable)cell;
- (void)editCellDelegate:(AddressCell *_Nullable)cell;
- (void)deleteCellDelegate:(AddressCell *_Nullable)cell;

@end
NS_ASSUME_NONNULL_BEGIN

@interface AddressCell : UITableViewCell
@property (nonatomic, strong) id<AddressCellDelegate>delegate;
- (void)configWithAddressData:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
