//
//  XMShareDingTalkUtil.m
//  分享测试
//
//  Created by ccpg_it on 2017/9/15.
//  Copyright © 2017年 ccpg_it. All rights reserved.
//

#import "XMShareDingTalkUtil.h"

@implementation XMShareDingTalkUtil

- (void)shareToDingTalk:(XMShareDingTalk_ContentType)shareType{

    switch (shareType) {
        case XMShareDingTalk_Text_Type:
        {
            [self shareTextToDingTalk];
        }
            break;
        case XMShareDingTalk_Image_Type:
        {
            [self shareImageToDingTalk];
        }
            break;
        case XMShareDingTalk_Url_Type:
        {
            [self shareWebToDingTalk];
        }
            break;
        default:
            break;
    }
    
}

- (void)openDingTalk
{
    NSLog(@"openDingTalk: %@", @([DTOpenAPI openDingTalk]));
}

- (void)shareTextToDingTalk
{
    DTSendMessageToDingTalkReq *sendMessageReq = [[DTSendMessageToDingTalkReq alloc] init];
    
    DTMediaMessage *mediaMessage = [[DTMediaMessage alloc] init];
    
    DTMediaTextObject *textObject = [[DTMediaTextObject alloc] init];
    textObject.text = self.shareTitle;
    
    mediaMessage.mediaObject = textObject;
    sendMessageReq.message = mediaMessage;
    
    BOOL result = [DTOpenAPI sendReq:sendMessageReq];
    if (result)
    {
        NSLog(@"Text 发送成功.");
    }
    else
    {
        NSLog(@"Text 发送失败.");
    }
}

- (void)shareImageToDingTalk
{
    DTSendMessageToDingTalkReq *sendMessageReq = [[DTSendMessageToDingTalkReq alloc] init];
    
    DTMediaMessage *mediaMessage = [[DTMediaMessage alloc] init];
    
    DTMediaImageObject *imageObject = [[DTMediaImageObject alloc] init];
    if (self.shareImgData) {
        imageObject.imageData = self.shareImgData;
    }else{
    
        imageObject.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.shareImgUrl]];
    }
    
    imageObject.imageURL = self.shareThumbnailUrl;
    
    mediaMessage.mediaObject = imageObject;
    sendMessageReq.message = mediaMessage;
    
    BOOL result = [DTOpenAPI sendReq:sendMessageReq];
    if (result)
    {
        NSLog(@"Image 发送成功.");
    }
    else
    {
        NSLog(@"Image 发送失败.");
    }
}

- (void)shareWebToDingTalk
{
    DTSendMessageToDingTalkReq *sendMessageReq = [[DTSendMessageToDingTalkReq alloc] init];
    
    DTMediaMessage *mediaMessage = [[DTMediaMessage alloc] init];
    DTMediaWebObject *webObject = [[DTMediaWebObject alloc] init];
    webObject.pageURL = self.shareUrl;
    
    mediaMessage.title = self.shareTitle;
    
    mediaMessage.thumbURL = self.shareThumbnailUrl;
    
    // Or Set a image data which less than 32K.
    // mediaMessage.thumbData = UIImagePNGRepresentation([UIImage imageNamed:@"open_icon"]);
    
    mediaMessage.messageDescription = self.shareText;
    mediaMessage.mediaObject = webObject;
    sendMessageReq.message = mediaMessage;
    
    BOOL result = [DTOpenAPI sendReq:sendMessageReq];
    if (result)
    {
        NSLog(@"Link 发送成功.");
    }
    else
    {
        NSLog(@"Link 发送失败.");
    }
}

+ (instancetype)sharedInstance
{
    
    static XMShareDingTalkUtil* util;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        util = [[XMShareDingTalkUtil alloc] init];
        
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
