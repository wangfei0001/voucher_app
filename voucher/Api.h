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

@end
