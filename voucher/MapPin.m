//
//  MapPin.m
//  voucher
//
//  Created by fei wang on 13-8-29.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "MapPin.h"

@implementation MapPin

@synthesize coordinate,title,subtitle;
@synthesize nTag;

- (id)initWithLocation: (CLLocationCoordinate2D)coord
{
    self = [super init];
    if (self) {
        coordinate = coord;
    }
    return self;
}



@end
