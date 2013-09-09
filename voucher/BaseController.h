//
//  BaseController.h
//  voucher
//
//  Created by fei wang on 13-8-23.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

#import "VoucherView.h"

#import "Api.h"

@interface BaseController : UIViewController

@property (nonatomic, weak) AppDelegate *appDelegate;

@property (weak, nonatomic) VoucherView *voucherView;

- (void)showVoucherView: (id)data;

@end
