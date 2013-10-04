//
//  RegisterController.m
//  voucher
//
//  Created by fei wang on 13-8-31.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "RegisterController.h"

#import "AppDelegate.h"

#import "Api.h"

#define REG_TEXTFIELD_USERNAME_TAG 50

#define REG_TEXTFIELD_EMAIL_TAG REG_TEXTFIELD_USERNAME_TAG + 1

#define REG_TEXTFIELD_PWD_TAG REG_TEXTFIELD_USERNAME_TAG + 2

@interface RegisterController (){
    
    AppDelegate *appDelegate;
    
}

@end

@implementation RegisterController

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
    self.registerTable.backgroundColor = [UIColor clearColor];
    self.registerTable.backgroundView = nil;
    
    appDelegate = APP_DELEGATE;
}

- (BOOL)validateForm
{
    BOOL result = YES;
    
    UITextField* usernameField = (UITextField*)[[self getTableCell: 0] viewWithTag:REG_TEXTFIELD_USERNAME_TAG];
    
    UITextField* emailField = (UITextField*)[[self getTableCell: 1] viewWithTag:REG_TEXTFIELD_EMAIL_TAG];
    
    UITextField* passwordField = (UITextField*)[[self getTableCell: 2]  viewWithTag:REG_TEXTFIELD_PWD_TAG];
    
    if([usernameField.text isEqualToString:@""]){
        [appDelegate showAlert:@"请填写用户名"];
        [usernameField becomeFirstResponder];
        result = NO;
    }else{
        if([emailField.text isEqualToString:@""]){
            [appDelegate showAlert:@"请填写电子邮件"];
            [emailField becomeFirstResponder];
            result = NO;
        }else{
            if([passwordField.text isEqualToString:@""]){
                [appDelegate showAlert:@"请填写用户密码"];
                [passwordField becomeFirstResponder];
                result = NO;
            }
        }
    }
    
    return result;
}


- (UITableViewCell *)getTableCell: (int)row
{
    NSIndexPath* indexpath = [NSIndexPath indexPathForRow:row inSection:0];
    
    UITableViewCell *cell = [self.registerTable cellForRowAtIndexPath:indexpath];
    
    return cell;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];// this will do the trick
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View Start


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier;
    
    int tag;
    
    if(indexPath.row == 0){
        CellIdentifier = @"TbCellUser";
        tag = REG_TEXTFIELD_USERNAME_TAG;
    }else if(indexPath.row == 1){
        CellIdentifier = @"TbCellEmail";
        tag = REG_TEXTFIELD_EMAIL_TAG;
    }else{
        CellIdentifier = @"TbCellPwd";
        tag = REG_TEXTFIELD_PWD_TAG;
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
    return 3;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}


- (IBAction)registerClick:(id)sender
{
    BOOL result = [self validateForm];
    if(result){
        UITextField *usernameField = (UITextField*)[[self getTableCell: 0] viewWithTag:REG_TEXTFIELD_USERNAME_TAG];
        
        UITextField *emailField = (UITextField*)[[self getTableCell: 1] viewWithTag:REG_TEXTFIELD_EMAIL_TAG];
        
        UITextField *passwordField = (UITextField*)[[self getTableCell: 2]  viewWithTag:REG_TEXTFIELD_PWD_TAG];
        
        [appDelegate ShowLoading:self.view];
        [Api signup: usernameField.text email:emailField.text password:passwordField.text success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
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
}

- (IBAction)cancelClick:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
