//
//  XMShareAliPayUtil.m
//  分享测试
//
//  Created by ccpg_it on 2017/9/13.
//  Copyright © 2017年 ccpg_it. All rights reserved.
//

#import "XMShareAliPayUtil.h"


@implementation XMShareAliPayUtil

- (void)sendShareMessage:(XMShareAP_ContentType)shareType
{
    //  创建消息载体 APMediaMessage 对象
    APMediaMessage *message = [[APMediaMessage alloc] init];
    

    switch (shareType) {
        case XMShareAP_Text_Type:
        {
        //  创建文本类型的消息对象
            APShareTextObject *textObj = [[APShareTextObject alloc] init];
            textObj.text = @"此处填充发送到支付宝的纯文本信息";
        }
            break;
        case XMShareAP_Image_Type:
        {
            APShareImageObject *imageObj = [[APShareImageObject alloc] init];
            imageObj.imageData = self.shareImgData;
            imageObj.imageUrl = self.shareImgUrl;
            message.mediaObject = imageObj;
        }
            break;
        case XMShareAP_Url_Type:
        {
            APShareWebObject *webObj = [[APShareWebObject alloc] init];
            webObj.wepageUrl = self.shareUrl;
            
            //  回填 APMediaMessage 的消息对象
            message.mediaObject = webObj;
        }
            break;
        default:
            break;
    }


    message.title = self.shareTitle;
    message.desc = self.shareText;
    message.thumbData = self.shareThumbnailData;
    message.thumbUrl = self.shareThumbnailUrl;
    
    
    //  创建发送请求对象
    APSendMessageToAPReq *request = [[APSendMessageToAPReq alloc] init];
    //  填充消息载体对象
    request.message = message;
    //  分享场景，0为分享到好友，1为分享到生活圈；支付宝9.9.5版本至当前版本，分享入口已合并，scene参数并没有被使用，用户会在跳转进支付宝后选择分享场景（好友、动态、圈子等），但为保证老版本上无问题，建议还是照常传入。
    request.scene = 0;
    //  发送请求，返回接口调用结果，用户操作行为结果通过接收响应消息获得，后面详解
    BOOL result = [APOpenAPI sendReq:request];
    if (!result) {
        //失败处理....
    }
}
+ (instancetype)sharedInstance
{
    
    static XMShareAliPayUtil* util;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        util = [[XMShareAliPayUtil alloc] init];
        
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
@end
