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
    
    NSMutableArray *data;     //voucher data
    
    id selectedVoucher;
    
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
    
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(refreshLatestVouchers) forControlEvents:UIControlEventValueChanged];
    [self.mainTable addSubview:refreshControl];
    
        
    data = [[NSMutableArray alloc] initWithCapacity:0];
    
    [Api getVouchers:nil success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
        //update the voucher views
        for(id val in JSON){
            [data addObject:val];
        }
        
        [self.mainTable reloadData];
        
        //update the mapviews
        [self updateMapView];
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View Start


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"VoucherCell";
    
    VoucherCell *cell = (VoucherCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }else{
        //cell = [[TripsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    id voucherData = [data objectAtIndex:indexPath.row];
    
    cell.merchantName.text = [[voucherData objectForKey:@"merchant"] objectForKey:@"company"];
    
    cell.voucherName.text = [voucherData objectForKey:@"name"];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [data count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //we need to fill the data
    selectedVoucher = [data objectAtIndex:indexPath.row];
    
    [self showVoucherView: selectedVoucher];
    
    self.voucherView.delegate = self;
}

#pragma mark - Some event handle functions
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
    CLLocationCoordinate2D location;
    
    for (int i = 0; i<[data count]; i++)
    {
        id merchant = [[data objectAtIndex:i] objectForKey:@"merchant"];
        
        id addresses = [merchant objectForKey:@"address"];
        
        //we support multiple stores
        for(int j = 0; j < [addresses count]; j++){
            id address = [addresses objectAtIndex:j];
            
            double double_lat = [[address valueForKey:@"lat"] doubleValue];
            double double_long = [[address valueForKey:@"lng"] doubleValue];
            location.latitude = double_lat;
            location.longitude = double_long;
            
            MapPin *mapPoint = [[MapPin alloc] initWithLocation:location];
            mapPoint.title = [[data objectAtIndex:i] objectForKey:@"name"];
            mapPoint.subtitle = [merchant valueForKey:@"company"];
            mapPoint.nTag = i;
            
            [self.mapView addAnnotation:mapPoint];
            
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
    id voucherData = [data objectAtIndex:0];
    
    NSLog(@"%@", voucherData);
    
    [self showVoucherView: voucherData];
    
    self.voucherView.delegate = self;
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
