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
}


@end
