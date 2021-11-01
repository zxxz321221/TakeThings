//
//  InfoViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/4/25.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "InfoViewController.h"
#import "SLDatePicker.h"
#import "JPhotoMagenage.h"
#import "RealNameViewController.h"
#import "BoundViewController.h"
#import "InterestViewController.h"
#import "baseViewController.h"
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "GzmPhotoViewController.h"
#import <Masonry.h>
#import "UIViewController+YINNav.h"
#define ORIGINAL_MAX_WIDTH 640.0f
@interface InfoViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, VPImageCropperDelegate>
{
    BOOL isMan; //yes 男 no 女
    UIButton * manImg;
    UIButton * womanImg;
    NSString * sexStr;
    BOOL isImg;
}
@property (nonatomic , strong) UIImageView * touxiang;
@property (nonatomic , strong) UILabel * user_name;
@property (nonatomic , strong) UITextField * nameText;
@property (nonatomic , strong) UILabel * date;

@property (nonatomic, weak) UIView *alphaBackgroundView;

@property (nonatomic, weak) SLGeneralDatePickerView *pickerView;

@property (nonatomic, weak) UIView *topContainerView;
@property (nonatomic, weak) UIButton *doneButton;
@property (nonatomic, weak) UIButton *cancelButton;

@property (nonatomic , strong) UIButton * realBtn;
@property (nonatomic , strong) UIButton * bindingBtn;
@property (nonatomic , strong) UIButton * classBtn;

@property (nonatomic , strong) AroundAnimation * aAnimation;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isImg = NO;
    isMan = YES;
    sexStr = @"1";
    [self.navigationItem setTitle:@"个人信息"];
    self.y_navLineHidden = YES;
    
    [self creareUI];
    [self.view addSubview:self.realBtn];
    [self.view addSubview:self.bindingBtn];
    [self.view addSubview:self.classBtn];

}
- (void)creareUI{
    NSArray * arr = @[@"修改头像",@"账号",@"昵称",@"性别",@"出生日期"];
    for (int i=0; i<arr.count; i++) {
        UIButton * btn = [Unity buttonAddsuperview_superView:self.view _subViewFrame:CGRectMake(0, ((i+1)*1)+(i)*[Unity countcoordinatesH:50], SCREEN_WIDTH, [Unity countcoordinatesH:50]) _tag:self _action:@selector(btnClick:) _string:@"" _imageName:nil];
        btn.tag = i+1000;
        btn.backgroundColor = [UIColor whiteColor];
        UILabel * label = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20]) _string:arr[i] _lableFont:[UIFont systemFontOfSize:15] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
        NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
        if (i==0) {
            self.touxiang = [Unity imageviewAddsuperview_superView:btn _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:50], ([Unity countcoordinatesH:50]-30)/2, 30, 30) _imageName:@"组8" _backgroundColor:nil];
            self.touxiang.layer.cornerRadius = self.touxiang.width/2;
            self.touxiang.clipsToBounds = YES;
            UIImageView * goImg = [Unity imageviewAddsuperview_superView:btn _subViewFrame:CGRectMake(self.touxiang.right+[Unity countcoordinatesW:5], [Unity countcoordinatesH:20], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10]) _imageName:@"go" _backgroundColor:nil];
            goImg.backgroundColor = [UIColor clearColor];
            if (![userInfo[@"w_photo"]isEqualToString:@""]) {
                [self.touxiang sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"],userInfo[@"w_photo"]]]];
            }
        }else if (i==1){
            self.user_name = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:210], [Unity countcoordinatesH:15], [Unity countcoordinatesW:200], [Unity countcoordinatesH:20]) _string:[Unity editMobile:userInfo[@"w_mobile"]] _lableFont:[UIFont systemFontOfSize:15] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentRight];
        }else if (i==2){
            self.nameText = [Unity textFieldAddSuperview_superView:btn _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:210], [Unity countcoordinatesH:15], [Unity countcoordinatesW:200], [Unity countcoordinatesH:20]) _placeT:@"捎东西" _backgroundImage:nil _delegate:self andSecure:NO andBackGroundColor:nil];
            self.nameText.textAlignment = NSTextAlignmentRight;
            self.nameText.text = userInfo[@"w_nickname"];
        }else if (i==3){
            manImg = [Unity buttonAddsuperview_superView:btn _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:122], [Unity countcoordinatesH:17], [Unity countcoordinatesW:16], [Unity countcoordinatesH:16]) _tag:self _action:@selector(manClick) _string:@"" _imageName:@"read"];
            UILabel * manL = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake(manImg.right, [Unity countcoordinatesH:15], [Unity countcoordinatesW:20], [Unity countcoordinatesH:20]) _string:@"男" _lableFont:[UIFont systemFontOfSize:15] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentRight];
            womanImg = [Unity buttonAddsuperview_superView:btn _subViewFrame:CGRectMake(manL.right+[Unity countcoordinatesW:40], [Unity countcoordinatesH:17], [Unity countcoordinatesW:16], [Unity countcoordinatesH:16]) _tag:self _action:@selector(womanClick) _string:@"" _imageName:@"没选"];
            UILabel * womanL = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake(womanImg.right, [Unity countcoordinatesH:15], [Unity countcoordinatesW:20], [Unity countcoordinatesH:20]) _string:@"女" _lableFont:[UIFont systemFontOfSize:15] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentRight];
            womanL.backgroundColor = [UIColor clearColor];
            if ([userInfo[@"w_sex"]isEqualToString:@"2"]) {
                [self womanClick];
            }else{
                [self manClick];
            }
        }else{
            self.date = [Unity lableViewAddsuperview_superView:btn _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:160], [Unity countcoordinatesH:15], [Unity countcoordinatesW:150], [Unity countcoordinatesH:20]) _string:userInfo[@"w_born"] _lableFont:[UIFont systemFontOfSize:15] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentRight];
            self.date.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(datePicker)];
            singleTap.numberOfTapsRequired = 1; //点击次数
            singleTap.numberOfTouchesRequired = 1; //点击手指数
            [self.date addGestureRecognizer:singleTap];
        }
    }
}

