//
//  XMShareDingTalkUtil.h
//  分享测试
//
//  Created by ccpg_it on 2017/9/15.
//  Copyright © 2017年 ccpg_it. All rights reserved.
//

#import "XMShareUtil.h"
#import <DTShareKit/DTOpenKit.h>

@interface XMShareDingTalkUtil : XMShareUtil

/**
 *  分享到微博
 */
- (void)shareToDingTalk:(XMShareDingTalk_ContentType)shareType;

+ (instancetype)sharedInstance;

@end
