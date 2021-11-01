//
//  Add_addressViewController.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/5/31.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "Add_addressViewController.h"
#import "RegionView.h"
#import "BidIdCardListViewController.h"
@interface Add_addressViewController ()<UITextViewDelegate,UITextFieldDelegate,RegionViewDelegate,BidIdCardListDelegate>
{
    NSInteger realType;// 0 默认未选择  1 认证信息 2重新上传
}
@property (nonatomic , strong) UIView * topView;
@property (nonatomic , strong) UIButton * biddingBtn;

@property (nonatomic , strong) UITextField * nameText;
@property (nonatomic , strong) UIView * line1;
@property (nonatomic , strong) UITextField * mobileText;
@property (nonatomic , strong) UIView * line2;
@property (nonatomic , strong) UITextField * regionText;
@property (nonatomic , strong) UIView * line3;
@property (nonatomic , strong) UITextField * zipcodeText;
@property (nonatomic , strong) UIView * line5;
@property (nonatomic , strong) UIImageView * goImg;
@property (nonatomic , strong) UITextView * textView;
@property (nonatomic , strong) UITextField * markText;
@property (nonatomic , strong) UIView * line4;
@property (nonatomic,retain) UILabel * textviewplace;
@property (nonatomic , strong) UIView * line10;//因为Xcode升级11.2以后 textView上边框出来个横线  找不到解决办法  所以在textView上方 加一条白色的横线覆盖掉黑色横线

@property (nonatomic , strong) RegionView * rView;
@property (nonatomic , strong) alertView * altView;
@end

