//
//  GZMUrl.h
//  wallet
//
//  Created by 桂在明 on 2018/8/13.
//  Copyright © 2018年 桂在明. All rights reserved.
//

#import <Foundation/Foundation.h>
//#define JLYUrl  @"http://47.93.205.147:8080"
#define SDXUrl  [[NSUserDefaults standardUserDefaults] objectForKey:@"sdxurl"]
#define New_SDXUrl [[NSUserDefaults standardUserDefaults] objectForKey:@"new_sdxurl"]
//#define SDXUrl  @"https://www.shaogood.com"
//#define New_SDXUrl @"https://bms.shaogood.com"
//#define SDXUrl  @"http://test.shaogood.com"//测试地址


#define register_url                @"/shaogood/mobile/appApi/auth/register.php" //注册
#define code_url                    @"/shaogood/mobile/appApi/auth/requestcheckcode.php"//短信验证码
#define login_url                   @"/shaogood/mobile/appApi/auth/login.php"//登录
#define resetpassword_url           @"/shaogood/mobile/appApi/auth/resetpassword.php"//忘记密码
#define home_url                    @"/shaogood/mobile/appApi/home/home2.php"//首页
#define home_special_url            @"/shaogood/mobile/appApi/home/homeapi.php"//首页精选商品
#define home_slide_url              @"/shaogood/mobile/appApi/home/slide.php"//请求间隔
#define searchhistory_url           @"/shaogood/mobile/appApi/home/searchhistory.php"//热门搜索 历史搜索
#define searchbar_url               @"/shaogood/mobile/appApi/home/searchbar.php"//搜索
#define exrate_url                  @"/shaogood/mobile/appApi/home/exrate.php"//汇率
#define classify_url                @"/shaogood/mobile/appApi/home/classify.php"//1级分类  0雅虎 5易贝
#define otherclassify_url           @"/shaogood/mobile/appApi/home/otherclassify.php"//2级3级分类
#define brand_url                   @"/shaogood/mobile/appApi/home/brand.php"//品牌列表
#define goodsDetail_url             @"/shaogood/mobile/appApi/home/goods.php"//商品详情
#define deleteSearch_url            @"/shaogood/mobile/appApi/home/searchclear.php"//删除历史搜索
#define orderlist_url               @"/shaogood/mobile/appApi/order/orderlist.php"//a区b区列表
#define ordermanager_url            @"/shaogood/mobile/appApi/order/ordermanager.php"//获取会员委托单案件信息列表
#define statusCount_url             @"/shaogood/mobile/appApi/order/ordercount.php"//委托单各种状态数量
#define caseDetail_url              @"/shaogood/mobile/appApi/order/order.php"//我的页面案件详情
#define helpList_url                @"/shaogood/mobile/appApi/member/helplist.php"//帮助中心1级列表
#define helpList2_url               @"/shaogood/mobile/appApi/member/otherhelplist.php"//帮助中心二级列表
#define collectionList_url          @"/shaogood/mobile/appApi/member/favorite.php"//获取信息列表
#define helpSearch_url              @"/shaogood/mobile/appApi/member/helpsearch.php"//帮助搜索
#define helpDetail_url              @"/shaogood/mobile/appApi/member/help.php"//帮助详情

#define saveAddress_url             @"/shaogood/mobile/appApi/member/addressmodifiy.php"//添加新的收货地址    编辑收货地址
#define selectAddress_url           @"/shaogood/mobile/appApi/member/address.php"//查询收货地址信息
#define setDefaultAddress_url       @"/shaogood/mobile/appApi/member/addressdefault.php"//设置默认地址
#define deleteAddress_url           @"/shaogood/mobile/appApi/member/addressdelete.php"//删除地址
#define loginPass_url               @"/shaogood/mobile/appApi/auth/updatepassword.php"//修改登录密码

#define collection_url              @"/shaogood/mobile/appApi/member/favoriteadd.php"//创建收藏
#define deleteCollection_url        @"/shaogood/mobile/appApi/member/favoritedelete.php"//删除收藏

#define avoidLogin_url              @"/shaogood/mobile/appApi/auth/autologin.php"//免登陆
#define userAuthen_url              @"/shaogood/mobile/appApi/auth/createpaypasswordcheck.php"//设置支付密码用户验证
#define userCancel_url              @"/shaogood/mobile/appApi/auth/logout.php"//会员注销