- (UIButton *)realBtn{
    if (!_realBtn) {
        _realBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, [Unity countcoordinatesH:265], SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        _realBtn.backgroundColor = [UIColor whiteColor];
        [_realBtn addTarget:self action:@selector(realClick) forControlEvents:UIControlEventTouchUpInside];
        UILabel * label = [Unity lableViewAddsuperview_superView:_realBtn _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20]) _string:@"实名认证" _lableFont:[UIFont systemFontOfSize:15] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
        UIImageView * goImg = [Unity imageviewAddsuperview_superView:_realBtn _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:15], [Unity countcoordinatesH:20], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10]) _imageName:@"go" _backgroundColor:nil];
        goImg.backgroundColor = [UIColor clearColor];
    }
    return _realBtn;
}
- (UIButton *)bindingBtn{
    if (!_bindingBtn) {
        _bindingBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _realBtn.bottom+1, SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        _bindingBtn.backgroundColor = [UIColor whiteColor];
        [_bindingBtn addTarget:self action:@selector(bindingClick) forControlEvents:UIControlEventTouchUpInside];
        UILabel * label = [Unity lableViewAddsuperview_superView:_bindingBtn _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20]) _string:@"账号绑定" _lableFont:[UIFont systemFontOfSize:15] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
        UIImageView * goImg = [Unity imageviewAddsuperview_superView:_bindingBtn _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:15], [Unity countcoordinatesH:20], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10]) _imageName:@"go" _backgroundColor:nil];
        goImg.backgroundColor = [UIColor clearColor];
    }
    return _bindingBtn;
}
- (UIButton *)classBtn{
    if (!_classBtn) {
        _classBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _bindingBtn.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        _classBtn.backgroundColor = [UIColor whiteColor];
        [_classBtn addTarget:self action:@selector(classClick) forControlEvents:UIControlEventTouchUpInside];
        UILabel * label = [Unity lableViewAddsuperview_superView:_classBtn _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:100], [Unity countcoordinatesH:20]) _string:@"感兴趣的分类" _lableFont:[UIFont systemFontOfSize:15] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
        UIImageView * goImg = [Unity imageviewAddsuperview_superView:_classBtn _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:15], [Unity countcoordinatesH:20], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10]) _imageName:@"go" _backgroundColor:nil];
        goImg.backgroundColor = [UIColor clearColor];
        UILabel * dianL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesH:25]-5, ([Unity countcoordinatesH:50]-5)/2, 5, 5)];
        dianL.backgroundColor = [UIColor redColor];
        dianL.layer.cornerRadius =2.5;
        dianL.layer.masksToBounds = YES;
        [_classBtn addSubview:dianL];
    }
    return _classBtn;
}
- (void)btnClick:(UIButton *)btn{
    if (btn.tag==1000) {
//        [JPhotoMagenage getOneImageInController:self finish:^(UIImage *images) {
//            NSData *data =UIImageJPEGRepresentation(images, 0.5);
//            UIImage *img = [UIImage imageWithData:data];
//
//            self.touxiang.image = img;
//            NSString *path_sandox = NSHomeDirectory();
//            NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/touxiang.png"];
//            NSLog(@"%@",imagePath);
//            [UIImagePNGRepresentation(images) writeToFile:imagePath atomically:YES];
//            isImg = YES;
//        } cancel:^{
//
//        }];
        
        UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"拍照", @"从相册中选取", nil];
        [choiceSheet showInView:self.view];
//        baseViewController * bvc = [[baseViewController alloc]init];
//
//        [self presentViewController:bvc animated:YES completion:nil]
    }
}

