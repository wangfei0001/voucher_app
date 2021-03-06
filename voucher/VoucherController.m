//
//  VoucherController.m
//  voucher
//
//  Created by fei wang on 13-8-22.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "VoucherController.h"

#import "VoucherCell.h"

#import "MapPin.h"


@interface VoucherController (){
    
    
    
    
    
    UIRefreshControl *refreshControl;
    
    

}

@end

@implementation VoucherController

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
    
//    CGRect frame = [UIScreen mainScreen].bounds;
//    CGRect navFrame = [[self.navigationController navigationBar] frame];
//    /* navFrame.origin.y is the status bar's height and navFrame.size.height is navigation bar's height.
//     So you can get usable view frame like this */
//    frame.size.height -= navFrame.origin.y + navFrame.size.height;
//    
//    frame.origin.y = 44;
//    
//    self.view.frame = frame;
    
//    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    
    

    
    [self initSegementView];
    
    
    [self initMapView];
    
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Show" style:UIBarButtonItemStylePlain target:self action:@selector(showCategoryClick:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(refreshLatestVouchers) forControlEvents:UIControlEventValueChanged];
    [self.mainTable addSubview:refreshControl];
    
        
    
    
    [self.appDelegate ShowLoading:self.view];
    
    [Api getVouchers:nil success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
        //update the voucher views
        for(id val in JSON){
            [self.data addObject:val];
        }
        
        [self.mainTable reloadData];
        
        //update the mapviews
        [self updateMapView];
        
        [self.appDelegate HideLoading];
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Some event handle functions


- (IBAction)showCategoryClick:(id)sender
{
    [self showCategories];
}


- (void)showCategories
{
    
    if(self.categoriesView == nil){
        self.categoriesView = (CategoryView *)[[[NSBundle mainBundle] loadNibNamed:@"CategoryView" owner:self options:nil] objectAtIndex:0];
        self.categoriesView.catsData = self.appDelegate.global.categories;
        self.categoriesView.delegate = self;
    }
    !self.categoriesView.visible ? [self.categoriesView show:self.view] : [self.categoriesView hide];
}

/***
 *  Segement Click Event handle function
 *
 **/
- (IBAction)segementAction:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    switch ([segmentedControl selectedSegmentIndex])
    {
        case 0:
        {
           
            [UIView transitionWithView:self.view
                              duration:0.5f
                               options:UIViewAnimationOptionTransitionFlipFromRight
                            animations:^{
                                
                                //[self.mapView removeFromSuperview];
                                [self.mapView setHidden:YES];
                                
                            } completion:nil];
            break;
        }
        case 1:
        {
            
            [UIView transitionWithView:self.view
                              duration:0.5f
                               options:UIViewAnimationOptionTransitionFlipFromLeft
                            animations:^{
                                
                                [self.mapView setHidden:NO];
                                
                            } completion:nil];
            
            break;
        }
    }
    
    

}


- (void)updateMapView
{
    
    for (int i = 0; i<[self.data count]; i++)
    {
        id merchant = [[self.data objectAtIndex:i] objectForKey:@"merchant"];

        id addresses = [[self.data objectAtIndex:i] objectForKey:@"addresses"];

        //we support multiple stores
        for(int j = 0; j < [addresses count]; j++){
            id address = [addresses objectAtIndex:j];
            
            [self.mapView addPin:[[self.data objectAtIndex:i] objectForKey:@"name"] subTitle:[merchant valueForKey:@"company"] lat:[[address valueForKey:@"lat"] doubleValue] lng:[[address valueForKey:@"lng"] doubleValue]];
        }
    }
}

- (void)initMapView
{
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    CGRect rect = CGRectMake(0, 0, 320, self.appDelegate.window.frame.size.height - tabBarHeight);
    self.mapView = [[MapView alloc] initWithFrame:rect];
    self.mapView.showsUserLocation = YES;
    [self.mapView setHidden:YES];
    self.mapView.delegate = self.mapView;
    self.mapView.mydelegate = self;
    //[self.mapView setMapType:MKMapTypeStandard];
    [self.view addSubview:self.mapView];
}


- (void)initSegementView
{
    self.segementCtrl.selectedSegmentIndex = 0;
    self.segementCtrl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.segementCtrl.segmentedControlStyle = UISegmentedControlStyleBar;
    //    [self.segementCtrl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    //defaultTintColor = [segmentedControl.tintColor retain];   // keep track of this for later
    
    self.segementCtrl.tintColor = [UIColor colorWithHue:8.0 saturation:8.0 brightness:8.0 alpha:1.0];
    self.segementCtrl.alpha = 0.8;
}


#pragma mark - Voucher View Delegate

-(void)voucherOnMapViewClick:(id)sender
{
    NSLog(@"click on map");
    //we need to fill the data
    id voucherData = [self.data objectAtIndex:0];
    
    NSLog(@"%@", voucherData);
    
    [self showVoucherView: voucherData];
    
    self.voucherView.delegate = self;
}




- (IBAction)searchClick:(id)sender {
    [self performSegueWithIdentifier:@"ShowSearch" sender:self];
}


#pragma mark - Category View Delegate

- (void)categoryClick:(id)sender selectedCat:(Category *)selectedCat
{
    [self.appDelegate ShowLoading:self.view];

        
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSString stringWithFormat:@"%d", selectedCat.id],
                                @"id_category",
                                nil];
    
    [self hideNotFound];
    [Api getVouchers:parameters success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
        //update the voucher views
        [self.data removeAllObjects];
        for(id val in JSON){
            [self.data addObject:val];
        }
        
        [self.mainTable reloadData];
        
        //update the mapviews
        [self updateMapView];
        
        [self.mainTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        if([self.data count] <= 0){
            [self showNotFound];
        }
        [self.appDelegate HideLoading];
    }];
}


#pragma mark - For table pull refresh control
/***
 *  Pull table view to refresh
 *
 **/

- (void)refreshLatestVouchers
{
    
    [self performSelector:@selector(refreshLatestVouchersDone) withObject:nil
               afterDelay:5];
}


- (void)refreshLatestVouchersDone
{
     [refreshControl endRefreshing];
}

@end
