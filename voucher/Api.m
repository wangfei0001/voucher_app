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

#import "User.h"

#import <CommonCrypto/CommonHMAC.h>


#define DOMAIN_URL @"http://192.168.1.101/api/v1/"

//#define DOMAIN_URL @"http://voucher/api/v1/"

#define DOMAIN_URL_SSH @"https://192.168.1.101/api/v1/"

//#define DOMAIN_URL_SSH @"https://voucher/api/v1/"

@implementation Api;

#pragma mark - Vocher操作

+ (void)getVouchers: (NSDictionary *)params
                    success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success
{
    AFHTTPClient *httpClient = [self getHttpClient];
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
    AFHTTPClient *httpClient = [self getHttpClient];
    
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


/*
 * Search voucher by keywords
 */
+ (void)searchVoucher: (NSString *)keyword
              success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success
{
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                keyword,
                                @"search",
                                nil];
    
    [self getVouchers:parameters success:success];
}


#pragma mark - 需要用户登录的操作


+ (void)getMyFavouriteVouchers: (NSDictionary *)params
            success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success
{
    
    AFHTTPClient *httpClient = [self getHttpClient];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"voucher",   //type
                                @"type",
                                nil];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:@"favourite" parameters:parameters];
    
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


/***
 *  使用voucher，将设备的序列号上传给服务器，每个手机只能使用一次
 *
 ***/
+ (void)redeemVoucher: (int)voucherId
                 uuid: (NSString *)uuid
{
    
}


/***
 * 添加喜爱的voucher
 * @voucherId
 * @favourite
 * @callback
 **/
+ (void)addFavouriteVocher: (int)voucherId
                   success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success
{
    AFHTTPClient *httpClient = [self getHttpClient];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:voucherId],
                  @"id",
                  @"voucher",   //type
                  @"type",
                  nil];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"favourite" parameters:parameters];
    
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

+ (void)removeFavouriteVocher: (int)id_favourite
                      success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success
{
    AFHTTPClient *httpClient = [self getHttpClient];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:id_favourite],
                                @"id",
                                nil];
    
    NSString *path = [NSString stringWithFormat:@"favourite/%d", id_favourite];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"DELETE" path:path parameters:parameters];
    
    /*
     Add HMAC authorization
     */
    [self addHttpAuth:httpClient request:request];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request , NSURLResponse *response , id json) {
            
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


#pragma mark - 帐户操作，注册，登录退出等

+ (void)login: (NSString *)username
     password: (NSString *)password
      success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success
{
    
    AFHTTPClient *httpClient = [self getHttpClient];
    
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
    AFHTTPClient *httpClient = [self getHttpClient];
    
    NSString *path = [NSString stringWithFormat:@"login/%d", [Session userid]];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"DELETE" path:path parameters:nil];
    
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


+ (void)signup: (NSString *)username
        email: (NSString *)email 
        password: (NSString *)password
        success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success
{
    AFHTTPClient *httpClient = [self getHttpClient];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:username,
                                @"username",
                                email,
                                @"email",
                                password,
                                @"password",
                                nil];
    
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"user" parameters:parameters];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request , NSURLResponse *response , id json) {
            
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


+ (void)saveProfile: (NSDictionary *)params
            success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success
{

    AFHTTPClient *httpClient = [self getHttpClient];
    
    NSString *path = [NSString stringWithFormat:@"user/%d", [Session userid]];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"PUT" path:path parameters:params];
    /*
     Add HMAC authorization
     */
    [self addHttpAuth:httpClient request:request];
    
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request , NSURLResponse *response , id json) {
            NSLog(@"%@",json);
            
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



+ (void)getProfile: (int)userid
           success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success
{
    AFHTTPClient *httpClient = [self getHttpClient];
    
    NSString *path = [NSString stringWithFormat:@"user/%d", userid];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:path parameters:nil];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request , NSURLResponse *response , id json) {
            
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


+ (void)getCategories:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success
{
    AFHTTPClient *httpClient = [self getHttpClient];
    
    NSString *path = [NSString stringWithFormat:@"category/"];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:path parameters:nil];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request , NSURLResponse *response , id json) {
            
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

#pragma mark - 无关紧要的api


+ (void)contact: (NSString *)content
        contact: (NSString *)contact
       success : (void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success
{
    AFHTTPClient *httpClient = [self getHttpClient];
    
    NSString *path = [NSString stringWithFormat:@"contact/"];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                content,
                                @"content",
                                contact,
                                @"contact_info",
                                nil];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:path parameters:parameters];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request , NSURLResponse *response , id json) {
            
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

#pragma mark - 通用方法

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


+ (void)addHttpAuth: (AFHTTPClient *)httpClient
            request: (NSMutableURLRequest *)request
{
    
    [httpClient clearAuthorizationHeader];
    
    
    NSURL *url = request.URL;
    
    NSString *codeToSign = [NSString stringWithFormat:@"%@\n%@\n%@",
                            request.HTTPMethod,
                            url.host,
                            url.path];
    if([url query]){
        codeToSign = [codeToSign stringByAppendingFormat:@"?%@", [url query]];
    }
    codeToSign = [codeToSign stringByAppendingString:@"\n"];
    NSLog(@"Code to Sign:%@", codeToSign);
    
    
    //[httpClient setAuthorizationHeaderWithUsername:nil password:nil];
	NSString *basicAuthCredentials = [NSString stringWithFormat:@"%@:%@",
                                      [Session publicKey],
                                      [self hmacForKeyAndData:codeToSign key:[Session privateKey]]];
    NSLog(@"Result:%@", basicAuthCredentials);
    
    
    [request addValue:[NSString stringWithFormat:@"%@", basicAuthCredentials] forHTTPHeaderField:@"Authorization"];
    
    
}

+ (AFHTTPClient *)getHttpClient
{
    NSURL *url = [NSURL URLWithString:DOMAIN_URL];
    
    return [[AFHTTPClient alloc] initWithBaseURL:url];
}

@end
