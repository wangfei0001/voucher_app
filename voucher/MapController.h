//
//  MapController.h
//  voucher
//
//  Created by fei wang on 13-8-25.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MapView.h"

@interface MapController : UIViewController

@property (weak, nonatomic) IBOutlet MapView *mapView;

@property (assign, nonatomic) CLLocationCoordinate2D startCoord;

@end
