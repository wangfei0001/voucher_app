//
//  AppDelegate.m
//  voucher
//
//  Created by fei wang on 13-8-22.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "AppDelegate.h"

#import "KeychainItemWrapper.h"

#import "UIImage+FrColor.h"



@implementation AppDelegate



- (void)buildUI
{
    //background for tab bar
    UIImage* tabBarBackground = [UIImage imageNamed:@"tabbar.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    //select image for tab bar
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"selection-tab.png"]];
    
    
    //navigation bar
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] rect:CGRectMake(0, 0, 320, 44)] forBarMetrics:UIBarMetricsDefault];
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                               [UIColor blackColor],UITextAttributeTextColor,
                                               [UIColor clearColor],      UITextAttributeTextShadowColor,
                                               [NSValue valueWithUIOffset:UIOffsetMake(-1, 0)], UITextAttributeTextShadowOffset,
                                               [UIFont fontWithName:@"Arial" size:16.0],UITextAttributeFont,
                                               nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    
    
    //background for navigation bar
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
              [UIColor whiteColor],
              UITextAttributeTextColor,
              [UIColor darkGrayColor],
              UITextAttributeTextShadowColor,
              [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
              UITextAttributeTextShadowOffset,
              nil] 
    forState:UIControlStateNormal];
    
    
    UIImage *backButtonImage = [[UIImage imageNamed:@"button_back.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 6)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    // Change the appearance of other navigation button
    UIImage *barButtonImage = [[UIImage imageNamed:@"button_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 6)];
    [[UIBarButtonItem appearance] setBackgroundImage:barButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
}




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    NSBundle *bundle = [NSBundle mainBundle];
//    NSDictionary *info = [bundle infoDictionary];
//    NSString *prodName = [info objectForKey:@"CFBundleDisplayName"];
    
    //微博
    [ WeiboSDK registerApp:kAppKey ];
    [ WeiboSDK enableDebugMode:YES ];
    
    //微信
//    [WXApi registerApp:WXAppID];
    
    
    
    
    
    //global variables.
    self.global = [[Global alloc] init];
    
    [Session loadCredentials];
    

    // Override point for customization after application launch.
    
//    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
//    UITabBar *tabbar = [UITabBar appearance];
    
//    UINavigationBar *navbar = [UINavigationBar appearance];
    
//    [navbar setBackgroundColor:[UIColor redColor]];
//    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
//    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque
//                                                animated:NO];
    
    [self buildUI];

    
    return YES;
    
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



#pragma mark - 各种SNS的sso模块

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
//    return [WXApi handleOpenURL:url delegate:self];
    
    return [ WeiboSDK handleOpenURL:url delegate:self ];
    
    return [self.qqwbapi handleOpenURL:url];
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
   
//    return [WXApi handleOpenURL:url delegate:self];

    return [ WeiboSDK handleOpenURL:url delegate:self ];

    return [self.qqwbapi handleOpenURL:url];
 
}

#pragma mark - 一些公用函数

- (void)ShowLoading: (UIView *)view
{
    if(self.HUD != nil) [self HideLoading];
    
    self.HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:self.HUD];
    [self.HUD show:YES];
}

- (void)HideLoading
{
    [self.HUD removeFromSuperview];
    self.HUD = nil;
}

- (void)showAlert: (NSString *)message
{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"出错啦"
                                                   message:message
                                                  delegate:NULL
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:NULL];

    [alert show];
}


#pragma mark - 新浪微薄的回调函数

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    if ([request isKindOfClass:WBProvideMessageForWeiboRequest.class])
    {
//        ProvideMessageForWeiboViewController *controller = [[[ProvideMessageForWeiboViewController alloc] init] autorelease];
//        [self.viewController presentModalViewController:controller animated:YES];
    }
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
//        NSString *title = @"发送结果";
//        NSString *message = [NSString stringWithFormat:@"响应状态: %d\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",
//                             response.statusCode, response.userInfo, response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
//        [alert release];
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
//        NSString *title = @"认证结果";
//        NSString *message = [NSString stringWithFormat:@"响应状态: %d\nresponse.userId: %@\nresponse.accessToken: %@\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",
//                             response.statusCode, [(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken], response.userInfo, response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        
//        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
//        
//        [alert show];
//        [alert release];
    }
}


@end
