//
//  LoginController.m
//  voucher
//
//  Created by fei wang on 13-8-31.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "LoginController.h"

#import "AppDelegate.h"

#import "Api.h"

#import "KeychainItemWrapper.h"


#define TEXTFIELD_USERNAME_TAG  50

#define TEXTFIELD_PASSWORD_TAG  TEXTFIELD_USERNAME_TAG + 1

@interface LoginController (){
    
    AppDelegate *appDelegate;

}

@end

@implementation LoginController

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

    appDelegate = APP_DELEGATE;
    
    [self.navigationController.navigationBar setHidden:NO];
    self.loginTable.backgroundColor = [UIColor clearColor];
    self.loginTable.backgroundView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginClick:(id)sender {
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//    
//    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"MainTabController"];
//    
//    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
//    
//    [self presentViewController:vc animated:NO completion:nil];
    
    UITableViewCell *usernameCell = [self getTableCell: 0];
    
    UITableViewCell *passwordCell = [self getTableCell: 1];
    
    UITextField* usernameField = (UITextField*)[usernameCell viewWithTag:TEXTFIELD_USERNAME_TAG];
    
    UITextField* passwordField = (UITextField*)[passwordCell  viewWithTag:TEXTFIELD_PASSWORD_TAG];

    [appDelegate ShowLoading:self.view];
    
    [Api login: usernameField.text password:passwordField.text success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
        //here we got the public key and private key and userid, we need to store them and keep it secure
        
        
        NSLog(@"%@", JSON);
        
        [Session saveCredentials:[JSON objectForKey:@"public_key"] pri_key:[JSON objectForKey:@"private_key"]];;
        
        [appDelegate HideLoading];
        
        [self.navigationController dismissViewControllerAnimated:NO completion:nil];
        
    }];
}


- (IBAction)registerClick:(id)sender {
    [self performSegueWithIdentifier:@"ShowRegister" sender:self];
}

#pragma mark - Table View Start


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier;
    
    if(indexPath.row == 0){
        CellIdentifier = @"TbCellUser";
    }else{
        CellIdentifier = @"TbCellPwd";
    }
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}


- (UITableViewCell *)getTableCell: (int)row
{
    NSIndexPath* indexpath = [NSIndexPath indexPathForRow:row inSection:0];

    UITableViewCell *cell = [self.loginTable cellForRowAtIndexPath:indexpath];
    
    return cell;
}

@end
