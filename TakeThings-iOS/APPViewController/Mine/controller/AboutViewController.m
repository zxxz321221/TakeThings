
//
//  AboutViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/8/19.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "AboutViewController.h"
#define bh (IS_iPhoneX ? [Unity countcoordinatesH:40] : [Unity countcoordinatesH:20])
@interface AboutViewController ()
@property (nonatomic , strong) UIImageView * backImg;
@property (nonatomic , strong) UIImageView * appIcon;
@property (nonatomic , strong) UILabel * version;
@property (nonatomic , strong) UILabel * markL;
@property (nonatomic , strong) UILabel * dunsL;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title= @"版本信息";
    [self createUI];
}
- (void)createUI{
    [self.view addSubview:self.backImg];
    [self.view addSubview:self.appIcon];
    [self.view addSubview:self.version];
    [self.view addSubview:self.markL];
    [self.view addSubview:self.dunsL];
}
- (UIImageView *)backImg{
    if (!_backImg) {
        _backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight)];
        _backImg.image = [UIImage imageNamed:@"背景"];
    }
    return _backImg;
}
- (UIImageView *)appIcon{
    if (!_appIcon) {
        _appIcon = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-[Unity countcoordinatesW:90])/2, [Unity countcoordinatesH:160], [Unity countcoordinatesW:90], [Unity countcoordinatesH:90])];
        _appIcon.image = [UIImage imageNamed:@"appicon"];
    }
    return _appIcon;
}
- (UILabel *)version{
    if (!_version) {
        _version = [[UILabel alloc]initWithFrame:CGRectMake(0, _appIcon.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH, [Unity countcoordinatesH:15])];
        _version.text = [NSString stringWithFormat:@"版本号：%@",self.app_version];
        _version.textColor = LabelColor3;
        _version.font = [UIFont systemFontOfSize:FontSize(14)];
        _version.textAlignment = NSTextAlignmentCenter;
    }
    return _version;
}
- (UILabel *)markL{
    if (!_markL) {
        _markL = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NavBarHeight-bh-[Unity countcoordinatesH:35], SCREEN_WIDTH, [Unity countcoordinatesH:15])];
        _markL.text = @"全球闲置品交易讯息服务凭条";
        _markL.textColor = LabelColor3;
        _markL.font = [UIFont systemFontOfSize:FontSize(12)];
        _markL.textAlignment = NSTextAlignmentCenter;
    }
    return _markL;
}
- (UILabel *)dunsL{
    if (!_dunsL) {
        _dunsL = [[UILabel alloc]initWithFrame:CGRectMake(0, _markL.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:15])];
        _dunsL.text = @"Copyright @2011-2019 Shaogood.com All Rights Reserved";
        _dunsL.textColor = LabelColor3;
        _dunsL.font = [UIFont systemFontOfSize:FontSize(8)];
        _dunsL.textAlignment = NSTextAlignmentCenter;
    }
    return _dunsL;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
