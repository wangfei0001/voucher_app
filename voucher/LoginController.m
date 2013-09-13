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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];// this will do the trick
}

- (IBAction)loginClick:(id)sender {
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//    
//    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"MainTabController"];
//    
//    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
//    
//    [self presentViewController:vc animated:NO completion:nil];
    
    UITextField* usernameField = (UITextField*)[[self getTableCell: 0] viewWithTag:TEXTFIELD_USERNAME_TAG];
    
    UITextField* passwordField = (UITextField*)[[self getTableCell: 1] viewWithTag:TEXTFIELD_PASSWORD_TAG];

    [appDelegate ShowLoading:self.view];
    
    [Api login: usernameField.text password:passwordField.text success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
        //here we got the public key and private key and userid, we need to store them and keep it secure
        
        
        NSLog(@"%@", JSON);
        
        [Session saveCredentials:[JSON objectForKey:@"public_key"]
                         pri_key:[JSON objectForKey:@"private_key"]
                          userid:[[JSON objectForKey:@"id_user"] intValue]
         ];
        
        [appDelegate HideLoading];
        
        [self.navigationController dismissViewControllerAnimated:NO completion:nil];
        
    }];
}


- (IBAction)registerClick:(id)sender {
    [self performSegueWithIdentifier:@"ShowRegister" sender:self];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

#pragma mark - Table View Start


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier;
    
    int tag;
    
    if(indexPath.row == 0){
        CellIdentifier = @"TbCellUser";
        tag = TEXTFIELD_USERNAME_TAG;
    }else{
        CellIdentifier = @"TbCellPwd";
        tag = TEXTFIELD_PASSWORD_TAG;
    }
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    UITextField *textField = (UITextField *)[cell viewWithTag:tag];
        
    textField.delegate = self;
    
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
