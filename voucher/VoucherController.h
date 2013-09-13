//
//  VoucherController.h
//  voucher
//
//  Created by fei wang on 13-8-22.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseController.h"

#import "MapView.h"

@interface VoucherController : BaseController<mapViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTable;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segementCtrl;


@property (strong, nonatomic) IBOutlet MapView *mapView;

@end
