//
//  GoodsWebCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/23.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol webViewCellDelegate<NSObject>
//
//- (void)webViewDidFinishLoad:(CGFloat)webHeight;
//
//@end
//typedef void (^WebHeightChangedCallback) (CGFloat cellH);
typedef void (^ReloadBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface GoodsWebCell : UITableViewCell

//@property (nonatomic,weak) id<webViewCellDelegate>delegate;
- (void)refreshWebView:(NSString *)url;
//@property(nonatomic, copy) WebHeightChangedCallback webHeightChangedCallback;
@property(nonatomic,copy)NSString *htmlString;
@property(nonatomic,copy)ReloadBlock reloadBlock;
+(CGFloat)cellHeight;
@end

NS_ASSUME_NONNULL_END
