//
//  AccountController.m
//  voucher
//
//  Created by fei wang on 13-9-9.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "AccountController.h"

#import "AppDelegate.h"

#import "Api.h"

@interface AccountController (){
    
    AppDelegate *appDelegate;
    
}

@end

@implementation AccountController

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
    
    appDelegate = APP_DELEGATE;
    
    //logout button
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(logoutClick:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutClick:(id)sender
{
    [appDelegate ShowLoading:self.view];
    
    [Api logout:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
        [Session saveCredentials:nil pri_key:nil];
        
        [appDelegate HideLoading];
        
        [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    }];
    
    
}

@end
