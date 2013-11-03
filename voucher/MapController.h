//
//  MapController.h
//  voucher
//
//  Created by fei wang on 13-8-25.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MapView.h"

#import "Voucher.h"

#import "Merchant.h"

#import "Address.h"


#define MAP_CONTROLLER_SHOW_TYPE_VOUCHER 1

@interface MapController : UIViewController

@property (weak, nonatomic) IBOutlet MapView *mapView;

@property (assign, nonatomic) CLLocationCoordinate2D startCoord;

@property (assign, nonatomic) int showType;

// for MAP_CONTROLLER_SHOW_TYPE_VOUCHER;
@property (weak, nonatomic) Voucher *voucher;

@end