@implementation Add_addressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    realType = 0;
    //注册通知(接收,监听,一个通知)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification) name:@"idCard" object:nil];
    [self createUI];
}
- (void)notification{
    NSLog(@"身份证通知");
    realType = 2;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [Unity getColor:@"#f0f0f0"];
    self.title = @"添加收货地址";
    [self addRightBarButtonItemWithTitle:@"保存" action:@selector(saveClick)];
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
- (void)saveClick{
    [self saveAddress];
}
- (void)createUI{
    [self.view addSubview:self.topView];
    [self.view addSubview:self.biddingBtn];
}
- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [Unity countcoordinatesH:305])];
        _topView.backgroundColor = [UIColor whiteColor];
        [_topView addSubview:self.nameText];
        [_topView addSubview:self.line1];
        [_topView addSubview:self.mobileText];
        [_topView addSubview:self.line2];
        [_topView addSubview:self.regionText];
        [_topView addSubview:self.goImg];
        [_topView addSubview:self.line3];
        [_topView addSubview:self.textView];
        [_topView addSubview:self.line10];
        [_topView addSubview:self.line4];
        [_topView addSubview:self.zipcodeText];
        [_topView addSubview:self.line5];
        [_topView addSubview:self.markText];
    }
    return _topView;
}
- (UIButton *)biddingBtn{
    if (!_biddingBtn) {
        _biddingBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _topView.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH, [Unity countcoordinatesH:50])];
        _biddingBtn.backgroundColor = [UIColor whiteColor];
        [_biddingBtn addTarget:self action:@selector(bidClick) forControlEvents:UIControlEventTouchUpInside];
        UILabel * label = [Unity lableViewAddsuperview_superView:_biddingBtn _subViewFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], [Unity countcoordinatesW:200], [Unity countcoordinatesH:20]) _string:@"身份证绑定" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor3 _textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor clearColor];
        UIImageView * img = [Unity imageviewAddsuperview_superView:_biddingBtn _subViewFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:15], [Unity countcoordinatesH:20], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10]) _imageName:@"go" _backgroundColor:nil];
        img.backgroundColor = [UIColor clearColor];
        
    }
    return _biddingBtn;
}
- (UITextField *)nameText{
    if (!_nameText) {
        _nameText = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], [Unity countcoordinatesH:15], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _nameText.text = self.addressDic[@"w_name"];
        _nameText.placeholder = @"收货人姓名(请使用真实姓名)";
        _nameText.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _nameText;
}
- (UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc]initWithFrame:CGRectMake(0, _nameText.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH, [Unity countcoordinatesH:1])];
        _line1.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line1;
}
- (UITextField *)mobileText{
    if (!_mobileText) {
        _mobileText = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line1.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _mobileText.text = self.addressDic[@"w_mobile"];
        _mobileText.placeholder = @"手机号码";
        _mobileText.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _mobileText;
}
- (UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc]initWithFrame:CGRectMake(0, _mobileText.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH, [Unity countcoordinatesH:1])];
        _line2.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line2;
}
- (UITextField *)regionText{
    if (!_regionText) {
        _regionText = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line2.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH-[Unity countcoordinatesW:35], [Unity countcoordinatesH:20])];
        _regionText.delegate = self;
        _regionText.text = self.addressDic[@"w_address"];
        _regionText.placeholder = @"所在地区";
        _regionText.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _regionText;
}
- (UIImageView *)goImg{
    if (!_goImg) {
        _goImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[Unity countcoordinatesW:15], _line2.bottom+[Unity countcoordinatesH:20], [Unity countcoordinatesW:5], [Unity countcoordinatesH:10])];
        _goImg.image = [UIImage imageNamed:@"go"];
    }
    return _goImg;
}
- (UIView *)line3{
    if (!_line3) {
        _line3 = [[UIView alloc]initWithFrame:CGRectMake(0, _regionText.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH, [Unity countcoordinatesH:1])];
        _line3.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line3;
}
- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line3.bottom+[Unity countcoordinatesH:15], _topView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:30])];
//        _textView.
//        _textView.layer.borderColor = [UIColor redColor].CGColor;
//        _textView.layer.borderWidth =1;
        _textView.delegate=self;
        _textView.font=[UIFont systemFontOfSize:FontSize(14)];
        _textView.text = self.addressDic[@"w_address_detail"];
        _textviewplace = [Unity lableViewAddsuperview_superView:_textView _subViewFrame:CGRectMake(5, 0, _textView.width-10, _textView.height) _string:@"详细地址：如道路、门牌号、小区、楼栋号、单元室等" _lableFont:[UIFont systemFontOfSize:FontSize(14)] _lableTxtColor:LabelColor9 _textAlignment:NSTextAlignmentLeft];
        self.textviewplace.numberOfLines=0;
        [self.textviewplace sizeToFit];

        if (_textView.text.length != 0 ) {
            self.textviewplace.hidden = YES;
        }
        
    }
    return _textView;
}
- (UIView *)line10{
    if (!_line10) {
        _line10 = [[UIView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line3.bottom+[Unity countcoordinatesH:15], _topView.width-[Unity countcoordinatesW:20], [Unity countcoordinatesH:1])];
        _line10.backgroundColor = [UIColor whiteColor];
    }
    return _line10;
}
- (UIView *)line4{
    if (!_line4) {
        _line4 = [[UIView alloc]initWithFrame:CGRectMake(0, _textView.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH, [Unity countcoordinatesH:1])];
        _line4.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line4;
}
- (UITextField *)zipcodeText{
    if (!_zipcodeText) {
        _zipcodeText = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line4.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH-[Unity countcoordinatesW:35], [Unity countcoordinatesH:20])];
        if (![self.addressDic[@"postal"] isKindOfClass:[NSNull class]]) {
            _zipcodeText.text = self.addressDic[@"postal"];
        }
        _zipcodeText.keyboardType = UIKeyboardTypeNumberPad;
        _zipcodeText.placeholder = @"请输入邮政编码";
        _zipcodeText.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _zipcodeText;
}
- (UIView *)line5{
    if (!_line5) {
        _line5 = [[UIView alloc]initWithFrame:CGRectMake(0, _zipcodeText.bottom+[Unity countcoordinatesH:15], SCREEN_WIDTH, [Unity countcoordinatesH:1])];
        _line5.backgroundColor = [Unity getColor:@"#e0e0e0"];
    }
    return _line5;
}
- (UITextField *)markText{
    if (!_markText) {
        _markText = [[UITextField alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:10], _line5.bottom+[Unity countcoordinatesH:10], SCREEN_WIDTH-[Unity countcoordinatesW:20], [Unity countcoordinatesH:20])];
        _markText.placeholder = @"备注";
        _markText.text =  self.addressDic[@"w_other"];
        _markText.font = [UIFont systemFontOfSize:FontSize(14)];
    }
    return _markText;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.textviewplace.hidden = NO;
    }else{
        self.textviewplace.hidden = YES;
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"这里返回为NO。则为禁止编辑");
    [self.rView showRegionView];
    return NO;
}
- (RegionView *)rView{
    if (!_rView) {
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        _rView = [RegionView setRegionView:window];
        _rView.delegate=self;
    }
    return _rView;
}
- (void)areaSelection:(NSString *)area{
    self.regionText.text = area;
}
- (void)bidClick{
    BidIdCardListViewController * bvc = [[BidIdCardListViewController alloc]init];
    bvc.delegate = self;
//    if (self.isEdit) {
    bvc.addressDic = self.addressDic;
//    }
    bvc.isEdit = self.isEdit;
    [self.navigationController pushViewController:bvc animated:YES];
}
- (void)saveAddress{
    if (self.isEdit) {//编辑状态 可以不传身份证
        if (self.nameText.text.length == 0 || self.mobileText.text.length == 0 || self.regionText.text.length == 0 || self.textView.text.length == 0 || self.zipcodeText.text.length == 0) {
            [WHToast showMessage:@"信息填写不完整" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            return;
        }
    }else{
        if (self.nameText.text.length == 0 || self.mobileText.text.length == 0 || self.regionText.text.length == 0 || self.textView.text.length == 0 || self.zipcodeText.text.length == 0) {
            [WHToast showMessage:@"信息填写不完整" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            return;
        }
    }
    [Unity showanimate];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSData *data;
    
    NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"zheng.png"];
    NSData *imageData=[[NSData alloc] initWithContentsOfFile:path];
    //将二进制数据转成图片
    UIImage *image=[[UIImage alloc] initWithData:imageData];
    if (1) {
        data = UIImageJPEGRepresentation(image, 0.1);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    NSData *dataB;
    NSString *path1=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"fan.png"];
    NSData *imageData1=[[NSData alloc] initWithContentsOfFile:path1];
    //将二进制数据转成图片
    UIImage *image1=[[UIImage alloc] initWithData:imageData1];
    if (1) {
        dataB = UIImageJPEGRepresentation(image1, 0.1);
    } else {
        dataB = UIImagePNGRepresentation(image1);
    }
    
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    
    NSLog(@"%@",[userInfo objectForKey:@"member_id"]);
    NSDictionary * dic = [NSDictionary new];
    if (!self.isEdit) {
        dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"w_name":self.nameText.text,@"w_mobile":self.mobileText.text,@"w_address":self.regionText.text,@"w_address_detail":self.textView.text,@"w_other":self.markText.text,@"postal":self.zipcodeText.text};
        if (realType == 1) {
            dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"w_name":self.nameText.text,@"w_mobile":self.mobileText.text,@"w_address":self.regionText.text,@"w_address_detail":self.textView.text,@"w_other":self.markText.text,@"auth":@"1",@"postal":self.zipcodeText.text};
        }
    }else{//编辑状态
        dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"w_name":self.nameText.text,@"w_mobile":self.mobileText.text,@"w_address":self.regionText.text,@"w_address_detail":self.textView.text,@"w_other":self.markText.text,@"id":self.addressDic[@"id"],@"postal":self.zipcodeText.text};
        if (realType == 1) {
            dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"w_name":self.nameText.text,@"w_mobile":self.mobileText.text,@"w_address":self.regionText.text,@"w_address_detail":self.textView.text,@"w_other":self.markText.text,@"id":self.addressDic[@"id"],@"auth":@"1",@"postal":self.zipcodeText.text};
        }
    }
    [manager POST:[GZMUrl get_saveAddress_url] parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (realType == 2) {
            [formData appendPartWithFileData:data name:@"front" fileName:@"zheng.png" mimeType:@"image/png"];
            [formData appendPartWithFileData:dataB name:@"back" fileName:@"fan.png" mimeType:@"image/png"];
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [Unity hiddenanimate];
        if ([[responseObject objectForKey:@"code"]isEqualToString:@"success"]) {
            
            [WHToast showMessage:@"保存成功" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
            [self.delegate loadAddress];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [self.altView showAlertView];
            self.altView.msgL.text = [responseObject objectForKey:@"msg"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [Unity hiddenanimate];
        [WHToast showMessage:@"加载失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
    }];
/*
//    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
//    NSLog(@"%@",[userInfo objectForKey:@"member_id"]);
//    NSDictionary * dic = [NSDictionary new];
//    if (self.addressDic == nil) {
//        dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"w_name":self.nameText.text,@"w_mobile":self.mobileText.text,@"w_address":self.regionText.text,@"w_address_detail":self.textView.text,@"w_other":self.markText.text};
//    }else{
//        dic = @{@"customer":[userInfo objectForKey:@"member_id"],@"w_name":self.nameText.text,@"w_mobile":self.mobileText.text,@"w_address":self.regionText.text,@"w_address_detail":self.textView.text,@"w_other":self.markText.text,@"id":self.addressDic[@"id"]};
//    }
//    [self.aAnimation startAround];
//    [GZMrequest postWithURLString:[GZMUrl get_saveAddress_url] parameters:dic success:^(NSDictionary *data) {
//        [self.aAnimation stopAround];
//        if ([[data objectForKey:@"code"]isEqualToString:@"success"]) {
//
//            [WHToast showMessage:@"保存成功" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
//            [self.delegate loadAddress];
//            [self.navigationController popViewControllerAnimated:YES];
//
//        }else{
//            [self.altView showAlertView];
//            self.altView.msgL.text = [data objectForKey:@"msg"];
//        }
//    } failure:^(NSError *error) {
//        [self.aAnimation stopAround];
//        [WHToast showMessage:@"请求失败" originY:SCREEN_HEIGHT-[Unity countcoordinatesH:100] duration:2 finishHandler:^{}];
//    }];
 */
}

- (alertView *)altView{
    if (_altView == nil) {
        _altView = [alertView setAlertView:self.view];
    }
    return _altView;
}
- (void)selectRealName{
    realType = 1;
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
