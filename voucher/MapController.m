//
//  MapController.m
//  voucher
//
//  Created by fei wang on 13-8-25.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "MapController.h"

#import "AppDelegate.h"


@interface MapController (){
    
    AppDelegate *appDelegate;
    
}

@end

@implementation MapController

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
    // Do any additional setup after loading the view from its nib.
    
    appDelegate = APP_DELEGATE;
    
    self.mapView.showsUserLocation = YES;
    
//    [self.mapView setLocation: self.startCoord];
    
    //CLLocationCoordinate2D centerCoord = CLLocationCoordinate2DMake(-33.833695 , 151.221533 );;
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    CGRect rect = CGRectMake(0, 0, 320, appDelegate.window.frame.size.height - tabBarHeight);
    
    self.mapView.frame = rect;
    
    [self.mapView setCenterCoordinate:self.startCoord zoomLevel:14 animated:NO];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
