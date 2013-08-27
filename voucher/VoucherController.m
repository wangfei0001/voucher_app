//
//  VoucherController.m
//  voucher
//
//  Created by fei wang on 13-8-22.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "VoucherController.h"

#import "VoucherCell.h"

@interface VoucherController (){
    
    NSMutableArray *data;     //voucher data

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
    
    
    
    
    data = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSURL *url = [NSURL URLWithString:DOMAIN_URL];
    
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
//    [httpClient clearAuthorizationHeader];
//    [httpClient setAuthorizationHeaderWithUsername:self.username.text password:self.password.text];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:@"voucher" parameters:nil];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request , NSURLResponse *response , id json) {
            
            NSLog(@"%@", json);
            
            BOOL status = [[json valueForKey:@"status"] boolValue];
            if (status) {
                //now we can refresh the content
                id vouchersData = [json valueForKey:@"data"];
                
                for(id val in vouchersData){
                    [data addObject:val];
                }
                
                [self.mainTable reloadData];
                

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma Table View Start


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
    id voucherData = [data objectAtIndex:indexPath.row];
    
    NSLog(@"%@", voucherData);
    
    [self showVoucherView: voucherData];
}





@end
