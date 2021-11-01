//
//  RealNameViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/29.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "RealNameViewController.h"
//#import "JPhotoMagenage.h"
#import "IDCardCaptureViewController.h"
#import "TIDCardCaptureViewController.h"
#import "UIViewController+YINNav.h"
@interface RealNameViewController ()<TIDCardDelegate,IDCardCaptureDelegate>
{
    BOOL isPositive;//yes正面 no反面
    UIButton *rightbBarButton;
}
@property (nonatomic , strong) UIScrollView * scrollView;
@property (nonatomic , strong) UILabel * identityInfo;
@property (nonatomic , strong) UITextField * nameText;
@property (nonatomic , strong) UITextField * idCardNumber;
@property (nonatomic , strong) UILabel * mobileL;
@property (nonatomic , strong) UITextField * mobileText;
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
@property (nonatomic , strong) AroundAnimation * aAnimation;

@end

@implementation RealNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.y_navLineHidden = YES;
    [self.navigationItem setTitle:@"实名认证"];
    
    [self creareUI];
    if (self.isReal) {
        [self reloadUI];
    }
}
- (void)creareUI{
    _scrollView = [UIScrollView new];
//    _scrollView.delegate=self;
    _scrollView.showsVerticalScrollIndicator = FALSE;
    _scrollView.showsHorizontalScrollIndicator = FALSE;
    [self.view addSubview:_scrollView];
    _scrollView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }//解决导航栏设置透明的情况下 scrollView发生偏移的问题：
    
    [self.scrollView addSubview:self.identityInfo];
    [self.scrollView addSubview:self.nameText];
    [self.scrollView addSubview:self.idCardNumber];
    [self.scrollView addSubview:self.mobileL];
    [self.scrollView addSubview:self.mobileText];
    [self.scrollView addSubview:self.idCardL];
    [self.scrollView addSubview:self.idCardView];
    [self.scrollView addSubview:self.whyL];
    [self.scrollView addSubview:self.explainL];
    
    /*将ui添加到scrollView数组中*/
    [self.scrollView sd_addSubviews:@[self.identityInfo,self.nameText,self.idCardNumber,self.mobileL,self.mobileText,self.idCardL,self.idCardView,self.whyL,self.explainL]];
    
    // scrollview自动contentsize
    [self.scrollView setupAutoContentSizeWithBottomView:self.explainL bottomMargin:[Unity countcoordinatesH:30]];
}
- (void)reloadUI{
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    self.nameText.placeholder = userInfo[@"name"];
//    self.nameText.text = userInfo[@"name"];
//    self.nameText.enabled = NO;
    self.idCardNumber.placeholder = [Unity editIdCard:userInfo[@"num"]];
//    self.idCardNumber.text = userInfo[@"num"];
//    self.idCardNumber.enabled = NO;
    self.mobileText.placeholder = [Unity editMobile:userInfo[@"mobile"]];
//    self.mobileText.text = userInfo[@"mobile"];
//    self.mobileText.enabled = NO;
    //反面
    [self.reverseImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"],userInfo[@"back"]]]];
    self.reverseL.hidden= YES;
    self.revimgL.hidden=YES;
//    self.reverseImg.userInteractionEnabled = NO;
    //正面
    [self.positiveImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"],userInfo[@"front"]]]];
    self.posimgL.hidden = YES;
    self.positiveL.hidden = YES;
//    self.positiveImg.userInteractionEnabled = NO;
}
- (UILabel *)identityInfo{
    if (!_identityInfo) {
        _identityInfo = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:40])];
//        _identityInfo.backgroundColor = [Unity getColor:@"#f0f0f0"];
        _identityInfo.text = @"   身份信息";
        _identityInfo.textColor = LabelColor3;
        _identityInfo.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _identityInfo;
}
- (UITextField *)nameText{
    if (!_nameText) {
        _nameText = [[UITextField alloc]initWithFrame:CGRectMake(0, _identityInfo.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        _nameText.backgroundColor = [UIColor whiteColor];
        _nameText.placeholder = @"您的真实姓名";
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [Unity countcoordinatesW:10], 0)];
        leftView.backgroundColor = [UIColor clearColor];
        // 保证点击缩进的view，也可以调出光标
//        leftView.userInteractionEnabled = NO;
        _nameText.leftView = leftView;
        _nameText.leftViewMode = UITextFieldViewModeAlways;
        _nameText.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _nameText;
}
- (UITextField *)idCardNumber{
    if (!_idCardNumber) {
        _idCardNumber = [[UITextField alloc]initWithFrame:CGRectMake(0, _nameText.bottom+1, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        _idCardNumber.backgroundColor = [UIColor whiteColor];
        _idCardNumber.placeholder = @"您的身份证号码";
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [Unity countcoordinatesW:10], 0)];
        leftView.backgroundColor = [UIColor clearColor];
        // 保证点击缩进的view，也可以调出光标
//        leftView.userInteractionEnabled = NO;
        _idCardNumber.leftView = leftView;
        _idCardNumber.leftViewMode = UITextFieldViewModeAlways;
        _idCardNumber.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _idCardNumber;
}
- (UILabel *)mobileL{
    if (!_mobileL) {
        _mobileL = [[UILabel alloc]initWithFrame:CGRectMake(0, _idCardNumber.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:40])];
        _mobileL.text = @"   手机号";
        _mobileL.textColor = LabelColor3;
        _mobileL.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _mobileL;
}
- (UITextField *)mobileText{
    if (!_mobileText) {
        _mobileText = [[UITextField alloc]initWithFrame:CGRectMake(0, _mobileL.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        _mobileText.backgroundColor = [UIColor whiteColor];
        _mobileText.placeholder = @"请填写您的手机号";
        _mobileText.keyboardType = UIKeyboardTypeNumberPad;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [Unity countcoordinatesW:10], 0)];
        leftView.backgroundColor = [UIColor clearColor];
        // 保证点击缩进的view，也可以调出光标
//        leftView.userInteractionEnabled = NO;
        _mobileText.leftView = leftView;
        _mobileText.leftViewMode = UITextFieldViewModeAlways;
        _mobileText.font = [UIFont systemFontOfSize:FontSize(12)];
    }
    return _mobileText;
}
- (UILabel *)idCardL{
    if (!_idCardL) {
        _idCardL = [[UILabel alloc]initWithFrame:CGRectMake(0, _mobileText.bottom, SCREEN_WIDTH, [Unity countcoordinatesH:40])];
        _idCardL.text = @"   身份证正反面照片";
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
        _whyL = [[UILabel alloc]initWithFrame:CGRectMake(0, _idCardView.bottom+[Unity countcoordinatesH:13], SCREEN_WIDTH, [Unity countcoordinatesH:20])];
        _whyL.text = @"为什么需要实名认证";
        _whyL.font = [UIFont systemFontOfSize:FontSize(14)];
        _whyL.textColor = LabelColor6;
        _whyL.textAlignment = NSTextAlignmentCenter;
    }
    return _whyL;
}
- (UILabel *)explainL{
    if (!_explainL) {
        _explainL = [[UILabel alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _whyL.bottom+[Unity countcoordinatesH:12], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:30])];
        _explainL.text = @"实名购物也是您权利的保障，也是中国海关对跨境购物包裹收件人信息一致需求。";
        _explainL.numberOfLines = 0;
        _explainL.font = [UIFont systemFontOfSize:FontSize(12)];
        _explainL.textColor = LabelColor6;
        _explainL.textAlignment = NSTextAlignmentLeft;
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
        NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/back.png"];
        [UIImagePNGRepresentation(img) writeToFile:imagePath atomically:YES];
    });
    
}
- (void)backIDCardInfo:(IDInfo *)idInfo WithImg:(UIImage *)img{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.positiveImg.image = img;
        self.posimgL.hidden = YES;
        self.positiveL.hidden = YES;
        NSString *path_sandox = NSHomeDirectory();
        NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/front.png"];
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
//            NSString *path_sandox = NSHomeDirectory();
//            NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/front.png"];
//            NSLog(@"%@",imagePath);
//            [UIImagePNGRepresentation(images) writeToFile:imagePath atomically:YES];
//        }else{
//            self.reverseImg.image = img;
//            self.reverseL.hidden= YES;
//            self.revimgL.hidden=YES;
//            NSString *path_sandox = NSHomeDirectory();
//            NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/back.png"];
//            [UIImagePNGRepresentation(images) writeToFile:imagePath atomically:YES];
//        }
//    } cancel:^{
//
//    }];
//}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [Unity getColor:@"#f0f0f0"];
    [self addRightBarButtonItemWithTitle:@"保存" action:@selector(addClick)];
}
- (void)addClick{
//    if (self.isReal) {
//        return;
//    }
//    if ([self.nameText.text isEqualToString:@""] || [self.idCardNumber.text isEqualToString:@""] || [self.mobileText.text isEqualToString:@""] || self.posimgL.hidden==NO || self.reverseL.hidden == NO) {
//        [WHToast showMessage:@"信息填写不完整" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
//        return;
//    }
    BOOL isPhoto = YES;
    if ((self.posimgL.hidden==NO && self.reverseL.hidden == YES) || (self.posimgL.hidden==YES && self.reverseL.hidden == NO)) {
        [WHToast showMessage:@"请选择上传照片" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        isPhoto = NO;
        if ([self.nameText.text isEqualToString:@""] && [self.idCardNumber.text isEqualToString:@""] && [self.mobileText.text isEqualToString:@""]) {
            return;
        }
    }
    [self.aAnimation startAround];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSData *data;
    NSData *dataB;
    if (isPhoto) {
        
        if (1) {
            data = UIImageJPEGRepresentation(self.positiveImg.image, 0.1);
        } else {
            
            data = UIImagePNGRepresentation(self.positiveImg.image);
        }
        
        
        if (1) {
            
            dataB = UIImageJPEGRepresentation(self.reverseImg.image, 0.1);
            
        } else {
            
            dataB = UIImagePNGRepresentation(self.reverseImg.image);
        }
    }
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    NSDictionary *params = @{@"customer":userInfo[@"member_id"],@"name":self.nameText.text,@"num":self.idCardNumber.text,@"mobile":self.mobileText.text};
    params = [Unity deleteNullValue:params];
    NSLog(@"实名修改 %@",params);
    [manager POST:[GZMUrl get_realName_url] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (isPhoto) {
            [formData appendPartWithFileData:data name:@"front" fileName:@"front.png" mimeType:@"image/png"];
            [formData appendPartWithFileData:dataB name:@"back" fileName:@"back.png" mimeType:@"image/png"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.aAnimation stopAround];
        if ([responseObject[@"code"]isEqualToString:@"success"]) {
            NSLog(@"实名成功 %@",responseObject);
            NSMutableDictionary * muDic = [userInfo mutableCopy];
            if ([responseObject[@"data"] count] !=0) {
                [muDic setObject:responseObject[@"data"][0] forKey:@"back"];
                [muDic setObject:responseObject[@"data"][1] forKey:@"front"];
            }
            if (![self.nameText.text isEqualToString:@""]) {
                [muDic setObject:self.nameText.text forKey:@"name"];
            }
            if (![self.idCardNumber.text isEqualToString:@""]) {
                [muDic setObject:self.idCardNumber.text forKey:@"num"];
            }
            if (![self.mobileText.text isEqualToString:@""]) {
                [muDic setObject:self.mobileText.text forKey:@"mobile"];
            }
            [[NSUserDefaults standardUserDefaults]setObject:muDic forKey:@"userInfo"];
            
            [WHToast showMessage:[responseObject objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
           [WHToast showMessage:[responseObject objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.aAnimation stopAround];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
//右侧为文字item的情况
- (void)addRightBarButtonItemWithTitle:(NSString *)itemTitle action:(SEL)action
{
    
    rightbBarButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 88, 44)];
    [rightbBarButton setTitle:itemTitle forState:(UIControlStateNormal)];
    [rightbBarButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    rightbBarButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightbBarButton addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    rightbBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightbBarButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5 * SCREEN_WIDTH/375.0)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightbBarButton];
}
- (AroundAnimation *)aAnimation{
    if (!_aAnimation) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _aAnimation = [AroundAnimation AroundAnimationViewSetView:window];
    }
    return _aAnimation;
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
