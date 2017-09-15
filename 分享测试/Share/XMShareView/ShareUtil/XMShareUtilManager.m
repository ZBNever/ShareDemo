//
//  XMShareToUtil.m
//  分享测试
//
//  Created by ccpg_it on 2017/9/12.
//  Copyright © 2017年 ccpg_it. All rights reserved.
//

#import "XMShareUtilManager.h"


@implementation XMShareUtilManager

- (void)shareToWeixinSession:(XMShareContentType)shareType
{
    XMShareWechatUtil *util = [XMShareWechatUtil sharedInstance];
    util.shareTitle = self.shareTitle;
    util.shareText = self.shareText;
    util.shareUrl = self.shareUrl;
    util.shareImgData = self.shareImgData;
    util.shareImgUrl = self.shareImgUrl;
    util.shareThumbnailData = self.shareThumbnailData;
    util.shareThumbnailUrl = self.shareThumbnailUrl;

    [util shareToWeixinSession:shareType];
    
}

- (void)shareToWeixinTimeline:(XMShareContentType)shareType
{
    XMShareWechatUtil *util = [XMShareWechatUtil sharedInstance];
    util.shareTitle = self.shareTitle;
    util.shareText = self.shareText;
    util.shareUrl = self.shareUrl;
    util.shareImgData = self.shareImgData;
    util.shareImgUrl = self.shareImgUrl;
    util.shareThumbnailData = self.shareThumbnailData;
    util.shareThumbnailUrl = self.shareThumbnailUrl;
    [util shareToWeixinTimeline:shareType];
    
}

- (void)shareToQQ:(XMShareQQ_ContentType)shareType
{
    XMShareQQUtil *util = [XMShareQQUtil sharedInstance];
    util.shareTitle = self.shareTitle;
    util.shareText = self.shareText;
    util.shareUrl = self.shareUrl;
    util.shareImgData = self.shareImgData;
    util.shareImgUrl = self.shareImgUrl;
    util.shareThumbnailData = self.shareThumbnailData;
    util.shareThumbnailUrl = self.shareThumbnailUrl;

    [util shareToQQ:shareType];
}

- (void)shareToQzone:(XMShareQQ_ContentType)shareType
{
    XMShareQQUtil *util = [XMShareQQUtil sharedInstance];
    util.shareTitle = self.shareTitle;
    util.shareText = self.shareText;
    util.shareUrl = self.shareUrl;
    util.shareImgData = self.shareImgData;
    util.shareImgUrl = self.shareImgUrl;
    util.shareThumbnailData = self.shareThumbnailData;
    util.shareThumbnailUrl = self.shareThumbnailUrl;

    [util shareToQzone:shareType];
}

- (void)shareToWeibo:(XMShareContentType)shareType
{
    XMShareWeiboUtil *util = [XMShareWeiboUtil sharedInstance];
    util.shareTitle = self.shareTitle;
    util.shareText = self.shareText;
    util.shareUrl = self.shareUrl;
    util.shareImgData = self.shareImgData;
    util.shareImgUrl = self.shareImgUrl;
    util.shareThumbnailData = self.shareThumbnailData;
    util.shareThumbnailUrl = self.shareThumbnailUrl;

    [util shareToWeibo:shareType];
    
}

- (void)shareToAliPay:(XMShareContentType)shareType
{
    XMShareAliPayUtil *util = [XMShareAliPayUtil sharedInstance];
    util.shareTitle = self.shareTitle;
    util.shareText = self.shareText;
    util.shareUrl = self.shareUrl;
    util.shareImgData = self.shareImgData;
    util.shareImgUrl = self.shareImgUrl;
    util.shareThumbnailData = self.shareThumbnailData;
    util.shareThumbnailUrl = self.shareThumbnailUrl;

    [util sendShareMessage];
    
}
- (void)shareToDingTalk:(XMShareDingTalk_ContentType)shareType{

    
    XMShareDingTalkUtil *util = [XMShareDingTalkUtil sharedInstance];
    util.shareTitle = self.shareTitle;
    util.shareText = self.shareText;
    util.shareUrl = self.shareUrl;
    util.shareImgData = self.shareImgData;
    util.shareImgUrl = self.shareImgUrl;
    util.shareThumbnailData = self.shareThumbnailData;
    util.shareThumbnailUrl = self.shareThumbnailUrl;
    
    [util shareToDingTalk:shareType];
}
/** 分享到短信 */
- (void)shareToMessage{
    
    if (![MFMessageComposeViewController canSendText]) {
        return;
    }
    MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc]init];
    //短信内容
    messageVC.body = self.shareTitle;
    
    //短信收件人
