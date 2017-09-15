//  分享工具类基类
//  XMShareUtil.h
//  XMShare
//
//  Created by Amon on 15/8/7.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonMarco.h"

/** 微博分享的消息类型 */
typedef enum : NSUInteger {
    XMShare_Text_Type,//纯文字分享
    XMShare_Media_Type,//多媒体分享
    XMShare_Image_Type,//图片分享
} XMShareContentType;

/** QQ分享的消息类型 */
typedef enum : NSUInteger {
    XMShareQQ_Text_Type,
    XMShareQQ_Image_Type,
    XMShareQQ_Url_Type,
    XMShareQQ_Audio_Type,
    XMShareQQ_Video_Type,
} XMShareQQ_ContentType;

/** 钉钉分享的消息类型 */
typedef enum : NSUInteger {
    XMShareDingTalk_Text_Type,
    XMShareDingTalk_Image_Type,
    XMShareDingTalk_Url_Type,
    XMShareDingTalk_Audio_Type,
    XMShareDingTalk_Video_Type,
} XMShareDingTalk_ContentType;


@interface XMShareUtil : NSObject

/**
 *  分享标题
 */
@property (nonatomic, strong) NSString *shareTitle;

/**
 *  分享内容
 */
@property (nonatomic, strong) NSString *shareText;

/**
 *  分享链接地址
 */
@property (nonatomic, strong) NSString *shareUrl;

/**
 *  分享图片数据(小于10M,优先级高于图片链接)
 */
@property (nonatomic, strong) NSData *shareImgData;

/**
 *  分享图片链接地址
 */
@property (nonatomic, strong) NSString *shareImgUrl;


/**
 *  分享缩略图数据(小于32K,优先级高于图片链接)
 */
@property (nonatomic, strong) NSData *shareThumbnailData;

/**
 *  分享缩略图链接地址
 */
@property (nonatomic, strong) NSString *shareThumbnailUrl;

/**
 *  分享类型
 */
@property (nonatomic, assign) XMShareContentType XMShareContentType;

@end
