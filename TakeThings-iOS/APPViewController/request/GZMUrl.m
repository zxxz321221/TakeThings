//
//  GZMUrl.m
//  wallet
//
//  Created by 桂在明 on 2018/8/13.
//  Copyright © 2018年 桂在明. All rights reserved.
//

#import "GZMUrl.h"

@implementation GZMUrl
+(NSString *)get_register_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,register_url];
}
+(NSString *)get_code_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,code_url];
}
+(NSString *)get_login_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,login_url];
}
+(NSString *)get_resetpassword_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,resetpassword_url];
}
+(NSString *)get_home_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,home_url];
}
+(NSString *)get_home_special_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,home_special_url];
}
+(NSString *)get_home_slide_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,home_slide_url];
}
+(NSString *)get_searchhistory_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,searchhistory_url];
}
+(NSString *)get_searchbar_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,searchbar_url];
}
+(NSString *)get_exrate_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,exrate_url];
}
+(NSString *)get_classify_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,classify_url];
}
+(NSString *)get_otherclassify_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,otherclassify_url];
}
+(NSString *)get_brand_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,brand_url];
}
+(NSString *)get_goodsDetail_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,goodsDetail_url];
}
+(NSString *)get_deleteSearch_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,deleteSearch_url];
}
+(NSString *)get_orderlist_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,orderlist_url];
}
+(NSString *)get_ordermanager_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,ordermanager_url];
}
+(NSString *)get_statusCount_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,statusCount_url];
}
+(NSString *)get_caseDetail_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,caseDetail_url];
}
+(NSString *)get_helpList_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,helpList_url];
}
+(NSString *)get_collectionList_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,collectionList_url];
}
+(NSString *)get_saveAddress_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,saveAddress_url];
}
+(NSString *)get_selectAddress_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,selectAddress_url];
}
+(NSString *)get_setDefaultAddress_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,setDefaultAddress_url];
}
+(NSString *)get_deleteAddress_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,deleteAddress_url];
}
+(NSString *)get_loginPass_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,loginPass_url];
}
+(NSString *)get_helpList2_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,helpList2_url];
}
+(NSString *)get_collection_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,collection_url];
}
+(NSString *)get_deleteCollection_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,deleteCollection_url];
}
+(NSString *)get_helpSearch_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,helpSearch_url];
}
+(NSString *)get_helpDetail_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,helpDetail_url];
}
+(NSString *)get_avoidLogin_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,avoidLogin_url];
}
+(NSString *)get_userAuthen_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,userAuthen_url];
}
+(NSString *)get_userCancel_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,userCancel_url];
}
+(NSString *)get_setPassword_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,setPassword_url];
}
+(NSString *)get_createCase_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,createCase_url];
}
+(NSString *)get_updateCase_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,updateCase_url];
}
+(NSString *)get_cancelCase_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,cancelCase_url];
}
+(NSString *)get_deleteCase_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,deleteCase_url];
}
+(NSString *)get_queueCase_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,queueCase_url];
}
+(NSString *)get_oldPayPass_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,oldPayPass_url];
}
+(NSString *)get_goodsList_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,goodsList_url];
}
+(NSString *)get_oldMobile_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,oldMobile_url];
}
+(NSString *)get_updateMobile_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,updateMobile_url];
}
+(NSString *)get_blanceShow_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,blanceShow_url];
}
+(NSString *)get_send_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,send_url];
}
+(NSString *)get_balanceList_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,balanceList_url];
}
+(NSString *)get_isCollection_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,isCollection_url];
}
+(NSString *)get_realName_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,realName_url];
}
+(NSString *)get_notice_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,notice_url];
}
+(NSString *)get_infomation_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,infomation_url];
}
+(NSString *)get_message_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,message_url];
}
+(NSString *)get_haitao_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,haitao_url];
}
+(NSString *)get_interest_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,interest_url];
}
+(NSString *)get_subInterest_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,subInterest_url];
}
+(NSString *)get_recharge_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,recharge_url];
}
+(NSString *)get_cash_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,cash_url];
}
+(NSString *)get_category_url{
    return [NSString stringWithFormat:@"%@%@",SDXUrl,category_url];
}
+(NSString *)get_footmarkadd_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,footmarkadd_url];
}
+(NSString *)get_saveFoot_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,saveFoot_url];
}
+(NSString *)get_footDate_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,footDate_url];
}
+(NSString *)get_selectFootData_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,selectFootData_url];
}
+(NSString *)get_deleteFoot_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,deleteFoot_url];
}
+(NSString *)get_guessPrice_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,guessPrice_url];
}
+(NSString *)get_seleteGuess_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,seleteGuess_url];
}
+(NSString *)get_sshaoleList_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,sshaoleList_url];
}
+(NSString *)get_confirmGuess_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,confirmGuess_url];
}
+(NSString *)get_recomeList_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,recomeList_url];
}
+(NSString *)get_messageList_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,messageList_url];
}
+(NSString *)get_newCreateCase_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,newCreateCase_url];
}
+(NSString *)get_newOrderList_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,newOrderList_url];
}
+(NSString *)get_transport_List_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,transport_List_url];
}
+(NSString *)get_wlPay_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,wlPay_url];
}
+(NSString *)get_execute_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,execute_url];
}
+(NSString *)get_updateInfo_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,updateInfo_url];
}
+(NSString *)get_back_confirm_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,back_confirm_url];
}
+(NSString * )get_precelDetail_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,precelDetail_url];
}
+(NSString *)get_receive_confirm_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,receive_confirm_url];
}
+(NSString *)get_payment_tariff_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,payment_tariff_url];
}
+(NSString *)get_precelDelete_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,precelDelete_url];
}
+(NSString *)get_newCut_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,newCut_url];
}
+(NSString *)get_newPay_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,newPay_url];
}
+(NSString *)get_newOrderPay_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,newOrderPay_url];
}
+(NSString *)get_newOrderDetail_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,newOrderDetail_url];
}
+(NSString * )get_bid_add_show_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,bid_add_show_url];
}
+(NSString *)get_bid_add_create_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,bid_add_create_url];
}
+(NSString *)get_haitao_send_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,haitao_send_url];
}
+(NSString *)get_haitaoRateSelete_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,haitaoRateSelete_url];
}
+(NSString *)get_haitaoList_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,haitaoList_url];
}
+(NSString *)get_haitaoDetail_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,haitaoDetail_url];
}
+(NSString *)get_haitaoPay_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,haitaoPay_url];
}
+(NSString *)get_haitaoDelete_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,haitaoDelete_url];
}
+(NSString *)get_newOrderDelete_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,newOrderDelete_url];
}
+(NSString *)get_haitaoCancel_url{
    return [NSString stringWithFormat:@"%@%@",New_SDXUrl,haitaoCancel_url];
}
@end
