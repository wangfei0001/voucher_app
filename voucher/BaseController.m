//
//  BaseController.m
//  voucher
//
//  Created by fei wang on 13-8-23.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "BaseController.h"

#import "MapController.h"

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
    
    self.appDelegate = APP_DELEGATE;
    
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
    voucher = [[Voucher alloc] initWithData:data];
    
    id merchant = [data objectForKey:@"merchant"];
    
    self.voucherView.merchantName.text = [merchant objectForKey:@"company"];
    
    self.voucherView.voucherTitle.text = [data objectForKey:@"name"];
    
    
    /*
     * 更新是否属于收藏
     */
    id id_favourite = [data objectForKey:@"id_favourite"];
    if(id_favourite && [id_favourite boolValue] == YES){
        [self.voucherView updateView:YES];
    }
    
    [Api getVoucherDetail:[[data objectForKey:@"id_voucher"] intValue]
                  success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
                      
                      //update UI
                      if(!voucher.reusable){
                          self.voucherView.redeemBut.hidden = NO;
                      }
                  }];
}


//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"");
//}

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

-(void)favouriteClick: (id)sender
{

    [self.appDelegate ShowLoading:self.voucherView];
    if(![voucher isMyFavourite]){
        [Api addFavouriteVocher:voucher.id success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
            voucher.id_favourite = [JSON intValue];
            [self.voucherView updateView:YES];
            [self.appDelegate HideLoading];
        }];
    }else{
        [Api removeFavouriteVocher:voucher.id_favourite success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
            voucher.id_favourite = 0;
            [self.voucherView updateView:NO];
            [self.appDelegate HideLoading];
        }];
    }
}

- (void)showMerchantOnMapClick:(id)sender
{
    [self performSegueWithIdentifier:@"ShowMerchantOnMap" sender:self];
}

- (void)redeemVoucherClick:(id)sender
{
    NSLog(@"test");
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowMerchantOnMap"])
    {
        MapController *vc = [segue destinationViewController];
        
        vc.startCoord = CLLocationCoordinate2DMake( voucher.merchant.lat , voucher.merchant.lng );
    }
}


@end
