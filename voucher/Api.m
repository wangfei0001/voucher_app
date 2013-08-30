//
//  Api.m
//  voucher
//
//  Created by fei wang on 13-8-30.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "Api.h"

#import "AFHTTPClient.h"

#import "AFJSONRequestOperation.h"

#define DOMAIN_URL @"http://voucher/api/v1/"

@implementation Api


+ (void)getVouchers: (NSDictionary *)params
                    success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success
{

    NSURL *url = [NSURL URLWithString:DOMAIN_URL];

    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    //    [httpClient clearAuthorizationHeader];
    //    [httpClient setAuthorizationHeaderWithUsername:self.username.text password:self.password.text];

    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:@"voucher" parameters:params];

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request , NSURLResponse *response , id json) {
            
            NSLog(@"%@", json);
            
            BOOL status = [[json valueForKey:@"status"] boolValue];
            if (status) {
                success(request, response, [json valueForKey:@"data"]);
                
            }
            else {
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Login Unsuccessful"
                                                               message:@"Please try again"
                                                              delegate:NULL
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:NULL];
                
                [alert show];
            }
            
        }
        failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON) {
            [self failure:request response:response error:error JSON:JSON];
        }];
    [operation start];
}


+ (void)getVoucherDetail: (int)voucherId
                 success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success
{
    //get additional data
    NSURL *url = [NSURL URLWithString:DOMAIN_URL];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    //    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
    //                            @"17", @"id_voucher",
    //                            nil];
    NSString *path = [NSString stringWithFormat:@"voucher/%d", voucherId];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:path parameters:nil];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request , NSURLResponse *response , id json) {
            
            NSLog(@"%@", json);
            
            BOOL status = [[json valueForKey:@"status"] boolValue];
            if (status) {
                success(request, response, [json valueForKey:@"data"]);
            }
            else {
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Login Unsuccessful"
                                                               message:@"Please try again"
                                                              delegate:NULL
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:NULL];
                
                [alert show];
                
            }
            
        }
        failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON) {
            [self failure:request response:response error:error JSON:JSON];
        }];
    [operation start];
}


/***
 *  Request failure, show error message;
 *
 ***/
+ (void)failure:(NSURLRequest *)request
        response: (NSURLResponse *)response
        error: (NSError *)error
        JSON: (id) JSON
{
    NSLog(@"%@", error);
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Login Unsuccessful"
                                                   message:@"There was a problem connecting to the network!"
                                                  delegate:NULL
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:NULL];
    
    [alert show];
}

@end
