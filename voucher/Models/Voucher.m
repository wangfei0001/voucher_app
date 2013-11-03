//
//  Voucher.m
//  voucher
//
//  Created by fei wang on 13-8-27.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "Voucher.h"

@implementation Voucher


- (id)initWithData: (id)data
{
    self = [super init];
    if(self)
    {
        [self loadData:data];
    }
    return self;
}

- (void)loadData: (id)data
{
    self.id = [[data objectForKey:@"id_voucher"] intValue];
    self.name = [data objectForKey:@"name"];
    self.reusable = [[data objectForKey:@"reusable"] boolValue];
    self.featured = [[data objectForKey:@"featured"] boolValue];
    if ([data objectForKey:@"reuse_total"] != [NSNull null]) {
        self.reuseTotal = [[data objectForKey:@"reuse_total"] intValue];
    }
    if ([data objectForKey:@"reuse_left"] != [NSNull null]) {
        self.reuseLeft = [[data objectForKey:@"reuse_left"] intValue];
    }
    self.termCondition = [data objectForKey:@"term_condition"];
    self.endTime = [data objectForKey:@"end_time"];
    
    self.id_favourite = [[data objectForKey:@"id_favourite"] intValue];
    
    //init merchant
    if([data objectForKey:@"merchant"]){
        self.merchant = [[Merchant alloc] initWithData:[data objectForKey:@"merchant"]];
    }
    //init vouchers
    id addresses = [data objectForKey:@"addresses"];
    if(addresses){
        //address
        self.addresses = [[NSMutableArray alloc] initWithCapacity:0];
        
        for(int i = 0; i < [addresses count]; i++){
            Address *address = [[Address alloc] initWithData:[addresses objectAtIndex:i]];
            [self.addresses addObject:address];
        }
    }
}


- (BOOL)isMyFavourite
{
    return self.id_favourite > 0 ? YES : NO;
}

@end
