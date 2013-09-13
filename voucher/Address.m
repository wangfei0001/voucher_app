//
//  Address.m
//  voucher
//
//  Created by fei wang on 13-9-14.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "Address.h"

@implementation Address

- (id)initWithData: (id)data
{
    self = [super init];
    if(self){
        self.lat = [[data objectForKey:@"lat"] floatValue];
        self.lng = [[data objectForKey:@"lng"] floatValue];
    }
    return self;
}


- (CLLocationCoordinate2D)getCoordinate2D
{
    return CLLocationCoordinate2DMake(self.lat, self.lng);
}

@end
