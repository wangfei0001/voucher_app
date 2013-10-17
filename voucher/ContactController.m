//
//  ContactController.m
//  voucher
//
//  Created by fei wang on 13-10-1.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ContactController.h"

#import "AppDelegate.h"

#import "Api.h"

@interface ContactController (){

    AppDelegate *appDelegate;

}

@end

@implementation ContactController

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
    
    [[self.txtContent layer] setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [[self.txtContent layer] setBorderWidth:1.2];
    [[self.txtContent layer] setCornerRadius:5];
    
    self.txtContact.borderStyle = UITextBorderStyleNone;
    [[self.txtContact layer] setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [[self.txtContact layer] setBorderWidth:1.2];
    [[self.txtContact layer] setCornerRadius:5];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];// this will do the trick
}


- (IBAction)submitClick:(id)sender {
    
    [appDelegate ShowLoading:self.view];
    
    [Api contact:self.txtContent.text contact:self.txtContact.text success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
        
        [appDelegate showAlert:@"感谢您的帮助，我们的工作人员会尽快审理您的意见和建议。"];
        
        [appDelegate HideLoading];
    }];
    
    
    
}

@end
