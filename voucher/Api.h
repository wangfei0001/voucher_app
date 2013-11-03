//
//  Api.h
//  voucher
//
//  Created by fei wang on 13-8-30.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Api : NSObject

+ (void)getVouchers: (NSDictionary *)params
            success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success;
+ (void)getVoucherDetail: (int)voucherId
                 success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success;
+ (void)redeemVoucher: (int)voucherId
                 uuid: (NSString *)uuid
              success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success;

+ (void)getMyFavouriteVouchers: (NSDictionary *)params
                       success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success;

+ (void)addFavouriteVocher: (int)voucherId
                 success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success;

+ (void)removeFavouriteVocher: (int)id_favourite
                   success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success;

+ (void)searchVoucher: (NSString *)keyword
                    success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success;


+ (void)login: (NSString *)username
                password: (NSString *)password
                success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success;

+ (void)logout: (void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success;

+ (void)signup: (NSString *)username
        email: (NSString *)email
        password: (NSString *)password
        success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success;
+ (void)saveProfile: (NSDictionary *)params
            success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success;
+ (void)getProfile: (int)userid
        success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success;



+ (void)getCategories:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success;

+ (void)contact: (NSString *)content
        contact: (NSString *)contact
       success : (void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success;

@end
