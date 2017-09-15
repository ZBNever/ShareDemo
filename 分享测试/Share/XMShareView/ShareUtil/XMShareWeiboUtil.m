//
//  XMShareWeiboUtil.m
//  XMShare
//
//  Created by Amon on 15/8/6.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import "XMShareWeiboUtil.h"

@implementation XMShareWeiboUtil

- (void)shareToWeibo:(XMShareContentType)shareType
{
    
    [self shareToWeiboBase:shareType];
    
}

- (void)shareToWeiboBase:(XMShareContentType)shareType
{
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = APP_KEY_WEIBO_RedirectURL;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare:shareType] authInfo:authRequest access_token:nil];
    
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    
    [WeiboSDK sendRequest:request];
}

- (WBMessageObject *)messageToShare:(XMShareContentType)shareType
{
    //一个消息结构由三部分组成：文字、图片和多媒体数据。三部分内容中至少有一项不为空，图片和多媒体数据不能共存。
    WBMessageObject *message = [WBMessageObject message];
    //判断是否安装了微博客户端
    BOOL hadInstalledWeibo = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weibo://"]];
    
    if(hadInstalledWeibo){
        
        switch (shareType) {
            case XMShare_Text_Type:
            {
                message.text = [NSString stringWithFormat:@"#%@#\n%@\n%@", self.shareTitle, self.shareText, self.shareUrl];
            }
                break;
            case XMShare_Image_Type:
            {
                //消息图片内容
                WBImageObject *imageObj = [WBImageObject object];
                if (self.shareImgData) {
                    imageObj.imageData = self.shareImgData;
                }else if (self.shareImgUrl){
                    imageObj.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.shareImgUrl]];
                }
                else{
                    
                    showAlert(@"分享图片不能为空");
                    return nil;
                }
                
                message.imageObject = imageObj;
                message.text = self.shareText;
            }
                break;
            case XMShare_Media_Type:
            {
                //消息的多媒体内容
                WBWebpageObject *webpage = [WBWebpageObject object];
                webpage.objectID = @"identifier1";
                webpage.title = self.shareTitle;
                webpage.description = self.shareText;
                // 可改为自定义图片
                if (self.shareThumbnailData) {
                    webpage.thumbnailData = self.shareThumbnailData;
                }else{
                    webpage.thumbnailData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.shareImgUrl]];
                }
                webpage.webpageUrl = self.shareUrl;
                message.mediaObject = webpage;
            }
                break;
            default:
            {
                message.text = [NSString stringWithFormat:@"#%@#\n%@\n%@", self.shareTitle, self.shareText, self.shareUrl];
            }
                break;
        }

    }
    
    
    
    return message;
    
}


+ (instancetype)sharedInstance
{
    
    static XMShareWeiboUtil* util;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        util = [[XMShareWeiboUtil alloc] init];
        
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
