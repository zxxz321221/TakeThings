//
//  Unity.h
//  flow
//
//  Created by 桂在明 on 2019/3/26.
//  Copyright © 2019年 桂在明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Unity : NSObject
//获取文本颜色
+(UIColor *)getColor:(NSString *) stringToConvert;

//计算坐标比例
+(CGFloat)countcoordinatesX:(CGFloat)numberX;

//计算坐标比例Y
+ (CGFloat)countcoordinatesY:(CGFloat)numberY;

+(CGFloat)countcoordinatesW:(CGFloat)numberW;

+(CGFloat)countcoordinatesH:(CGFloat)numberH;

//image
+ (UIImageView *)imageviewAddsuperview_superView:(UIView *)superview _subViewFrame:(CGRect)rect _imageName:(NSString *)image _backgroundColor:(UIColor *)color;

+(UILabel *)lableViewAddsuperview_superView:(UIView *)superview _subViewFrame:(CGRect)rect _string:(NSString *)string _lableFont:(UIFont *)font _lableTxtColor:(UIColor *)color _textAlignment:(NSTextAlignment)alignment;

+(UITextField *)textFieldAddSuperview_superView:(UIView *)superview
                                  _subViewFrame:(CGRect)rect
                                        _placeT:(NSString *)placeholder
                               _backgroundImage:(UIImage *)background
                                      _delegate:(id)delegate
                                      andSecure:(BOOL)ture
                             andBackGroundColor:(UIColor *)color;

+(UIButton *)buttonAddsuperview_superView:(UIView *)superview _subViewFrame:(CGRect)rect _tag:(id)viewcontroller _action:(SEL)action _string:(NSString *)string _imageName:(NSString *)image;

//校验手机号
+ (BOOL)validateMobile:(NSString *)mobile;

//根据宽度和字体 自动计算文本高度
+(CGFloat) getLabelHeightWithWidth:(CGFloat)labelWidth andDefaultHeight:(CGFloat)labelDefaultHeight andFontSize:(CGFloat)fontSize andText:(NSString *)text;
//根据字符串获取label宽度
+ (CGFloat)widthOfString:(NSString *)string OfFontSize:(CGFloat)font OfHeight:(CGFloat)height;
//登录密码校验  字母 数字 特殊符号 必须同时存在 大小写字母其中一种
+ (BOOL)isSafePassword:(NSString *)strPwd;
//dic转json
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
+ (NSString *)timeStamp:(NSString *)time;
+ (NSInteger)calcDaysFromBegin:(NSString *)beginDate end:(NSString *)endDate;
+ (NSString *)configWithCurrentCurrency:(NSString *)currentCurrency WithTargetCurrency:(NSString *)targetCurrency WithAmount:(NSString *)amount;

+ (NSString *)getCurrentTimeyyyymmdd;
+ (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr;
+ (NSString *)getSmallestUnitOfBid:(NSString *)price;
+ (NSString *)getSmallestUnitOfBid:(NSString *)price WithCount:(NSString *)count;
+ (NSString *)editMobile:(NSString *)mobile;
+ (NSDictionary *)deleteNullValue:(NSDictionary *)dic;
+ (NSMutableDictionary *)editLoginData:(NSDictionary *)dic;
+(CGFloat)getCellHeight:(NSString*)htmlStr;
+ (NSString *)compareCurrentTime:(NSString *)str;
+(void)showanimate;
+(void)hiddenanimate;
+ (NSInteger)getFreightWithWeight:(NSString *)weight WithSteam:(NSString *)steam;
+ (NSString *)gs_jsonStringCompactFormatForNSArray:(NSArray *)arrJson;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format andForTimeZone:(NSString *)time;
+ (NSMutableDictionary *)setKey:(NSString *)key WithValue:(NSString *)value WithDic:(NSMutableDictionary *)dic;
+ (NSString *)getLanguage;
+ (NSString *)editIdCard:(NSString *)idCard;
+ (NSString *)getState:(NSInteger)state WithPage:(NSInteger)page;
+ (NSString *)parcelNumber:(NSInteger)num;
+ (NSMutableDictionary *)nullDicToDic:(NSDictionary *)dic;
+ (NSString *)get_image:(id)image;
+ (NSString *)get_HaitaoStatusId:(NSString *)status;
//新委托单状态
+ (NSString *)getStatus:(NSString *)status;
@end
