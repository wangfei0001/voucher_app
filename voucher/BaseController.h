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

@interface BaseController : UIViewController<voucherViewDelegate,
UIActionSheetDelegate,
WeiboRequestDelegate,
WeiboAuthDelegate
>

@property (nonatomic, weak) AppDelegate *appDelegate;

@property (weak, nonatomic) VoucherView *voucherView;

@property (weak, nonatomic) IBOutlet UITableView *mainTable;

- (void)showVoucherView: (id)data;

- (void)showNotFound;

- (void)hideNotFound;

@end
