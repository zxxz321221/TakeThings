//
//  SearchCell.h
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/16.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@protocol  SearchCellDelegate <NSObject>
- (void)searchKeywords:(NSString *)str WithTag:(NSInteger)tag;


@end


@interface SearchCell : UITableViewCell
- (void)configDatasource:(NSArray *)arr;
@property (nonatomic , strong) id<SearchCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
