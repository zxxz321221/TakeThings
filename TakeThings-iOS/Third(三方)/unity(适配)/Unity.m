//
//  Unity.m
//  flow
//
//  Created by 桂在明 on 2019/3/26.
//  Copyright © 2019年 桂在明. All rights reserved.
//

#import "Unity.h"

@implementation Unity
+(UIColor *)getColor:(NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
//计算坐标比例X
+(CGFloat)countcoordinatesX:(CGFloat)numberX
{
    CGFloat percentage = numberX / 320;  //百分比
    return [UIScreen mainScreen].bounds.size.width * percentage;
}

//计算坐标比例Y
+(CGFloat)countcoordinatesY:(CGFloat)numberY
{
    //    CGFloat percentage = numberY / 558;
    CGFloat percentage = numberY / 568;  //百分比
    return  [UIScreen mainScreen].bounds.size.height * percentage;
}
+ (BOOL)isPhoneXMax{
    BOOL iPhoneX = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {//判断是否是手机
        return iPhoneX;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneX = YES;
        }
    }
    return iPhoneX;
}
+(CGFloat)countcoordinatesW:(CGFloat)numberW
{
    CGFloat percentage = [UIScreen mainScreen].bounds.size.width / 320;  //百分比
    return numberW * percentage;
}
+(CGFloat)countcoordinatesH:(CGFloat)numberH
{
    CGFloat H = 0.0;
    if ([UIScreen mainScreen].bounds.size.height == 812) {
        H = 667;
    }else if ([UIScreen mainScreen].bounds.size.height == 896){
        H= 736;
    }else{
        H = [UIScreen mainScreen].bounds.size.height;
    }
    CGFloat percentage = H / 568;  //百分比
    return numberH * percentage;
}

+ (UIImageView *)imageviewAddsuperview_superView:(UIView *)superview _subViewFrame:(CGRect)rect _imageName:(NSString *)image _backgroundColor:(UIColor *)color
{
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:rect];
    if(image != nil && image.length>0)
        imageview.image = [UIImage imageNamed:image];
    else if(color != nil)
        imageview.backgroundColor = color;
    [superview addSubview:imageview];
    
    return imageview;
}

+(UILabel *)lableViewAddsuperview_superView:(UIView *)superview _subViewFrame:(CGRect)rect _string:(NSString *)string _lableFont:(UIFont *)font _lableTxtColor:(UIColor *)color _textAlignment:(NSTextAlignment)alignment
{
    UILabel *lable = [[UILabel alloc]initWithFrame:rect];
    lable.backgroundColor = [UIColor clearColor];
    lable.text = string;
    lable.font = font;
    lable.textColor = color;
    lable.textAlignment = alignment;
    [superview addSubview:lable];
    
    return lable;
}
+(UITextField *)textFieldAddSuperview_superView:(UIView *)superview
                                  _subViewFrame:(CGRect)rect
                                        _placeT:(NSString *)placeholder
                               _backgroundImage:(UIImage *)background
                                      _delegate:(id)delegate
                                      andSecure:(BOOL)ture
                             andBackGroundColor:(UIColor *)color
{
    UITextField * textfield = [[UITextField alloc] initWithFrame:rect];
    if (placeholder != nil){
        textfield.placeholder = placeholder;
        
    }
    if (background != nil){
        textfield.background = background;
    }
    textfield.delegate = delegate;
    textfield.secureTextEntry = ture;
    textfield.backgroundColor = color;
    [superview addSubview:textfield];
    return textfield;
}

+(UIButton *)buttonAddsuperview_superView:(UIView *)superview _subViewFrame:(CGRect)rect _tag:(id)viewcontroller _action:(SEL)action _string:(NSString *)string _imageName:(NSString *)image
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    //避免⚠️  null或’‘
    if (![image isEqualToString:@""] && image != nil) {
        [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    [button setTitle:string forState:UIControlStateNormal];
    if(viewcontroller != nil)
        [button addTarget:viewcontroller action:action forControlEvents:UIControlEventTouchUpInside];
    [superview addSubview:button];
    
    return button;
}
//验证手机号
+ (BOOL)validateMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@"" withString:@""];
    
    if (mobile.length !=11) {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))|(198)\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))|(166)\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString * CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))|(199)\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}


