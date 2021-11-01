
//
//  BidIdCardViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/6/3.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "BidIdCardViewController.h"
//#import "JPhotoMagenage.h"
#import "IDCardCaptureViewController.h"
#import "TIDCardCaptureViewController.h"
#import "UIViewController+YINNav.h"
@interface BidIdCardViewController ()<TIDCardDelegate,IDCardCaptureDelegate>
{
    BOOL isPositive;//yes正面 no反面
}
@property (nonatomic , strong) UILabel * idCardL;
@property (nonatomic , strong) UIView * idCardView;
@property (nonatomic , strong) UILabel * markL;//身份证照片上方提示语
@property (nonatomic , strong) UIImageView * positiveImg;//身份证正面
@property (nonatomic , strong) UIImageView * reverseImg;//身份证反面

@property (nonatomic , strong) UILabel *positiveL;//身份证正面+号
@property (nonatomic , strong) UILabel *reverseL;//反面
@property (nonatomic , strong) UILabel *posimgL;//正面 上传照片文字
@property (nonatomic , strong) UILabel *revimgL;//反面

@property (nonatomic , strong) UILabel * whyL;//页面最下方2个label
@property (nonatomic , strong) UILabel * explainL;
@end

@implementation BidIdCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.y_navLineHidden = YES;
    [self setupUI];
    if (self.isEdit) {
        NSLog(@"%@",self.addressDic);
        NSString *urlString = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"],self.addressDic[@"idcard"][@"front"]];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        UIImage *image = [UIImage imageWithData:data]; // 取得图片
        self.positiveImg.image = image;
        self.posimgL.hidden = YES;
        self.positiveL.hidden = YES;
        NSString *path_sandox = NSHomeDirectory();
        NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/zheng.png"];
        //        NSLog(@"%@",imagePath);
        [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
        
        NSString *urlString1 = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"],self.addressDic[@"idcard"][@"back"]];
        NSData *data1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString1]];
        UIImage *image1 = [UIImage imageWithData:data1]; // 取得图片
        self.reverseImg.image = image1;
        self.reverseL.hidden= YES;
        self.revimgL.hidden=YES;
        NSString *path_sandox1 = NSHomeDirectory();
        NSString *imagePath1 = [path_sandox1 stringByAppendingString:@"/Documents/fan.png"];
        [UIImagePNGRepresentation(image1) writeToFile:imagePath1 atomically:YES];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"身份证绑定";
    [self addRightBarButtonItemWithTitle:@"完成" action:@selector(confimClick)];
}
//右侧为文字item的情况
- (void)addRightBarButtonItemWithTitle:(NSString *)itemTitle action:(SEL)action
{
    
    UIButton *rightbBarButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 88, 44)];
    [rightbBarButton setTitle:itemTitle forState:(UIControlStateNormal)];
    [rightbBarButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    rightbBarButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightbBarButton addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    rightbBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightbBarButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5 * SCREEN_WIDTH/375.0)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightbBarButton];
}
- (void)setupUI{
    [self.view addSubview:self.idCardL];
    [self.view addSubview:self.idCardView];
    [self.view addSubview:self.whyL];
    [self.view addSubview:self.explainL];
}
- (UILabel *)idCardL{
    if (!_idCardL) {
        _idCardL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:40])];
        _idCardL.text = @"   身份证正反面照片（必填）";
        _idCardL.backgroundColor = [Unity getColor:@"#f0f0f0"];
        _idCardL.textColor = LabelColor3;
        _idCardL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _idCardL;
}
- (UIView *)idCardView{
    if (!_idCardView) {
        _idCardView = [[UIView alloc]initWithFrame:CGRectMake(0, _idCardL.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:270])];
        _idCardView.backgroundColor = [UIColor whiteColor];
        
        _markL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:40])];
        _markL.numberOfLines = 0;
        _markL.backgroundColor = [UIColor whiteColor];
        _markL.text = @"温馨提示：请上传原始比例的身份证正反面，请勿剪裁涂改，保证身份证信息清晰显示，否则无法通过审核";
        _markL.textColor = LabelColor6;
        _markL.font = [UIFont systemFontOfSize:FontSize(12)];
        [_idCardView addSubview:_markL];
        
        [_idCardView addSubview:self.positiveImg];
        [_idCardView addSubview:self.reverseImg];
        
        NSArray * arr =@[@"图层2",@"图层1"];
        for (int i=0; i<2; i++) {
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(i*(SCREEN_WIDTH/2), _reverseImg.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH/2, [Unity countcoordinatesH:10])];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = @"示例";
            label.textColor = LabelColor6;
            label.font = [UIFont systemFontOfSize:FontSize(12)];
            [_idCardView addSubview:label];
            UIImageView * imageView = [Unity imageviewAddsuperview_superView:_idCardView _subViewFrame:CGRectMake(i*(SCREEN_WIDTH/2)+[Unity countcoordinatesW:25], label.bottom+[Unity countcoordinatesH:10], [Unity countcoordinatesW:110], [Unity countcoordinatesH:70]) _imageName:arr[i] _backgroundColor:nil];
            imageView.backgroundColor = [UIColor clearColor];
        }
        
        
    }
    return _idCardView;
}
- (UIImageView *)positiveImg{
    if (!_positiveImg) {
        _positiveImg = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _markL.bottom+[Unity countcoordinatesH:10], (SCREEN_WIDTH-[Unity countcoordinatesW:40])/2, [Unity countcoordinatesH:90])];
        CALayer * layer = [_positiveImg layer];
        layer.borderColor = [[Unity getColor:@"#f0f0f0"] CGColor];
        layer.borderWidth = 2.0f;
        UITapGestureRecognizer *singleTap =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerAction:)];
        singleTap.numberOfTapsRequired = 1; //点击次数
        singleTap.numberOfTouchesRequired = 1; //点击手指数
        [_positiveImg addGestureRecognizer:singleTap];
        UIView *tapView1 = [singleTap view];
        tapView1.tag = 1000;
        _positiveImg.userInteractionEnabled = YES;
        
        _positiveL = [Unity lableViewAddsuperview_superView:_positiveImg _subViewFrame:CGRectMake(0, [Unity countcoordinatesH:15], _positiveImg.width, [Unity countcoordinatesH:20]) _string:@"+" _lableFont:[UIFont systemFontOfSize:30] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentCenter];
        _posimgL = [Unity lableViewAddsuperview_superView:_positiveImg _subViewFrame:CGRectMake(0, _positiveL.bottom+[Unity countcoordinatesH:10], _positiveL.width, [Unity countcoordinatesH:30]) _string:@"上传照片" _lableFont:[UIFont systemFontOfSize:FontSize(18)] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentCenter];
    }
    return _positiveImg;
}
- (UIImageView *)reverseImg{
    if (!_reverseImg) {
        _reverseImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+[Unity countcoordinatesW:10], _markL.bottom+[Unity countcoordinatesH:10], (SCREEN_WIDTH-[Unity countcoordinatesW:40])/2, [Unity countcoordinatesH:90])];
        CALayer * layer1 = [_reverseImg layer];
        layer1.borderColor = [[Unity getColor:@"#f0f0f0"] CGColor];
        layer1.borderWidth = 2.0f;
        UITapGestureRecognizer *singleTap =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerAction:)];
        singleTap.numberOfTapsRequired = 1; //点击次数
        singleTap.numberOfTouchesRequired = 1; //点击手指数
        [_reverseImg addGestureRecognizer:singleTap];
        UIView *tapView1 = [singleTap view];
        tapView1.tag = 1001;
        _reverseImg.userInteractionEnabled = YES;
        
        _reverseL = [Unity lableViewAddsuperview_superView:_reverseImg _subViewFrame:CGRectMake(0, [Unity countcoordinatesH:15], _positiveImg.width, [Unity countcoordinatesH:20]) _string:@"+" _lableFont:[UIFont systemFontOfSize:30] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentCenter];
        _revimgL = [Unity lableViewAddsuperview_superView:_reverseImg _subViewFrame:CGRectMake(0, _reverseL.bottom+[Unity countcoordinatesH:10], _reverseL.width, [Unity countcoordinatesH:30]) _string:@"上传照片" _lableFont:[UIFont systemFontOfSize:FontSize(18)] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentCenter];
    }
    return _reverseImg;
}
- (UILabel *)whyL{
    if (!_whyL) {
        _whyL = [[UILabel alloc]initWithFrame:CGRectMake(0, _idCardView.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:40])];
        _whyL.backgroundColor = [Unity getColor:@"#f0f0f0"];
        _whyL.text = @"为什么需要实名认证";
        _whyL.font = [UIFont systemFontOfSize:FontSize(14)];
        _whyL.textColor = LabelColor6;
        _whyL.textAlignment = NSTextAlignmentCenter;
    }
    return _whyL;
}
- (UILabel *)explainL{
    if (!_explainL) {
        _explainL = [[UILabel alloc]initWithFrame:CGRectMake(0, _whyL.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        _explainL.backgroundColor = [Unity getColor:@"#f0f0f0"];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], 0, SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:30])];
        label.text = @"实名购物也是您权利的保障，也是中国海关对跨境购物包裹收件人信息一致需求。";
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:FontSize(12)];
        label.textColor = LabelColor6;
        label.textAlignment = NSTextAlignmentLeft;
        [_explainL addSubview:label];
    }
    return _explainL;
}
- (void)headerAction:(UITapGestureRecognizer *)tapGesture{
    NSLog(@"img = %ld",(long)tapGesture.view.tag);
    if (tapGesture.view.tag == 1000) {
//        isPositive = YES;
        IDCardCaptureViewController *idcvc = [[IDCardCaptureViewController alloc]init];
        idcvc.delegate=self;
        [self.navigationController pushViewController:idcvc animated:YES];
    }else{
        TIDCardCaptureViewController *idcvc = [[TIDCardCaptureViewController alloc]init];
        idcvc.delegate = self;
        [self.navigationController pushViewController:idcvc animated:YES];
//        isPositive = NO;
    }
//    [self photo:isPositive];
}
- (void)backIDInfo:(IDInfo *)idInfo WithImg:(UIImage *)img{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.reverseImg.image = img;
        self.reverseL.hidden= YES;
        self.revimgL.hidden=YES;
        NSString *path_sandox = NSHomeDirectory();
        NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/fan.png"];
        [UIImagePNGRepresentation(img) writeToFile:imagePath atomically:YES];
    });
    
}
- (void)backIDCardInfo:(IDInfo *)idInfo WithImg:(UIImage *)img{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.positiveImg.image = img;
        self.posimgL.hidden = YES;
        self.positiveL.hidden = YES;
        NSString *path_sandox = NSHomeDirectory();
        NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/zheng.png"];
        //        NSLog(@"%@",imagePath);
        [UIImagePNGRepresentation(img) writeToFile:imagePath atomically:YES];
    });
}
//- (void)photo:(BOOL)positive{
//    [JPhotoMagenage getOneImageInController:self finish:^(UIImage *images) {
//
//        //            NSLog(@"%@",images);
//
//        NSData *data =UIImageJPEGRepresentation(images, 0.5);
//        UIImage *img = [UIImage imageWithData:data];
//        //            NSString *imgName = UserDefaultObjectForKey(USERTOKEN);
//
//        //            NSString *path_sandox = NSHomeDirectory();
//
//        //            NSString *imagePath = [path_sandox stringByAppendingString:[NSString stringWithFormat: @"/Documents/%@.png",imgName]];
//
//        //            [UIImagePNGRepresentation(img) writeToFile:imagePath atomically:YES];
//
//        if (positive) {
//            self.positiveImg.image = img;
//            self.posimgL.hidden = YES;
//            self.positiveL.hidden = YES;
//        }else{
//            self.reverseImg.image = img;
//            self.reverseL.hidden= YES;
//            self.revimgL.hidden=YES;
//        }
//
//
//
//        //            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        //            hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
//        //            hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
//        //            hud.label.text= NSLocalizedString(@"正在上传", nil);
//        //
//        //            NSDictionary *api_token = UserDefaultObjectForKey(USERTOKEN);;
//        //            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        //
//        //            NSData *dataAvatar;
//        //            if (UIImagePNGRepresentation(_phImage) == nil) {
//        //
//        //                dataAvatar = UIImageJPEGRepresentation(images, 1);
//        //
//        //            } else {
//        //
//        //                dataAvatar = UIImagePNGRepresentation(images);
//        //            }
//    } cancel:^{
//
//    }];
//}
- (void)confimClick{
    if (self.posimgL.hidden == NO) {
        [WHToast showMessage:@"请上传身份证正面" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
        return;
    }
    if (self.reverseL.hidden == NO) {
        [WHToast showMessage:@"请上传身份证反面" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:1 finishHandler:^{}];
        return;
    }
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"idCard" object:nil];
    NSInteger index = (NSInteger)[[self.navigationController viewControllers] indexOfObject:self];
    if (index > 2) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index-2)] animated:YES];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
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
