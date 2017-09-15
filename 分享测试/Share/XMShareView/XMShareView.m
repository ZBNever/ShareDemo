//
//  XMShareView.m
//  XMShare
//
//  Created by Amon on 15/8/6.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import "XMShareView.h"

#import "VerticalUIButton.h"
#import "CommonMarco.h"
#import "XMShareUtilManager.h"


//  每一项的宽度
static const CGFloat itemWidth = 60.0;

//  每一项的高度
static const CGFloat itemHeight = 60.0;

//  水平间隔
static const CGFloat itemHorPadding = 20.0;

//  垂直间隔
static const CGFloat itemVerPadding = 20.0;


//  每行显示数量
static const NSInteger numbersOfItemInLine = 3;

@implementation XMShareView


- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configureData];
        [self initUI];
        
    }
    return self;
    
}

/**
 *  加载视图（视图界面可自定义）
 */
- (void)initUI
{
    
    //  背景色黑色半透明
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    
    //  点击关闭
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(clickClose)];
    [self addGestureRecognizer:tap];
    self.userInteractionEnabled = YES;
    
    CGFloat startY = 0;
    CGFloat bgViewWidth = itemWidth * numbersOfItemInLine + itemHorPadding * (numbersOfItemInLine + 1) ;
    CGFloat bgViewHeight = itemHeight * (iconList.count/numbersOfItemInLine) + itemVerPadding * 5;
    CGFloat bgViewX = (SIZE_OF_SCREEN.width - bgViewWidth) / 2;
    CGFloat bgViewY = (SIZE_OF_SCREEN.height - bgViewHeight) / 2;
    
    //  居中白色视图
    UIView *shareActionView = [[UIView alloc] initWithFrame:CGRectMake(bgViewX,
                                                                       bgViewY,
                                                                       bgViewWidth,
                                                                       bgViewHeight)];
    ViewRadius(shareActionView, 2);
    shareActionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:shareActionView];
    
    for ( int i = 0; i < iconList.count; i ++ ) {
        
        VerticalUIButton *tempButton;
        UIImage *img = [UIImage imageNamed: iconList[i]];
        
        int row = i / numbersOfItemInLine;
        
        int col = i % numbersOfItemInLine;
        
        CGFloat x =  (itemWidth + itemHorPadding) * col + itemHorPadding;
        
        CGFloat y = startY  + (itemHeight + itemVerPadding) * row + itemVerPadding;
        
        tempButton = [[VerticalUIButton alloc] initWithFrame:CGRectMake(x, y, itemWidth, itemHeight)];
        tempButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [tempButton setImage:img forState:UIControlStateNormal];
        [tempButton setTitle:textList[i] forState:UIControlStateNormal];
        [tempButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tempButton addTarget:self action:@selector(clickActionButton:) forControlEvents:UIControlEventTouchUpInside];
        
        if([textList[i] isEqualToString:NSLocalizedString(@"微信好友", nil)]){
            
            tempButton.tag = SHARE_ITEM_WEIXIN_SESSION;
            
        }else if([textList[i] isEqualToString:NSLocalizedString(@"朋友圈", nil)]){
            
            tempButton.tag = SHARE_ITEM_WEIXIN_TIMELINE;
            
        }else if([textList[i] isEqualToString:NSLocalizedString(@"QQ", nil)]){
            
            tempButton.tag = SHARE_ITEM_QQ;
            
        }else if([textList[i] isEqualToString:NSLocalizedString(@"QQ空间", nil)]){
            
            tempButton.tag = SHARE_ITEM_QZONE;
            
        }else if([textList[i] isEqualToString:NSLocalizedString(@"微博", nil)]){
            
            tempButton.tag = SHARE_ITEM_WEIBO;
            
        }else if ([textList[i] isEqualToString:NSLocalizedString(@"支付宝", nil)]){
        
            tempButton.tag = SHARE_ITEM_ALIPAY_SESSION;
        }else if([textList[i] isEqualToString:NSLocalizedString(@"钉钉", nil)]){
            
            tempButton.tag = SHARE_ITEM_DINGTALK;
            
        }else if([textList[i] isEqualToString:NSLocalizedString(@"短信", nil)]){
            
            tempButton.tag = SHARE_ITEM_MESSAGE;
            
        }else if ([textList[i] isEqualToString:NSLocalizedString(@"邮件", nil)]){
            
            tempButton.tag = SHARE_ITEM_EMAIL;
        }
        
        [shareActionView addSubview:tempButton];
    }
   
}