+(CGFloat) getLabelHeightWithWidth:(CGFloat)labelWidth andDefaultHeight:(CGFloat)labelDefaultHeight andFontSize:(CGFloat)fontSize andText:(NSString *)text
{
    CGSize constraint = CGSizeMake(labelWidth, 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat labelHeight = MAX(size.height, labelDefaultHeight);
    
    return labelHeight;
}
+ (CGFloat)widthOfString:(NSString *)string OfFontSize:(CGFloat)font OfHeight:(CGFloat)height{
    
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:font]};     //字体属性，设置字体的font
    
    CGSize maxSize = CGSizeMake(MAXFLOAT, height);     //设置字符串的宽高  MAXFLOAT为最大宽度极限值  JPSlideBarHeight为固定高度
    
    CGSize size = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return ceil(size.width);     //此方法结合  预编译字符串  字体font  字符串宽高  三个参数计算文本  返回字符串宽度
}

//登录密码校验  字母 数字 特殊符号 必须同时存在 大小写字母其中一种
+ (BOOL)isSafePassword:(NSString *)strPwd{
//    NSString *passWordRegex = @"^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[~!@#$%^&*()_+-=?/])[a-zA-Z0-9~!@#$%^&*()_+-=?/]{8,16}$";
    NSString * passWordRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z~!@#$%^&*()_+-=?/]{8,16}$";
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordRegex];
    
    if ([regextestcm evaluateWithObject:strPwd] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}
//dic转json
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
// iOS 生成的时间戳是10位
+ (NSString *)timeStamp:(NSString *)time{
//    NSLog(@"%@",time);
    // iOS 生成的时间戳是10位
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[time floatValue]];
    NSString *timeStr=[[self dateFormatWith:@"YYYY-MM-dd HH:mm:ss"] stringFromDate:date];
    
    return timeStr;
    
}
//获取日期格式化器
+ (NSDateFormatter *)dateFormatWith:(NSString *)formatStr {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formatStr];//@"YYYY-MM-dd HH:mm:ss"
    //设置时区
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    return formatter;
}
//计算两个日期之间的天数

+ (NSInteger)calcDaysFromBegin:(NSString *)beginDate end:(NSString *)endDate

{
    
    //创建日期格式化对象
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    
    
    //取两个日期对象的时间间隔：
    
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    
    dateFormatter.dateFormat=@"yyyy-mm-dd HH:mm";//后面的hh:mm:ss不写可以吗?答案不写不可以
    
    //dateFormatter.dateFormat=@"yyyy-MM-dd hh:mm:ss";//转化格式
    
//    NSLog(@"%@",[dateFormatter dateFromString:dateStr]);
    NSTimeInterval time=[[dateFormatter dateFromString:endDate] timeIntervalSinceDate:[dateFormatter dateFromString:beginDate]];
    
    
    
    int days=((int)time)/(3600*24);
    
    //int hours=((int)time)%(3600*24)/3600;
    
    //NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
    
     return days;
}
//币种转换
+ (NSString *)configWithCurrentCurrency:(NSString *)currentCurrency WithTargetCurrency:(NSString *)targetCurrency WithAmount:(NSString *)amount{
    //自定义  日币 jp  人民币 cn  美元 us   台币 tw
    NSString * str;
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"exrate"];
    if ([currentCurrency isEqualToString:@"jp"]) {
        str = [NSString stringWithFormat:@"%.2f",[amount floatValue]*[dic[@"w_tw_jp"] floatValue]];
    }else if ([currentCurrency isEqualToString:@"us"]){
        str = [NSString stringWithFormat:@"%.2f",[amount floatValue]*[dic[@"w_tw_us"] floatValue]];
    }else if ([currentCurrency isEqualToString:@"tw"]){
        
    }
    return str;
}
/**
 *  获取当天的字符串
 *
 *  @return 格式为年-月-日 时分秒
 */
