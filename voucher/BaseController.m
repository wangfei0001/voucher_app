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
    
    
    [Api getVoucherDetail:[[data objectForKey:@"id_voucher"] intValue]
                  success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
                      voucher = [[Voucher alloc] initWithData:JSON];
                      //update UI
                      if(!voucher.reusable){
                          self.voucherView.redeemBut.hidden = NO;
                      }
                  }];
}

- (void)showVoucherView: (id)data
{
    if(voucherViewMoving) return;
    
    voucherViewMoving = YES;
    
    self.voucherView = (VoucherView *)[[[NSBundle mainBundle] loadNibNamed:@"VoucherView" owner:self options:nil] objectAtIndex:0];
    
    
    
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;

    
    CGRect oriRect = CGRectMake(320, statusBarHeight, 320, self.appDelegate.window.frame.size.height - statusBarHeight);
    
    self.voucherView.frame = oriRect;
    
    //fill data
    [self fillData: data];
    

    //[[self.appDelegate window] addSubview:self.voucherView];
    [self.tabBarController.view addSubview:self.voucherView];
    
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


@end
