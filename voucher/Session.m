//
//  Session.m
//  voucher
//
//  Created by fei wang on 13-9-9.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "Session.h"

#import "KeychainItemWrapper.h"

#import "User.h"

@implementation Session

static NSString *public_key;

static NSString *private_key;

static int userid;

static User *user;


+ (BOOL)saveCredentials: (NSString *)pub_key pri_key:(NSString *)pri_key userid: (int)userid
{
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"Account Number" accessGroup:nil];
    
    if(!pub_key && !pri_key){
        [keychainItem resetKeychainItem];
    }else{
        [keychainItem setObject:pub_key forKey:(__bridge id)(kSecAttrAccount)];
        [keychainItem setObject:pri_key forKey: (__bridge id)kSecValueData];
        [keychainItem setObject:[NSNumber numberWithInt:userid] forKey: (__bridge id)kSecAttrService];
    }
    
    public_key = pub_key;
    private_key = pri_key;
    
    return YES;
}

+ (void)loadCredentials
{
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"Account Number" accessGroup:nil];
//   [keychainItem resetKeychainItem];
    
    id pub = [keychainItem objectForKey:(__bridge id)kSecAttrAccount];
    
    public_key = (NSString *)pub;
    NSLog(@"pub key :%@", (NSString *)pub);
    
    id pri = [keychainItem objectForKey:(__bridge id)kSecValueData];
    
    private_key = (NSString *)pri;
    
    NSLog(@"pri key :%@", (NSString *)pri);
    
    id user_id = [keychainItem objectForKey:(__bridge id)kSecAttrService];
    
    userid = [user_id intValue];
    
    NSLog(@"userid :%d", userid);
}

+ (BOOL)isLogged
{
    [Session loadCredentials];
    if(![public_key isEqualToString:@""] && ![private_key isEqualToString:@""])
        return YES;
    
    return NO;
}

+ (NSString *)publicKey
{
    return public_key;
}

+ (NSString *)privateKey
{
    return private_key;
}

+ (int)userid
{
    return userid;
}

+ (User *)user
{
    return user;
}

+ (void)setUser: (User *)val
{
    user = val;
}

@end
