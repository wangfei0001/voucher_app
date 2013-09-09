//
//  Session.h
//  voucher
//
//  Created by fei wang on 13-9-9.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Session : NSObject

+ (void)loadCredentials;

+ (BOOL)saveCredentials: (NSString *)pub_key pri_key:(NSString *)pri_key;

+ (BOOL)isLogged;

+ (NSString *)publicKey;

+ (NSString *)privateKey;

@end
