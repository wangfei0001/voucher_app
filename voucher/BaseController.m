//
//  BaseController.m
//  voucher
//
//  Created by fei wang on 13-8-23.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "BaseController.h"

#import "Voucher.h"

@interface BaseController (){
    
    BOOL voucherViewMoving;
    
    Voucher *voucher;

}

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
    
    voucherViewMoving = NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 填充数据
*/
- (void)fillData: (id)data
{
    id merchant = [data objectForKey:@"merchant"];
    
    self.voucherView.merchantName.text = [merchant objectForKey:@"company"];
    
    self.voucherView.voucherTitle.text = [data objectForKey:@"name"];
    
    //get additional data
    NSURL *url = [NSURL URLWithString:DOMAIN_URL];
    
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            @"17", @"id_voucher",
//                            nil];
    NSString *path = [NSString stringWithFormat:@"voucher/%d", [[data objectForKey:@"id_voucher"] intValue]];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:path parameters:nil];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request , NSURLResponse *response , id json) {
            
            NSLog(@"%@", json);
            
            BOOL status = [[json valueForKey:@"status"] boolValue];
            if (status) {
                //now we can refresh the content
                
                voucher = [[Voucher alloc] initWithData:[json valueForKey:@"data"]];
                
                //update UI
                if(!voucher.reusable){
                    self.voucherView.redeemBut.hidden = NO;
                }
            }
            else {
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Login Unsuccessful"
                                                               message:@"Please try again"
                                                              delegate:NULL
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:NULL];
                
                [alert show];
                
            }
            
        }

        failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON) {
            
            NSLog(@"%@", error);
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Login Unsuccessful"
                                                           message:@"There was a problem connecting to the network!"
                                                          delegate:NULL
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:NULL];
            
            [alert show];
        }];
    [operation start];
}

- (void)showVoucherView: (id)data
{
    if(voucherViewMoving) return;
    
    voucherViewMoving = YES;
    
    self.voucherView = (VoucherView *)[[[NSBundle mainBundle] loadNibNamed:@"VoucherView" owner:self options:nil] objectAtIndex:0];
    
    self.voucherView.delegate = self;
    
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;

    
    CGRect oriRect = CGRectMake(320, statusBarHeight, 320, self.appDelegate.window.frame.size.height - statusBarHeight);
    
    self.voucherView.frame = oriRect;
    
    //fill data
    [self fillData: data];
    

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
                     completion:^(BOOL finished) {
                         voucherViewMoving = NO;
                     }];
}


#pragma Voucher View delegate 

- (void)showMerchantOnMapClick:(id)sender
{
    [self performSegueWithIdentifier:@"ShowMerchantOnMap" sender:self];
    
}


- (void)movingVoucherViewDone
{
    
}

@end
