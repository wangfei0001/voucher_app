//
//  SearchController.m
//  voucher
//
//  Created by fei wang on 13-9-17.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "SearchController.h"

#import "VoucherCell.h"

@interface SearchController (){

    NSMutableArray *data;
    
    id selectedVoucher;
    
    BOOL isSearching;
    
}

@end

@implementation SearchController

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
    
    isSearching = NO;
    
    self.searchDisplayController.searchBar.delegate = self;

}

- (void)viewDidAppear:(BOOL)animated
{
 //   [self.searchBar becomeFirstResponder];
    
    [self.searchDisplayController setActive:YES animated:YES];
    [self.navigationController setNavigationBarHidden: NO animated: NO];
    [self.searchDisplayController.searchBar becomeFirstResponder];
    
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - Table View Start


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [data count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //we need to fill the data
    selectedVoucher = [data objectAtIndex:indexPath.row];
    
    [self showVoucherView: selectedVoucher];
    
    self.voucherView.delegate = self;
}


#pragma mark - UISearchDisplayControllerDelegate

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    isSearching = NO;
//    self.searchDisplayController.searchBar.showsCancelButton = NO;
    controller.searchBar.showsCancelButton = NO;
//    UIButton *cancelButton = nil;
//    for (UIView *subView in self.searchDisplayController.searchBar.subviews) {
//        if ([subView isKindOfClass:NSClassFromString(@"UIButton")]) {
//            cancelButton = (UIButton*)subView;
//        }
//    }
//    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
}


- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    //When the user taps the Cancel Button, or anywhere aside from the view.

    isSearching = NO;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    self.searchDisplayController.searchBar.showsScopeBar = YES;
    [self.searchDisplayController.searchBar sizeToFit];
    
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.appDelegate ShowLoading:self.view];
    
    [Api searchVoucher: self.searchDisplayController.searchBar.text
        success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
        //update the voucher views
        for(id val in JSON){
            [data addObject:val];
        }
        
        [self.searchDisplayController.searchResultsTableView reloadData];
        
        [self.appDelegate HideLoading];
    }];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}
@end
