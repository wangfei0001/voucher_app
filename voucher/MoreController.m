//
//  MoreController.m
//  voucher
//
//  Created by fei wang on 13-9-30.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "MoreController.h"

@interface MoreController (){
    NSMutableArray *data;
    
    NSMutableArray *dataController;
}

@end

@implementation MoreController

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
    
    self.tableView.backgroundView = nil;
    [self.tableView setBackgroundColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1]];
    
	// Do any additional setup after loading the view.
    data = [[NSMutableArray alloc] initWithCapacity:0];
    
    dataController = [[NSMutableArray alloc] initWithCapacity:0];
    
    [data addObject:@"系统设置"];
    [dataController addObject:@"ShowSettings"];

    
    [data addObject:@"检测版本"];
    [dataController addObject:@"CheckVersion"];

    
    [data addObject:@"意见建议"];
    [dataController addObject:@"ShowContact"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [data count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *CellIdentifier = @"MoreCell";
//    
//    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
//        cell = [nib objectAtIndex:0];
//    }else{
//        //cell = [[TripsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        
//    }
//    UILabel *label = (UILabel *)[cell viewWithTag:50];
//    label.text = [data objectAtIndex:indexPath.row];
//    
//    return cell;
//}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSString *segueID = [dataController objectAtIndex:indexPath.row];
//
//    [self performSegueWithIdentifier:segueID sender:self];
//}

@end
