//
//  Merchant.m
//  voucher
//
//  Created by fei wang on 13-9-14.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "Merchant.h"

@implementation Merchant

- (id)initWithData: (id)data
{
    self = [super init];
    if(self){
        self.id_merchant = [[data objectForKey:@"id_merchant"] intValue];
        self.company = [data objectForKey:@"company"];
        self.logo = [data objectForKey:@"logo"];
        //address
        self.addresses = [[NSMutableArray alloc] initWithCapacity:0];
        id addresses = [data objectForKey:@"address"];
        for(int i = 0; i < [addresses count]; i++){
            Address *address = [[Address alloc] initWithData:[addresses objectAtIndex:i]];
            [self.addresses addObject:address];
        }
        
    }
    return self;
}

@end