+ (NSString *)getCurrentTimeyyyymmdd {
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dayStr = [formatDay stringFromDate:now];
    
    return dayStr;
}
/**
 *  获取时间差值  截止时间-当前时间
 *  nowDateStr : 当前时间
 *  deadlineStr : 截止时间
 *  @return 时间戳差值
 */
+ (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr {
    
    NSInteger timeDifference = 0;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy-MM-dd HH:mm:ss"];
    NSDate *nowDate = [formatter dateFromString:nowDateStr];
    NSDate *deadline = [formatter dateFromString:deadlineStr];
    NSTimeInterval oldTime = [nowDate timeIntervalSince1970];
    NSTimeInterval newTime = [deadline timeIntervalSince1970];
    timeDifference = newTime - oldTime;
    
    return timeDifference;
}
+ (NSString *)getSmallestUnitOfBid:(NSString *)price{
    NSString * str ;
    if ([price floatValue]<=999) {
        str = @"10";
    }else if ([price floatValue]>=1000 && [price floatValue]<=4999){
        str = @"100";
    }else if ([price floatValue]>=5000 && [price floatValue]<=9999){
        str = @"250";
    }else if ([price floatValue]>=10000 && [price floatValue]<=49999){
        str = @"500";
    }else if ([price floatValue]>=50000){
        str = @"1000";
    }else{
        str = @"0.00";
    }
    return str;
}
+ (NSString *)getSmallestUnitOfBid:(NSString *)price WithCount:(NSString *)count{
    NSString * str ;
    if ([price floatValue]<=0.99) {
        str = @"0.05";
    }else if ([price floatValue]>=1 && [price floatValue]<=4.99){
        str = @"0.25";
    }else if ([price floatValue]>=5 && [price floatValue]<=24.99){
        str = @"0.50";
    }else if ([price floatValue]>=25 && [price floatValue]<=99.99){
        str = @"1.00";
    }else if ([price floatValue]>=100 && [price floatValue]<=249.99){
        str = @"2.50";
    }else if ([price floatValue]>=250.00 && [price floatValue]<=499.99){
        str = @"5.00";
    }else if ([price floatValue]>=500.00 && [price floatValue]<=999.99){
        str = @"10.00";
    }else if ([price floatValue]>=1000.00 && [price floatValue]<=2499.99){
        str = @"25.00";
    }else if ([price floatValue]>=2500.00 && [price floatValue]<=4999.99){
        str = @"50.00";
    }else if ([price floatValue]>=5000.00){
        str = @"100.00";
    }else{
        str = @"0.00";
    }
    if ([count intValue] == 0) {
        str = @"0.00";
    }
    return str;
}
+ (NSString *)editMobile:(NSString *)mobile{
    if (mobile.length != 11) {
        return mobile;
    }else{
        NSString *str1 = [mobile substringToIndex:3];//截取掉下标5之前的字符串
        NSString *str2 = [mobile substringFromIndex:7];//截取掉下标3之后的字符串
        return [NSString stringWithFormat:@"%@****%@",str1,str2];
    }
}
+ (NSString *)editIdCard:(NSString *)idCard{
    NSString *str1 = [idCard substringToIndex:3];
    NSString *str2 = [idCard substringFromIndex:14];
    return [NSString stringWithFormat:@"%@***********%@",str1,str2];
}
//处理字典中 value空字符串
+ (NSDictionary *)deleteNullValue:(NSDictionary *)dic{
    NSMutableDictionary  * dict = [dic mutableCopy];
    NSArray * allkeys = [dict allKeys];
//    NSLog(@"allkeys %@",allkeys);
    for (int i=0; i<allkeys.count; i++) {
        if ([dict[allkeys[i]] isEqualToString:@""]) {
            [dict removeObjectForKey:allkeys[i]];
        }
    }
    return dict;
}
//处理扥估信息
+ (NSMutableDictionary *)editLoginData:(NSDictionary *)dic{
    NSMutableDictionary * mutableDic = [NSMutableDictionary new];
    NSArray * allKeys =[dic allKeys];
    for (int i=0; i<allKeys.count; i++) {
        if ([dic[allKeys[i]] isKindOfClass:[NSNull class]]) {
            [mutableDic setObject:@"" forKey:allKeys[i]];
        }else{
            [mutableDic setObject:dic[allKeys[i]] forKey:allKeys[i]];
        }
    }
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:mutableDic[@"w_mobile"] forKey:@"w_mobile"];
    [dict setObject:mutableDic[@"w_nickname"] forKey:@"w_nickname"];
    [dict setObject:mutableDic[@"w_user"] forKey:@"w_email"];
    [dict setObject:mutableDic[@"id"] forKey:@"member_id"];
    [dict setObject:mutableDic[@"token"] forKey:@"token"];
    [dict setObject:mutableDic[@"w_sex"] forKey:@"w_sex"];
    if ([mutableDic[@"w_born"] isEqualToString:@""]) {
        [dict setObject:@"1985-01-01" forKey:@"w_born"];
    }else{
        [dict setObject:mutableDic[@"w_born"] forKey:@"w_born"];
    }
    [dict setObject:mutableDic[@"w_photo"] forKey:@"w_photo"];
    [dict setObject:mutableDic[@"pay_password"] forKey:@"pay_password"];
    [dict setObject:mutableDic[@"token"] forKey:@"token"];
    [dict setObject:mutableDic[@"w_message"] forKey:@"w_message"];
    [dict setObject:mutableDic[@"w_coins"] forKey:@"w_coins"];
    [dict setObject:mutableDic[@"w_yk_tw"] forKey:@"w_yk_tw"];
    [dict setObject:mutableDic[@"w_remainappear"] forKey:@"w_remainappear"];
    [dict setObject:mutableDic[@"wechat_unionid"] forKey:@"wechat_unionid"];
    [dict setObject:mutableDic[@"wechat_openid"] forKey:@"wechat_openid"];
    
    if([allKeys containsObject:@"auth"]){
        //实名信息
        NSArray * keys = [dic[@"auth"] allKeys];
        NSMutableDictionary * muDic = [NSMutableDictionary new];
        for (int j=0; j<keys.count; j++) {
            if ([dic[@"auth"][keys[j]] isKindOfClass:[NSNull class]]) {
                [muDic setObject:@"" forKey:keys[j]];
            }else{
                [muDic setObject:dic[@"auth"][keys[j]] forKey:keys[j]];
            }
        }
        [dict setObject:muDic[@"back"] forKey:@"back"];
        [dict setObject:muDic[@"front"] forKey:@"front"];
        [dict setObject:muDic[@"num"] forKey:@"num"];
        [dict setObject:muDic[@"name"] forKey:@"name"];
        [dict setObject:muDic[@"mobile"] forKey:@"mobile"];
    }else{
        [dict setObject:@"" forKey:@"back"];
        [dict setObject:@"" forKey:@"front"];
        [dict setObject:@"" forKey:@"num"];
        [dict setObject:@"" forKey:@"name"];
        [dict setObject:@"" forKey:@"mobile"];
    }
    
    return dict;
}
// cell的高度
+(CGFloat)getCellHeight:(NSString*)htmlStr {
    
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding)
                               };
    NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attrStr =  [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
    
    CGFloat attriHeight = [attrStr boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    
    return attriHeight ;
}
/*计算消息时间*/
+ (NSString *)compareCurrentTime:(NSString *)str
{
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    timeInterval = timeInterval - 8*60*60;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

+(void)showanimate{
    UIWindow * window = [UIApplication sharedApplication].windows[0];
    AroundAnimation * aView = [AroundAnimation AroundAnimationViewSetView:window];
    
    [aView startAround];
}
+(void)hiddenanimate{
    UIWindow * window = [UIApplication sharedApplication].windows[0];
    [self getSub:window andLevel:1];
}
// 递归获取子视图
+ (void)getSub:(UIView *)view andLevel:(int)level {
    NSArray *subviews = [view subviews];
    
    // 如果没有子视图就直接返回
    if ([subviews count] == 0) return;
    
    for (UIView *subview in subviews) {
        
        // 根据层级决定前面空格个数，来缩进显示
        NSString *blank = @"";
        for (int i = 1; i < level; i++) {
            blank = [NSString stringWithFormat:@"  %@", blank];
        }
        
        // 打印子视图类名
        //        NSLog(@"%@%d: %@", blank, level, subview.class);
        
        // 递归获取此视图的子视图
        [self getSub:subview andLevel:(level+1)];
        if ([subview.class isSubclassOfClass:[AroundAnimation class]]) {
            // 打印子视图类名
//            NSLog(@"%@%d: %@", blank, level, subview.class);
            [subview removeFromSuperview];
        }
    }
}
+ (NSInteger)getFreightWithWeight:(NSString *)weight WithSteam:(NSString *)steam{
    if ([steam isEqualToString:@"ems"]) {
        if ([weight floatValue]<=0) {
            return 0;
        }else if ([weight floatValue]<=0.3){
            return 900;
        }else if ([weight floatValue]<=0.5){
            return 1400;
        }else if ([weight floatValue]<=0.6){
            return 1540;
        }else if ([weight floatValue]<=0.7){
            return 1680;
        }else if ([weight floatValue]<=0.8){
            return 1820;
        }else if ([weight floatValue]<=0.9){
            return 1960;
        }else if ([weight floatValue]<=1){
            return 2100;
        }else if ([weight floatValue]<=1.25){
            return 2400;
        }else if ([weight floatValue]<=1.5){
            return 2700;
        }else if ([weight floatValue]<=1.75){
            return 3000;
        }else if ([weight floatValue]<=2){
            return 3300;
        }else if ([weight floatValue]<=2.5){
            return 3800;
        }else if ([weight floatValue]<=3){
            return 4300;
        }else if ([weight floatValue]<=3.5){
            return 4800;
        }else if ([weight floatValue]<=4){
            return 5300;
        }else if ([weight floatValue]<=4.5){
            return 5800;
        }else if ([weight floatValue]<=5){
            return 6300;
        }else if ([weight floatValue]<=5.5){
            return 6800;
        }else if ([weight floatValue]<=6){
            return 7300;
        }else if ([weight floatValue]<=7){
            return 8100;
        }else if ([weight floatValue]<=8){
            return 8900;
        }else if ([weight floatValue]<=9){
            return 9700;
        }else if ([weight floatValue]<=10){
            return 10500;
        }else if ([weight floatValue]<=11){
            return 11300;
        }else if ([weight floatValue]<=12){
            return 12100;
        }else if ([weight floatValue]<=13){
            return 12900;
        }else if ([weight floatValue]<=14){
            return 13700;
        }else if ([weight floatValue]<=15){
            return 14500;
        }else if ([weight floatValue]<=16){
            return 15300;
        }else if ([weight floatValue]<=17){
            return 16100;
        }else if ([weight floatValue]<=18){
            return 16900;
        }else if ([weight floatValue]<=19){
            return 17700;
        }else if ([weight floatValue]<=20){
            return 18500;
        }else if ([weight floatValue]<=21){
            return 19300;
        }else if ([weight floatValue]<=22){
            return 20100;
        }else if ([weight floatValue]<=23){
            return 20900;
        }else if ([weight floatValue]<=24){
            return 21700;
        }else if ([weight floatValue]<=25){
            return 22500;
        }else if ([weight floatValue]<=26){
            return 23300;
        }else if ([weight floatValue]<=27){
            return 24100;
        }else if ([weight floatValue]<=28){
            return 24900;
        }else if ([weight floatValue]<=29){
            return 25700;
        }else if ([weight floatValue]<=30){
            return 26500;
        }
    }else if ([steam isEqualToString:@"sal"]){
        if ([weight floatValue]<=0) {
            return 0;
        }else if ([weight floatValue] <= 1){
            return 1800;
        }else if ([weight floatValue] <= 2){
            return 2400;
        }else if ([weight floatValue] <= 3){
            return 3000;
        }else if ([weight floatValue] <= 4){
            return 3600;
        }else if ([weight floatValue] <= 5){
            return 4200;
        }else if ([weight floatValue] <= 6){
            return 4700;
        }else if ([weight floatValue] <= 7){
            return 5200;
        }else if ([weight floatValue] <= 8){
            return 5700;
        }else if ([weight floatValue] <= 9){
            return 6200;
        }else if ([weight floatValue] <= 10){
            return 6700;
        }else if ([weight floatValue] <= 11){
            return 7000;
        }else if ([weight floatValue] <= 12){
            return 7300;
        }else if ([weight floatValue] <= 13){
            return 7600;
        }else if ([weight floatValue] <= 14){
            return 7900;
        }else if ([weight floatValue] <= 15){
            return 8200;
        }else if ([weight floatValue] <= 16){
            return 8500;
        }else if ([weight floatValue] <= 17){
            return 8800;
        }else if ([weight floatValue] <= 18){
            return 9100;
        }else if ([weight floatValue] <= 19){
            return 9400;
        }else if ([weight floatValue] <= 20){
            return 9700;
        }else if ([weight floatValue] <= 21){
            return 10000;
        }else if ([weight floatValue] <= 22){
            return 10300;
        }else if ([weight floatValue] <= 23){
            return 10600;
        }else if ([weight floatValue] <= 24){
            return 10900;
        }else if ([weight floatValue] <= 25){
            return 11200;
        }else if ([weight floatValue] <= 26){
            return 11500;
        }else if ([weight floatValue] <= 27){
            return 11800;
        }else if ([weight floatValue] <= 28){
            return 12100;
        }else if ([weight floatValue] <= 29){
            return 12400;
        }
    }else if ([steam isEqualToString:@"ship"]){
        if ([weight floatValue]<=0) {
            return 0;
        }else if ([weight floatValue] <= 1){
            return 1600;
        }else if ([weight floatValue] <= 2){
            return 1900;
        }else if ([weight floatValue] <= 3){
            return 2200;
        }else if ([weight floatValue] <= 4){
            return 2500;
        }else if ([weight floatValue] <= 5){
            return 2800;
        }else if ([weight floatValue] <= 6){
            return 3100;
        }else if ([weight floatValue] <= 7){
            return 3400;
        }else if ([weight floatValue] <= 8){
            return 3700;
        }else if ([weight floatValue] <= 9){
            return 4000;
        }else if ([weight floatValue] <= 10){
            return 4300;
        }else if ([weight floatValue] <= 11){
            return 4550;
        }else if ([weight floatValue] <= 12){
            return 4800;
        }else if ([weight floatValue] <= 13){
            return 5050;
        }else if ([weight floatValue] <= 14){
            return 5300;
        }else if ([weight floatValue] <= 15){
            return 5550;
        }else if ([weight floatValue] <= 16){
            return 5800;
        }else if ([weight floatValue] <= 17){
            return 6050;
        }else if ([weight floatValue] <= 18){
            return 6300;
        }else if ([weight floatValue] <= 19){
            return 6550;
        }else if ([weight floatValue] <= 20){
            return 6800;
        }else if ([weight floatValue] <= 21){
            return 7050;
        }else if ([weight floatValue] <= 22){
            return 7300;
        }else if ([weight floatValue] <= 23){
            return 7550;
        }else if ([weight floatValue] <= 24){
            return 7800;
        }else if ([weight floatValue] <= 25){
            return 8050;
        }else if ([weight floatValue] <= 26){
            return 8300;
        }else if ([weight floatValue] <= 27){
            return 8550;
        }else if ([weight floatValue] <= 28){
            return 8800;
        }else if ([weight floatValue] <= 29){
            return 9050;
        }else if ([weight floatValue] <= 30){
            return 9300;
        }
    }else{//空港快线按人民币算  折算成当前汇率下的日币进行计算
        NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"exrate"];
        if ([weight floatValue]<=0) {
            return 0;
        }else if ([weight floatValue] <= 0.5){
            return (int)ceilf(51/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 1){
            return (int)ceilf(81/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 1.5){
            return (int)ceilf(112/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 2){
            return (int)ceilf(143/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 2.5){
            return (int)ceilf(174/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 3){
            return (int)ceilf(205/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 3.5){
            return (int)ceilf(235/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 4){
            return (int)ceilf(266/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 4.5){
            return (int)ceilf(297/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 5){
            return (int)ceilf(328/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 5.5){
            return (int)ceilf(359/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 6){
            return (int)ceilf(389/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 6.5){
            return (int)ceilf(420/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 7){
            return (int)ceilf(451/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 7.5){
            return (int)ceilf(482/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 8){
            return (int)ceilf(512/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 8.5){
            return (int)ceilf(543/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 9){
            return (int)ceilf(574/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 9.5){
            return (int)ceilf(605/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 10){
            return (int)ceilf(636/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 11){
            return (int)ceilf(696/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 12){
            return (int)ceilf(759/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 13){
            return (int)ceilf(820/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 14){
            return (int)ceilf(882/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 15){
            return (int)ceilf(943/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 16){
            return (int)ceilf(1005/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 17){
            return (int)ceilf(1066/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 18){
            return (int)ceilf(1128/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 19){
            return (int)ceilf(1190/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 20){
            return (int)ceilf(1251/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 21){
            return (int)ceilf(1313/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 22){
            return (int)ceilf(1374/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 23){
            return (int)ceilf(1436/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 24){
            return (int)ceilf(1497/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 25){
            return (int)ceilf(1559/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 26){
            return (int)ceilf(1620/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 27){
            return (int)ceilf(1682/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 28){
            return (int)ceilf(1744/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 29){
            return (int)ceilf(1805/[dic[@"w_tw_jp"] floatValue]);
        }else if ([weight floatValue] <= 30){
            return (int)ceilf(1867/[dic[@"w_tw_jp"] floatValue]);
        }
    }
    return 0;
}
//将数组转换成json格式字符串,不含\n这些符号

+ (NSString *)gs_jsonStringCompactFormatForNSArray:(NSArray *)arrJson {
    if (![arrJson isKindOfClass:[NSArray class]] || ![NSJSONSerialization isValidJSONObject:arrJson]) {
        return nil;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arrJson options:0 error:nil];
    NSString *strJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return strJson;
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
}
#pragma mark - 将某个时间转化成 时间戳   时间字符串  时间格式  时区
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format andForTimeZone:(NSString *)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:time];//Asia/tokyo Asia/Beijing
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
//    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    return timeSp;
}
//防止 字典set数据的时候  存在null 封装一个方法避免崩溃
+ (NSMutableDictionary *)setKey:(NSString *)key WithValue:(NSString *)value WithDic:(NSMutableDictionary *)dic{
    if ([value isKindOfClass:[NSNull class]]) {
        [dic setObject:@"" forKey:key];
        return dic;
    }else{
        [dic setObject:value forKey:key];
        return dic;
    }
}
+ (NSString *)getLanguage{
    NSString * udfLanguageCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"][0];
//    NSLog(@"%@",udfLanguageCode);
    if ([udfLanguageCode isEqualToString:@"zh-Hans-CN"]) {
        return @"zh_CN";
    }else{
        return @"zh_TW";
    }
}
+ (NSString *)getState:(NSInteger)state WithPage:(NSInteger)page{
    if (page == 1) {
        if (state == 0) {
            return @"被超价";
        }else if (state == 2){
            return @"购买成功";
        }else if (state == 13){
            return @"无法出价";
        }else if (state == 14){
            return @"提前结束";
        }else if (state == 15){
            return @"被直购";
        }else if (state == 16){
            return @"出价被取消";
        }else{
            return @"进行中";
        }
    }else if (page == 2){
        if (state == 0) {
            return @"被超价";
        }else if (state == 1){
            return @"进行中";
        }else if (state == 13){
            return @"无法出价";
        }else if (state == 14){
            return @"提前结束";
        }else if (state == 15){
            return @"被直购";
        }else if (state == 16){
            return @"出价被取消";
        }else{
            return @"购买成功";
        }
    }else{
        if (state == 0) {
            return @"被超价";
        }else if (state == 1){
            return @"进行中";
        }else if (state == 2){
            return @"购买成功";
        }else if (state == 13){
            return @"无法出价";
        }else if (state == 14){
            return @"提前结束";
        }else if (state == 15){
            return @"被直购";
        }else if (state == 16){
            return @"出价被取消";
        }else{
            return @"购买失败";
        }
    }
}
+ (NSString *)parcelNumber:(NSInteger)num{
    if (num == 140) {
        return @"确认发货 待审核";
    }else if (num == 150){
        return @"待仓库确认";
    }else if (num == 160){
        return @"待付运费";
    }else if (num == 170){
        return @"已付待发出";
    }else if (num == 180){
        return @"仓库已发货";
    }else if (num == 190){
        return @"待付关税";
    }else if (num == 200){
        return @"确认退回";
    }else if (num == 210){
        return @"退回到仓";
    }else if (num == 212){
        return @"已收货";
    }else{
        return @"已转单";
    }
}
//字典中所有null改成@""
+ (NSMutableDictionary *)nullDicToDic:(NSDictionary *)dic{
    
    NSMutableDictionary *resultDic = [@{} mutableCopy];
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return resultDic;
    }
    for (NSString *key in [dic allKeys]) {
        if ([(id)[dic objectForKey:key] isKindOfClass:[NSNull class]]) {
            [resultDic setValue:@"" forKey:key];
        }else{
            [resultDic setValue:[dic objectForKey:key] forKey:key];
        }
    }
    return resultDic;
}
//新委托单状态
+ (NSString *)getStatus:(NSString *)status{
    NSInteger state = [status intValue];
    switch (state) {
        case 10:
            return @"委托单审核中";
            break;
        case 30:
            return @"定金待支付";
            break;
        case 40:
            return @"竞价中";
            break;
        case 50:
            return @"无法出价";
            break;
        case 60:
            return @"出价被取消";
            break;
        case 70:
            return @"出价被超过";
            break;
        case 80:
            return @"提前结束";
            break;
        case 90:
            return @"被直购";
            break;
        case 100:
            return @"流标";
            break;
        case 110:
            return @"已得标";
            break;
        case 115:
            return @"已得标";
            break;
        case 120:
            return @"得标已付款";
            break;
        case 123:
            return @"海外待汇款";
            break;
        case 125:
            return @"海外已付款";
            break;
        case 127:
            return @"待到仓";
            break;
        case 130:
            return @"海外已收货";
            break;
        case 140:
            return @"海外已发货";
            break;
        case 220:
            return @"已收货";
            break;
        default:
            break;
    }
    return @"";
}
//判断后台返回图片的类型 进行图片取其中1个
+ (NSString *)get_image:(id)image{
    if ([image isKindOfClass:[NSDictionary class]]) {//字典
        NSArray * arr = [image allKeys];
        return image[arr[0]];
    }else if ([image isKindOfClass:[NSNull class]]){//null
        return @"";
    }else if ([image isKindOfClass:[NSArray class]]){//数组
        if ([image count] ==0) {
            return @"";
        }else{
            return image[0];
        }
    }else{//json
        NSArray * arr = [[Unity dictionaryWithJsonString:image] allKeys];
        return [Unity dictionaryWithJsonString:image][arr[0]];
    }
}
+ (NSString *)get_HaitaoStatusId:(NSString *)status{
    switch ([status intValue]) {
        case 10:
            return @"委托审核中";
            break;
        case 115:
            return @"报价待支付";
        break;
        case 120:
            return @"订单已支付";
        break;
        case 123:
            return @"订单已支付";
        break;
        case 125:
            return @"订单已采购";
        break;
        case 127:
            return @"订单运输中";
        break;
        case 130:
            return @"海外已收货";
        break;
        case 140:
            return @"订单已退运";
        break;
        case 410:
            return @"委托已取消";
        break;
        case 420:
            return @"委托已失效";
        break;
        case 430:
            return @"委托已退款";
        break;
        case 220:
            return @"包裹已签收";
        break;
        
        default:
            return @"";
            break;
    }
}
@end

