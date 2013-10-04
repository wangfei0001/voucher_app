//
//  CategoryController.m
//  voucher
//
//  Created by fei wang on 13-10-3.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "CategoryController.h"

@interface CategoryController (){
    int selectedRow;
}

@end

@implementation CategoryController

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
    
    selectedRow = -1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View Start


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CatalogCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }else{
        //cell = [[TripsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
//    id voucherData = [data objectAtIndex:indexPath.row];
//    
//    cell.merchantName.text = [[voucherData objectForKey:@"merchant"] objectForKey:@"company"];
//    
//    cell.voucherName.text = [voucherData objectForKey:@"name"];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(selectedRow != indexPath.row){
        selectedRow = indexPath.row;
    }else{
        selectedRow = -1;
    }
   
    [tableView beginUpdates];
    [tableView endUpdates];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == [tableView indexPathForSelectedRow].row && selectedRow != -1) {
        return 164;
    }
    
    return 64;
}

@end
