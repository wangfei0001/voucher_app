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

#import "Session.h"

#import <CommonCrypto/CommonHMAC.h>


#define DOMAIN_URL @"http://voucher/api/v1/"

#define DOMAIN_URL_SSH @"https://voucher/api/v1/"

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
 *  使用voucher，将设备的序列号上传给服务器，每个手机只能使用一次
 *
 ***/
+ (void)redeemVoucher: (int)voucherId
                 uuid: (NSString *)uuid
{
    
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


+ (void)getMyFavouriteVouchers: (NSDictionary *)params
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

+ (void)login: (NSString *)username
     password: (NSString *)password
      success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success
{
    
    NSURL *url = [NSURL URLWithString:DOMAIN_URL];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];

    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:username,
                                @"username",
                                password,
                                @"password",
                                nil];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"login" parameters:parameters];
    
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

+ (void)logout: (void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success
{
    NSURL *url = [NSURL URLWithString:DOMAIN_URL];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"DELETE" path:@"login/1" parameters:nil];
    
    /*
     Add HMAC authorization
     */
    [self addHttpAuth:httpClient request:request];
    
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

+ (void)addHttpAuth: (AFHTTPClient *)httpClient
                    request: (NSMutableURLRequest *)request
{
    
    [httpClient clearAuthorizationHeader];
    
    
    NSURL *url = request.URL;

    NSString *codeToSign = [NSString stringWithFormat:@"%@\n%@\n%@\n",
                            request.HTTPMethod,
                            url.host,
                            url.path];
    NSLog(@"Code to Sign:%@", codeToSign);
    
    //[httpClient setAuthorizationHeaderWithUsername:nil password:nil];
	NSString *basicAuthCredentials = [NSString stringWithFormat:@"%@:%@",
                                      [Session publicKey],
                                      [self hmacForKeyAndData:codeToSign key:[Session privateKey]]];
    NSLog(@"Result:%@", basicAuthCredentials);

    
    [request addValue:[NSString stringWithFormat:@"%@", basicAuthCredentials] forHTTPHeaderField:@"Authorization"];


}


+ (NSString *) hmacForKeyAndData :(NSString *)data key: (NSString *) key {
    
    
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [data cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSString *hash;
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", cHMAC[i]];
    hash = output;
    
    return hash;
}
@end