/**
 *  初始化数据
 */
- (void)configureData
{
    
    /**
     *  判断应用是否安装，可用于是否显示
     *  QQ和Weibo分别有网页版登录与分享，微信目前不支持
     */
    BOOL hadInstalledWeixin = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
    //    BOOL hadInstalledQQ = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
    //    BOOL hadInstalledWeibo = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weibo://"]];
    
    iconList = [[NSMutableArray alloc] init];
    textList = [[NSMutableArray alloc] init];
    
    if(hadInstalledWeixin){
        
        [iconList addObject:@"icon_share_wechat@2x"];
        [iconList addObject:@"icon_share_moment@2x"];
        [textList addObject:NSLocalizedString(@"微信好友", nil)];
        [textList addObject:NSLocalizedString(@"朋友圈", nil)];
        
    }
    
    //    if(hadInstalledQQ){
    
    [iconList addObject:@"icon_share_qq@2x"];
    [iconList addObject:@"icon_share_qzone@2x"];
    [textList addObject:NSLocalizedString(@"QQ", nil)];
    [textList addObject:NSLocalizedString(@"QQ空间", nil)];
    
    //    }
    
    //    if(hadInstalledWeibo){
    
    [iconList addObject:@"icon_share_webo@2x"];
    [textList addObject:NSLocalizedString(@"微博", nil)];
    
    //    }
    [iconList addObject:@"icon_share_alipay@2x"];
    [textList addObject:NSLocalizedString(@"支付宝", nil)];
    
    [iconList addObject:@"icon_share_dingtalk@2x"];
    [textList addObject:NSLocalizedString(@"钉钉", nil)];
    
    [iconList addObject:@"icon_share_message@2x"];
    [textList addObject:NSLocalizedString(@"短信", nil)];
    
    [iconList addObject:@"icon_share_email@2x"];
    [textList addObject:NSLocalizedString(@"邮件", nil)];
    
}

- (void)clickActionButton:(VerticalUIButton *)sender
{
    XMShareUtilManager *util = [XMShareUtilManager sharedInstance];
    util.shareTitle = self.shareTitle;
    util.shareText = self.shareText;
    util.shareUrl = self.shareUrl;
    util.shareImgData = self.shareImgData;
    util.shareImgUrl = self.shareImgUrl;
    util.shareThumbnailData = self.shareThumbnailData;
    util.shareThumbnailUrl = self.shareThumbnailUrl;
    
    if ( sender.tag == SHARE_ITEM_WEIXIN_SESSION ) {
        
        [util shareToWeixinSession:XMShare_Media_Type];

    }else if ( sender.tag == SHARE_ITEM_WEIXIN_TIMELINE ) {
        
        [util shareToWeixinTimeline:XMShare_Media_Type];
        
    }else if ( sender.tag == SHARE_ITEM_QQ ) {
        
        [util shareToQQ:XMShareQQ_Image_Type];
        
    }else if ( sender.tag == SHARE_ITEM_QZONE ) {
        
        [util shareToQzone:XMShareQQ_Url_Type];
        
    }else if ( sender.tag == SHARE_ITEM_WEIBO ) {
        
        [util shareToWeibo:XMShare_Media_Type];
        
    }else if (sender.tag == SHARE_ITEM_ALIPAY_SESSION){
    
        [util shareToAliPay:XMShare_Media_Type];
        
    }else if ( sender.tag == SHARE_ITEM_DINGTALK ) {
        
        [util shareToDingTalk:XMShareDingTalk_Url_Type];
        
    }else if ( sender.tag == SHARE_ITEM_MESSAGE ) {
        
        [util shareToMessage];
        
    }else if (sender.tag == SHARE_ITEM_EMAIL){
        
        [util shareToEmail];
    }
    
    [self clickClose];
    
}

- (void)clickClose
{
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 0.0;
    }];
    
    
}


@end
