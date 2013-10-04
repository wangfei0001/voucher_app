//
//  AppDelegate.h
//  voucher
//
//  Created by fei wang on 13-8-22.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Session.h"

#import "Global.h"

#import "MBProgressHUD.h"

#import "WeiboSDK.h"

#import "WeiboApi.h"

#import "WXApi.h"

#define APP_DELEGATE (AppDelegate*)[UIApplication sharedApplication].delegate

@interface AppDelegate : UIResponder <UIApplicationDelegate,
WeiboSDKDelegate,
WXApiDelegate
>




@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MBProgressHUD *HUD;

@property (strong, nonatomic) Global *global;


@property (strong, nonatomic) WeiboApi *qqwbapi;    //腾迅微薄api


- (void)ShowLoading: (UIView *)view;

- (void)HideLoading;

- (void)showAlert: (NSString *)message;

@end