//    messageVC.recipients = @[@"10086",@"10010"];
    //MFMessageComposeViewConreoller的代理
    messageVC.messageComposeDelegate = self;
    
    [[self getCurrentVC] presentViewController:messageVC animated:YES completion:nil];
    
}

- (void)shareToEmail{

    if (![MFMailComposeViewController canSendMail]) {
        return;
    }
    MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc]init];
    //收件人列表
    [mailVC setToRecipients:@[@"never1750@163.com"]];
    //抄送
    [mailVC setCcRecipients:@[@"778275034@qq.com"]];
    //密送
//    [mailVC setBccRecipients:@[@"987676@163.com"]];
    //主题
    [mailVC setSubject:self.shareTitle];
    //内容
    [mailVC setMessageBody:self.shareText isHTML:NO];
    //附件
    NSData *imageData;
    if (self.shareImgData) {
        imageData = self.shareImgData;
    }else{
        imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.shareImgUrl]];
    }

    [mailVC addAttachmentData:imageData mimeType:@"image/jpg" fileName:@"rockstar programmer.jpg"];
    //MFMailComposeViewConreoller的代理
    mailVC.mailComposeDelegate = self;
    [[self getCurrentVC] presentViewController:mailVC animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
//    NSLog(@"result:%lu",result);
    NSString *messag;
    switch (result) {
        case 0:
        {
            messag = @"取消分享";
        }
            break;
        case 1:
        {
            messag = @"分享成功";
        }
            break;
        case 2:
        {
            messag = @"分享失败";
        }
            break;
        default:
        {
            messag = @"分享失败";
        }
            break;
    }
    
    [[self getCurrentVC] dismissViewControllerAnimated:YES completion:^{
        showAlert(messag)
    }];
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    NSLog(@"result:%lu",result);
    NSString *messag;
    switch (result) {
        case 0:
        {
            messag = @"取消分享";
        }
            break;
        case 1:
        {
            messag = @"保存成功";
        }
            break;
        case 2:
        {
            messag = @"分享成功";
        }
            break;
        case 3:
        {
            messag = @"分享失败";
        }
            break;
        default:
        {
            messag = @"分享失败";
        }
            break;
    }
    
    [[self getCurrentVC] dismissViewControllerAnimated:YES completion:^{
        showAlert(messag)
    }];
}


+ (instancetype)sharedInstance
{
    
    static XMShareUtilManager* util;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        util = [[XMShareUtilManager alloc] init];
        
    });
    return util;
    
}

- (instancetype)init
{
    
    static id obj=nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        obj = [super init];
        if (obj) {
            
        }
        
    });
    self=obj;
    return self;
    
}

/** ios9以后使用此方法回调 */
- (BOOL)RegisterApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([[url absoluteString] hasPrefix:@"tencent"]) {
        
        return [QQApiInterface handleOpenURL:url delegate:self];
        
    }else if([[url absoluteString] hasPrefix:@"wb"]) {
        
        return [WeiboSDK handleOpenURL:url delegate:self];
        
    }else if([[url absoluteString] hasPrefix:@"wx"]) {
        
        return [WXApi handleOpenURL:url delegate:self];
        
    }else if ([[url absoluteString] hasPrefix:@"ap"]){
        
        return [APOpenAPI handleOpenURL:url delegate:self];
        
    }else if ([[url absoluteString] hasPrefix:@"ding"]){
        
        return [DTOpenAPI handleOpenURL:url delegate:self];
        
    }
    
    return NO;
}
/** ios9以前使用此方法回调 */
- (BOOL)RegisterApplication:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([[url absoluteString] hasPrefix:@"tencent"]) {
        
        return [TencentOAuth HandleOpenURL:url];
        
    }else if([[url absoluteString] hasPrefix:@"wb"]) {
        
        return [WeiboSDK handleOpenURL:url delegate:self];
        
    }else if([[url absoluteString] hasPrefix:@"wx"]){
        
        return [WXApi handleOpenURL:url delegate:self];
        
    }else if([[url absoluteString] hasPrefix:@"ap"]){
        
        return [APOpenAPI handleOpenURL:url delegate:self];
        
    }else if ([[url absoluteString] hasPrefix:@"di"]){
        
        return [DTOpenAPI handleOpenURL:url delegate:self];
    }
    return NO;
}

