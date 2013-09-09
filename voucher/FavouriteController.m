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

@interface FavouriteController (){
    
    NSMutableArray *data;
    
    id selectedVoucher;
    
}

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
    
    data = [[NSMutableArray alloc] initWithCapacity:0];
    
    [Api getMyFavouriteVouchers:nil success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
        //update the voucher views
        for(id val in JSON){
            [data addObject:val];
        }
        
        [self.mainTable reloadData];
    }];
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
    selectedVoucher = [data objectAtIndex:indexPath.row];
    
    
    [self showVoucherView: selectedVoucher];
    
    self.voucherView.delegate = self;
}

@end
