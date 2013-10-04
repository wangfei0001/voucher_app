//
//  DefaultController.m
//  voucher
//
//  Created by fei wang on 13-8-31.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "DefaultController.h"

#import "AppDelegate.h"

@interface DefaultController ()

@end

@implementation DefaultController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    UIViewController *vc;
    
//    if([Session isLogged])
        vc = [storyboard instantiateViewControllerWithIdentifier:@"MainTabController"];
//    else
//        vc = [storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
    
    
    [vc setModalPresentationStyle:UIModalPresentationFullScreen];

    [self presentViewController:vc animated:NO completion:nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
