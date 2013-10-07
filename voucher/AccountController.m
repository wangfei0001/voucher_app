//
//  AccountController.m
//  voucher
//
//  Created by fei wang on 13-9-9.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "AccountController.h"

#import "AppDelegate.h"

#import "Api.h"

#import "Session.h"

#import "User.h"


#define USER_PROFILE_USERNAME       1

#define USER_PROFILE_PASSWORD       2

#define USER_PROFILE_EMAIL       3

@interface AccountController (){
    
    AppDelegate *appDelegate;
    
    NSMutableArray *data;
    
}

@end

@implementation AccountController

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

//    data = [[NSMutableArray alloc] initWithCapacity:0];
    
    
//    [data addObject:[[NSDictionary alloc] initWithObjectsAndKeys:
//                     @"用户名",
//                     @"label",
//                     @"上海阿飞",
//                     @"value",
//                     [NSNumber numberWithInt:USER_PROFILE_USERNAME],
//                     @"key",
//                     nil]];
//    
//    
//    [data addObject:[[NSDictionary alloc] initWithObjectsAndKeys:
//                     @"密码",
//                     @"label",
//                     @"616682",
//                     @"value",
//                     [NSNumber numberWithInt:USER_PROFILE_PASSWORD],
//                     @"key",
//                     nil]];
//    
//    [data addObject:[[NSDictionary alloc] initWithObjectsAndKeys:
//                     @"电子邮件",
//                     @"label",
//                     @"wangfei001@hotmail.com",
//                     @"value",
//                     [NSNumber numberWithInt:USER_PROFILE_EMAIL],
//                     @"key",
//                     nil]];
    
    
    appDelegate = APP_DELEGATE;
    

    [appDelegate ShowLoading:self.view];
    [Api getProfile:[Session userid] success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
        
        self.lblEmail.text = [JSON objectForKey:@"email"];
        self.lblUsername.text = [JSON objectForKey:@"username"];
        
        if(![Session user]){
            User *user = [[User alloc] init];
            
            user.email = [JSON objectForKey:@"email"];
            
            user.username = [JSON objectForKey:@"username"];
            
            user.fname = [JSON objectForKey:@"fname"];
            
            user.lname = [JSON objectForKey:@"lname"];
            
            
            Session.user = user;
            
        }
        
        
        [appDelegate HideLoading];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //logout button
    if([Session isLogged]){
        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(logoutClick:)];
        self.navigationItem.rightBarButtonItem = anotherButton;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutClick:(id)sender
{
    [appDelegate ShowLoading:self.view];
    
    [Api logout:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
        [Session saveCredentials:nil pri_key:nil userid:0];
        
        [appDelegate HideLoading];
        
        [self.tabBarController setSelectedIndex:0];
        //[self.navigationController dismissViewControllerAnimated:NO completion:nil];
    }];
    
    
}


//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [data count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"ProfileCell";
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
//    int cellKey = [[cellData objectForKey:@"key"] intValue];
//    
//    UILabel *label1 = (UILabel *)[cell viewWithTag:50];
//    label1.text = [cellData objectForKey:@"label"];
//
//    UILabel *label2 = (UILabel *)[cell viewWithTag:51];
//    if(cellKey == USER_PROFILE_PASSWORD){
//        label2.text = @"********";
//    }else
//        label2.text = [cellData objectForKey:@"value"];
//    
//    return cell;
//}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //NSDictionary *cellData = [data objectAtIndex:indexPath.row];
//    
//    [self performSegueWithIdentifier:@"ShowProfileChange" sender:self];
//    
//}

@end