- (void)manClick{
    isMan=YES;
    sexStr = @"1";
    [manImg setBackgroundImage:[UIImage imageNamed:@"read"] forState:UIControlStateNormal];
    [womanImg setBackgroundImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
}
- (void)womanClick{
    isMan=NO;
    sexStr = @"2";
    [manImg setBackgroundImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
    [womanImg setBackgroundImage:[UIImage imageNamed:@"read"] forState:UIControlStateNormal];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [Unity getColor:@"#f0f0f0"];
    [self addRightBarButtonItemWithTitle:@"保存" action:@selector(addClick)];
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
- (void)datePicker{
    self.alphaBackgroundView.hidden = NO;
    self.pickerView.hidden = NO;
    
    //如果只需要默认值，则屏蔽这行代码
    [self.pickerView setupPickerViewDataWithDefaultSelectedDate:[NSDate date] dateFormatter:@"yyyy-MM-dd" datePickerMode:SLDatePickerModeDate];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.pickerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.alphaBackgroundView);
        make.height.equalTo(@(260.f));
    }];
    
    [self.topContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.alphaBackgroundView);
        make.bottom.equalTo(self.pickerView.mas_top);
        make.height.equalTo(@40.f);
    }];
    
    [self.doneButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.topContainerView);
        make.right.equalTo(self.topContainerView.mas_right);
        make.width.equalTo(@(60.f));
    }];
    
    [self.cancelButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.centerY.equalTo(self.doneButton);
        make.left.equalTo(self.topContainerView.mas_left);
    }];
}
- (void)doneButtonTapped:(id)sender {
    self.alphaBackgroundView.hidden = YES;
    self.date.text = self.pickerView.date;
    //    NSLog(@"g.date = %@", self.pickerView.date);
}

- (void)cancelButtonTapped:(id)sender {
    self.alphaBackgroundView.hidden = YES;
}

#pragma mark - Getter
- (UIView *)alphaBackgroundView {
    if (!_alphaBackgroundView) {
        UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.28f];
        view.hidden = YES;
        [self.view addSubview:view];
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelButtonTapped:)];
        view.userInteractionEnabled = YES;
        [view addGestureRecognizer:recognizer];
        
        _alphaBackgroundView = view;
    }
    
    return _alphaBackgroundView;
}

