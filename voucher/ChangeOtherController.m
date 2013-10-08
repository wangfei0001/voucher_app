//
//  ChangeOtherController.m
//  voucher
//
//  Created by fei wang on 13-10-7.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "ChangeOtherController.h"

#import "AppDelegate.h"

#import "Session.h"

#import "User.h"

#import "Api.h"

@interface ChangeOtherController (){
    
    AppDelegate *appDelegate;
    
    NSString *fieldName;
    
}

@end

@implementation ChangeOtherController

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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(self.changeType == USER_PROFILE_USERNAME){
        self.txtValue.text = [Session user].username;
        fieldName = @"用户名";
        
    }else if(self.changeType == USER_PROFILE_EMAIL){
        self.txtValue.text = [Session user].email;
        fieldName = @"电子邮件";

    }
    self.navigationItem.title = [NSString stringWithFormat:@"编辑%@", fieldName];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}



- (IBAction)submitClick:(id)sender {
    if(![self validate]){
        
        
        return;
    }
    NSLog(@"ok, we submit now!");
    
    NSDictionary *parameters;
    
    if(self.changeType == USER_PROFILE_USERNAME){
        parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                        @"normal",  // or "password"
                        @"type",    //request type, normal changes or password change
                        self.txtValue.text,
                        @"username",
                        [Session user].email,
                        @"email",
                        [Session user].fname,
                        @"fname",
                        [Session user].lname,
                        @"lname",
                        nil];
    }else if(self.changeType == USER_PROFILE_EMAIL){
        parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                      @"normal",  // or "password"
                      @"type",    //request type, normal changes or password change
                      [Session user].username,
                      @"username",
                      self.txtValue.text,
                      @"email",
                      [Session user].fname,
                      @"fname",
                      [Session user].lname,
                      @"lname",
                      nil];
    }
    
    [Api saveProfile:parameters
             success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
                 NSLog(@"%@", JSON);
                 User *user = Session.user;
                 user.fname = [JSON objectForKey:@"fname"];
                 user.lname = [JSON objectForKey:@"lname"];
                 user.username = [JSON objectForKey:@"username"];
                 user.email = [JSON objectForKey:@"email"];
                 [Session setUser:user];
                 [self.navigationController popViewControllerAnimated:YES];
        
    }];
}


/***
 * Validate the form
 *
 */
- (BOOL)validate
{
    BOOL result = YES;
    if([self.txtValue.text isEqualToString:@""]){
        
        [appDelegate showAlert:[NSString stringWithFormat:@"请输入您的辑%@", fieldName]];
        [self.txtValue becomeFirstResponder];
        result = NO;
    }
    
    
    return result;
}

@end
