//
//  XMShareQQUtil.m
//  XMShare
//
//  Created by Amon on 15/8/6.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import "XMShareQQUtil.h"


@implementation XMShareQQUtil


- (void)shareToQQ:(XMShareQQ_ContentType)shareType
{
    
    [self shareToQQBase:SHARE_QQ_TYPE_SESSION contentType:shareType];
    
}

- (void)shareToQzone:(XMShareQQ_ContentType)shareType
{
    
    [self shareToQQBase:SHARE_QQ_TYPE_QZONE contentType:shareType];
    
}

- (void)shareToQQBase:(SHARE_QQ_TYPE)type contentType:(XMShareQQ_ContentType)shareType
{
    NSString *QQ_Key = [[NSUserDefaults standardUserDefaults] objectForKey:@"APP_KEY_QQ"];
    TencentOAuth *tencentOAuth = [[TencentOAuth alloc] initWithAppId:QQ_Key andDelegate:self];
    NSLog(@"TencentOAuth accessToken:%@", tencentOAuth.accessToken);
    
    NSString *utf8String = self.shareUrl;
    NSString *theTitle = self.shareTitle;
    NSString *description = self.shareText;
    NSData *imageData;
    if (self.shareImgData) {
        imageData = self.shareImgData;
    }else{
    
        imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.shareImgUrl]];
    }
    
    NSData *thumbnailData;
    
    if (self.shareThumbnailData) {
        
        thumbnailData = self.shareThumbnailData;
        
    }else{
    
        thumbnailData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.shareThumbnailUrl]];
    }
    SendMessageToQQReq *req;
    switch (shareType) {
        case XMShareQQ_Text_Type:
        {
            QQApiTextObject *textObj = [QQApiTextObject objectWithText:self.shareText];
            req = [SendMessageToQQReq reqWithContent:textObj];
        }
            break;
        case XMShareQQ_Image_Type:
        {
            QQApiImageObject *imageObj = [QQApiImageObject objectWithData:imageData previewImageData:thumbnailData title:self.shareTitle description:self.shareText];
            req = [SendMessageToQQReq reqWithContent:imageObj];
        }
            break;
        case XMShareQQ_Url_Type:
        {
            QQApiNewsObject *newsObj = [QQApiNewsObject
                                        objectWithURL:[NSURL URLWithString:utf8String]
                                        title:theTitle
                                        description:description
                                        previewImageData:thumbnailData];
            
            req = [SendMessageToQQReq reqWithContent:newsObj];
        }
            break;
        case XMShareQQ_Audio_Type:
        {
            QQApiAudioObject *audioObj = [QQApiAudioObject
                                        objectWithURL:[NSURL URLWithString:utf8String]
                                        title:theTitle
                                        description:description
                                        previewImageData:thumbnailData];
            
            req = [SendMessageToQQReq reqWithContent:audioObj];
        }
            break;
        case XMShareQQ_Video_Type:
        {
            QQApiVideoObject *videoObj = [QQApiVideoObject
                                        objectWithURL:[NSURL URLWithString:utf8String]
                                        title:theTitle
                                        description:description
                                        previewImageData:thumbnailData];
            
            req = [SendMessageToQQReq reqWithContent:videoObj];
        }
            break;
        default:
        {
            QQApiNewsObject *newsObj = [QQApiNewsObject
                                        objectWithURL:[NSURL URLWithString:utf8String]
                                        title:theTitle
                                        description:description
                                        previewImageData:thumbnailData];
            
            req = [SendMessageToQQReq reqWithContent:newsObj];
        }
            break;
    }

    

    
    if (type == SHARE_QQ_TYPE_SESSION) {
        
        //将内容分享到qq
        QQApiSendResultCode sent = [QQApiInterface sendReq:req];
        NSLog(@"QQApiSendResultCode:%d", sent);
        
    }else{
        
        //将内容分享到qzone
        QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
        NSLog(@"Qzone QQApiSendResultCode:%d", sent);
        switch (sent) {
            case 10000:
            {
                showAlert(@"qzone分享不支持text类型分享")
            }
                break;
            case 10001:
            {
                showAlert(@"qzone分享不支持image类型分享")
            }
                break;
            default:
                break;
        }
    }
}
- (void)tencentDidLogin{

}
- (void)tencentDidNotLogin:(BOOL)cancelled{

}
- (void)tencentDidNotNetWork{

}
+ (instancetype)sharedInstance
{
    
    static XMShareQQUtil* util;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        util = [[XMShareQQUtil alloc] init];
        
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
