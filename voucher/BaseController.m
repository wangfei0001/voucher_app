//
//  BaseController.m
//  voucher
//
//  Created by fei wang on 13-8-23.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController

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
    
    //self.view.backgroundColor = [UIColor redColor];
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)showVoucherView
{
    self.voucherView = (VoucherView *)[[[NSBundle mainBundle] loadNibNamed:@"VoucherView" owner:self options:nil] objectAtIndex:0];
    
    self.voucherView.delegate = self;
    
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;

    
    CGRect oriRect = CGRectMake(320, statusBarHeight, 320, self.appDelegate.window.frame.size.height - statusBarHeight);
    
    self.voucherView.frame = oriRect;

    //[[self.appDelegate window] addSubview:self.voucherView];
    [self.navigationController.view addSubview:self.voucherView];
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         CGRect finalRect = self.voucherView.frame;
                         finalRect.origin.x = 0;
                         [self.voucherView setFrame:finalRect];
                     }
                     completion:nil];
}


//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"");
//}

- (void)showMerchantOnMapClick:(id)sender
{
    [self performSegueWithIdentifier:@"ShowMerchantOnMap" sender:self];
    
}

@end