/** 此处传入开发者平台申请的APPid */
- (void)registerWithQQAppID:(NSString *)QQAppID WechatAppID:(NSString *)WechatAppID WeiboAppID:(NSString *)WeiboAppID AliPayAppID:(NSString *)AliPayAppID DingTalkAppID:(NSString *)DingTalkAppID{
    
    
    if (QQAppID && QQAppID.length != 0) {
        [[NSUserDefaults standardUserDefaults] setObject:QQAppID forKey:@"APP_KEY_QQ"];
    }
    if (WechatAppID && WechatAppID.length != 0) {
        [WXApi registerApp:WechatAppID];
    }
    if (WeiboAppID && WeiboAppID.length != 0) {
        [WeiboSDK enableDebugMode:YES];
        [WeiboSDK registerApp:WeiboAppID];
    }
    if (AliPayAppID && AliPayAppID.length != 0) {
        [APOpenAPI registerApp:AliPayAppID];
    }
    if (DingTalkAppID && DingTalkAppID.length != 0) {
        [DTOpenAPI registerApp:DingTalkAppID];
    }
    
}

#pragma mark - 实现代理回调

/**
 *  微博
 
 @param request 请求响应
 */
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
    
}

/**
 *  微博
 *
 *  @param response 响应体。根据 WeiboSDKResponseStatusCode 作对应的处理.
 *  具体参见 `WeiboSDKResponseStatusCode` 枚举.
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    NSString *message;
    switch (response.statusCode) {
        case WeiboSDKResponseStatusCodeSuccess:
            message = @"分享成功";
            break;
        case WeiboSDKResponseStatusCodeUserCancel:
            message = @"取消分享";
            break;
        case WeiboSDKResponseStatusCodeSentFail:
            message = @"分享失败";
            break;
        default:
            message = @"分享失败";
            break;
    }
    showAlert(message);
}

/**
 *  处理来至QQ的请求
 *
 *  @param req QQApi请求消息基类
 */
- (void)onReq:(QQBaseReq *)req
{
    
}


/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response{
    
    
}

/**
 处理来自QQ和微信的返回响应,QQ跟微信的代理方法名相同,故此做以下处理
 
 @param resp 响应体，根据响应结果作对应处理
 */
- (void)onResp:(id)resp{
    
    //Wechat分享返回
    NSString *message;
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        
        SendMessageToWXResp * tmpResp = (SendMessageToWXResp *)resp;
        
        if (tmpResp.errCode == WXSuccess) {
            //分享成功
            message = @"分享成功";
        }else{
            //分享失败
            message = @"分享失败";
        }
        
    }
    
    //QQ分享返回
    
    if ([resp isKindOfClass:[SendMessageToQQResp class]]) {
        
        SendMessageToQQResp * tmpResp = (SendMessageToQQResp *)resp;
        
        if (tmpResp.type == ESENDMESSAGETOQQRESPTYPE && [tmpResp.result integerValue] == 0) {
            //分享成功
            message = @"分享成功";
        }
        else{
            //分享失败
            message = @"分享失败";
        }
        
    }
    
    //支付宝回调信息
    if ([resp isKindOfClass:[APBaseResp class]]) {
        
        APBaseResp *tempResp = (APBaseResp *)resp;
        
        if (tempResp.errCode == APSuccess) {
            message = @"分享成功";
        } else {
            message = @"分享失败";
            
        }
    }
    //钉钉回调信息
    if ([resp isKindOfClass:[DTBaseResp class]]) {
        
        DTBaseResp *tempResp = (DTBaseResp *)resp;

        if (tempResp.errorCode == DTOpenAPISuccess) {
            message = @"分享成功";
        }else if (tempResp.errorCode == DTOpenAPIErrorCodeCommon){
            message = tempResp.errorMessage;
        }else if (tempResp.errorCode == DTOpenAPIErrorCodeUserCancel){
            message = @"取消分享";
        }else if (tempResp.errorCode == DTOpenAPIErrorCodeSendFail){
            message = @"分享失败";
        }else if (tempResp.errorCode == DTOpenAPIErrorCodeAuthDeny){
            message = tempResp.errorMessage;
        }
        else {
            message = tempResp.errorMessage;
            
        }
    }
    showAlert(message);
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
@end
