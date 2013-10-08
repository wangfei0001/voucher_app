//
//  FavouriteController.m
//  voucher
//
//  Created by fei wang on 13-8-22.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "FavouriteController.h"

#import "AppDelegate.h"

#import "VoucherView.h"

#import "VoucherCell.h"

@interface FavouriteController ()

@end

@implementation FavouriteController

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
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [Api getMyFavouriteVouchers:nil success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
        //update the voucher views
        [self.data removeAllObjects];
        
        if(JSON != [NSNull null]){
            for(id val in JSON){
                [self.data addObject:val];
            }
            
            [self.mainTable reloadData];
        }else{
            
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)searchClick:(id)sender {
    
    [self performSegueWithIdentifier:@"ShowSearch" sender:self];
}



@end