#define setPassword_url             @"/shaogood/mobile/appApi/auth/setpaypassword.php"//设置修改支付密码

#define createCase_url              @"/shaogood/mobile/appApi/home/offer.php"//创建委托单
#define newCreateCase_url           @"/index/order_bid/bid_create"//创建委托单（新）
#define updateCase_url              @"/shaogood/mobile/appApi/order/add.php"//更新委托单（加价）
#define cancelCase_url              @"/shaogood/mobile/appApi/order/cut.php"//取消委托单（砍单）
#define deleteCase_url              @"/shaogood/mobile/appApi/order/lossdelete.php"//删除未得标
#define queueCase_url               @"/shaogood/mobile/appApi/order/queue.php"//排入

#define oldPayPass_url              @"/shaogood/mobile/appApi/auth/checkpaypassword.php"//旧支付密码验证
#define goodsList_url               @"/shaogood/mobile/appApi/home/goodslist.php"//商品列表

#define oldMobile_url               @"/shaogood/mobile/appApi/auth/checkmobile.php"//验证原始手机
#define updateMobile_url            @"/shaogood/mobile/appApi/auth/updatemobile.php"//更新绑定手机

#define blanceShow_url              @"/shaogood/mobile/appApi/member/updateremainappear.php"//余额显示不显示
#define send_url                    @"/shaogood/mobile/appApi/order/send.php"//确认发货

#define balanceList_url             @"/shaogood/mobile/appApi/member/szlog.php"//余额列表信息
#define isCollection_url            @"/shaogood/mobile/appApi/home/havefavorite.php"//是否收藏

#define realName_url                @"/shaogood/mobile/appApi/auth/auth.php"//实名认证
#define notice_url                  @"/shaogood/mobile/appApi/home/notice.php"//最新消息更多
#define infomation_url              @"/shaogood/mobile/appApi/member/updatemember.php"//更新会员个人信息
#define message_url                 @"/shaogood/mobile/appApi/member/updatemessagenotice.php"//是否短信提示
#define haitao_url                  @"/shaogood/mobile/appApi/home/notice.php"//海淘资讯

#define interest_url                @"/shaogood/mobile/appApi/member/interest.php"//兴趣列表
#define subInterest_url             @"/shaogood/mobile/appApi/member/interestmodify.php"//兴趣提交
#define recharge_url                @"/shaogood/mobile/appApi/member/allpayxrequest.php"//充值
#define cash_url                    @"/shaogood/mobile/appApi/member/back.php"//退款
#define category_url                @"/shaogood/mobile/appApi/home/getcategorytree.php"//商品列表分类查询
#define footmarkadd_url             @"/api/product/footmarkadd"//（浏览产品的足迹接口）

/**
 浏览产品的足迹接口
 user                否    用户的登录账号，未登录只更新产品表（不更新足迹表）
 auction_id          是    竞拍产品id
 goods_name          是    商品名称
 source              是    来源，默认yahoo，ebay
 category_id_path    是    类别id路径，用,分隔，例:0,20000,2084259484,2084310194,2084310195
 category_path       是    类别名称路径，用>分隔，例:オークション > アンティーク、コレクション > 武具 > 日本刀、刀剣 > 刀、太刀
 seller_id           是    卖家ID例:art_0813
 goods_img           是    商品图片地址，json格式
 goods_img_thumbnail 是    商品缩略图，json格式
 over_price          是    结标价格
 over_time           是    结标时间
 terminal            是    访问终端 默认0：未知，1：web，2：wap，3：安卓，4：ios
 */

/*
 * @request POST
 *
 * @param int customer 会员编号
 * @param int why 充值用途
 * @param float amount 充值金额
 * @param string type 充值方式
 * @param string coin 充值币种
 * @param string test 是否测试
 *
 * @return string code 状态码
 * @return string msg 结果信息
 why（0保证金，1货款）
 test（1测试用）
 */
#define saveFoot_url                @"/api/product/save_footmark_cache"//（登录时调用保存所有未登录时候存的足迹）
/**
 请求方式    post
 参数        类型       是否必填       备注
 user                    是      用户的登录账号
 mod                     否      web端 给值'pc',app忽略此字段
 markdata   json         否（只有APP用）    "[
 {""auction_id"":""j591991243"",""terminal"":1,""source"":""yahoo"",""read_time"":""2019-09-18 13:06:46""},
 {""auction_id"":""j591991243"",""terminal"":1,""source"":""ebay"",""read_time"":""2019-09-18 13:06:46""}
 ]"
 auction_id              是        竞拍产品id
 terminal                是        访问终端 默认0：未知，1：web，2：wap，3：安卓，4：ios
 source                  是        来源，默认yahoo，ebay
 read_time               是        浏览时间
 
 */
