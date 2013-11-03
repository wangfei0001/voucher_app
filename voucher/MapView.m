//
//  MapView.m
//  voucher
//
//  Created by fei wang on 13-8-29.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "MapView.h"

#import "MapPin.h"

#import <MapKit/MKPinAnnotationView.h>


#define MERCATOR_OFFSET 268435456
#define MERCATOR_RADIUS 85445659.44705395

@implementation MapView

#pragma mark -
#pragma mark Map conversion methods

- (double)longitudeToPixelSpaceX:(double)longitude
{
    return round(MERCATOR_OFFSET + MERCATOR_RADIUS * longitude * M_PI / 180.0);
}

- (double)latitudeToPixelSpaceY:(double)latitude
{
    return round(MERCATOR_OFFSET - MERCATOR_RADIUS * logf((1 + sinf(latitude * M_PI / 180.0)) / (1 - sinf(latitude * M_PI / 180.0))) / 2.0);
}

- (double)pixelSpaceXToLongitude:(double)pixelX
{
    return ((round(pixelX) - MERCATOR_OFFSET) / MERCATOR_RADIUS) * 180.0 / M_PI;
}

- (double)pixelSpaceYToLatitude:(double)pixelY
{
    return (M_PI / 2.0 - 2.0 * atan(exp((round(pixelY) - MERCATOR_OFFSET) / MERCATOR_RADIUS))) * 180.0 / M_PI;
}

#pragma mark -
#pragma mark Helper methods

- (MKCoordinateSpan)coordinateSpanWithMapView:(MKMapView *)mapView
                             centerCoordinate:(CLLocationCoordinate2D)centerCoordinate
                                 andZoomLevel:(NSUInteger)zoomLevel
{
    // convert center coordiate to pixel space
    double centerPixelX = [self longitudeToPixelSpaceX:centerCoordinate.longitude];
    double centerPixelY = [self latitudeToPixelSpaceY:centerCoordinate.latitude];
    
    // determine the scale value from the zoom level
    NSInteger zoomExponent = 20 - zoomLevel;
    double zoomScale = pow(2, zoomExponent);
    
    // scale the map’s size in pixel space
    CGSize mapSizeInPixels = mapView.bounds.size;
    double scaledMapWidth = mapSizeInPixels.width * zoomScale;
    double scaledMapHeight = mapSizeInPixels.height * zoomScale;
    
    // figure out the position of the top-left pixel
    double topLeftPixelX = centerPixelX - (scaledMapWidth / 2);
    double topLeftPixelY = centerPixelY - (scaledMapHeight / 2);
    
    // find delta between left and right longitudes
    CLLocationDegrees minLng = [self pixelSpaceXToLongitude:topLeftPixelX];
    CLLocationDegrees maxLng = [self pixelSpaceXToLongitude:topLeftPixelX + scaledMapWidth];
    CLLocationDegrees longitudeDelta = maxLng - minLng;
    
    // find delta between top and bottom latitudes
    CLLocationDegrees minLat = [self pixelSpaceYToLatitude:topLeftPixelY];
    CLLocationDegrees maxLat = [self pixelSpaceYToLatitude:topLeftPixelY + scaledMapHeight];
    CLLocationDegrees latitudeDelta = -1 * (maxLat - minLat);
    
    // create and return the lat/lng span
    MKCoordinateSpan span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta);
    return span;
}

#pragma mark -
#pragma mark Public methods

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated
{
    // clamp large numbers to 28
    zoomLevel = MIN(zoomLevel, 28);
    
    // use the zoom level to compute the region
    MKCoordinateSpan span = [self coordinateSpanWithMapView:self centerCoordinate:centerCoordinate andZoomLevel:zoomLevel];
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, span);
    
    // set the region like normal
    [self setRegion:region animated:animated];
}


- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
    
    if(self.zoomLevel == 14) return;
    
    self.zoomLevel = 14;
    
    MKUserLocation *location = self.userLocation;
    
    CLLocationCoordinate2D centerCoord = location.location.coordinate;
    
    
    [self setCenterCoordinate:centerCoord zoomLevel:self.zoomLevel animated:NO];
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
//    NSLog(@"tap");
//    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AnnotationView" owner:self options:nil];
//    UIView *aView = [nib objectAtIndex:0];
//    
//    
//    [self addSubview:aView];
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    
}

- (void)addPin: (NSString *)title
            subTitle: (NSString *)subTitle
            lat: (double)lat
            lng: (double)lng
{
    CLLocationCoordinate2D location;
    

    location.latitude = lat;
    location.longitude = lng;
    
    MapPin *mapPoint = [[MapPin alloc] initWithLocation:location];
    mapPoint.title = title;
    mapPoint.subtitle = subTitle;
    //mapPoint.nTag = i;
    
    [self addAnnotation:mapPoint];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id < MKAnnotation >)annotation
{
    if(annotation == mapView.userLocation) return nil;
    
    static NSString* MyIdentifier = @"CinemaMapAnotation";
    MKPinAnnotationView* aView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:MyIdentifier];
    if (!aView)
    {
        aView = [[MKPinAnnotationView alloc]
                                         initWithAnnotation:annotation reuseIdentifier:MyIdentifier];
        aView.draggable = NO;
        aView.animatesDrop = NO;
        aView.enabled = YES;
    } else {
        aView.annotation = annotation;
    }
    
    aView.canShowCallout = YES;
    
    if(annotation != mapView.userLocation){
        aView.image = [UIImage imageNamed:@"map-pin.png"];

        // Add a detail disclosure button to the callout.
        UIButton* rightButton = [UIButton buttonWithType:
                                 UIButtonTypeDetailDisclosure];
        [rightButton addTarget:self action:@selector(myShowDetailsMethod:)
              forControlEvents:UIControlEventTouchUpInside];
        aView.rightCalloutAccessoryView = rightButton;
    }


    return aView;
}

- (IBAction)myShowDetailsMethod:(id)sender
{
    [self.mydelegate voucherOnMapViewClick:sender];
}


//- (void)setLocation: (CLLocationCoordinate2D) startCoord
//{
//    MKCoordinateRegion adjustedRegion = [self regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 100, 100)];
//    [self setRegion:adjustedRegion animated:YES];
//}

@end
