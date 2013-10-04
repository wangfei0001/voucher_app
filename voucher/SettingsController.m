//
//  SettingsController.m
//  voucher
//
//  Created by fei wang on 13-10-1.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "SettingsController.h"


#define SETTING_CACHE 1

@interface SettingsController (){
    

    
}

@end

@implementation SettingsController

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
    
    self.tableView.backgroundView = nil;
    [self.tableView setBackgroundColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1]];
    
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

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"SettingCell";
//    
//    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
//        cell = [nib objectAtIndex:0];
//    }else{
//        //cell = [[TripsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        
//    }
//    NSDictionary *cellData = [data objectAtIndex:indexPath.row];
//    
//    UILabel *label = (UILabel *)[cell viewWithTag:50];
//    label.text = [cellData objectForKey:@"label"];
//    
//    return cell;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            {
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"清除缓存"
                    message:@"您确定要清除缓存吗？"
                    delegate:NULL
                    cancelButtonTitle:@"取消"
                    otherButtonTitles:@"确定",
                    nil];
                alert.delegate = self;
                
                [alert show];
            }
            break;
        default:
            break;
    }
}



- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 0)
    {
        NSLog(@"cancel");
    }
    else
    {
        NSLog(@"ok");
    }
}
@end