#define footDate_url                         @"/api/product/footmarkym"//（有足迹的日期接口）
#define selectFootData_url                   @"/api/product/footmarklist"//（浏览产品的足迹接口）
/**
 请求方式    get
 参数    类型    是否必填    备注
 page    数字    是    第几页
 pagesize    数字    是    每页显示几条
 ymd    日期    否    按日期搜索   例如： 2019-09-20
 user        是    用户的登录账号
 返回结果字段    total：总条数，per_page：当前页条数，current_page：当前是第几页，last_page：最后一页是第几页（总页数）
 返回结果    {"status":1,"mes":"Success","data":{"total":2,"per_page":12,"current_page":1,"last_page":1,"data":[{"id":8,"read_time":"2019-09-18 14:26:57","auction_id":"j591991243","goods_name":"刀、太刀","goods_img":"","goods_img_thumbnail":null,"over_price":null,"over_time":"2019-10-30 12:10:10"},{"id":10,"read_time":"2019-09-17 15:47:42","auction_id":"x645828827","goods_name":"产品名称","goods_img":"","goods_img_thumbnail":null,"over_price":null,"over_time":"2019-09-30 12:10:10"}]}}
 
 */
#define deleteFoot_url                         @"/api/product/footmarkdel"//（删除足迹接口）
/**
 请求方式    post
 参数    类型    是否必填    备注
 ids        是    可以是单个id，也可以是id组 例如：1,2,8
 user        是    用户的登录账号
 
 返回结果    {"status":1,"mes":"Success","data":3]}  data 里的数字是删除了几条
 
 */

#define guessPrice_url                         @"/game/bidding/send_price"//竞价
#define seleteGuess_url                        @"/game/bidding/get_game"//请求是否猜过价
#define sshaoleList_url                        @"/game/bidding/get_list"//稍稍乐列表
#define confirmGuess_url                       @"/game/bidding/user_confirm"//竞猜确认
#define recomeList_url                         @"/api/product/tuijian"//推荐列表

#define messageList_url                            @"/api/message/message_list"//消息列表

#define newOrderList_url                       @"/index/order_bid/bid_list"//新委托单列表
#define transport_List_url                     @"/index/order_transport/transport_list"//新物流列表
#define wlPay_url                              @"/index/order_transport/payment"//物流单支付
#define execute_url                            @"/payment/payment_umf/payment_execute"//订单支付验证码，银行卡支付需要
#define updateInfo_url                         @"/index/order_transport/update_get_info"//更新会员收货信息
#define back_confirm_url                       @"/index/order_transport/back_confirm"//确认回退包裹
#define precelDetail_url          @"/index/order_transport/transport_info"//包裹、委托单详情
#define receive_confirm_url       @"/index/order_transport/receive_confirm"//确认收货
#define payment_tariff_url        @"/index/order_transport/payment_tariff"//支付关税验证码获取
#define precelDelete_url          @"/index/order_transport/del"//删除物流 包裹
#define newCut_url                @"/index/order_bid/order_cut"//新委托单砍单
#define newPay_url                @"/index/order_bid/bid_add_payment"//定金支付
#define newOrderPay_url           @"/index/order_bid/bid_payment"//委托单结算 验证码请求
#define newOrderDetail_url        @"/index/order_bid/bid_get"//委托单详情（新）
#define bid_add_show_url          @"/index/order_bid/bid_add_show"//创建加价单前显示
#define bid_add_create_url        @"/index/order_bid/bid_add_create"//创建加价单
#define haitao_send_url           @"/index/order_agent/create"//海淘发货
#define haitaoRateSelete_url            @"/index/order_agent/getcost"//海淘费率查询
#define haitaoList_url            @"/index/order_agent/agent_list"//海淘列表
#define haitaoDetail_url          @"/index/order_agent/agent_get"//海淘详情
#define haitaoPay_url             @"/index/order_agent/payment"//海淘支付验证码
#define haitaoDelete_url          @"/index/order_agent/order_del"//海淘列表删除
#define newOrderDelete_url        @"/index/order_bid/order_del"//新委托单列表删除
#define haitaoCancel_url          @"/index/order_agent/order_cancel"//海淘委托单取消委托

