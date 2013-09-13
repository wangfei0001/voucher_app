//
//  Address.h
//  voucher
//
//  Created by fei wang on 13-9-14.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

@interface Address : NSObject

@property (assign, nonatomic) float lat;

@property (assign, nonatomic) float lng;


- (id)initWithData: (id)data;

- (CLLocationCoordinate2D)getCoordinate2D;

@end
