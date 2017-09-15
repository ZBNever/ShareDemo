//
//  ViewController.m
//  分享测试
//
//  Created by ccpg_it on 2017/9/7.
//  Copyright © 2017年 ccpg_it. All rights reserved.
//

#import "ViewController.h"
#import "XMShareView.h"
#import "CommonMarco.h"
#import <MessageUI/MessageUI.h>

@interface ViewController ()<MFMessageComposeViewControllerDelegate>
/** 分享界面 */
@property (nonatomic, strong) XMShareView *shareView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(0, 0, 200, 100);
    shareBtn.center = CGPointMake(SIZE_OF_SCREEN.width/2.0, SIZE_OF_SCREEN.height/2.0);
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareBtn setTitle:@"分享一下" forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    
}


- (void)shareBtnClick{

    
    
    if(!self.shareView){
        
        
        self.shareView = [[XMShareView alloc] initWithFrame:self.view.bounds];
         
        self.shareView.alpha = 0.0;
        
        self.shareView.shareTitle = NSLocalizedString(@"分享标题", nil);
        
        self.shareView.shareText = NSLocalizedString(@"分享内容", nil);
        
        self.shareView.shareUrl = @"http://www.jianshu.com/u/0819c4a1f916";
        
        self.shareView.shareImgData = UIImageJPEGRepresentation([UIImage imageNamed:@"iphoneX.jpg"], 1.0);
        
//        self.shareView.shareThumbnailData = UIImageJPEGRepresentation([UIImage imageNamed:@"logo.jpg"], 0.5);
        
        //缩略图
        self.shareView.shareThumbnailUrl = @"http://upload.jianshu.io/users/upload_avatars/1373050/38ba11ce-53fc-43c3-8cb2-b69acf6eaf02.png?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240";
        
        [self.view addSubview:self.shareView];
        
        [UIView animateWithDuration:1 animations:^{
            self.shareView.alpha = 1.0;
        }];
        
        
    }else{
        
//        [self shareToMessage];
        
        [UIView animateWithDuration:1 animations:^{
            self.shareView.alpha = 1.0;
        }];
        
    }
}
/** 分享到短信 */
- (void)shareToMessage{
    
    if (![MFMessageComposeViewController canSendText]) {
        return;
    }
    MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc]init];
    //短信内容
    messageVC.body = @"跟你分享一个超赞的App";
    //短信收件人
    messageVC.recipients = @[@"10086",@"10010"];
    //MFMessageComposeViewConreoller的代理
    messageVC.messageComposeDelegate = self;
    
    [self presentViewController:messageVC animated:YES completion:nil];
    
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{

    NSLog(@"result:%lu",result);
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