@interface GZMUrl : NSObject


//注册
+(NSString *)get_register_url;
//短信验证码
+(NSString *)get_code_url;
//登录
+(NSString *)get_login_url;

+(NSString *)get_resetpassword_url;
//首页get_home_url
+(NSString *)get_home_url;

+(NSString *)get_home_special_url;

+(NSString *)get_home_slide_url;

+(NSString *)get_searchhistory_url;

+(NSString *)get_searchbar_url;

+(NSString *)get_exrate_url;

+(NSString *)get_classify_url;

+(NSString *)get_otherclassify_url;
//
+(NSString *)get_brand_url;
//
+(NSString *)get_goodsDetail_url;

+(NSString *)get_deleteSearch_url;
//
+(NSString *)get_orderlist_url;

+(NSString *)get_ordermanager_url;
//
+(NSString *)get_statusCount_url;

+(NSString *)get_caseDetail_url;

+(NSString *)get_helpList_url;
//
+(NSString *)get_collectionList_url;
////
+(NSString *)get_saveAddress_url;

+(NSString *)get_selectAddress_url;
//
+(NSString *)get_setDefaultAddress_url;
//
+(NSString *)get_deleteAddress_url;

+(NSString *)get_loginPass_url;

+(NSString *)get_helpList2_url;
//
+(NSString *)get_collection_url;

+(NSString *)get_deleteCollection_url;

+(NSString *)get_helpSearch_url;

+(NSString *)get_helpDetail_url;

+(NSString *)get_avoidLogin_url;

+(NSString *)get_userAuthen_url;

+(NSString *)get_userCancel_url;

+(NSString *)get_setPassword_url;

+(NSString *)get_createCase_url;

+(NSString *)get_updateCase_url;

+(NSString *)get_cancelCase_url;

+(NSString *)get_deleteCase_url;

+(NSString *)get_queueCase_url;

+(NSString *)get_oldPayPass_url;

+(NSString *)get_goodsList_url;

+(NSString *)get_oldMobile_url;

+(NSString *)get_updateMobile_url;

+(NSString *)get_blanceShow_url;

+(NSString *)get_send_url;

+(NSString *)get_balanceList_url;

+(NSString *)get_isCollection_url;

+(NSString *)get_realName_url;

+(NSString *)get_notice_url;

+(NSString *)get_infomation_url;

+(NSString *)get_message_url;

+(NSString *)get_haitao_url;

+(NSString *)get_interest_url;

+(NSString *)get_subInterest_url;

+(NSString *)get_recharge_url;

+(NSString *)get_cash_url;

+(NSString *)get_category_url;

+(NSString *)get_footmarkadd_url;

+(NSString *)get_saveFoot_url;

+(NSString *)get_footDate_url;

+(NSString *)get_selectFootData_url;

+(NSString *)get_deleteFoot_url;

+(NSString *)get_guessPrice_url;

+(NSString *)get_seleteGuess_url;

+(NSString *)get_sshaoleList_url;

+(NSString *)get_confirmGuess_url;

+(NSString *)get_recomeList_url;

+(NSString *)get_messageList_url;

+(NSString *)get_newCreateCase_url;

+(NSString *)get_newOrderList_url;

+(NSString *)get_transport_List_url;

+(NSString *)get_wlPay_url;

+(NSString *)get_execute_url;

+(NSString *)get_updateInfo_url;

+(NSString *)get_back_confirm_url;

+(NSString * )get_precelDetail_url;

+(NSString *)get_receive_confirm_url;

+(NSString *)get_payment_tariff_url;

+(NSString *)get_precelDelete_url;

+(NSString *)get_newCut_url;

+(NSString *)get_newPay_url;

+(NSString *)get_newOrderPay_url;

+(NSString *)get_newOrderDetail_url;

+(NSString * )get_bid_add_show_url;

+(NSString *)get_bid_add_create_url;

+(NSString *)get_haitao_send_url;

+(NSString *)get_haitaoRateSelete_url;

+(NSString *)get_haitaoList_url;

+(NSString *)get_haitaoDetail_url;

+(NSString *)get_haitaoPay_url;

+(NSString *)get_haitaoDelete_url;

+(NSString *)get_newOrderDelete_url;

+(NSString *)get_haitaoCancel_url;
@end
