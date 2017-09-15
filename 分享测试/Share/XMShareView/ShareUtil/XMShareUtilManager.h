//
//  XMShareToUtil.h
//  分享测试
//
//  Created by ccpg_it on 2017/9/12.
//  Copyright © 2017年 ccpg_it. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CommonMarco.h"
#import "XMShareWeiboUtil.h"
#import "XMShareWechatUtil.h"
#import "XMShareQQUtil.h"
#import "XMShareAliPayUtil.h"
#import "XMShareDingTalkUtil.h"
#import <MessageUI/MessageUI.h>

#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WeiboSDK.h"
#import "APOpenAPI.h"
#import <DTShareKit/DTOpenKit.h>


@interface XMShareUtilManager : NSObject<WeiboSDKDelegate, QQApiInterfaceDelegate,WXApiDelegate,APOpenAPIDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate,DTOpenAPIDelegate>

//  分享标题
@property (nonatomic, strong) NSString *shareTitle;

//  分享文本
@property (nonatomic, strong) NSString *shareText;

//  分享链接
@property (nonatomic, strong) NSString *shareUrl;

//  分享图片数据(小于10M,优先级高于图片链接)
@property (nonatomic, strong) NSData *shareImgData;

//  分享图片链接
@property (nonatomic, strong) NSString *shareImgUrl;

//  分享缩略图数据(优先级高于图片链接)
@property (nonatomic, strong) NSData *shareThumbnailData;

//  分享缩略图链接地址
@property (nonatomic, strong) NSString *shareThumbnailUrl;


+ (instancetype)sharedInstance;
/** 分享到微信会话 */
- (void)shareToWeixinSession:(XMShareContentType)shareType;
/** 分享到微信朋友圈 */
- (void)shareToWeixinTimeline:(XMShareContentType)shareType;
/** 分享到QQ会话 */
- (void)shareToQQ:(XMShareQQ_ContentType)shareType;
/** 分享到QQ空间 */
- (void)shareToQzone:(XMShareQQ_ContentType)shareType;
/** 分享到新浪微博 */
- (void)shareToWeibo:(XMShareContentType)shareType;
/** 分享到支付宝好友 */
- (void)shareToAliPay:(XMShareContentType)shareType;
/** 分享到钉钉 */
- (void)shareToDingTalk:(XMShareDingTalk_ContentType)shareType;
/** 分享到短信 */
- (void)shareToMessage;
/** 分享到邮件 */
- (void)shareToEmail;
/**
 *  注册AppID 不需要的就传nil
 */
- (void)registerWithQQAppID:(NSString *)QQAppID
                WechatAppID:(NSString *)WechatAppID
                 WeiboAppID:(NSString *)WeiboAppID
                AliPayAppID:(NSString *)AliPayAppID
              DingTalkAppID:(NSString *)DingTalkAppID;


/** ios9以后使用此方法回调 */
- (BOOL)RegisterApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
/** ios9以前使用此方法回调 */
- (BOOL)RegisterApplication:(UIApplication *)application handleOpenURL:(NSURL *)url;

@end