- (SLGeneralDatePickerView *)pickerView {
    if (!_pickerView) {
        SLGeneralDatePickerView *view = [[SLGeneralDatePickerView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.hidden = YES;
        [self.alphaBackgroundView addSubview:view];
        
        _pickerView = view;
    }
    
    return _pickerView;
}

- (UIView *)topContainerView {
    if (!_topContainerView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor grayColor];
        [self.alphaBackgroundView addSubview:view];
        
        _topContainerView = view;
    }
    
    return _topContainerView;
}

- (UIButton *)doneButton {
    if (!_doneButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [button addTarget:self action:@selector(doneButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.topContainerView addSubview:button];
        
        _doneButton = button;
    }
    
    return _doneButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [button addTarget:self action:@selector(cancelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.topContainerView addSubview:button];
        
        _cancelButton = button;
    }
    
    return _cancelButton;
}
- (void)realClick{
    BOOL isRealName;
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    if (![userInfo[@"back"]isEqualToString:@""]) {//已实名
        isRealName = YES;
    }else{
        isRealName = NO;
    }
    RealNameViewController * rvc = [[RealNameViewController alloc]init];
    rvc.hidesBottomBarWhenPushed = YES;
    rvc.isReal = isRealName;
    [self.navigationController pushViewController:rvc animated:YES];
}
- (void)bindingClick{
    BoundViewController * bvc = [[BoundViewController alloc]init];
    bvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bvc animated:YES];
}
- (void)classClick{
    InterestViewController * ivc = [[InterestViewController alloc]init];
    ivc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ivc animated:YES];
}
- (void)addClick{
    [self.aAnimation startAround];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSData *data;
    if (1) {
        data = UIImageJPEGRepresentation(self.touxiang.image, 0.1);
    } else {
        data = UIImagePNGRepresentation(self.touxiang.image);
    }
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    
    NSDictionary *params = @{@"customer":userInfo[@"member_id"],@"nickname":self.nameText.text,@"sex":sexStr,@"born":self.date.text};
    NSLog(@" %@",params);
    [manager POST:[GZMUrl get_infomation_url] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (isImg) {
            [formData appendPartWithFileData:data name:@"photo" fileName:@"touxiang.png" mimeType:@"image/png"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.aAnimation stopAround];
        NSLog(@"个人信息更新 %@",responseObject);
        if ([responseObject[@"code"]isEqualToString:@"success"]) {
            [WHToast showMessage:[responseObject objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            NSMutableDictionary * dict = [NSMutableDictionary new];
            dict = [userInfo mutableCopy];
            if (isImg) {
                [dict setObject:responseObject[@"data"] forKey:@"w_photo"];
            }
            [dict setObject:self.nameText.text forKey:@"w_nickname"];
            [dict setObject:sexStr forKey:@"w_sex"];
            [dict setObject:self.date.text forKey:@"w_born"];
            [[NSUserDefaults standardUserDefaults]setObject:dict forKey:@"userInfo"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [WHToast showMessage:[responseObject objectForKey:@"msg"] originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.aAnimation stopAround];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
}
- (AroundAnimation *)aAnimation{
    if (!_aAnimation) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _aAnimation = [AroundAnimation AroundAnimationViewSetView:window];
    }
    return _aAnimation;
}




#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
//    self.portraitImageView.image = editedImage;
    self.touxiang.image = editedImage;
    NSString *path_sandox = NSHomeDirectory();
    NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/touxiang.png"];
//    NSLog(@"%@",imagePath);
    [UIImagePNGRepresentation(editedImage) writeToFile:imagePath atomically:YES];
    isImg = YES;
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
//        GzmPhotoViewController * gvc = [[GzmPhotoViewController alloc]init];
//        self.navigationController pushViewController:gvc animated:<#(BOOL)#>
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
//            if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
//                controller.modalPresentationStyle=UIModalPresentationOverCurrentContext;
//            }
//            controller.navigationBar.translucent= NO;
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
                controller.modalPresentationStyle=UIModalPresentationOverCurrentContext;
            }
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // present the cropper view controller
        VPImageCropperViewController *imgCropperVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgCropperVC.delegate = self;
        [self presentViewController:imgCropperVC animated:YES completion:^{
            // TO DO
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
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
