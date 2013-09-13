//
//  MapView.h
//  voucher
//
//  Created by fei wang on 13-8-29.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MKMapView.h>

#import <MapKit/MKUserLocation.h>

@protocol mapViewDelegate<NSObject>

-(void)voucherOnMapViewClick:(id)sender;

@end

@interface MapView : MKMapView<MKMapViewDelegate>

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

//- (void)setLocation: (CLLocationCoordinate2D) startCoord;


@property (nonatomic, assign) id<mapViewDelegate> mydelegate;


@property (nonatomic, assign) int zoomLevel;

@end
