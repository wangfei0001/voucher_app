//
//  AppDelegate.m
//  voucher
//
//  Created by fei wang on 13-8-22.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "AppDelegate.h"

#import "KeychainItemWrapper.h"

@implementation AppDelegate



- (void)buildUI
{
    //background for tab bar
    UIImage* tabBarBackground = [UIImage imageNamed:@"tabbar.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    //select image for tab bar
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"selection-tab.png"]];
    
    //background for navigation bar
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
              [UIColor whiteColor],
              UITextAttributeTextColor,
              [UIColor darkGrayColor],
              UITextAttributeTextShadowColor,
              [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
              UITextAttributeTextShadowOffset,
              nil] 
    forState:UIControlStateNormal];
    
}




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    
    
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
@end
