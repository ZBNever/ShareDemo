//
//  XMShareView.h
//  XMShare
//
//  Created by Amon on 15/8/6.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import <UIKit/UIKit.h>

//  分享类型
typedef NS_ENUM(NSInteger, SHARE_ITEM){
    
    //  微信会话
    SHARE_ITEM_WEIXIN_SESSION,
    
    //  微信朋友圈
    SHARE_ITEM_WEIXIN_TIMELINE,
    
    //  QQ会话
    SHARE_ITEM_QQ,
    
    //  QQ空间
    SHARE_ITEM_QZONE,
    
    //  微博
    SHARE_ITEM_WEIBO,
    
    //  支付宝好友
    SHARE_ITEM_ALIPAY_SESSION,

    //  钉钉
    SHARE_ITEM_DINGTALK,
    
    //  短信
    SHARE_ITEM_MESSAGE,
    
    //  邮箱
    SHARE_ITEM_EMAIL,
};


@interface XMShareView : UIView

{
    //  图片项
    NSMutableArray *iconList;
    
    //  文字项
    NSMutableArray *textList;
}
//  分享平台
@property (nonatomic, strong) NSArray *shareToThirdArr;

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

- (instancetype)initWithFrame:(CGRect)frame shareArr:(NSArray *)shareArray;


@end

