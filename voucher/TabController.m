//
//  TabController.m
//  voucher
//
//  Created by fei wang on 13-8-31.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//
#import "AppDelegate.h"

#import "TabController.h"

//#import "DefaultController.h"


@interface TabController ()

@end

@implementation TabController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    [self.navigationController.navigationBar setHidden:YES];
    
//    [self performSegueWithIdentifier:@"ShowLogin" sender:self];
    self.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    int idx = tabBarController.selectedIndex;
    if(idx == 1 || idx == 3){
        if(![Session isLogged]){
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
            
            [self presentViewController:vc animated:YES completion:nil];
            
        }
    }
}

@end
