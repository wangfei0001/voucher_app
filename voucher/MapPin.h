//
//  MapPin.h
//  voucher
//
//  Created by fei wang on 13-8-29.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MKAnnotation.h>

@interface MapPin : NSObject<MKAnnotation>{
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    int nTag;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic) int nTag;

- (id)initWithLocation: (CLLocationCoordinate2D)coord;

@end
