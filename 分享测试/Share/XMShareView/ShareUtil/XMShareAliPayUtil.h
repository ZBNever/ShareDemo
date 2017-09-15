//
//  XMShareAliPayUtil.h
//  分享测试
//
//  Created by ccpg_it on 2017/9/13.
//  Copyright © 2017年 ccpg_it. All rights reserved.
//

#import "XMShareUtil.h"
#import "APOpenAPI.h"

@interface XMShareAliPayUtil : XMShareUtil

+ (instancetype)sharedInstance;

- (void)sendShareMessage;

@end
